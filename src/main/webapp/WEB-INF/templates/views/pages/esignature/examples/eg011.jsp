<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<jsp:include page="../../../partials/head.jsp"/>

<h4>Use embedded sending</h4>
<p>An envelope will be created in draft mode. Your browser will then be redirected to
    the DocuSign web tool where the envelope can be (optionally) updated and then sent.</p>
<p>The envelope includes a pdf, Word, and HTML document. Anchor text
    (<a href="https://developers.docusign.com/docs/esign-rest-api/esign101/concepts/tabs/auto-place/">AutoPlace</a>)
    is used to position the signing fields in the documents.</p>
<p>DocuSign recommends that you enhance your application as needed to avoid the need
    for the embedded sender view.
</p>
<p>For example, if the sender view is used to optionally
    add additional documents to the envelope, enhance your app to provide the
    needed feature (see Use embedded signing from a template with an added document for adding additional documents programmatically).
</p>
<c:if test="${showDoc}">
    <p><a target='_blank' href='${documentation}'>Documentation</a> about this example.</p>
</c:if>


<p>API methods used:
    <a target='_blank' rel="noopener noreferrer" href="https://developers.docusign.com/docs/esign-rest-api/reference/envelopes/envelopes/create/">Envelopes::create</a> and
    <a target='_blank' rel="noopener noreferrer" href="https://developers.docusign.com/docs/esign-rest-api/reference/envelopes/envelopeviews/createsender/">EnvelopeViews::createSender</a>.
</p>

<p>
    View source file <a target="_blank" href="${sourceUrl}">${sourceFile}</a> on GitHub.
</p>

<form class="eg" action="" method="post" data-busy="form">
    <div class="form-group">
        <label for="startingView">Starting View</label>
        <select id="startingView" name="startingView" class="form-control">
            <option value="tagging" selected>Tagging view</option>
            <option value="recipient">Recipient &amp; Documents view</option>
        </select>
    </div>
    <div class="form-group">
        <label for="signerEmail">Signer Email</label>
        <input type="email" class="form-control" id="signerEmail" name="signerEmail"
               aria-describedby="emailHelp" placeholder="pat@example.com" required
               value="${locals.dsConfig.signerEmail}">
        <small id="emailHelp" class="form-text text-muted">We'll never share your email with anyone else.</small>
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
        <small id="emailHelp" class="form-text text-muted">The email and/or name for the cc recipient must be different from the signer.</small>
    </div>
    <div class="form-group">
        <label for="ccName">CC Name</label>
        <input type="text" class="form-control" id="ccName" placeholder="Pat Johnson" name="ccName"
               required>
    </div>
    <input type="hidden" name="_csrf" value="${csrfToken}">
    <button type="submit" class="btn btn-docu">Submit</button>
</form>

<jsp:include page="../../../partials/foot.jsp"/>
