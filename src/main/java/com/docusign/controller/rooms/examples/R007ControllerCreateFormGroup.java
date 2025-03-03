package com.docusign.controller.rooms.examples;

import com.docusign.DSConfiguration;
import com.docusign.common.WorkArguments;
import com.docusign.core.model.DoneExample;
import com.docusign.core.model.Session;
import com.docusign.core.model.User;
import com.docusign.rooms.api.FormGroupsApi;
import com.docusign.rooms.client.ApiException;
import com.docusign.rooms.model.FormGroup;
import com.docusign.controller.rooms.services.CreateFormGroupService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;

import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

/**
 * Creating create a form group.
 */
@Controller
@RequestMapping("/r007")
public class R007ControllerCreateFormGroup extends AbstractRoomsController {

    private final Session session;
    private final User user;

    @Autowired
    public R007ControllerCreateFormGroup(DSConfiguration config, Session session, User user) {
        super(config, "r007", "Creating create a form group");
        this.session = session;
        this.user = user;
    }

    @Override
    // ***DS.snippet.0.start
    protected Object doWork(WorkArguments args, ModelMap model,
                            HttpServletResponse response) throws IOException, ApiException {

        FormGroupsApi formGroupsApi = createFormGroupsApi(
                this.session.getBasePath(), this.user.getAccessToken()
        );

        FormGroup formGroup = CreateFormGroupService.createFormGroup(
                formGroupsApi,
                this.session.getAccountId(),
                args.getFormGroupName());
        
        DoneExample.createDefault(this.title)
                .withJsonObject(formGroup)
                .withMessage("A form group has been created!")
                .addToModel(model);
        return DONE_EXAMPLE_PAGE;
    }
}
