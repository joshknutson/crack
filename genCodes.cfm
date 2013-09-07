<cfset codeGenerator = CreateObject("component", "cfcs.services.codeGenerator").init(#url.table#,#url.datasource#,#url.revTable#,#url.pathType#,#url.cf8#,#url.useRTE#) />
<cfif url.method EQ "bean">
	<cfset getCode = codeGenerator.generateBean()>
<cfelseif url.method EQ "dao">
	<cfset getCode = codeGenerator.generateDAO()>
<cfelseif url.method EQ "gateway">
	<cfset getCode = codeGenerator.generateGateway()>
<cfelseif url.method EQ "controller">
	<cfset getCode = codeGenerator.generateController()>
<cfelseif url.method EQ "datatable" or url.method EQ "datagrid">
	<cfset getCode = codeGenerator.generateDatatable()>
<cfelseif url.method EQ "form">
	<cfset getCode = codeGenerator.generateForm()>
<cfelseif url.method EQ "application">
	<cfset getCode = codeGenerator.generateApplicationCFC()>
<cfelse>
	<cfset getCode = "Could not find specified method">
</cfif>
<cfset getCode =  replaceList(getCode,"<%,%,^","&lt;,##,%") />
<cfoutput>
	<pre>#getCode#</pre>
</cfoutput>