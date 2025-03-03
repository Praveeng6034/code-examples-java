<%@ taglib prefix='c' uri='http://java.sun.com/jsp/jstl/core' %>
<jsp:include page='../../partials/head.jsp'/>

<c:if test="${locals.user == null}">
    <!-- IF not signed in -->
    <div>
    <div class='jumbotron jumbotron-fluid'> <table>
        <tbody>
        <tr>
            <td>
                <h1 class='display-4'>Java Launcher</h1>
                <p class='Xlead'>Run and explore DocuSign Admin API code examples with Authorization Code Grant or JWT Grant authentication</p>
            </td>
            <td>
                <img src='/assets/banner-code.png' />
            </td>
        </tr>
        </tbody>
    </table>
    </div>
</c:if>

<div class='container' style='margin-top: 40px' id='index-page'>
    <c:if test="${showDoc == true}">
        <p><a target='_blank' href='${documentation}'>Documentation</a> on using OAuth Authorization Code Grant from a Java application.</p>
    </c:if>

    
    <h2>Admin API Code Examples</h2>
    <h4 id="Example1">1. <a href="a001">Create a new active eSignature user</a></h4>
    <p>
        Demonstrates how to create a new eSignature user and activate their account automatically.
    </p>
    <p>
        API methods used:
        <a target='_blank' rel='noopener noreferrer' 
        href='https://developers.docusign.com/docs/esign-rest-api/reference/accounts/accountpermissionprofiles/list/'>AccountPermissionProfiles:list</a>, 
    <a target='_blank' rel='noopener noreferrer' 
        href='https://developers.docusign.com/docs/esign-rest-api/reference/usergroups/groups/list/'>Groups:list</a>, 
    <a target='_blank' rel='noopener noreferrer' 
        href="https://developers.docusign.com/docs/admin-api/reference/usermanagement/esignusermanagement/createuser/">eSignUserManagement:createUser</a>
</p>
    <h4 id="Example2">2. <a href="a002">Create a new active user for CLM and eSignature</a></h4>
    <p>
        Demonstrates how to create a new DocuSign user (valid for both CLM and eSignature) and activate their account automatically.
    </p>
    <p>
        API methods used:
        <a target='_blank' rel='noopener noreferrer' 
            href="https://developers.docusign.com/docs/admin-api/reference/usermanagement/multiproductusermanagement/getproductpermissionprofiles/">MultiProductUserManagement:getProductPermissionProfiles</a>,
        <a target='_blank' rel='noopener noreferrer' 
            href="https://developers.docusign.com/docs/admin-api/reference/usermanagement/multiproductusermanagement/getdsgroups/">MultiProductUserManagement:getDsGroups</a>,
        <a target='_blank' rel='noopener noreferrer' 
            href="https://developers.docusign.com/docs/admin-api/reference/usermanagement/multiproductusermanagement/addorupdateuser/">MultiProductUserManagement:addOrUpdateUser</a>
    </p>
  


    <h4 id="Example3">3. <a href="a003">Bulk export user data</a></h4>
    <p>
        Demonstrates how to bulk export user accounts within an organization into a CSV (comma-separated value) file.
    </p>
    <p>
        API methods used:
        <a target='_blank' rel='noopener noreferrer' 
            href="https://developers.docusign.com/docs/admin-api/reference/bulkoperations/userexport/createuserlistexport/">UserExport:createUserListExport</a>,
        <a target='_blank' rel='noopener noreferrer' 
            href="https://developers.docusign.com/docs/admin-api/reference/bulkoperations/userexport/getuserlistexport/">UserExport:getUserListExport</a>
    </p>

    <!--
    <h4 id="Example3a">
        3a. <a href="a003a">Check request status</a>
    </h4>
    <p>
        Check the status of your pending request and, if complete, obtain a URL that you can call to download the CSV file containing the export data.
    </p>
    <p>API method used:
        <a target='_blank' rel='noopener noreferrer'
           href='https://developers.docusign.com/docs/admin-api/reference/bulkoperations/userexport/getuserlistexport/'>UserExport:getUserListExport</a>
    </p>
    -->  

    <h4 id="Example4">4. <a href="a004">Add users via bulk import</a></h4>
    <p>
        Demonstrates how to bulk import users and add user data from an example CSV (comma-separated value) file into a DocuSign Admin organization.
    </p>
    <p>
        API methods used:
        <a target='_blank' rel='noopener noreferrer' 
            href="https://developers.docusign.com/docs/admin-api/reference/bulkoperations/userimport/addbulkuserimport/">UserImport:addBulkUserImport</a>, 
       <a target='_blank' rel='noopener noreferrer'
            href='https://developers.docusign.com/docs/admin-api/reference/bulkoperations/userimport/getbulkuserimportrequest/'>UserImport:getBulkUserImportRequest</a>
    </p>

    
    <!-- 
    <h4 id="Example4a">
        5. <a href="a004a">Check the request status</a>
    </h4>
    <p>Check the status of your pending request and, if complete, obtain a URL that you can call to download the CSV file containing the data to verify that the updates were made</p>
    <p>API method used:
        <a target='_blank' rel='noopener noreferrer'
           href='https://developers.docusign.com/docs/admin-api/reference/bulkoperations/userimport/getbulkuserimportrequest/'>UserImport :getBulkUserImportRequest</a>
    </p> 
    -->

    <h4 id="Example5">5. <a href="a005">Audit users</a></h4>
    <p>
        Demonstrates how to audit the users in your account by retrieving the profiles of users that were modified after a specified date.
    </p>
    <p>
        API methods used:
        <a target="_blank" rel="noopener noreferrer" 
            href="https://developers.docusign.com/docs/admin-api/reference/usermanagement/users/getusers/">Users:getUsers</a>,
        <a target="_blank" rel="noopener noreferrer"
            href="https://developers.docusign.com/docs/admin-api/reference/usermanagement/esignusermanagement/getuserprofiles/">eSignUserManagement:getUserProfiles</a>
    </p>

    <h4 id="Example6">6. <a href="a006">Retrieve the user's DocuSign profile using an email address</a></h4>
    <p>
        Demonstrates how to obtain the user's DocuSign profile information across all DocuSign accounts by specifying the user's email address.
    </p>
    <p>
        API method used:
        <a target="_blank" rel='noopener noreferrer'
           href="https://developers.docusign.com/docs/admin-api/reference/usermanagement/multiproductusermanagement/getuserdsprofilesbyemail/">MultiProductUserManagement:getUserDSProfilesByEmail</a>
    </p>

    <h4 id="Example7">7. <a href="a007">Retrieve the user's DocuSign profile using a User ID</a></h4>
    <p>Demonstrates how to obtain the user's DocuSign profile information across all DocuSign accounts by specifying the user's User ID.</p>
    <p>
        API method used:
        <a target="_blank" rel='noopener noreferrer'
           href="https://developers.docusign.com/docs/admin-api/reference/usermanagement/multiproductusermanagement/getuserdsprofile/">MultiProductUserManagement:getUserDSProfile</a>
    </p>

    <h4 id="Example8">8. <a href="a008">Update user product permission profiles using an email address</a></h4>
    <p>Demonstrates how to update user product permission profiles. There may only be one permission profile assigned to a user per product.</p>
    <p>
        API methods used:
        <a target='_blank' rel='noopener noreferrer'
           href="https://developers.docusign.com/docs/admin-api/reference/usermanagement/multiproductusermanagement/getproductpermissionprofiles/">MultiProductUserManagement:getProductPermissionProfiles</a>,
        <a target="_blank" rel='noopener noreferrer'
           href="https://developers.docusign.com/docs/admin-api/reference/usermanagement/multiproductusermanagement/adduserproductpermissionprofilesbyemail/">MultiProductUserManagement:addUserProductPermissionProfilesByEmail</a>
    </p>

    <h4 id="Example9">9. <a href="a009">Delete user product permission profiles using an email address</a></h4>
    <p>Demonstrates how to list and delete DocuSign Admin user product permission profiles.</p>
    <p>
        API methods used:
        <a target="_blank" rel='noopener noreferrer'
           href="https://developers.docusign.com/docs/admin-api/reference/usermanagement/multiproductusermanagement/getuserproductpermissionprofilesbyemail/">MultiProductUserManagement:getUserProductPermissionProfilesByEmail</a>,
        <a target="_blank" rel='noopener noreferrer'
           href="https://developers.docusign.com/docs/admin-api/reference/usermanagement/multiproductusermanagement/removeuserproductpermission/">MultiProductUserManagement:removeUserProductPermission</a>
    </p>

<!-- anchor-js is only for the index page -->
<script src='https://cdnjs.cloudflare.com/ajax/libs/anchor-js/4.1.1/anchor.min.js'></script>
<script>anchors.options.placement = 'left'; anchors.add('h4')</script>

<jsp:include page='../../partials/foot.jsp'/>

