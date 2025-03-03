package com.docusign.core.controller;

import com.docusign.DSConfiguration;
import com.docusign.core.model.Locals;
import com.docusign.core.model.Session;
import com.docusign.core.model.User;
import java.io.IOException;
import java.util.*;

import com.docusign.core.security.OAuthProperties;
import org.apache.commons.lang3.StringUtils;
import org.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Scope;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.oauth2.provider.OAuth2Authentication;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.context.WebApplicationContext;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.view.RedirectView;
import com.docusign.esign.client.auth.OAuth;
import java.util.stream.Collectors;
import org.springframework.security.core.Authentication;
import org.springframework.security.oauth2.provider.authentication.OAuth2AuthenticationDetails;
import org.springframework.web.bind.annotation.ControllerAdvice;
import org.springframework.web.bind.annotation.ModelAttribute;
import javax.servlet.http.HttpServletResponse;

@Controller
@ControllerAdvice
@Scope(WebApplicationContext.SCOPE_SESSION)
public class IndexController {
    private static final String ATTR_ENVELOPE_ID = "qpEnvelopeId";
    private static final String ATTR_STATE = "state";
    private static final String ATTR_EVENT = "event";
    private static final String ATTR_TITLE = "title";

    private static final String ERROR_ACCOUNT_NOT_FOUND = "Could not find account information for the user";
    private static final String SELECTED_API_NOT_SUPPORTED = "Currently selected api is not supported by launcher. Please, check appsettings.json file.";
    private final DSConfiguration config;
    private final Session session;
    private final User user;
    private Optional<OAuth.Account> account;

    @Autowired
    private OAuthProperties authCodeGrantSso;

    @Autowired
    public IndexController(DSConfiguration config, Session session, User user, Optional<OAuth.Account> account) {
        this.config = config;
        this.session = session;
        this.user = user;
        this.account = account;
    }

    @GetMapping(path = "/")
    public String index(ModelMap model, HttpServletResponse response) throws IOException {
        String site = "/eg001";
        response.setStatus(response.SC_MOVED_TEMPORARILY);
        response.setHeader("Location", site);
        return null;
    }

    @GetMapping(path = "/ds/mustAuthenticate")
    public ModelAndView mustAuthenticateController(ModelMap model) throws IOException {
        return new ModelAndView(getRedirectView());
    }

    @GetMapping(path = "/ds-return")
    public String returnController(@RequestParam(value = ATTR_STATE, required = false) String state,
            @RequestParam(value = ATTR_EVENT, required = false) String event,
            @RequestParam(value = "envelopeId", required = false) String envelopeId, ModelMap model, HttpServletResponse response) throws IOException {
        String site = "/eg001";
        response.setStatus(response.SC_MOVED_TEMPORARILY);
        response.setHeader("Location", site);
        return null;
    }

    private RedirectView getRedirectView() {
        RedirectView redirect = new RedirectView(getLoginPath());
        redirect.setExposeModelAttributes(false);
        return redirect;
    }

    private String getLoginPath() {
        return authCodeGrantSso.getLoginPath();
    }

    @ModelAttribute("documentOptions")
    public List<JSONObject> populateDocumentOptions() {
        return new ArrayList<>();
    }

    @ModelAttribute("showDoc")
    public boolean populateShowDoc() {
        return StringUtils.isNotBlank(config.getDocumentationPath());
    }

    @ModelAttribute("locals")
    public Object populateLocals() throws IOException {
        Authentication authentication = SecurityContextHolder.getContext().getAuthentication();

        if (!(authentication instanceof OAuth2Authentication)) {
            return new RedirectView("/");
        }

        OAuth2Authentication oauth = (OAuth2Authentication) authentication;
        OAuth2AuthenticationDetails details = (OAuth2AuthenticationDetails) oauth.getDetails();
        Authentication oauthUser = oauth.getUserAuthentication();

        if (oauthUser != null && oauthUser.isAuthenticated()) {
            user.setName(oauthUser.getName());
            user.setAccessToken(details.getTokenValue());

            if (account.isEmpty()) {
                account = Optional.ofNullable(getDefaultAccountInfo(getOAuthAccounts(oauth)));
            }

            OAuth.Account oauthAccount = account.orElseThrow(() -> new NoSuchElementException(ERROR_ACCOUNT_NOT_FOUND));
            session.setAccountId(oauthAccount.getAccountId());
            session.setAccountName(oauthAccount.getAccountName());
            //TODO set this more efficiently with more APIs as they're added in
            String basePath = this.getBaseUrl(oauthAccount) + "/restapi";
            session.setBasePath(basePath);
        }

        return new Locals(config, session, user, "");
    }

    private String getBaseUrl(OAuth.Account oauthAccount) {
        return oauthAccount.getBaseUri();
    }

    @SuppressWarnings("unchecked")
    private static List<OAuth.Account> getOAuthAccounts(OAuth2Authentication oauth) {
        Map<?, ?> userAuthenticationDetails = (Map<?, ?>) oauth.getUserAuthentication().getDetails();
        List<Map<String, Object>> oauthAccounts = (ArrayList<Map<String, Object>>) userAuthenticationDetails.get("accounts");
        return oauthAccounts.stream()
                .map(IndexController::convert)
                .collect(Collectors.toList());
    }

    private OAuth.Account getDefaultAccountInfo(List<OAuth.Account> accounts) {
        String targetAccountId = config.getTargetAccountId();
        if (StringUtils.isNotBlank(targetAccountId)) {
            OAuth.Account account = getAccountById(accounts, targetAccountId);
            if(account != null) {
                return account;
            }
        }
        return getDefaultAccount(accounts);
    }

    private static OAuth.Account getDefaultAccount(List<OAuth.Account> accounts) {
        for (OAuth.Account oauthAccount : accounts) {
            if ("true".equals(oauthAccount.getIsDefault())) {
                return oauthAccount;
            }
        }
        return null;
    }

    private static OAuth.Account getAccountById(List<OAuth.Account> accounts, String accountId) {
        for (OAuth.Account oauthAccount : accounts) {
            if (StringUtils.equals(oauthAccount.getAccountId(), accountId)) {
                return oauthAccount;
            }
        }
        return null;
    }

    public static OAuth.Account convert(Map<String, Object> account) {
        OAuth.Account res = new OAuth.Account();
        res.setAccountId((String) account.get("account_id"));
        res.setIsDefault(String.valueOf(account.get("is_default")));
        res.setAccountName((String) account.get("account_name"));
        res.setBaseUri((String) account.get("base_uri"));
        return res;
    }
}
