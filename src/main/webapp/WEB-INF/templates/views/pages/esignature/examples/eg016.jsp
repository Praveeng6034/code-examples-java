<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<jsp:include page="../../../partials/head.jsp"/>

<h4>Set tab values for an envelope.</h4>

<p>
    This example creates an example with both read-only tabs (fields) and tabs that can
    be updated by the recipient.
</p>
<p>The example also sets custom metadata in the envelope via the envelope custom fields feature.</p>



<c:if test="${showDoc}">
<p><a target='_blank' href='${documentation}'>Documentation</a> about this example.</p>
</c:if>

<p>
    API method used:
    <a target='_blank' href="https://developers.docusign.com/docs/esign-rest-api/reference/envelopes/envelopeformdata/get/">EnvelopeFormData::get</a>.
</p>

<p>
    View source file <a target="_blank" href="${sourceUrl}">${sourceFile}</a> on GitHub.
</p>


<form class="eg" action="" method="post" data-busy="form">
    <div class="form-group">
        <label for="signerEmail">Signer Email</label>
        <input type="email" class="form-control" id="signerEmail" name="signerEmail"
               aria-describedby="emailHelp" placeholder="john@example.com" required
               value="${locals.dsConfig.signerEmail}">
        <small id="emailHelp" class="form-text text-muted">We'll never share your email with anyone else.</small>
    </div>
    <div class="form-group">
        <label for="signerName">Signer Name</label>
        <input type="text" class="form-control" id="signerName" placeholder="john doe" name="signerName"
               value="${locals.dsConfig.signerName}" required>
    </div>
    <div class="form-group">
        <label for="ccEmail">CC Email</label>
        <input type="email" class="form-control" id="ccEmail" name="ccEmail"
               aria-describedby="ccHelp" placeholder="pat@example.com" required >
        <small id="ccHelp" class="form-text text-muted">The email for the cc recipient must be different from the signer's email.</small>
    </div>
    <div class="form-group">
        <label for="ccName">CC Name</label>
        <input type="text" class="form-control" id="ccName" placeholder="Pat Johnson" name="ccName"
               required >
    </div>
    <input type="hidden" name="csrfToken" value="${csrfToken}"/>
    <button type="submit" class="btn btn-docu">Submit</button>
</form>


<jsp:include page="../../../partials/foot.jsp"/>
