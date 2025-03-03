package com.docusign.controller.eSignature.examples;

import com.docusign.DSConfiguration;
import com.docusign.common.WorkArguments;
import com.docusign.controller.eSignature.services.InPersonSigningService;
import com.docusign.core.model.Session;
import com.docusign.core.model.User;
import com.docusign.esign.api.EnvelopesApi;
import com.docusign.esign.client.ApiClient;
import com.docusign.esign.client.ApiException;
import com.docusign.esign.model.EnvelopeDefinition;
import com.docusign.esign.model.EnvelopeSummary;
import com.docusign.esign.model.RecipientViewRequest;
import com.docusign.esign.model.ViewUrl;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.view.RedirectView;

import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

@Controller
@RequestMapping("/eg039")
public class EG039ControllerInPersonSigning extends AbstractEsignatureController {
    private static final String DOCUMENT_FILE_NAME = "World_Wide_Corp_lorem.pdf";
    private static final String DOCUMENT_NAME = "Lorem Ipsum";
    private static final int ANCHOR_OFFSET_Y = 10;
    private static final int ANCHOR_OFFSET_X = 20;
    private final User user;

    @Autowired
    public EG039ControllerInPersonSigning(DSConfiguration config, Session session, User user) {
	   super(config, "eg039", "In-person signing");
	   this.session = session;
	   this.user = user;
    }

    @Override
    protected Object doWork(WorkArguments args, ModelMap model,
					   HttpServletResponse response) throws ApiException, IOException {
        String basePath = session.getBasePath();
        String accessToken = user.getAccessToken();

	   String hostName = getAuthenticatedUserName(basePath, accessToken);
	   String hostEmail = getAuthenticatedUserEmail(basePath, accessToken);
	   String signerName = args.getSignerName();
	   String accountId = session.getAccountId();

	   EnvelopeDefinition envelope = InPersonSigningService.makeEnvelope(hostEmail, hostName, signerName,
		  ANCHOR_OFFSET_Y, ANCHOR_OFFSET_X, DOCUMENT_FILE_NAME, DOCUMENT_NAME);

	   // Step 3 start
	   ApiClient apiClient = createApiClient(basePath, accessToken);
	   EnvelopesApi envelopesApi = new EnvelopesApi(apiClient);

	   EnvelopeSummary envelopeSummary = envelopesApi.createEnvelope(accountId, envelope);
	   // Step 3 end
	   // Step 5 start
	   RecipientViewRequest viewRequest = InPersonSigningService.makeRecipientViewRequest(hostEmail, hostName, config);
	   // Step 5 end

	   ViewUrl viewUrl = InPersonSigningService.inPersonSigning(
		  envelopesApi,
		  accountId,
		  envelopeSummary.getEnvelopeId(),
		  viewRequest);

	   return new RedirectView(viewUrl.getUrl());
    }
}
