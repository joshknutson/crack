<cfparam name="author" type="string" default="">
<cfparam name="datasource" type="string" default="">
<cfparam name="pathType" type="string" default="useHardcodedPath">
<cfparam name="cf8" type="boolean" default="false">
<cfparam name="useRTE" type="boolean" default="false">
<cfparam name="appCFC" type="boolean" default="false">
<cfparam name="isAdmin" type="boolean" default="false">
<cfparam name="adminFolder" type="string" default="">
<cfparam name="generateType" type="string" default="false">

<cfdbinfo datasource="#datasource#" name="tableList" type="tables" />

<cf_layout>

		<div id="container">
			<div id="header">
				<div id="logo">&nbsp;</div>
			</div>
			<div id="subheading">
				Table Settings<br/>
				<img src="assets/images/application_edit.png" /> <cfoutput><a title="Change Application Setting href="index.cfm?author=#author#&datasource=#datasource#&pathType=#pathType#&useRTE=#useRTE#&cf8=#cf8#&appCFC=#appCFC#&isAdmin=#isAdmin#&adminFolder=#adminFolder#&generateType=#generateType#"></cfoutput>Change Application Settings</a><br/>
			</div>
			<div id="credits">
				<a href="http://joshknutson.github.io/" target="_blank" title="http://joshknutson.github.io/>http://joshknutson.github.io/</a><br/>
	            Send Bugs to <a href="mailto:josh.knutson@gmail.com" title="Email Me">josh.knutson@gmail.com</a>
            </div>

			<div id="content">
				<cfoutput>
            	<form id="Form" name="Form" method="post" action="codeLinks.cfm">
					<fieldset>
						<legend>Table Settings</legend>
			              <ol>
							<li><cftooltip autoDismissDelay="0" tooltip="Select the table for which you want to create CRUD code"><img src="assets/images/help.png"></cftooltip><label for="table">Table Name</label>
								<select name="table" id="table" >
										        <cfloop query="tableList">
										             <option <cfif isDefined('url.table')><cfif url.table EQ #tableList.table_name#>Selected</cfif></cfif>>#tableList.table_name#</option>
										        </cfloop>
										   </select>
							</li>
							<li><cftooltip autoDismissDelay="0" tooltip="Enter a more grammer correct name for this table (used for titling purposes)"><img src="assets/images/help.png"></cftooltip>Revised Name <input type="text" name="revTable" id="revTable" <cfif isDefined('url.revTable')>value="#url.revTable#"</cfif> /></li>
							<li><cftooltip autoDismissDelay="0" tooltip="If a file already exists should the code generator skip that file or overwrite the file with a the new version? (Only used when the generator writes files to the system)"><img src="assets/images/help.png"></cftooltip>If the file exists...
								<li class="sub"><input type="radio" name="ifExists" id="ifExists" value="skip" checked="checked" />Skip the file</li>
								<li class="sub"><input type="radio" name="ifExists" id="ifExists" value="overwrite" <cfif isDefined('url.ifExists')><cfif url.ifExists EQ "overwrite">checked="checked"</cfif></cfif> />Overwrite the file</li>
							</li>
							<cfoutput>
								<input type="hidden" value="#author#" name="author">
								<input type="hidden" value="#datasource#"  name="datasource">
								<input type="hidden" value="#pathType#"  name="pathType">
								<input type="hidden" value="#cf8#"  name="cf8">
								<input type="hidden" value="#useRTE#"  name="useRTE">
								<input type="hidden" value="#appCFC#" name="appCFC">
								<input type="hidden" value="#isAdmin#" name="isAdmin">
								<input type="hidden" value="#adminFolder#" name="adminFolder">
								<input type="hidden" value="#generateType#" name="model">
							</cfoutput>
							<li class="btn"><input type="submit" name="button" id="button" value="Next >>" /></li>
						  </ol>
					</fieldset>
      			</form>
				</cfoutput>
			</div>
			<div id="footer"&nbsp;</div>
		</div>
</cf_layout>