<cfparam name="author" type="string" default="">
<cfparam name="datasource" type="string" default="">
<cfparam name="pathType" type="string" default="useHardcodedPath">
<cfparam name="cf8" type="boolean" default="false">
<cfparam name="useRTE" type="boolean" default="false">
<cfparam name="appCFC" type="boolean" default="false">
<cfparam name="table" type="string" default="">
<cfparam name="revTable" type="string" default="">
<cfparam name="ifExists" type="string" default="">
<cfparam name="isAdmin" type="boolean" default="false">
<cfparam name="adminFolder" type="string" default="">
<cfparam name="generateType" type="string" default="false">
<cfif isdefined('session.generateType')>
	<cfset generateType = session.generateType />
</cfif>
		<div id="container">

			<div id="content">
				<cfif listlen(table) gt 1>
					so you want to generate all the tables<br />
					Need the ability to create an xml that you can use to create the xml bean, liken to transfer and hopefully be able to have better forms automatically
					<cflayout type="tab" tabposition="top">
						 <cfoutput>
							<ol>
						        <li><img src="assets/images/pencil.png" border="0"/> <a href="##" onclick="javascript:ColdFusion.Window.show('writeFilesAll')" title="Write Files to This Root Folder">Write Files to This Root Folder</a></li>
							</ol>
						</cfoutput>
						<!---<cfloop list="#table#" index="i">
							<cfdbinfo type="foreignkeys" datasource="#session.dsn#" name="fk" table="#i#">
							<cfdbinfo type="columns" datasource="#session.dsn#" name="remarks" table="#i#">
							<cfdump var="#fk#" label="foreign keys for #table#">
							<cfdump var="#remarks#" label="column information for #table#">
							</cfloop>--->
				</cflayout>
				<cfelse><!---so the user isn't lazy, oh well--->

				<cfset codeGenerator = CreateObject("component", "cfcs.services.codeGenerator").init(#author#,#table#,#datasource#,#revTable#,#pathType#,#cf8#,#useRTE#,#appCFC#,#isAdmin#) />
				<cfset tableColumns = codeGenerator.getColumns() />

				<cflayout type="tab" name="generatedCode" tabheight="500" style="background-color:##FFF;">
				    <cflayoutarea name="home" title="Home">
				        <cfoutput>
							<ol>
						        <li><img src="assets/images/pencil.png" border="0"/> <a href="##" onclick="javascript:ColdFusion.Window.show('writeFiles#table#')" title="Write Files to This Root Folder">Write Files to This Root Folder</a></li>
							</ol>
						</cfoutput>
						<br/>

					   	<table border="0" width="600" cellpadding="5" cellspacing="0">
					   		<caption>
									<h2><cfoutput>#ucase(table)# Table Structure</cfoutput></h2>
							</caption>
							<thead
				               <tr>
				                   <th>Column Name</td>
				                   <th>Data Type</td>
				                   <th>Column Size</td>
				                   <th>decimal digits</td>
				                   <th>Is Nullable</td>
				                   <th>default</td>
				               </tr>
		              		</thead>
			               <tbody>
						       	<cfoutput query="tableColumns">
					               <tr>
					                   <td>#column_name#</td>
					                   <td>#type_name#</td>
					                   <td>#column_size#</td>
					                   <td>#DECIMAL_DIGITS#</td>
					                   <td>#is_nullable#</td>
					                   <td>#COLUMN_DEFAULT_VALUE#</td>
					               </tr>
						           </cfoutput>
					        </tbody>
					       </table>
				    </cflayoutarea>
				    <cfif generateType eq "gateway">
				    <cflayoutarea name="bean" title="Bean" style="background-color:##FFF;">
				        <cfset getBean = codeGenerator.generateBean()>
						<cfset getBean =  replaceList(getBean,"<%,%,/@","&lt;,##,%") />
						<cfoutput>
							<span style="color:##000099; font-weight:bold;">Look you generated code</span>
							<textarea
								style="font-size: 8pt; width: 100%;"
								wrap="hard" rows="33" name="linkNode">
									#getBean#
								</textarea>
						</cfoutput>
				    </cflayoutarea>
				    <cflayoutarea name="dao" title="DAO" style="background-color:##FFF;">
				        <cfset getDAO = codeGenerator.generateDAO()>
						<cfset getDAO =  replaceList(getDAO,"<%,%,/@","&lt;,##,%") />
						<cfoutput>
							<span style="color:##000099; font-weight:bold;">Look you generated code</span>
							<textarea
								style="font-size: 8pt; width: 100%;"
								wrap="hard" rows="33" name="linkNode">
									#getDAO#
								</textarea>
						</cfoutput>
				    </cflayoutarea>
				    <cflayoutarea name="gateway" title="Gateway" style="background-color:##FFF;">
				        <cfset getGateway = codeGenerator.generateGateway()>
						<cfset getGateway =  replaceList(getGateway,"<%,%,/@","&lt;,##,%") />
						<cfoutput>
							<span style="color:##000099; font-weight:bold;">Look you generated code</span>
							<textarea
								style="font-size: 8pt; width: 100%;"
								wrap="hard" rows="33" name="linkNode">
									#getGateway#
								</textarea>
						</cfoutput>
				    </cflayoutarea>
				    </cfif>
				    <cfif generateType eq "model">
					<cflayoutarea name="model" title="Model" style="background-color:##FFF;">
				        <cfset getModel = codeGenerator.generateModel()>
						<cfset getModel =  replaceList(getModel,"<%,%,/@","&lt;,##,%") />
						<cfoutput>
							<span style="color:##000099; font-weight:bold;">Look you generated code</span>
							<textarea
								style="font-size: 8pt; width: 100%;"
								wrap="hard" rows="33" name="linkNode">
									#getModel#
								</textarea>
						</cfoutput>
				    </cflayoutarea>
				    </cfif>
				     <cfif generateType eq "model">
					     <cflayoutarea name="controller" title="Controller" style="background-color:##FFF;">
					        <cfset getController = codeGenerator.generateModelController()>
							<cfset getController =  replaceList(getController,"<%,%,/@","&lt;,##,%") />
							<cfoutput>
								<span style="color:##000099; font-weight:bold;">Look you generated code</span>
								<textarea
									style="font-size: 8pt; width: 100%;"
									wrap="hard" rows="33" name="linkNode">
										#getController#
									</textarea>
							</cfoutput>
					    </cflayoutarea>
				     <cfelse>
					    <cflayoutarea name="controller" title="Controller" style="background-color:##FFF;">
					        <cfset getController = codeGenerator.generateController()>
							<cfset getController =  replaceList(getController,"<%,%,/@","&lt;,##,%") />
							<cfoutput>
								<span style="color:##000099; font-weight:bold;">Look you generated code</span>
								<textarea
									style="font-size: 8pt; width: 100%;"
									wrap="hard" rows="33" name="linkNode">
										#getController#
									</textarea>
							</cfoutput>
					    </cflayoutarea>
				    </cfif>
				    <cflayoutarea name="dataTable" title="Data Table" style="background-color:##FFF;">
				        <cfset getDataTable = codeGenerator.generateDataTable()>
						<cfset getDataTable =  replaceList(getDataTable,"<%,%,/@","&lt;,##,%") />
						<cfoutput>
							<span style="color:##000099; font-weight:bold;">Look you generated code</span>
							<textarea
								style="font-size: 8pt; width: 100%;"
								wrap="hard" rows="33" name="linkNode">
									#getDataTable#
								</textarea>
						</cfoutput>
				    </cflayoutarea>
				    <cflayoutarea name="form" title="Form" style="background-color:##FFF;">
				        <cfset getForm = codeGenerator.generateForm()>
						<cfset getForm =  replaceList(getForm,"<%,%,/@","&lt;,##,%") />
						<cfoutput>
							<span style="color:##000099; font-weight:bold;">Look you generated code</span>
							<textarea
								style="font-size: 8pt; width: 100%;"
								wrap="hard" rows="33" name="linkNode">
									#getForm#
								</textarea>
						</cfoutput>
				    </cflayoutarea>
				    <cfif appCFC EQ true>
					    <cflayoutarea name="applicationcfc" title="ApplicationCFC" style="background-color:##FFF;">
					        <cfset getApplicationCFC = codeGenerator.generateApplicationCFC()>
							<cfset getApplicationCFC =  replaceList(getApplicationCFC,"<%,%,/@","&lt;,##,%") />
							<cfoutput>
								<span style="color:##000099; font-weight:bold;">Look you generated code</span>
								<textarea
									style="font-size: 8pt; width: 100%;"
									wrap="hard" rows="33" name="linkNode">
										#getApplicationCFC#
									</textarea>
							</cfoutput>
					    </cflayoutarea>
				    </cfif>
				</cflayout>

				</cfif>
			</div>
			<div id="footer"&nbsp;</div>
		</div>
		<cfif listlen(table) gt 1>
			<cfwindow width="500" height="520" name="writeFilesAll"
        	center="true" draggable="true" modal="true" resizable="true"
        	title="Writing Files to System" initshow="false"
        	source="writeToFSAll.cfm?author=#author#&datasource=#datasource#&tableList=#table#&revTable=#revTable#&pathType=#pathType#&useRTE=#useRTE#&cf8=#cf8#&appCFC=#appCFC#&ifExists=#ifExists#&isAdmin=#isAdmin#&adminFolder=#adminFolder#" />
		<cfelse>
		<cfwindow width="500" height="520" name="writeFiles#table#"
        	center="true" draggable="true" modal="true" resizable="true"
        	title="Writing Files to System" initshow="false"
        	source="writeToFS.cfm?author=#author#&datasource=#datasource#&table=#table#&revTable=#revTable#&pathType=#pathType#&useRTE=#useRTE#&cf8=#cf8#&appCFC=#appCFC#&ifExists=#ifExists#&isAdmin=#isAdmin#&adminFolder=#adminFolder#" />
    	</cfif>