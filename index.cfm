<cflocation url="default.cfm?message=moved from index" addtoken="false">
<cf_layout>
	<cf_head>
		<script type="text/javascript" src="assets/js/script.js"></script>
	</cf_head>
		<div id="container">
			<div id="header">
				<div id="logo">&nbsp;</div>
			</div>
			<div id="subheading">
				Application Settings
			</div>
			<div id="credits">
				<a href="http://www.joshknutson.net" onclick="target='_blank';" title="http://www.joshknutson.net">http://www.joshknutson.net</a><br/>
	            Send Bugs to <a href="mailto:josh.knutson@gmail.com" title="Email Me">josh.knutson@gmail.com</a>
            </div>

<div id="content">
				   <cfoutput>
		           <cfform id="appSettings" name="appSettings" method="post" action="tableSettings.cfm">
					<fieldset>
						<legend>Database Settings</legend>
			              <ol>
							<li><cftooltip hideDelay="250" tooltip="Enter the ColdFusion datasource for this applications database"><img src="assets/images/help.png"></cftooltip>
								<label for="datasource">Datasource Name</label>
								<cfif isDefined('url.datasource')>
									<cfinput type="text" name="datasource" id="datasource" value="#url.datasource#" required="true" message="Datasource is required" />
								<cfelse>
									<cfinput type="text" name="datasource" id="datasource" required="true" message="Datasource is required" />
								</cfif>
							</li>
						  </ol>
					</fieldset>
					<br/>
					<fieldset>
						<legend>Application Settings</legend>
						<ol>
							<li><cftooltip hideDelay="250" tooltip="The code generator can create a complete Application.cfc file prefilled with useful application variables and functions"><img src="assets/images/help.png"></cftooltip>Do you want an Application.cfc file created?
								<li class="sub"><input name="appCFC" type="radio" id="noApp" value="false" checked="checked" onClick="funNoApp();" /> No, Don't Generate the Application CFC </li>
								<li class="sub"><input name="appCFC" type="radio" id="genApp" value="true" onClick="funGenApp();" <cfif isDefined('url.appCFC')><cfif url.appCFC EQ true>checked="checked"</cfif></cfif> /> Yes, Generate the Application CFC File</li>
							</li>
							<li><cftooltip hideDelay="250" tooltip="How do you want the path to your cfcs and the datasource name encoded, as an application variable or hardcoded into each CreateObject statement?"><img src="assets/images/help.png"></cftooltip>Do you want the component path and datasource name set using an Application variable or hardcoded?
								<li class="sub"><input name="pathType" type="radio" id="useHardcodedPath" value="useHardcodedPath" disabled="disabled" checked="checked" /> Use Hardcoded Path and datasource settings</li>
								<li class="sub"><input name="pathType" type="radio" id="useAppPath" value="useAppPath" disabled="disabled" <cfif isDefined('url.pathType')><cfif url.pathType EQ "useAppPath">checked="checked"</cfif></cfif> /> Use Application Path and datasource settings</li>
							</li>
							<li><cftooltip hideDelay="250" tooltip="If you are using ColdFusion 8 (Not dependent on previous answer) you can use the richtext feature of the textarea fields"><img src="assets/images/help.png"></cftooltip>If you are using CF8 do you want to use Rich Text Area?
								<li class="sub"><input type="radio" name="useRTE" id="useRTE" value="false" disabled="disabled" checked="checked" /> No, use a plan textarea field</li>
								<li class="sub"><input type="radio" name="useRTE" id="useRTE" value="true" disabled="disabled" <cfif isDefined('url.useRTE')><cfif url.useRTE EQ true>checked="checked"</cfif></cfif> /> Yes, use RTE on textarea fields</li>
							</li>
							<li><cftooltip hideDelay="250" tooltip="Would you like these files to be placed in a folder section (Data Table (or Grid) and the Form will be placed in the created folder)"><img src="assets/images/help.png"></cftooltip>Should the user interface scripts be placed in a subfolder?
								<li class="sub"><input type="radio" name="isAdmin" id="isAdmin" value="false" onClick="funNoAdmin();" checked="checked" /> No, place files in root folder</li>
								<li class="sub"><input type="radio" name="isAdmin" id="isAdmin" value="true" onClick="funIsAdmin();" <cfif isDefined('url.isAdmin')><cfif url.isAdmin EQ true>checked="checked"</cfif></cfif> /> Yes, create and place files in the following folder: <input type="text" name="adminFolder" id="adminFolder" <cfif isDefined('url.adminFolder')>value="#url.adminFolder#"</cfif> disabled="disabled"></li>
							</li>
							<!--- <li><cftooltip hideDelay="250" tooltip="If yes a Flex value object and a Flex CRUD form component will be generated."><img src="assets/images/help.png"></cftooltip>Would you like to generate a value object and component for Flex?
								<li class="sub"><input type="radio" name="forFlex" id="forFlex" value="false" checked="checked" /> No, this is strictly a CF application</li>
								<li class="sub"><input type="radio" name="forFlex" id="forFlex" value="true" <cfif isDefined('url.forFlex')><cfif url.forFlex EQ true>checked="checked"</cfif></cfif> /> Yes, please create the value object and form component for Flex</li>
							</li> --->
							<li class="btn"><input type="submit" name="button" id="button" value="Next >>" /></li>
						</ol>
					</fieldset>
						<input type="hidden" value="true" name="cf8" id="cf8" />
		     		</cfform>
		     		</cfoutput>
			</div>
			<div id="footer">&nbsp;</div>
		</div>
</cf_layout>