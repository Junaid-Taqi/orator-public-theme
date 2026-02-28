<!DOCTYPE html>
<#include init />

<html class="${root_css_class}" dir="<@liferay.language key="lang.dir" />" lang="${w3c_language_id}">

<#assign user = themeDisplay.getUser() />
<#assign userId = user.getUserId() />
<#assign fullName = user.getFullName() />
<#assign emailAddress = user.getEmailAddress() />
<#assign groups = user.getGroups() />


<head>
	<title>${html_title}</title>

	<meta content="initial-scale=1.0, width=device-width" name="viewport" />

	<@liferay_util["include"] page=top_head_include />
</head>

<body class="${css_class}">

<@liferay_ui["quick-access"] contentId="#main-content" />

<@liferay_util["include"] page=body_top_include />

<@liferay.control_menu />

<div class="container-fluid position-relative p-0" id="wrapper">

	<section id="content">
		<h2 class="hide-accessible sr-only" role="heading" aria-level="1">${htmlUtil.escape(the_title)}</h2>

		<#if selectable>
			<@liferay_util["include"] page=content_include />
		<#else>
			${portletDisplay.recycle()}

			${portletDisplay.setTitle(the_title)}

			<@liferay_theme["wrap-portlet"] page="portlet.ftl">
				<@liferay_util["include"] page=content_include />
			</@>
		</#if>
	</section>

</div>

<@liferay_util["include"] page=body_bottom_include />

<@liferay_util["include"] page=bottom_include />

<style>
	.portlet-content{
	    padding: 0 !important;
	    border: none !important;
	}
</style>

<script>
	<#if is_signed_in>
	    const liferayUser = {
	        userId: "${userId}",
	        fullName: "${fullName}",
	        email: "${emailAddress}",
	        groups: [
				<#list groups as group>
				{
				    id: "${group.getGroupId()}",
				    name: "${group.getDescriptiveName(themeDisplay.getLocale())}"
				}<#if group_has_next>,</#if>
				</#list>
			]
	    };
	    sessionStorage.setItem("liferayUser", JSON.stringify(liferayUser));
	    console.log("Liferay User:", liferayUser);
	<#else>
	    sessionStorage.removeItem('liferayUser');
        sessionStorage.removeItem('token');
	</#if>
</script>

</body>

</html>
