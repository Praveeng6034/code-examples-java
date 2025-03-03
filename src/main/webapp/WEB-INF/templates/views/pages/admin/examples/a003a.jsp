<%@ taglib prefix='c' uri='http://java.sun.com/jsp/jstl/core' %>
<jsp:include page='../../../partials/head.jsp'/>

<h4>3a. Check request status</h4>
<p> Check the status of your pending request and, if complete, obtain a URL that you can call to download the CSV file containing the export data.</p>
<c:if test='${showDoc}'>
    <p><a target='_blank' rel="noopener noreferrer" href='${documentation}'>Documentation</a> about this example.</p>
</c:if>


<p>API method used:
    <a target='_blank' rel='noopener noreferrer'
       href='https://developers.docusign.com/docs/admin-api/reference/bulkoperations/userexport/getuserlistexport/'>UserExport:getUserListExport</a>.
</p>
<p>
    View source file <a target='_blank' href='${sourceUrl}'>${sourceFile}</a> on GitHub.
</p>

<c:choose>
    <c:when test="${exportOk == true}">
        <p>Uses the export information that was received during previous step</p>
        <form class="eg" action="" method="post" data-busy="form">
            <input type="hidden" name="_csrf" value="${csrfToken}">
            <button type="submit" class="btn btn-docu">Submit</button>
        </form>
    </c:when>
    <c:otherwise>
        <p>
            Problem: please first bulk export user data using <a target="_blank" href="/a002">Send an envelope with a remote (email) signer and cc recipient.</a>.<br />
            Thank you.
        </p>
    </c:otherwise>
</c:choose>

<jsp:include page='../../../partials/foot.jsp'/>
