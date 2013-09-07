<cfajaximport tags="cfform,cftree,cfgrid,cftooltip,cfwindow,cflayout-tab">
<cf_layout>

<cf_head>
<script type="text/javascript">
function setDSN(dsn) {
	ColdFusion.navigate('main.cfm?dsn='+escape(dsn),'main');
}
function setHideTables(toggle) {
	ColdFusion.navigate('main.cfm?hidetables='+escape(toggle),'main');
}
function setType(toggle) {
	ColdFusion.navigate('main.cfm?generateType='+escape(toggle),'main');
}
<!--- The error handler pops an alert with the error code and message. --->
    var myerrorhandler = function(errorCode,errorMessage){
        alert("[In Error Handler]" + "\n\n" + "Error Code: " + errorCode + "\n\n" + "Error Message: " + errorMessage);
    }
</script>
</cf_head>

<cflayout type="border">

	<cflayoutarea position="top" maxsize="80" >

		<cfset datasources = structKeyList(application.dsObj.getDatasources())>
		<cfset datasources = listSort(datasources, "textnocase")>

		<table width="100%" cellpadding="5" cellspacing="0" border="0" class="topbody">
		<tr>
		<td><span class="apptitle">Coldfusion Rapid Application Construction Kit</span></td>
		<td align="right" valign="middle">
		<span class="dsselector">
			<label for="forType">Generate What</label>
			<select name="forType" id="forType" onchange="setType(this.options[this.selectedIndex].value);">
				<option value="models" <cfif session.generateType is "model">selected="selected"</cfif>>Model</option>
				<option value="gateway" <cfif session.generateType is "gateway">selected="selected"</cfif>>Gateway</option>
			</select>
			<select name="dsn" onchange="setDSN(this.options[this.selectedIndex].value)">
			<option value="">Select Datasource:</option>
			<cfloop list="#datasources#" index="dsn">
				<cfoutput><option value="#dsn#" <cfif session.dsn is dsn>selected="selected"</cfif> >#dsn#</option></cfoutput>
			</cfloop>
			</select>
			<label for="hidetables">Hide System Tables</label>
			<input type="checkbox" id="hidetables" onchange="setHideTables(this.checked)" <cfif session.hidetables>checked="checked" title="Show System Tables if you uncheck this box"<cfelse>title="Hide System Tables if you check this box"</cfif> />

			<a href="index.cfm?logout=youbet" title="[Logout]">[Logout]</a>
		</span>
		</td>
		</tr>
		</table>
	</cflayoutarea>
	<cfif len(session.dsn)>
		<cfset source = "main.cfm">
	<cfelse>
		<cfset source = "welcome.cfm">
	</cfif>
	<cflayoutarea position="center" name="main" source="#source#" />

</cflayout>
</cf_layout>