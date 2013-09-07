<cfparam name="author" type="string" default="">
<cfparam name="datasource" type="string" default="">
<cfparam name="pathType" type="string" default="useHardcodedPath">
<cfparam name="cf8" type="boolean" default="true">
<cfparam name="useRTE" type="boolean" default="false">
<cfparam name="appCFC" type="boolean" default="true">
<cfparam name="table" type="string" default="">
<cfparam name="revTable" type="string" default="">
<cfparam name="isAdmin" type="boolean" default="false">
<cfparam name="adminFolder" type="string" default="">
<cfparam name="ifExists" type="string" default="skip">

<cfset rootPath = #expandpath("../.")#>

<cfif find("/",rootPath) GT 0>
	<cfset slash = "/">
<cfelse>
	<cfset slash = "\">
</cfif>

<cfset adminPath="#rootPath##slash##adminFolder#">

<cf_layout>
		<div id="container">
			<div id="cfWindowHeader">
				<div id="cfWindowLogo">&nbsp;</div>
			</div>
			<div id="cfWindowContent">
				<h2>Creating Directory Structure</h2>
				<cfif NOT DirectoryExists( ExpandPath( "..#slash##datasource##slash#app" ) )>
				    <cfdirectory action="create" directory="#rootPath##slash##datasource##slash#app">
					app directory was created.<br />
				<cfelse>
					app directory already existed.<br />
				</cfif>

				<cfif NOT DirectoryExists( ExpandPath( "..#slash##datasource##slash#config" ) )>
				    <cfdirectory action="create" directory="#rootPath##slash##datasource##slash#config">
					config directory was created.<br />
				<cfelse>
					config directory already existed.<br />
				</cfif>


				<cfif NOT DirectoryExists( ExpandPath( "..#slash##datasource##slash#app#slash#views" ) )>
				    <cfdirectory action="create" directory="#rootPath##slash##datasource##slash#app#slash#views">
					views directory was created.<br />
				<cfelse>
					views directory already existed.<br />
				</cfif>

				<cfif NOT DirectoryExists( ExpandPath( "..#slash##datasource##slash#app#slash#beans" ) )>
				    <cfdirectory action="create" directory="#rootPath##slash##datasource##slash#app#slash#beans">
					Beans directory was created.<br />
				<cfelse>
					Beans directory already existed.<br />
				</cfif>

				<cfif NOT DirectoryExists( ExpandPath( "..#slash##datasource##slash#app#slash#helpers" ) )>
				    <cfdirectory action="create" directory="#rootPath##slash##datasource##slash#app#slash#helpers">
					helpers directory was created.<br />
				<cfelse>
					helpers directory already existed.<br />
				</cfif>

				<cfif NOT DirectoryExists( ExpandPath( "..#slash##datasource##slash#app#slash#helpers#slash#grids" ) )>
				    <cfdirectory action="create" directory="#rootPath##slash##datasource##slash#app#slash#helpers#slash#grids">
					grids directory was created.<br />
				<cfelse>
					grids directory already existed.<br />
				</cfif>

				<cfif NOT DirectoryExists( ExpandPath( "..#slash##datasource##slash#app#slash#dataobjects" ) )>
				    <cfdirectory action="create" directory="#rootPath##slash##datasource##slash#app#slash#dataobjects">
					Dataobjects directory was created.<br />
				<cfelse>
					Dataobjects directory already existed.<br />
				</cfif>

				<cfif NOT DirectoryExists( ExpandPath( "..#slash##datasource##slash#app#slash#views#slash#layouts" ) )>
				    <cfdirectory action="create" directory="#rootPath##slash##datasource##slash#app#slash#views#slash#layouts">
					layouts directory was created.<br />
				<cfelse>
					layouts directory already existed.<br />
				</cfif>

				<cfif isAdmin EQ true>
                    <cfif NOT DirectoryExists( ExpandPath( "..#slash##adminFolder#" ) )>
                        <cfdirectory action="create" directory="#rootPath##slash##adminFolder#">
                        <cfoutput>#adminFolder#</cfoutput> directory was created.<br />
                    <cfelse>
                        <cfoutput>#adminFolder#</cfoutput> directory already existed.<br />
                    </cfif>

					<cfif NOT DirectoryExists( ExpandPath( "..#slash##adminfolder##slash#controllers" ) )>
                        <cfdirectory action="create" directory="#rootPath##slash##adminFolder##slash#controllers">
                        Controllers directory was created.<br />
                    <cfelse>
                        Controllers directory already existed.<br />
                    </cfif>
                <cfelse>
					<cfif NOT DirectoryExists( ExpandPath( "..#slash##datasource##slash#app#slash#controllers" ) )>
                        <cfdirectory action="create" directory="#rootPath##slash##datasource##slash#app#slash#controllers">
                        Controllers directory was created.<br />
                    <cfelse>
                        Controllers directory already existed.<br />
                    </cfif>
                </cfif>

				<cfif NOT DirectoryExists( ExpandPath( "..#slash##datasource##slash#assets" ) )>
					<cfdirectory action="create" directory="#rootPath##slash##datasource##slash#assets">
					Assets directory was created.<br />
				<cfelse>
					Assets directory already existed.<br />
				</cfif>


				<cfif NOT DirectoryExists( ExpandPath( "..#slash##datasource##slash#assets#slash#js" ) )>
					<cfdirectory action="create" directory="#rootPath##slash##datasource##slash#assets#slash#js">
					JS directory was created.<br />
				<cfelse>
					JS directory already existed.<br />
				</cfif>

				<cfif NOT DirectoryExists( ExpandPath( "..#slash##datasource##slash#assets#slash#css" ) )>
					<cfdirectory action="create" directory="#rootPath##slash##datasource##slash#assets#slash#css">
					CSS directory was created.<br />
				<cfelse>
					CSS directory already existed.<br />
				</cfif>

                <cfif NOT DirectoryExists( ExpandPath( "..#slash##datasource##slash#assets#slash#images" ) )>
                    <cfdirectory action="create" directory="#rootPath##slash##datasource##slash#assets#slash#images">
                    Images directory was created.<br />
                <cfelse>
                    Images directory already existed.<br />
                </cfif>

				<br/><br/>
				<h2>Writing Files to the System</h2>
				<cfloop list="#tableList#" index="table">
					<cfif NOT DirectoryExists( ExpandPath( "..#slash##datasource##slash#app#slash#views#slash##table#" ) )>
				    <cfdirectory action="create" directory="#rootPath##slash##datasource##slash#app#slash#views#slash##table#">
					<cfoutput>#table#</cfoutput>directory was created.<br />
				<cfelse>
					<cfoutput>#table#</cfoutput> directory already existed.<br />
				</cfif>
				<cfset codeGenerator = CreateObject("component", "cfcs.services.codeGenerator").init(#author#,#table#,#datasource#,#revTable#,#pathType#,#cf8#,#useRTE#,#appCFC#,#isAdmin#) />
				<cfset generateBean = codeGenerator.generateBean() />
				<cfset generateDAO = codeGenerator.generateDAO() />
				<cfset generateGateway = codeGenerator.generateGateway() />
				<cfset generateLayout = trim(codeGenerator.generateLayout()) />
				<cfset generateCSS = trim(codeGenerator.generateCSS()) />
				<cfset generateController = codeGenerator.generateModelController() />
				<cfset generateForm = trim(codeGenerator.generateForm()) />
				<cfset generateDataTable = trim(codeGenerator.generateDataTable()) />
				<cfset generateDefault = trim(codeGenerator.generateDefault()) />
				<cfset generateApplicationCFC = trim(codeGenerator.generateApplicationCFC()) />
				<cfset generateHelperNavigation = trim(codeGenerator.generateHelperNavigation()) />

				<cfif FileExists( ExpandPath( "..#slash##datasource##slash#app#slash#helpers#slash#hlp_navigation.cfc" ) ) AND ifExists EQ "skip">
					<cfoutput>#slash##datasource##slash#app#slash#helpers#slash#hlp_navigation.cfc already existed and was skipped.<br /></cfoutput>
				<cfelse>
					<cfif NOT FileExists( ExpandPath( "..#slash##datasource##slash#app#slash#helpers#slash#hlp_navigation.cfc" ) )>
				    	<cfoutput>#slash##datasource##slash#app#slash#helpers#slash#hlp_navigation.cfc has been created.<br /></cfoutput>
					<cfelse>
						<cfoutput>#slash##datasource##slash#app#slash#helpers#slash#hlp_navigation.cfc existed and was overwritten.<br /></cfoutput>
					</cfif>
					<cfset generateHelperNavigation =  replaceList(generateHelperNavigation,"<%,%,$@'","<,##,%") />
					<cffile action="write" file="#rootPath##slash##datasource##slash#app#slash#helpers#slash#hlp_navigation.cfc" output="#generateHelperNavigation#" nameconflict="overwrite">
				</cfif>


				<cfif FileExists( ExpandPath( "..#slash##datasource##slash#app#slash#beans#slash#bean_#table#.cfc" ) ) AND ifExists EQ "skip">
					<cfoutput>#slash##datasource##slash#app#slash#beans#slash#bean_#table#.cfc already existed and was skipped.<br /></cfoutput>
				<cfelse>
					<cfif NOT FileExists( ExpandPath( "..#slash##datasource##slash#app#slash#beans#slash#bean_#table#.cfc" ) )>
				    	<cfoutput>#slash##datasource##slash#app#slash#beans#slash#bean_#table#.cfc has been created.<br /></cfoutput>
					<cfelse>
						<cfoutput>#slash##datasource##slash#app#slash#beans#slash#bean_#table#.cfc existed and was overwritten.<br /></cfoutput>
					</cfif>
					<cfset generateBean =  replaceList(generateBean,"<%,%,$@'","<,##,%") />
					<cffile action="write" file="#rootPath##slash##datasource##slash#app#slash#beans#slash#bean_#table#.cfc" output="#generateBean#" nameconflict="overwrite">
				</cfif>

				<cfif FileExists( ExpandPath( "..#slash##datasource##slash#app#slash#dataobjects#slash##table#dao.cfc" ) ) AND ifExists EQ "skip">
					<cfoutput>#slash##datasource##slash#app#slash#dataobjects#slash##table#dao.cfc already existed and was skipped.<br /></cfoutput>
				<cfelse>
					<cfif NOT FileExists( ExpandPath( "..#slash##datasource##slash#app#slash#dataobjects#slash##table#dao.cfc" ) )>
				    	<cfoutput>#slash##datasource##slash#app#slash#dataobjects#slash##table#dao.cfc has been created.<br /></cfoutput>
					<cfelse>
						<cfoutput>#slash##datasource##slash#app#slash#dataobjects#slash##table#dao.cfc existed and was overwritten.<br /></cfoutput>
					</cfif>
					<cfset generateDAO =  replaceList(generateDAO,"<%,%,^","<,##,%") />
					<cffile action="write" file="#rootPath##slash##datasource##slash#app#slash#dataobjects#slash##table#dao.cfc" output="#generateDAO#" nameconflict="overwrite">
				</cfif>

				<cfif FileExists( ExpandPath( "..#slash##datasource##slash#app#slash#dataobjects#slash##table#Gateway.cfc" ) ) AND ifExists EQ "skip">
					<cfoutput>#slash##datasource##slash#app#slash#dataobjects#slash##table#Gateway.cfc already existed and was skipped.<br /></cfoutput>
				<cfelse>
					<cfif NOT FileExists( ExpandPath( "..#slash##datasource##slash#app#slash#dataobjects#slash##table#Gateway.cfc" ) )>
				    	<cfoutput>#slash##datasource##slash#app#slash#dataobjects#slash##table#Gateway.cfc has been created.<br /></cfoutput>
					<cfelse>
						<cfoutput>#slash##datasource##slash#app#slash#dataobjects#slash##table#Gateway.cfc existed and was overwritten.<br /></cfoutput>
					</cfif>
					<cfset generateGateway =  replaceList(generateGateway,"<%,%,^","<,##,%") />
					<cffile action="write" file="#rootPath##slash##datasource##slash#app#slash#dataobjects#slash##table#Gateway.cfc" output="#generateGateway#" nameconflict="overwrite">
				</cfif>

				<cfif FileExists( ExpandPath( "..#slash##datasource##slash#app#slash#views#slash#layouts#slash#layout.cfm" ) ) AND ifExists EQ "skip">
					<cfoutput>#slash##datasource##slash#app#slash#views#slash#layouts#slash#layout.cfm already existed and was skipped.<br /></cfoutput>
				<cfelse>
					<cfif NOT FileExists( ExpandPath( "..#slash##datasource##slash#app#slash#views#slash#layouts#slash#layout.cfm" ) )>
				    	<cfoutput>#slash##datasource##slash#app#slash#views#slash#layouts#slash#layout.cfm has been created.<br /></cfoutput>
					<cfelse>
						<cfoutput>#slash##datasource##slash#app#slash#views#slash#layouts#slash#layout.cfm existed and was overwritten.<br /></cfoutput>
					</cfif>
					<cfset generateLayout =  replaceList(generateLayout,"<%,%,^","<,##,%") />
					<cffile action="write" file="#rootPath##slash##datasource##slash#app#slash#views#slash#layouts#slash#layout.cfm" output="#generateLayout#" nameconflict="overwrite">
				</cfif>

				<cfif FileExists( ExpandPath( "..#slash##datasource##slash#assets#slash#css#slash##datasource#.css" ) ) AND ifExists EQ "skip">
					<cfoutput>#slash##datasource##slash#assets#slash#css#slash#layouts#slash##datasource#.css already existed and was skipped.<br /></cfoutput>
				<cfelse>
					<cfif NOT FileExists( ExpandPath( "..#slash##datasource##slash#assets#slash#css#slash##datasource#.css" ) )>
				    	<cfoutput>#slash##datasource##slash#assets#slash#css#slash##datasource#.css has been created.<br /></cfoutput>
					<cfelse>
						<cfoutput>#slash##datasource##slash#assets#slash#css#slash##datasource#.css existed and was overwritten.<br /></cfoutput>
					</cfif>
					<cfset generateCSS =  replaceList(generateCSS,"<%,%,^","<,##,%") />
					<cffile action="write" file="#rootPath##slash##datasource##slash#assets#slash#css#slash##datasource#.css" output="#generateCSS#" nameconflict="overwrite">
				</cfif>

                <cfif isAdmin EQ true>
					<cfif FileExists( ExpandPath( "..#slash##adminFolder##slash#controllers#slash#cnt_#table#.cfc" ) ) AND ifExists EQ "skip">
                        <cfoutput>#slash##adminFolder##slash#controllers#slash#cnt_#table#.cfc already existed and was skipped.<br /></cfoutput>
                    <cfelse>
                        <cfif NOT FileExists( ExpandPath( "..#slash##adminFolder##slash#controllers#slash#cnt_#table#.cfc" ) )>
                            <cfoutput>#slash##adminFolder##slash#controllers#slash#cnt_#table#.cfc has been created.<br /></cfoutput>
                        <cfelse>
                            <cfoutput>#slash##adminFolder##slash#controllers#slash#cnt_#table#.cfcexisted and was overwritten.<br /></cfoutput>
                        </cfif>
                        <cfset generateController =  replaceList(generateController,"<%,%,^","<,##,%") />
                        <cffile action="write" file="#rootPath##slash##adminFolder##slash#controllers#slash#cnt_#table#.cfc" output="#generateController#" nameconflict="overwrite">
                    </cfif>

					<cfif FileExists( ExpandPath( "..#slash##adminFolder##slash##table##slash#edit.cfm" ) ) AND ifExists EQ "skip">
                        <cfoutput>#slash##adminFolder##slash##table##slash#edit.cfm already existed and was skipped.<br /></cfoutput>
                    <cfelse>
                        <cfif NOT FileExists( ExpandPath( "..#slash##adminFolder##slash##table##slash#edit.cfm" ) )>
                            <cfoutput>#slash##adminFolder##slash##table##slash#edit.cfm has been created.<br /></cfoutput>
                        <cfelse>
                            <cfoutput>#slash##adminFolder##slash##table##slash#edit.cfm existed and was overwritten.<br /></cfoutput>
                        </cfif>
                        <cfset generateForm =  replaceList(generateForm,"<%,%,^","<,##,%") />
                        <cffile action="write" file="#rootPath##slash##adminFolder##slash##table##slash#edit.cfm" output="#generateForm#" nameconflict="overwrite">
                    </cfif>

                    <cfif cf8 EQ false>
                        <cfif FileExists( ExpandPath( "..#slash##adminFolder##slash##table##slash#default.cfm" ) ) AND ifExists EQ "skip">
                            <cfoutput>#slash##adminFolder##slash##table##slash#default already existed and was skipped.<br /></cfoutput>
                        <cfelse>
                            <cfif NOT FileExists( ExpandPath( "..#slash##adminFolder##slash##table##slash#default.cfm" ) )>
                                <cfoutput>#slash##adminFolder##slash##table##slash#default has been created.<br /></cfoutput>
                            <cfelse>
                                <cfoutput>#slash##adminFolder##slash##table##slash#default existed and was overwritten.<br /></cfoutput>
                            </cfif>
                            <cfset generateDefault =  replaceList(generateDefault,"<%,%,^","<,##,%") />
                            <cffile action="write" file="#rootPath##slash##adminFolder##slash##table##slash#default.cfm" output="#generateDefault#" nameconflict="overwrite">
                        </cfif>
                    <cfelse>
                        <cfif FileExists( ExpandPath( "..#slash##adminFolder##slash##table##slash#default.cfm" ) ) AND ifExists EQ "skip">
                            <cfoutput>#slash##adminFolder##slash##table##slash#default already existed and was skipped.<br /></cfoutput>
                        <cfelse>
                            <cfif NOT FileExists( ExpandPath( "..#slash##adminFolder##slash##table##slash#default.cfm" ) )>
                                <cfoutput>#slash##adminFolder##slash##table##slash#default has been created.<br /></cfoutput>
                            <cfelse>
                                <cfoutput>#slash##adminFolder##slash##table##slash#default existed and was overwritten.<br /></cfoutput>
                            </cfif>
                            <cfset generateDefault =  replaceList(generateDefault,"<%,%,^","<,##,%") />
                            <cffile action="write" file="#rootPath##slash##adminFolder##slash##table##slash#default.cfm" output="#generateDefault#" nameconflict="overwrite">
                        </cfif>
                    </cfif>

                    <cfif appCFC EQ true>
                        <cfif FileExists( ExpandPath( "..#slash##adminFolder##slash##datasource##slash#application.cfc" ) ) AND ifExists EQ "skip">
                            <cfoutput>#slash##adminFolder##slash##datasource##slash#application.cfc already existed and was skipped.<br /></cfoutput>
                        <cfelse>
                            <cfif NOT FileExists( ExpandPath( "..#slash##adminFolder##slash##datasource##slash#application.cfc" ) )>
                                <cfoutput>#slash##adminFolder##slash##datasource##slash#application.cfc has been created.<br /></cfoutput>
                            <cfelse>
                                <cfoutput>#slash##adminFolder##slash##datasource##slash#application.cfc existed and was overwritten.<br /></cfoutput>
                            </cfif>
                            <cfset generateApplicationCFC =  replaceList(generateApplicationCFC,"<%,%,^","<,##,%") />
                            <cffile action="write" file="#rootPath##slash##adminFolder##slash##datasource##slash#application.cfc" output="#generateApplicationCFC#" nameconflict="overwrite">
                        </cfif>
                    </cfif>
                <cfelse>
					<cfif FileExists( ExpandPath( "..#slash##datasource##slash#app#slash#controllers#slash#cnt_#table#.cfc" ) ) AND ifExists EQ "skip">
                        <cfoutput>#slash#controllers#slash#cnt_#table#.cfc already existed and was skipped.<br /></cfoutput>
                    <cfelse>
                        <cfif NOT FileExists( ExpandPath( "..#slash##datasource##slash#app#slash#controllers#slash#cnt_#table#.cfc" ) )>
                            <cfoutput>#slash#controllers#slash#cnt_#table#.cfc has been created.<br /></cfoutput>
                        <cfelse>
                            <cfoutput>#slash#controllers#slash#cnt_#table#.cfc existed and was overwritten.<br /></cfoutput>
                        </cfif>
                        <cfset generateController =  replaceList(generateController,"<%,%,^","<,##,%") />
                        <cffile action="write" file="#rootPath##slash##datasource##slash#app#slash#controllers#slash#cnt_#table#.cfc" output="#generateController#" nameconflict="overwrite">
                    </cfif>

					<cfif FileExists( ExpandPath( "..#slash##datasource##slash#app#slash#views#slash##table##slash#edit.cfm" ) ) AND ifExists EQ "skip">
                        <cfoutput>#slash##table##slash#edit.cfm already existed and was skipped.<br /></cfoutput>
                    <cfelse>
                        <cfif NOT FileExists( ExpandPath( "..#slash##datasource##slash##table##slash#views##slashedit.cfm" ) )>
                            <cfoutput>#slash##table##slash#edit.cfm has been created.<br /></cfoutput>
                        <cfelse>
                            <cfoutput>#slash##table##slash#edit.cfm existed and was overwritten.<br /></cfoutput>
                        </cfif>
                        <cfset generateForm =  replaceList(generateForm,"<%,%,^","<,##,%") />
                        <cffile action="write" file="#rootPath##slash##datasource##slash#app#slash#views#slash##table##slash#edit.cfm" output="#generateForm#" nameconflict="overwrite">
                    </cfif>

                   <!---<cfif cf8 EQ false>
                        <cfif FileExists( ExpandPath( "..#slash##table##slash#default.cfm" ) ) AND ifExists EQ "skip">
                            <cfoutput>#slash##table##slash#default already existed and was skipped.<br /></cfoutput>
                        <cfelse>
                            <cfif NOT FileExists( ExpandPath( "..#slash##table##slash#default.cfm" ) )>
                                <cfoutput>#slash##table##slash#default has been created.<br /></cfoutput>
                            <cfelse>
                                <cfoutput>#slash##table##slash#default existed and was overwritten.<br /></cfoutput>
                            </cfif>
                            <cfset generateDefault =  replaceList(generateDefault,"<%,%,^","<,##,%") />
                            <cffile action="write" file="#rootPath##slash##table##slash#default.cfm" output="#generateDefault#" nameconflict="overwrite">
                        </cfif>
                    <cfelse>--->
                        <cfif FileExists( ExpandPath( "..#slash##datasource##slash#app#slash#views#slash##table##slash#default.cfm" ) ) AND ifExists EQ "skip">
                            <cfoutput>#slash##table##slash#default already existed and was skipped.<br /></cfoutput>
                        <cfelse>
                            <cfif NOT FileExists( ExpandPath( "..#slash##datasource##slash#app#slash#views#slash##table##slash#default.cfm" ) )>
                                <cfoutput>#slash##table##slash#default has been created.<br /></cfoutput>
                            <cfelse>
                                <cfoutput>#slash##table##slash#default existed and was overwritten.<br /></cfoutput>
                            </cfif>
                            <cfset generateDefault =  replaceList(generateDefault,"<%,%,^","<,##,%") />
                            <cffile action="write" file="#rootPath##slash##datasource##slash#app#slash#views#slash##table##slash#default.cfm" output="#generateDefault#" nameconflict="overwrite">
                        </cfif>
                    <!---</cfif>--->

                    <cfif appCFC EQ true>
                        <cfif FileExists( ExpandPath( "..#slash##datasource##slash#application.cfc" ) ) AND ifExists EQ "skip">
                            <cfoutput>#slash##datasource##slash#application.cfc already existed and was skipped.<br /></cfoutput>
                        <cfelse>
                            <cfif NOT FileExists( ExpandPath( "..#slash##datasource##slash#application.cfc" ) )>
                                <cfoutput>#slash##datasource##slash#application.cfc has been created.<br /></cfoutput>
                            <cfelse>
                                <cfoutput>#slash##datasource##slash#application.cfc existed and was overwritten.<br /></cfoutput>
                            </cfif>
                            <cfset generateApplicationCFC =  replaceList(generateApplicationCFC,"<%,%,^","<,##,%") />
                            <cffile action="write" file="#rootPath##slash##datasource##slash#application.cfc" output="#generateApplicationCFC#" nameconflict="overwrite">
                        </cfif>
                    </cfif>
                </cfif>

				<!--- <cfif forFlex eq true>
					<cfif FileExists( ExpandPath( "..#slash##datasource##slash#app#slash#views#slash#layouts#slash#layout.cfm" ) ) AND ifExists EQ "skip">
						<cfoutput>#slash##datasource##slash#app#slash#views#slash#layouts#slash#layout.cfm already existed and was skipped.<br /></cfoutput>
					<cfelse>
						<cfif NOT FileExists( ExpandPath( "..#slash##datasource##slash#app#slash#views#slash#layouts#slash#layout.cfm" ) )>
					    	<cfoutput>#slash##datasource##slash#app#slash#views#slash#layouts#slash#layout.cfm has been created.<br /></cfoutput>
						<cfelse>
							<cfoutput>#slash##datasource##slash#app#slash#views#slash#layouts#slash#layout.cfm existed and was overwritten.<br /></cfoutput>
						</cfif>
						<cfset generateLayout =  replaceList(generateLayout,"<%,%,^","<,##,%") />
						<cffile action="write" file="#rootPath##slash##datasource##slash#app#slash#views#slash#layouts#slash#layout.cfm" output="#generateLayout#" nameconflict="overwrite">
					</cfif>
				</cfif> --->
			</cfloop>
			</div>
			<div id="footer"&nbsp;</div>
		</div>
</cf_layout>