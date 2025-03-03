<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<jsp:include page="../../../partials/head.jsp"/>

<h4>Send an envelope using a template</h4>
<p>The envelope is defined by the template.
    The signer and cc recipient name and email are used to fill in the template's <em>roles</em>.</p>

<p>This example demonstrates a common pattern for DocuSign integrations: envelopes will
    be sent programmatically, based on a template. If the template definition needs to be
    updated, the DocuSign web tool can be used to easily update the template, thus
    avoiding the need to make software changes.
</p>

<c:if test="${showDoc}">
    <p><a target='_blank' href='${documentation}'>Documentation</a> about this example.</p>
</c:if>


<p>API method used:
    <a target='_blank' rel="noopener noreferrer" href="https://developers.docusign.com/docs/esign-rest-api/reference/envelopes/envelopes/create/">Envelopes::create</a>.
</p>
<p>
    View source file <a target="_blank" href="${sourceUrl}">${sourceFile}</a> on GitHub.
</p>

<c:choose>
    <c:when test="${not empty listTemplates}">
        <p>The template you created via Create a template will be used.</p>

        <form class="eg" action="" method="post" data-busy="form">
            <div class="form-group">
                <label for="templateId">Envelope template</label> <select
                    id="templateId" name="templateId" class="form-control">
                    <c:forEach items="${listTemplates}" var="template">
                        <option value="${template.templateId}">${template.name}</option>
                    </c:forEach>
                </select>
            </div>
            <div class="form-group">
                <label for="signerEmail">Signer Email</label>
                <input type="email" class="form-control" id="signerEmail" name="signerEmail"
                       aria-describedby="emailHelp" placeholder="pat@example.com" required
                       value="${locals.dsConfig.signerEmail}">
                <small id="emailHelp" class="form-text text-muted">We'll never share your email with anyone else.
                </small>
            </div>
            <div class="form-group">
                <label for="signerName">Signer Name</label>
                <input type="text" class="form-control" id="signerName" placeholder="Pat Johnson" name="signerName"
                       value="${locals.dsConfig.signerName}" required>
            </div>
            <div class="form-group">
                <label for="ccEmail">CC Email</label>
                <input type="email" class="form-control" id="ccEmail" name="ccEmail"
                       aria-describedby="emailHelp" placeholder="pat@example.com" required>
                <small id="emailHelp" class="form-text text-muted">The email and/or name for the cc recipient must be
                    different from the signer.
                </small>
            </div>
            <div class="form-group">
                <label for="ccName">CC Name</label>
                <input type="text" class="form-control" id="ccName" placeholder="Pat Johnson" name="ccName"
                       required>
            </div>
            <input type="hidden" name="_csrf" value="${csrfToken}">
            <button type="submit" class="btn btn-docu">Submit</button>
        </form>
    </c:when>
    <c:otherwise>
        <p>Problem: please first create the template using <a href="eg008">Create a template.</a> <br/>
            Thank you.</p>

        <form class="eg" action="eg008" method="get">
            <button type="submit" class="btn btn-docu">Continue</button>
        </form>
    </c:otherwise>
</c:choose>

<jsp:include page="../../../partials/foot.jsp"/>
