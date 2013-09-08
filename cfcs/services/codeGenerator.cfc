<cfcomponent output="false">

<!--- constructor --->
<cffunction name="init" access="public" output="false" returntype="any" hint="Constructor for this cfc">
	<!--- take form input as arguments --->
	<cfargument name="author" type="string" required="yes">
	<cfargument name="table" type="string" required="yes">
	<cfargument name="datasource" type="string" required="yes">
	<cfargument name="revTable" type="string" required="yes">
	<cfargument name="pathType" type="string" required="yes">
	<cfargument name="cf8" type="boolean" required="yes">
	<cfargument name="useRTE" type="boolean" required="yes">
	<cfargument name="appCFC" type="boolean" required="yes">
    <cfargument name="isAdmin" type="boolean" required="yes">

	<!--- set arguments into the variables scope so they can be used throughout the cfc --->
	<cfset variables.author = arguments.author />
	<cfset variables.table = arguments.table/>
	<cfset variables.datasource = arguments.datasource />
	<cfset variables.revTable = arguments.revTable />
	<cfset variables.pathType = arguments.pathType />
	<cfset variables.cf8 = arguments.cf8 />
	<cfset variables.useRTE = arguments.useRTE />
	<cfset variables.appCFC = arguments.appCFC />

    <cfset variables.tableColumns = getColumns(variables.datasource, variables.table)>

	<!--- return this cfc --->
	<cfreturn this/>
</cffunction>

<!--- Get Database Info --->
<cffunction name="getColumns" displayname="Get Columns" hint="Return column data from specified table" access="public" output="false" returntype="query">

    <cfdbinfo datasource=#variables.datasource#
      name="retVar"
      type="columns"
      table="#variables.table#">

    <cfreturn retVar>
</cffunction>

<!--- Bean Generator --->
<cffunction name="generateBean" access="public" returntype="string" hint="Generates code for bean component">
<cfsavecontent variable="generatedBean"><cfoutput><cfprocessingdirective suppresswhitespace="true">

<%cfcomponent name="#variables.table#" displayname="#variables.table#" hint="#variables.table# bean created by ColdFusion generator">

    <%!--- PROPERTIES FOR DOCUMENTATION PURPOSES ONLY --->
    <cfloop query="tableColumns">
        <cfset columnType = "">
        <cfset isRequired = "">

        <cfswitch expression="#type_name#">
            <cfcase value="int unsigned, int signed, tinyint unsigned, tinyint signed">
                <cfset columnType = "numeric">
            </cfcase>
            <cfcase value="varchar, char, text, nvarchar, nchar, ntext">
                <cfset columnType = "string">
            </cfcase>
            <cfcase value="bit">
                <cfset columnType = "boolean">
            </cfcase>
            <cfcase value="date">
                <cfset columnType = "date">
            </cfcase>
            <cfdefaultcase>
                <cfset columnType = "any">
            </cfdefaultcase>
        </cfswitch>

        <cfswitch expression="#is_nullable#">
            <cfcase value="NO">
                <cfset isRequired = "True">
            </cfcase>
            <cfcase value="YES">
                <cfset isRequired = "False">
            </cfcase>
        </cfswitch>
    <%cfproperty name="#column_name#" displayname="#column_name#" hint="#column_name# of the #variables.table#" type="#columnType#" required="#isRequired#"/>
    </cfloop>

    <%!--- PSEUDO-CONSTRUCTOR: SETS DEFAULT VALUES IF INIT METHOD IS NOT CALLED --->
    <%cfscript>
    <cfloop query="tableColumns">
        variables.#column_name# = "";
    </cfloop>
    <%/cfscript>

    <%!--- CONSTRUCTOR: TAKES IN ARGUMENTS AND CALLS SETTER (MUTATOR) FOR EACH ATTRIBUTE OF THE BEAN --->
    <%cffunction name="init" displayname="Init" hint="Constructor for the CFC" access="public" output="false" returntype="any">
        <%!--- ARGUMENTS FOR THE CONSTRUCTOR, ALL OF WHICH ARE OPTIONAL (NO-ARG CONSTRUCTOR) --->
        <cfloop query="tableColumns">
        <%cfargument name="a#column_name#" displayname="#column_name#" hint="#column_name# of the #variables.table#" type="any" required="false" default="" />
        </cfloop>

        <%!--- CALL THE SETTERS (MUTATORS) FOR EACH OF THE #variables.table# ATTRIBUTES AND PASS IN THE ARGUMENTS --->
        <%cfscript>
            <cfloop query="tableColumns">
            set#column_name#(arguments.a#column_name#);
            </cfloop>
        <%/cfscript>

        <%cfreturn this />
    <%/cffunction>

    <%!--- GETTERS AND SETTERS (MUTATORS AND ACCESSORS) --->
    <cfloop query="tableColumns">
    <%cffunction name="get#column_name#" access="public" output="false" returntype="string">
        <%cfreturn variables.#column_name# />
    <%/cffunction>
    <%cffunction name="set#column_name#" access="public" output="false" returntype="void">
        <%cfargument name="a#column_name#" type="string" required="true" />
        <%cfset variables.#column_name# = arguments.a#column_name# />
    <%/cffunction>
    </cfloop>
<%/cfcomponent>
</cfprocessingdirective></cfoutput></cfsavecontent>

<cfreturn generatedBean>
</cffunction>

<!--- DAO Generator --->
<cffunction name="generateDAO" access="public" returntype="string" hint="Generates code for DAO component">
<cfsavecontent variable="generatedDAO"><cfoutput><cfprocessingdirective suppresswhitespace="true">
<%cfcomponent name="<cfoutput>#variables.table#</cfoutput>DAO" displayname="<cfoutput>#variables.table#</cfoutput> DAO" output="false" hint="<cfoutput>#variables.table#</cfoutput> Data Access Object">
        <%!--- PROPERTIES FOR DOCUMENTATION PURPOSES ONLY --->
        <cfloop query="tableColumns">
            <cfsilent>
				<cfset columnType = "">
	            <cfset isRequired = "">
	            <cfswitch expression="#type_name#">
	                <cfcase value="int unsigned, int signed, tinyint unsigned, tinyint signed">
	                    <cfset columnType = "numeric">
	                </cfcase>
	                <cfcase value="varchar, char, text, nvarchar, nchar, ntext">
	                    <cfset columnType = "string">
	                </cfcase>
	                <cfcase value="bit">
	                    <cfset columnType = "boolean">
	                </cfcase>
	                <cfcase value="date">
	                    <cfset columnType = "date">
	                </cfcase>
	                <cfdefaultcase>
	                    <cfset columnType = "any">
	                </cfdefaultcase>
	            </cfswitch>
			</cfsilent>
        <%cfproperty name="<cfoutput>#column_name#</cfoutput>" displayname="<cfoutput>#column_name#</cfoutput>" hint="<cfoutput>#column_name#</cfoutput> of the <cfoutput>#variables.table#</cfoutput> from the form - used by the controller to package into an object" type="<cfoutput>#columnType#</cfoutput>" required="false"/>
        </cfloop>
		<%cfproperty name="action" displayname="Action" hint="Action to preform with the data - Create, Update, or Delete" type="string" required="false"/>

	    <%!--- pseudo constructor --->
	    <%cfscript>
	  		variables.datasource = <cfif variables.pathType EQ "useAppPath">Application.datasource<cfelse>'<cfoutput>#variables.datasource#</cfoutput>'</cfif>;
	    <%/cfscript>

	<%cffunction name="init" access="public" output="false" returntype="any"
			hint="Constructor for this CFC">
		<%!--- take datasource as argument --->
		<%cfargument name="datasource" type="string" required="true" hint="The datasource name" />

		<%!--- put datasource in variables scope so we can use it throughout the CFC --->
		<%cfset variables.datasource = arguments.datasource />

		<%!--- return this CFC --->
		<%cfreturn this />
	<%/cffunction>

	<%!--- CRUD methods (create, read, update, delete) --->
	<%!--- CREATE: inserts a new <cfoutput>#variables.table#</cfoutput> into the database --->
	<%cffunction name="createRecord" access="public" output="true"
			hint="Creates a new <cfoutput>#variables.table#</cfoutput> record and returns a struct containing a boolean (success) indicating the success or
			failure of the operation, an id (id), and a string (message) containing a message">

		<%!--- take <cfoutput>#variables.table#</cfoutput> bean as argument --->
		<%cfargument name="<cfoutput>#variables.table#</cfoutput>" type="any" required="true" />

		<%!--- initialize variables --->
		<%cfset var results = StructNew() />
		<%cfset var qInsert<cfoutput>#variables.table#</cfoutput> = 0 />

		<%!--- defaults --->
		<%cfset results.success = true />
		<%cfset results.message = "The record was inserted successfully." />

		<%!--- insert the <cfoutput>#variables.table#</cfoutput> --->
		<%cftry>
			<%cfquery name="qInsert<cfoutput>#variables.table#</cfoutput>" datasource="#variables.datasource#">
				INSERT INTO <cfoutput>#variables.table#</cfoutput> (
					<cfloop query="tableColumns">
						<cfif tableColumns.ORDINAL_POSITION NEQ 1>
							<cfif tableColumns.recordcount NEQ tableColumns.currentrow>
								<cfoutput>#column_name#</cfoutput>,
							<cfelse>
								<cfoutput>#column_name#</cfoutput>
							</cfif>
						</cfif>
					</cfloop>
				) VALUES (
				<cfloop query="tableColumns">
					<cfif tableColumns.ORDINAL_POSITION NEQ 1>
                        <cfswitch expression="#type_name#">
                            <cfcase value="int unsigned, int signed, tinyint unsigned, tinyint signed, int, smallint, tinyint, bigint">
                                <cfset sqlType = "numeric">
                            </cfcase>
                            <cfcase value="bit">
                                <cfset sqlType = "bit">
                            </cfcase>
                            <cfcase value="date, datetime, smalldatetime, timestamp">
                                <cfset sqlType = "timestamp">
                            </cfcase>
                            <cfdefaultcase>
                                <cfset sqlType = "varchar">
                            </cfdefaultcase>
                        </cfswitch>

						<cfif tableColumns.recordcount NEQ tableColumns.currentrow>
							<%cfqueryparam value="%arguments.<cfoutput>#variables.table#</cfoutput>.get<cfoutput>#column_name#</cfoutput>()%" cfsqltype="cf_sql_<cfoutput>#sqlType#</cfoutput>" />,
						<cfelseif tableColumns.currentrow NEQ 1>
							<%cfqueryparam value="%arguments.<cfoutput>#variables.table#</cfoutput>.get<cfoutput>#column_name#</cfoutput>()%" cfsqltype="cf_sql_<cfoutput>#sqlType#</cfoutput>" />
						</cfif>
					</cfif>
				</cfloop>
				)
			<%/cfquery>
			<%cfcatch type="database">
				<%cfset results.success = false />
				<%cfset results.message = "Inserting the record failed.  The error details if available are as follows: " & CFCATCH.Detail />
			<%/cfcatch>
		<%/cftry>

		<%!--- return the struct --->
		<%cfreturn StructCopy(results) />
	<%/cffunction>

	<%!--- READ: reads a <cfoutput>#variables.table#</cfoutput> from the database and populates the <cfoutput>#variables.table#</cfoutput> object --->
	<%cffunction name="readRecord" access="public" output="false" returntype="void" hint="Reads <cfoutput>#variables.table#</cfoutput> data
			from the database and populates the object passed to this function">
		<%!--- take <cfoutput>#variables.table#</cfoutput> bean as argument --->
		<%cfargument name="<cfoutput>#variables.table#</cfoutput>" type="any" required="true" />

		<%!--- initialize variables --->
		<%cfset var qRead<cfoutput>#variables.table#</cfoutput> = 0 />

		<%!--- call init function to define variables.datasource if not done so already (for Flash Remoting for Flex) --->
		<%cfif NOT isDefined('variables.datasource')>
			<%cfscript>
				init(<cfif variables.pathType EQ "useAppPath">Application.datasource<cfelse>'<cfoutput>#variables.datasource#</cfoutput>'</cfif>);
			<%/cfscript>
		<%/cfif>

		<%!--- read <cfoutput>#variables.table#</cfoutput> data --->
		<%cftry>
			<%cfquery name="qRead<cfoutput>#variables.table#</cfoutput>" datasource="#variables.datasource#">
				SELECT <cfoutput>#variables.table#</cfoutput>.*
				FROM <cfoutput>#variables.table#</cfoutput>
				WHERE <cfoutput>#variables.tableColumns.column_name#</cfoutput> = <%cfqueryparam value="%arguments.<cfoutput>#variables.table#</cfoutput>.get<cfoutput>#variables.tableColumns.column_name#</cfoutput>()%" cfsqltype="cf_sql_char" />

			<%/cfquery>
			<%cfcatch type="database">
				<%!--- object will remain empty --->
			<%/cfcatch>
		<%/cftry>

		<%!--- if we got data back, initialize the object --->
		<%cfif IsQuery(qRead<cfoutput>#variables.table#</cfoutput>) AND qRead<cfoutput>#variables.table#</cfoutput>.RecordCount EQ 1>
			<%cfset arguments.<cfoutput>#variables.table#</cfoutput>.init(
																	<cfloop query="tableColumns">
																		<cfif tableColumns.recordcount NEQ tableColumns.currentrow>
																			qRead<cfoutput>#variables.table#</cfoutput>.<cfoutput>#column_name#</cfoutput>,
																		<cfelse>
																			qRead<cfoutput>#variables.table#</cfoutput>.<cfoutput>#column_name#</cfoutput>
																		</cfif>
																	</cfloop>
																	) />
		<%/cfif>
	<%/cffunction>

	<%!--- UPDATE: updates a <cfoutput>#variables.table#</cfoutput> in the database --->
	<%cffunction name="updateRecord" access="public" output="false" returntype="struct" hint="Updates a
			<cfoutput>#variables.table#</cfoutput> record in the database and returns a struct containing a boolean (success) indicating
			the success or failure of the operation and a string (message) containing a message">
		<%!--- take <cfoutput>#variables.table#</cfoutput> bean as argument --->
		<%cfargument name="<cfoutput>#variables.table#</cfoutput>" type="any" required="true" />

		<%!--- initialize variables --->
		<%cfset var qUpdate<cfoutput>#variables.table#</cfoutput> = 0 />
		<%cfset var results = StructNew() />

		<%!--- set defaults --->
		<%cfset results.success = true />
		<%cfset results.message = "The record was updated successfully." />

		<%!--- update the <cfoutput>#variables.table#</cfoutput> --->
		<%cftry>
			<%cfquery name="qUpdate<cfoutput>#variables.table#</cfoutput>" datasource="#variables.datasource#">
				UPDATE <cfoutput>#variables.table#</cfoutput>
				SET
				<cfloop query="tableColumns">
					<cfif tableColumns.ORDINAL_POSITION NEQ 1>
                        <cfswitch expression="#type_name#">
                            <cfcase value="int unsigned, int signed, tinyint unsigned, tinyint signed, int, smallint, tinyint, bigint">
                                <cfset sqlType = "numeric">
                            </cfcase>
                            <cfcase value="bit">
                                <cfset sqlType = "bit">
                            </cfcase>
                            <cfcase value="date, datetime, smalldatetime, timestamp">
                                <cfset sqlType = "timestamp">
                            </cfcase>
                            <cfdefaultcase>
                                <cfset sqlType = "varchar">
                            </cfdefaultcase>
                        </cfswitch>
						<cfif tableColumns.recordcount NEQ tableColumns.currentrow>
							<cfoutput>#column_name#</cfoutput>=<%cfqueryparam value="%arguments.<cfoutput>#variables.table#</cfoutput>.get<cfoutput>#column_name#</cfoutput>()%" cfsqltype="cf_sql_<cfoutput>#sqlType#</cfoutput>" />,
						<cfelseif tableColumns.currentrow NEQ 1>
							<cfoutput>#column_name#</cfoutput>=<%cfqueryparam value="%arguments.<cfoutput>#variables.table#</cfoutput>.get<cfoutput>#column_name#</cfoutput>()%" cfsqltype="cf_sql_<cfoutput>#sqlType#</cfoutput>" />
						</cfif>
					</cfif>
				</cfloop>
				WHERE <cfoutput>#variables.tableColumns.column_name#</cfoutput> = <%cfqueryparam value="%arguments.<cfoutput>#variables.table#</cfoutput>.get<cfoutput>#variables.tableColumns.column_name#</cfoutput>()%" cfsqltype="cf_sql_char" />
			<%/cfquery>
			<%cfcatch type="database">
				<%cfset results.success = false />
				<%cfset results.message = "Updating the record failed.  The error details if available are as follows" & CFCATCH.Detail />
			<%/cfcatch>
		<%/cftry>

		<%!--- return the struct --->
		<%cfreturn StructCopy(results) />
	<%/cffunction>

	<%!--- DELETE: deletes a <cfoutput>#variables.table#</cfoutput> from the database --->
	<%cffunction name="deleteRecord" access="public" output="false" returntype="struct" hint="Deletes a
			<cfoutput>#variables.table#</cfoutput> record from the database and returns a struct containing a boolean (success)
			indicating the success or failure of the operation and a string (message) containing a message">
		<%!--- take <cfoutput>#variables.table#</cfoutput> bean as argument --->
		<%cfargument name="<cfoutput>#variables.table#</cfoutput>" type="any" required="true" />

		<%!--- initialize variables --->
		<%cfset var qDelete<cfoutput>#variables.table#</cfoutput> = 0 />
		<%cfset var results = StructNew() />

		<%!--- set defaults --->
		<%cfset results.success = true />
		<%cfset results.message = "The record was deleted successfully." />

		<%!--- delete the <cfoutput>#variables.table#</cfoutput> --->
		<%cftry>
			<%cfquery name="qDelete<cfoutput>#variables.table#</cfoutput>" datasource="#variables.datasource#">
				DELETE FROM <cfoutput>#variables.table#</cfoutput>
				WHERE <cfoutput>#variables.tableColumns.column_name#</cfoutput> = <%cfqueryparam value="%arguments.<cfoutput>#variables.table#</cfoutput>.get<cfoutput>#variables.tableColumns.column_name#</cfoutput>()%" cfsqltype="cf_sql_char" />
			<%/cfquery>
			<%cfcatch type="database">
				<%cfset results.success = false />
				<%cfset results.message = "Deleting the record failed.  The error details if available are as follows: " & CFCATCH.Detail />
			<%/cfcatch>
		<%/cftry>

		<%!--- return the struct --->
		<%cfreturn StructCopy(results) />
	<%/cffunction>
<%/cfcomponent>
</cfprocessingdirective></cfoutput></cfsavecontent>

<cfreturn generatedDAO>
</cffunction>

<!--- Gateway Generator --->
<cffunction name="generateGateway" access="public" returntype="string" hint="Generates code for gateway component">
<cfsavecontent variable="generatedGateway">
<cfprocessingdirective suppresswhitespace="true">
<cfoutput>

<%cfcomponent name="#variables.table#Gateway" displayname="#variables.table# Gateway" output="false" hint="#variables.table# Gateway created by ColdFusion generator">

        <%!--- PROPERTIES FOR DOCUMENTATION PURPOSES ONLY --->
 		<%cfproperty name="datasource" displayname="Datasource Name" hint="datasource of the datasource - used by the init function" type="string" required="true"/>
       <cfloop query="tableColumns">
            <cfset columnType = "">
            <cfset isRequired = "">

            <cfswitch expression="#type_name#">
                <cfcase value="int unsigned, int signed, tinyint unsigned, tinyint signed">
                    <cfset columnType = "numeric">
                </cfcase>
                <cfcase value="varchar, char, text, nvarchar, nchar, ntext">
                    <cfset columnType = "string">
                </cfcase>
                <cfcase value="bit">
                    <cfset columnType = "boolean">
                </cfcase>
                <cfcase value="date">
                    <cfset columnType = "date">
                </cfcase>
                <cfdefaultcase>
                    <cfset columnType = "any">
                </cfdefaultcase>
            </cfswitch>

        <%cfproperty name="#column_name#" displayname="#column_name#" hint="Filter parameter of the #column_name# column used by the getByAttributes method" type="#columnType#" required="false"/>
        </cfloop>
		<%cfproperty name="orderby" displayname="Order By" hint="Sort parameter used by the getByAttributes method" type="string" required="false"/>

	<%!--- constructor --->
	<%cffunction name="init" access="public" output="false"
		returntype="any" hint="Constructor for this CFC">
		<%!--- take datasource as argument --->
		<%cfargument name="datasource" type="string" required="true" />

		<%!--- set datasource to variables scope so we can use it throughout the CFC --->
		<%cfset variables.datasource = arguments.datasource />

		<%!--- return this CFC --->
		<%cfreturn this />
	<%/cffunction>

	<%!--- get all records --->
	<%cffunction name="getAllRecords" access="public" output="false" returntype="query" hint="Returns a query object containing all of the #variables.table# records">
		<%!--- arguments --->
		<%cfargument name="orderby" required="no">

		<%!--- initialize variables --->
		<%cfset var qGetAllRecords = 0 />

		<%!--- call init function to define variables.datasource if not done so already (for Flash Remoting for Flex) --->
		<%cfif NOT isDefined('variables.datasource')>
			<%cfscript>
				init(<cfif variables.pathType EQ "useAppPath">Application.datasource<cfelse>'<cfoutput>#variables.datasource#</cfoutput>'</cfif>);
			<%/cfscript>
		<%/cfif>

		<%!--- run query --->
		<%cftry>
</cfoutput>
			<%cfquery name="qGetAllRecords" datasource="#variables.datasource#">
<cfoutput>
				SELECT <cfloop query="tableColumns">#variables.table#.<cfif tableColumns.recordcount NEQ tableColumns.currentrow>#column_name#,<cfelse>#column_name#</cfif></cfloop>
				FROM #variables.table#
				WHERE 1=1
				<%cfif structKeyExists(arguments, "orderby") and len(arguments.orderby)>
					AND orderby = '%arguments.orderby%'
				<%/cfif>
			<%/cfquery>
			<%cfcatch type="database">
				<%cfset qGetAllRecords = QueryNew("<cfloop query="tableColumns"><cfif tableColumns.recordcount NEQ tableColumns.currentrow>#column_name#,<cfelse>#column_name#</cfif></cfloop>") />
				<%cfset QueryAddRow(qGetAllRecords, 1) />
				<cfloop query="tableColumns">
				<%cfset QuerySetCell(qGetAllRecords, "#column_name#", "An error occurred", 1) />
				</cfloop>
			<%/cfcatch>
		<%/cftry>

		<%!--- return the query object --->
		<%cfreturn qGetAllRecords />
	<%/cffunction>

      <%!--- get all records JSON serialized  --->
      <%cffunction name="getAllRecordsSerialized" access="remote" hint="Returns a JSON serialized object containing all of the #variables.table# records">
            <%!--- arguments --->
			<%cfargument name="page" required="yes">
			<%cfargument name="pageSize" required="yes">
			<%cfargument name="gridsortcolumn" required="yes">
			<%cfargument name="gridsortdirection" required="yes">
			<%cfargument name="orderby" required="no" default="">

            <%!--- initialize variables --->
            <%cfset var qResults =  ""/>

            <%cfif structkeyexists(arguments,"gridsortcolumn") and len(trim(gridsortcolumn)) and structkeyexists(arguments,"gridsortdirection") and len(trim(gridsortdirection))>
				<%cfset arguments.orderby = arguments.gridsortcolumn &" "& arguments.gridsortdirection />
			<%/cfif>

            <%!--- call query --->
            <%cfscript>
				  init(%application.datasource%);
                  qResults = getAllRecords(arguments.orderby);
            <%/cfscript>

            <%!--- return the query object --->
            <%cfreturn queryconvertforgrid(qResults,arguments.page,arguments.pagesize) />
      <%/cffunction>

	<%!--- get #variables.table# by attributes --->
	<%cffunction name="getByAttributes" access="public" output="false" returntype="query" hint="Returns a query object containing the #variables.table# records matching the supplied attributes">
		<cfloop query="tableColumns">
		<%cfargument name="<cfoutput>#variables.tableColumns.column_name#</cfoutput>" required="false">
		</cfloop>
		<%cfargument name="orderby" required="false">

		<%!--- initialize variables --->
		<%cfset var qGetByAttributes = 0 />

		<%!--- call init function to define variables.datasource if not done so already (for Flash Remoting for Flex) --->
		<%cfif NOT isDefined('variables.datasource')>
			<%cfscript>
				init(<cfif variables.pathType EQ "useAppPath">Application.datasource<cfelse>'<cfoutput>#variables.datasource#</cfoutput>'</cfif>);
			<%/cfscript>
		<%/cfif>

		<%!--- run query --->
		<%cftry>
</cfoutput>
			<%cfquery name="qGetByAttributes" datasource="#variables.datasource#">
<cfoutput>
				SELECT <cfloop query="tableColumns">#variables.table#.<cfif tableColumns.recordcount NEQ tableColumns.currentrow>#column_name#,<cfelse>#column_name#</cfif></cfloop>
				FROM #variables.table#
				WHERE 1=1
</cfoutput>
				<cfloop query="tableColumns">
				<%cfif structKeyExists(arguments, "<cfoutput>#variables.tableColumns.column_name#</cfoutput>") and len(arguments.<cfoutput>#variables.tableColumns.column_name#</cfoutput>)>
					AND <cfoutput>#variables.tableColumns.column_name#</cfoutput> = <%cfqueryparam value="#arguments.<cfoutput>#variables.tableColumns.column_name#</cfoutput>#" cfsqltype="cf_sql_<cfoutput>#sqlType#</cfoutput>" />
				<%/cfif>
				</cfloop>
				<%cfif structKeyExists(arguments, "orderby") and len(arguments.orderby)>
					AND orderby = '%arguments.orderby%'
				<%/cfif>
<cfoutput>
			<%/cfquery>
			<%cfcatch type="database">
				<%cfset qGetByAttributes = QueryNew("<cfloop query="tableColumns"><cfif tableColumns.recordcount NEQ tableColumns.currentrow>#column_name#,<cfelse>#column_name#</cfif></cfloop>") />
				<%cfset QueryAddRow(qGetByAttributes, 1) />
				<cfloop query="tableColumns">
				<%cfset QuerySetCell(qGetByAttributes, "#column_name#", "An error occurred", 1) />
				</cfloop>
			<%/cfcatch>
		<%/cftry>

		<%!--- return the query object --->
		<%cfreturn qGetByAttributes />
	<%/cffunction>
<%/cfcomponent>
</cfoutput>
</cfprocessingdirective></cfsavecontent>

<cfreturn generatedGateway>
</cffunction>

<!--- Model Controller Generator --->
<cffunction name="generateModelController" access="public" returntype="string" hint="Generates code for the controller component">
	<cfset variables.easyTableName = variables.table />
<cfsavecontent variable="generatedModelController"><cfoutput><cfprocessingdirective suppresswhitespace="true">
<%cfcomponent name="cnt_#variables.table#" displayname="#variables.table# Controller" output="false">

	<%cffunction name="OnMissingMethod">
		<%cfoutput>You are trying to call the method "%arguments.missingMethodName%" with parameters:
		%arguments.missingmethodarguments.1% and %arguments.missingmethodarguments.2%
		<br> This method does not exist.<br><br><%/cfoutput>
	<%/cffunction>

	<%!------>

	<%cffunction name="create" access="remote" output="no">
		<%cfset var local = structNew() />

		<%cfinvoke component="models.#variables.table#" method="insert#variables.table#" returnvariable="<cfloop query="tableColumns"><cfif is_PrimaryKey or not is_Nullable><cfoutput>#column_name#</cfoutput></cfif></cfloop>">
			<%cfloop collection="%arguments%" item="local.key">
				<%cfif structKeyExists(arguments, "%local.key%")>
					<%cfif local.key neq "fieldnames" and local.key neq "submit" and findNoCase("#variables.table#_",local.key)>
						<%cfinvokeargument name="%trim(replaceNoCase(local.key,'#variables.table#_',''))%" value="%arguments[local.key]%" />
					<%/cfif>
				<%/cfif>
			<%/cfloop>
		<%/cfinvoke>

		<%cfif <cfloop query="tableColumns"><cfif is_PrimaryKey or not is_Nullable><cfoutput>#column_name#</cfoutput></cfif></cfloop> neq "false">
			<%cfset session.message = "You have added a #variables.easyTableName#.">
			<%cflocation url="%application.views%#variables.easyTableName#/default.cfm" addtoken="false">
		<%cfelse>
			<%cfset session.alert = "The #variables.easyTableName# could not be saved.">
			<%cflocation url="%application.views%#variables.easyTableName#/edit.cfm" addtoken="false">
		<%/cfif>
	<%/cffunction>

	<%!------>

	<%cffunction name="update" access="remote" output="no" hint="used for update and delete, IsDeleted = 1 for delete">
		<%cfset var local = structNew() />

		<%cfinvoke component="#variables.datasource#.app.dataobjects.#variables.table#dao" method="update#variables.table#">
			<%cfloop collection="%form%" item="key">
				<%cfif key neq "fieldnames" and key neq "submit" and findNoCase("#variables.table#_",key)>
					<%cfinvokeargument name="%trim(replaceNoCase(key,'#variables.table#_',''))%" value="%form[key]%">
				<%/cfif>
			<%/cfloop>
		<%/cfinvoke>

		<%cfif structKeyExists(arguments, "delete") or (structKeyExists(arguments,"isDeleted") and arguments.isDeleted eq true)>
			<%cfset session.message = "You have deleted the #variables.easyTableName#.">
			<%cflocation url="%application.views%#variables.easyTableName#/default.cfm" addtoken="false">
		<%cfelse>
			<%cfset session.alert = "The #variables.easyTableName# was updated.">
			<%cflocation url="%application.views%#variables.easyTableName#/default.cfm" addtoken="false">
		<%/cfif>
	<%/cffunction>

	<%!------>

	<%cffunction name="get" access="remote" output="no" returntype="any" hint="gets data">
		<%cfargument name="page" default="1" />
		<%cfargument name="pageSize" default="%application.ecommerce.grid.pagesize%" />
		<%cfargument name="gridsortcolumn" default="<cfloop query="tableColumns"><cfif is_PrimaryKey or not is_Nullable><cfoutput>#column_name#</cfoutput></cfif></cfloop>" />
		<%cfargument name="gridsortdirection" default="desc" />
		<%cfargument name="isGrid" default="no" type="boolean" />
		<%cfargument name="gridAction" default="" type="string" />
		<%cfargument name="searchText" default="" type="string" />
		<%cfargument name="isDeleted" type="string" default="false" />
		<%cfargument name="sortorder" type="string" />

		<%cfset var local = structNew() />

		<%cfif arguments.gridsortcolumn eq "">
			<%cfset arguments.gridsortcolumn="<cfloop query="tableColumns"><cfif is_PrimaryKey or not is_Nullable><cfoutput>#column_name#</cfoutput></cfif></cfloop>">
			<%cfset arguments.gridsortdirection="asc">
		<%/cfif>
		<%cfset ps=pageSize>

		<%cfinvoke component="models.#variables.table#" method="get#variables.table#" returnvariable="local.#variables.table#Query">
			<%cfloop collection="%arguments%" item="local.key">
				<%cfif structKeyExists(arguments, "%local.key%")>
					<%cfinvokeargument name="%local.key%" value="%arguments[local.key]%" />
				<%/cfif>
			<%/cfloop>
			<%cfif structKeyExists(arguments,"searchText") and len(arguments.searchText)>
				<%cfinvokeargument name="searchText" value="%arguments.searchText%">
			<%/cfif>
		<%/cfinvoke>

 		<%cfif isdefined('arguments.isGrid') and arguments.isGrid eq 'yes'>
			<%cfset local.startRow = ((page-1) * arguments.pageSize) + 1 />
			<%cfset local.endRow = local.startRow + arguments.pageSize - 1 />
			<%cfset local.tmpQuery = queryNew(local.#variables.table#Query.columnList) />
			<%cfloop query="local.#variables.table#Query" startRow="%local.startRow%" endRow="%local.endRow%">
				<%cfset local.tmp = queryAddRow(local.tmpQuery) />
				<%cfloop list="%local.#variables.table#Query.columnList%" index="column">
					<%cfset tmp = querySetCell(local.tmpQuery,column,evaluate("local.#variables.table#Query.%column%")) />
				<%/cfloop>
			<%/cfloop>
			<%cfset gridQuery = structNew() />
			<%cfset gridQuery.query = local.tmpQuery />
			<%cfset gridQuery.totalrowcount = local.#variables.table#Query.recordcount />
			<%cfreturn gridQuery />
		<%cfelse>
			<%cfreturn #variables.table#Query>
		<%/cfif>
	<%/cffunction>

<%/cfcomponent>
</cfprocessingdirective></cfoutput></cfsavecontent>

<cfreturn generatedModelController>
</cffunction>

<!--- Model Generator --->
<cffunction name="generateModel" access="public" returntype="string" hint="Generate code for the model component">
<cfsavecontent variable="generatedModel"><cfoutput><cfprocessingdirective suppresswhitespace="true">
<%cfcomponent name="#variables.table#Gateway" displayname="#variables.table# Gateway" output="false" hint="#variables.table# Gateway created by ColdFusion generator">
        <%!--- PROPERTIES FOR DOCUMENTATION PURPOSES ONLY --->
       <cfloop query="tableColumns">
			<cfsilent>
			<cfset columnType = "">
            <cfset isRequired = "">
			<cfset realDelete="true">
            <!--- lets check for few certain fields if we do have those fields then we remove the delete function --->
			<cfif column_name is "isDeleted">
				<cfset realDelete="false">
			</cfif>
			<cfswitch expression="#type_name#">
                <cfcase value="int unsigned, int signed, tinyint unsigned, tinyint signed">
                    <cfset columnType = "numeric">
                </cfcase>
                <cfcase value="varchar, char, text, nvarchar, nchar, ntext">
                    <cfset columnType = "string">
                </cfcase>
                <cfcase value="bit">
                    <cfset columnType = "boolean">
                </cfcase>
                <cfcase value="date">
                    <cfset columnType = "date">
                </cfcase>
                <cfdefaultcase>
                    <cfset columnType = "any">
                </cfdefaultcase>
            </cfswitch>
		</cfsilent>
        <%cfproperty name="#column_name#" displayname="#column_name#" hint="Filter parameter of the #column_name# column used by the get#variables.table# method" type="#columnType#" required="false"/>
        </cfloop>
		<%cfproperty name="orderby" displayname="Order By" hint="Sort parameter used by the get#variables.table# method" type="string" required="false"/>
		<%cfproperty name="search" displayname="Search" hint="Search parameter used by the get#variables.table# method" type="string" required="false"/>

	<%!--- CRUD methods (create, read, update, delete) --->
	<%!--- CREATE: inserts a new <cfoutput>#variables.table#</cfoutput> into the database --->
	<%cffunction name="createRecord" access="public" output="true"
			hint="Creates a new <cfoutput>#variables.table#</cfoutput> record and returns a struct containing a boolean (success) indicating the success or
			failure of the operation, an id (id), and a string (message) containing a message">

		<%!--- take <cfoutput>#variables.table#</cfoutput> bean as argument --->
		<%cfargument name="<cfoutput>#variables.table#</cfoutput>" type="any" required="true" />

		<%!--- initialize variables --->
		<%cfset var results = StructNew() />
		<%cfset var qInsert<cfoutput>#variables.table#</cfoutput> = 0 />

		<%!--- defaults --->
		<%cfset results.success = true />
		<%cfset results.message = "The record was inserted successfully." />

		<%!--- insert the <cfoutput>#variables.table#</cfoutput> --->
		<%cftry>
			<%cfquery name="qInsert<cfoutput>#variables.table#</cfoutput>" datasource="#variables.datasource#">
				INSERT INTO <cfoutput>#variables.table#</cfoutput> (
					<cfloop query="tableColumns">
						<cfif tableColumns.ORDINAL_POSITION NEQ 1>
							<cfif tableColumns.recordcount NEQ tableColumns.currentrow>
								<cfoutput>#column_name#</cfoutput>,
							<cfelse>
								<cfoutput>#column_name#</cfoutput>
							</cfif>
						</cfif>
					</cfloop>
				) VALUES (
				<cfloop query="tableColumns">
					<cfif tableColumns.ORDINAL_POSITION NEQ 1>
                        <cfswitch expression="#type_name#">
                            <cfcase value="int unsigned, int signed, tinyint unsigned, tinyint signed, int, smallint, tinyint, bigint">
                                <cfset sqlType = "numeric">
                            </cfcase>
                            <cfcase value="bit">
                                <cfset sqlType = "bit">
                            </cfcase>
                            <cfcase value="date, datetime, smalldatetime, timestamp">
                                <cfset sqlType = "timestamp">
                            </cfcase>
                            <cfdefaultcase>
                                <cfset sqlType = "varchar">
                            </cfdefaultcase>
                        </cfswitch>

						<cfif tableColumns.recordcount NEQ tableColumns.currentrow>
							<%cfqueryparam value="%arguments.<cfoutput>#variables.table#</cfoutput>.get<cfoutput>#column_name#</cfoutput>()%" cfsqltype="cf_sql_<cfoutput>#sqlType#</cfoutput>" />,
						<cfelseif tableColumns.currentrow NEQ 1>
							<%cfqueryparam value="%arguments.<cfoutput>#variables.table#</cfoutput>.get<cfoutput>#column_name#</cfoutput>()%" cfsqltype="cf_sql_<cfoutput>#sqlType#</cfoutput>" />
						</cfif>
					</cfif>
				</cfloop>
				)
			<%/cfquery>
			<%cfcatch type="database">
				<%cfset results.success = false />
				<%cfset results.message = "Inserting the record failed.  The error details if available are as follows: " & CFCATCH.Detail />
			<%/cfcatch>
		<%/cftry>

		<%!--- return the struct --->
		<%cfreturn StructCopy(results) />
	<%/cffunction>

	<%!--- UPDATE: updates a <cfoutput>#variables.table#</cfoutput> in the database --->
	<%cffunction name="updateRecord" access="public" output="false" returntype="struct" hint="Updates a
			<cfoutput>#variables.table#</cfoutput> record in the database and returns a struct containing a boolean (success) indicating
			the success or failure of the operation and a string (message) containing a message">
		<%!--- take <cfoutput>#variables.table#</cfoutput> bean as argument --->
		<%cfargument name="<cfoutput>#variables.table#</cfoutput>" type="any" required="true" />

		<%!--- initialize variables --->
		<%cfset var qUpdate<cfoutput>#variables.table#</cfoutput> = 0 />
		<%cfset var results = StructNew() />

		<%!--- set defaults --->
		<%cfset results.success = true />
		<%cfset results.message = "The record was updated successfully." />

		<%!--- update the <cfoutput>#variables.table#</cfoutput> --->
		<%cftry>
			<%cfquery name="qUpdate<cfoutput>#variables.table#</cfoutput>" datasource="#variables.datasource#">
				UPDATE <cfoutput>#variables.table#</cfoutput>
				SET
				<cfloop query="tableColumns">
					<cfif tableColumns.ORDINAL_POSITION NEQ 1>
                        <cfswitch expression="#type_name#">
                            <cfcase value="int unsigned, int signed, tinyint unsigned, tinyint signed, int, smallint, tinyint, bigint">
                                <cfset sqlType = "numeric">
                            </cfcase>
                            <cfcase value="bit">
                                <cfset sqlType = "bit">
                            </cfcase>
                            <cfcase value="date, datetime, smalldatetime, timestamp">
                                <cfset sqlType = "timestamp">
                            </cfcase>
                            <cfdefaultcase>
                                <cfset sqlType = "varchar">
                            </cfdefaultcase>
                        </cfswitch>
						<cfif tableColumns.recordcount NEQ tableColumns.currentrow>
							<%cfif structKeyExists(arguments,"<cfoutput>#column_name#</cfoutput>") and len(arguments.<cfoutput>#column_name#</cfoutput>)>
								<cfoutput>#column_name#</cfoutput>=<%cfqueryparam value="%arguments.<cfoutput>#variables.table#</cfoutput>.get<cfoutput>#column_name#</cfoutput>()%" cfsqltype="cf_sql_<cfoutput>#sqlType#</cfoutput>" />,
							<%cfelse>
								<cfoutput>#column_name#</cfoutput>=<cfoutput>#column_name#</cfoutput>,
							<%/cfif>
						<cfelseif tableColumns.currentrow NEQ 1>
							<%cfif structKeyExists(arguments,"<cfoutput>#column_name#</cfoutput>") and len(arguments.<cfoutput>#column_name#</cfoutput>)>
								<cfoutput>#column_name#</cfoutput>=<%cfqueryparam value="%arguments.<cfoutput>#variables.table#</cfoutput>.get<cfoutput>#column_name#</cfoutput>()%" cfsqltype="cf_sql_<cfoutput>#sqlType#</cfoutput>" />
							<%cfelse>
								<cfoutput>#column_name#</cfoutput>=<cfoutput>#column_name#</cfoutput>
							<%/cfif>
						</cfif>
					</cfif>
				</cfloop>
				WHERE <cfoutput>#variables.tableColumns.column_name#</cfoutput> = <%cfqueryparam value="%arguments.<cfoutput>#variables.table#</cfoutput>.get<cfoutput>#variables.tableColumns.column_name#</cfoutput>()%" cfsqltype="cf_sql_char" />
			<%/cfquery>
			<%cfcatch type="database">
				<%cfset results.success = false />
				<%cfset results.message = "Updating the record failed.  The error details if available are as follows" & CFCATCH.Detail />
			<%/cfcatch>
		<%/cftry>

		<%!--- return the struct --->
		<%cfreturn StructCopy(results) />
	<%/cffunction>

	<cfif realDelete is "true">
	<%!--- DELETE: deletes a <cfoutput>#variables.table#</cfoutput> from the database --->
	<%cffunction name="deleteRecord" access="public" output="false" returntype="struct" hint="Deletes a
			<cfoutput>#variables.table#</cfoutput> record from the database and returns a struct containing a boolean (success)
			indicating the success or failure of the operation and a string (message) containing a message">
		<%!--- take <cfoutput>#variables.table#</cfoutput> bean as argument --->
		<%cfargument name="<cfoutput>#variables.table#</cfoutput>" type="any" required="true" />

		<%!--- initialize variables --->
		<%cfset var qDelete<cfoutput>#variables.table#</cfoutput> = 0 />
		<%cfset var results = StructNew() />

		<%!--- set defaults --->
		<%cfset results.success = true />
		<%cfset results.message = "The record was deleted successfully." />

		<%!--- delete the <cfoutput>#variables.table#</cfoutput> --->
		<%cftry>
			<%cfquery name="qDelete<cfoutput>#variables.table#</cfoutput>" datasource="#variables.datasource#">
				DELETE FROM <cfoutput>#variables.table#</cfoutput>
				WHERE <cfoutput>#variables.tableColumns.column_name#</cfoutput> = <%cfqueryparam value="%arguments.<cfoutput>#variables.table#</cfoutput>.get<cfoutput>#variables.tableColumns.column_name#</cfoutput>()%" cfsqltype="cf_sql_char" />
			<%/cfquery>
			<%cfcatch type="database">
				<%cfset results.success = false />
				<%cfset results.message = "Deleting the record failed.  The error details if available are as follows: " & CFCATCH.Detail />
			<%/cfcatch>
		<%/cftry>

		<%!--- return the struct --->
		<%cfreturn StructCopy(results) />
	<%/cffunction>
	</cfif>

	<%!--- READ: reads a <cfoutput>#variables.table#</cfoutput> from the database and populates the <cfoutput>#variables.table#</cfoutput> object --->
	<%cffunction name="readRecord" access="public" output="false" returntype="query" hint="Reads <cfoutput>#variables.table#</cfoutput> data
			from the database and populates the object passed to this function">

		<%!--- read <cfoutput>#variables.table#</cfoutput> data --->
		<%cftry>
			<%cfquery name="qRead<cfoutput>#variables.table#</cfoutput>" datasource="#variables.datasource#">
				SELECT <cfloop query="tableColumns"><cfoutput>#variables.table#.#column_name#</cfoutput></cfloop>
				FROM <cfoutput>#variables.table#</cfoutput>
				WHERE <cfoutput>#variables.tableColumns.column_name#</cfoutput> = <%cfqueryparam value="%arguments.<cfoutput>#variables.table#</cfoutput>.get<cfoutput>#variables.tableColumns.column_name#</cfoutput>()%" cfsqltype="cf_sql_char" />

			<%/cfquery>
			<%cfcatch type="database">
				<%!--- object will remain empty --->
			<%/cfcatch>
		<%/cftry>
	<%/cffunction>

<%/cfcomponent>

</cfprocessingdirective></cfoutput></cfsavecontent>
<cfreturn generatedModel>
</cffunction>


<!--- Form Generator --->
<cffunction name="generateForm" access="public" returntype="string" hint="Generates code for the form script">
<cfsavecontent variable="generatedForm"><cfoutput><cfprocessingdirective suppresswhitespace="true">
<%cfsilent>
	<%cfparam name="<cfoutput>#variables.tableColumns.column_name#</cfoutput>" type="string" default="" />
	<%cfparam name="action" type="string" default="Add" />
	<%cfif structkeyexists(url,"cfgridkey")>
		<%cfset <cfoutput>#variables.tableColumns.column_name#</cfoutput> = url.cfgridkey />
	<%/cfif>
	<%cfif action eq "add" or <cfoutput>#variables.tableColumns.column_name#</cfoutput> eq "">
		<%cfset <cfoutput>#variables.tableColumns.column_name#</cfoutput> = 0 />
	<%/cfif>

	<%cfset <cfoutput>#variables.table#</cfoutput> = CreateObject("component", "#datasource#.app.dataobjects.<cfoutput>#variables.table#</cfoutput>Gateway").getByAttributes(<cfoutput>#variables.tableColumns.column_name#</cfoutput>='%<cfoutput>#variables.tableColumns.column_name#</cfoutput>%') />
<%/cfsilent>
<cfparam name="countArea" default="false"/>
<cfloop query="tableColumns">
  <cfif #type_name# EQ "varchar" AND #column_size# GT 255>
        <cfset countArea = true />
  </cfif>
</cfloop>

<cfif appCFC EQ false>
<%cfif %cgi.HTTP_HOST% EQ "localhost">
	<%cfset urlString = %mid(cgi.PATH_INFO, 2, 200)%>
    <%cfset localhostFolderName = %spanexcluding(urlString, "/")%>
<%/cfif>
</cfif>

<cfparam name="datefield" default="false"/>
<cfloop query="tableColumns">
  <cfif #type_name# EQ "date" OR #type_name# EQ "datetime" <!---OR #type_name# EQ "timestamp"---> OR #type_name# EQ "smalldatetime">
        <cfset datefield = true />
  </cfif>
</cfloop>

<!--- validate password fields --->
<cfparam name="passwordField" default="false"/>
<cfloop query="tableColumns">
	<cfif "#column_name#" contains "password">
        <cfset passwordField = true />
    </cfif>
</cfloop>
<%cf_layout title="#variables.table#">
<cfif isDefined('passwordField') AND passwordField EQ true>
	<%script type="text/javascript">
		function validatePassword ( ) {
		if (document.<cfoutput>#variables.table#</cfoutput>.password.value != document.<cfoutput>#variables.table#</cfoutput>.confirmPassword.value) {
			alert( "Your passwords do not match.\nPlease Try Again." );
			document.<cfoutput>#variables.table#</cfoutput>.password.focus();
			return false ;
		}
		document.<cfoutput>#variables.table#</cfoutput>.action.disabled=false;
		return true ;
		}
	<%/script>
</cfif>

<%cfoutput>
<%h2>%url.action% <cfoutput>#variables.table#</cfoutput> Details<%/h2>
	<%form action="%application.dirpath%#variables.datasource#/app/controllers/cnt_<cfoutput>#variables.table#</cfoutput>.cfc" method="post" name="<cfoutput>#variables.table#</cfoutput>" id="<cfoutput>#variables.table#</cfoutput>" role="form">
		<%fieldset>
			<cfloop query="tableColumns">
			<cfif is_PrimaryKey EQ "no" and is_ForeignKey eq "no" and column_default_value eq "">
			<%div class="form-group">
				<%label for="<cfoutput>#variables.table#_#column_name#</cfoutput>"<cfif is_nullable eq "no"> class="required"</cfif>><cfoutput>#column_name#</cfoutput><%/label>
				<!--- Loop through columns and create form fields based off column type --->
				<!--- BIT and BOOLEAN datatypes --->
				<cfif #type_name# EQ "bit" OR #type_name# EQ "boolean" >
				<%cfif %<cfoutput>#variables.table#</cfoutput>.<cfoutput>#column_name#</cfoutput>% EQ 1>
					<%input type="checkbox" name="<cfoutput>#variables.table#_#column_name#</cfoutput>" id="<cfoutput>#variables.table#_#column_name#</cfoutput>" value="1" checked="checked" class="form-control"  />
				<%cfelse>
					<%input type="checkbox" name="<cfoutput>#variables.table#_#column_name#</cfoutput>" id="<cfoutput>#variables.table#_#column_name#</cfoutput>" value="1" class="form-control" />
				<%/cfif>
				<!--- TEXT datatype --->
				<cfelseif #type_name# EQ "text" or (#type_name# eq "varchar" and column_size gte 1000)>
				<%textarea name="<cfoutput>#variables.table#_#column_name#</cfoutput>" class="form-control" id="<cfoutput>#variables.table#_#column_name#</cfoutput>" maxlength="<cfoutput>#column_size#</cfoutput>" <cfif is_nullable eq "no">required="yes" message="<cfoutput>#column_name#</cfoutput> is required"</cfif> <cfif variables.useRTE EQ true>richtext="true" toolbar="Default"</cfif>>%<cfoutput>#variables.table#</cfoutput>.<cfoutput>#column_name#</cfoutput>%<%/textarea>
				<!--- DATE, DATETIME, SMALLDATETIME and TIMESTAMP datatypes --->
				<cfelseif #type_name# EQ "date" OR #type_name# EQ "datetime" OR #type_name# EQ "timestamp" OR #type_name# EQ "smalldatetime" >
				<%cfif isDate(<cfoutput>#variables.table#</cfoutput>.<cfoutput>#column_name#</cfoutput>)>
					<%input type="datefield" class="form-control" name="<cfoutput>#variables.table#_#column_name#</cfoutput>" id="<cfoutput>#variables.table#_#column_name#</cfoutput>" <cfif is_nullable eq "no">required="true" message="<cfoutput>#column_name#</cfoutput> is required"</cfif> validate="date" maxlength="<cfoutput>#column_size#</cfoutput>" value="%dateformat(<cfoutput>#variables.table#</cfoutput>.<cfoutput>#column_name#</cfoutput>, 'm/d/yyyy')%" />
				<%cfelse>
					<%input type="datefield" class="form-control" name="<cfoutput>#variables.table#_#column_name#</cfoutput>" id="<cfoutput>#variables.table#_#column_name#</cfoutput>" <cfif is_nullable eq "no">required="true" message="<cfoutput>#column_name#</cfoutput> is required"</cfif> validate="date" maxlength="<cfoutput>#column_size#</cfoutput>" value="" />
				<%/cfif>
				<!--- Column Name is PASSWORD --->
				<cfelseif #column_name# contains "password" >
				<%input type="password" class="form-control" name="<cfoutput>#variables.table#_#column_name#</cfoutput>" id="<cfoutput>#variables.table#_#column_name#</cfoutput>" <cfif is_nullable eq "no">required="true" message="<cfoutput>#column_name#</cfoutput> is required"</cfif> maxlength="<cfoutput>#column_size#</cfoutput>" value="%<cfoutput>#variables.table#</cfoutput>.<cfoutput>#column_name#</cfoutput>%" />
				<%/td>
			<%/div>
			<%div class="form-group">
				<%label for="<cfoutput>#column_name#</cfoutput>"><cfoutput>confirm #column_name#</cfoutput><%/label>
					<%input type="password" name="confirmPassword" onblur="validatePassword()" onkeypress="return true; validateField(this, 'confirmPasswordError')" maxlength="<cfoutput>#column_size#</cfoutput>" value="%<cfoutput>#variables.table#</cfoutput>.<cfoutput>#column_name#</cfoutput>%" />
					<!--- Any other datatypes --->
					<cfelseif #type_name# eq "decimal">
					<%input type="number" class="form-control" name="<cfoutput>#variables.table#_#column_name#</cfoutput>" id="<cfoutput>#variables.table#_#column_name#</cfoutput>" <cfif is_nullable eq "no">required="true" message="<cfoutput>#column_name#</cfoutput> is required"</cfif> maxlength="<cfoutput>#column_size#</cfoutput>" value="%<cfoutput>#variables.table#</cfoutput>.<cfoutput>#column_name#</cfoutput>%" validate="numeric" message="Enter correct float number" />
					<cfelseif #type_name# eq "integer">
					<%input type="number" class="form-control" name="<cfoutput>#variables.table#_#column_name#</cfoutput>" id="<cfoutput>#variables.table#_#column_name#</cfoutput>" <cfif is_nullable eq "no">required="true" message="<cfoutput>#column_name#</cfoutput> is required"</cfif> maxlength="<cfoutput>#column_size#</cfoutput>" value="%<cfoutput>#variables.table#</cfoutput>.<cfoutput>#column_name#</cfoutput>%" validate="integer" message="Enter correct number" />
					<cfelseif #type_name# eq "money" or #column_name# contains "price">
					<%input type="number" class="form-control" name="<cfoutput>#variables.table#_#column_name#</cfoutput>" id="<cfoutput>#variables.table#_#column_name#</cfoutput>" <cfif is_nullable eq "no">required="true" message="<cfoutput>#column_name#</cfoutput> is required"</cfif> maxlength="<cfoutput>#column_size#</cfoutput>" value="%dollarformat(<cfoutput>#variables.table#</cfoutput>.<cfoutput>#column_name#</cfoutput>)%" validate="numeric" message="Enter correct float number" />
					<cfelseif #column_name# contains "phone">
					<%input type="tel" class="form-control" name="<cfoutput>#variables.table#_#column_name#</cfoutput>" id="<cfoutput>#variables.table#_#column_name#</cfoutput>" <cfif is_nullable eq "no">required="true" message="<cfoutput>#column_name#</cfoutput> is required"</cfif> maxlength="<cfoutput>#column_size#</cfoutput>" value="%<cfoutput>#variables.table#</cfoutput>.<cfoutput>#column_name#</cfoutput>%" validate="telephone" message="Enter correctly formatted telephone number" />
					<cfelseif #column_name# contains "zip" or #column_name# contains "postal">
					<%input type="text" class="form-control" name="<cfoutput>#variables.table#_#column_name#</cfoutput>" id="<cfoutput>#variables.table#_#column_name#</cfoutput>" <cfif is_nullable eq "no">required="true" message="<cfoutput>#column_name#</cfoutput> is required"</cfif> maxlength="<cfoutput>#column_size#</cfoutput>" value="%<cfoutput>#variables.table#</cfoutput>.<cfoutput>#column_name#</cfoutput>%" validate="zipcode" message="Enter correct zip code" />
					<cfelseif #column_name# contains "creditcard">
					<%input type="text" class="form-control" name="<cfoutput>#variables.table#_#column_name#</cfoutput>" id="<cfoutput>#variables.table#_#column_name#</cfoutput>" <cfif is_nullable eq "no">required="true" message="<cfoutput>#column_name#</cfoutput> is required"</cfif> maxlength="<cfoutput>#column_size#</cfoutput>" value="%<cfoutput>#variables.table#</cfoutput>.<cfoutput>#column_name#</cfoutput>%" validate="creditcard" message="Enter correct credit card" />
					<cfelseif #column_name# contains "email">
					<%input type="email" class="form-control" name="<cfoutput>#variables.table#_#column_name#</cfoutput>" id="<cfoutput>#variables.table#_#column_name#</cfoutput>" <cfif is_nullable eq "no">required="true" message="<cfoutput>#column_name#</cfoutput> is required"</cfif> maxlength="<cfoutput>#column_size#</cfoutput>" value="%<cfoutput>#variables.table#</cfoutput>.<cfoutput>#column_name#</cfoutput>%" validate="email" message="Enter correct email address" />
					<cfelseif #column_name# contains "url">
					<%input type="url" class="form-control" name="<cfoutput>#variables.table#_#column_name#</cfoutput>" id="<cfoutput>#variables.table#_#column_name#</cfoutput>" <cfif is_nullable eq "no">required="true" message="<cfoutput>#column_name#</cfoutput> is required"</cfif> maxlength="<cfoutput>#column_size#</cfoutput>" value="%<cfoutput>#variables.table#</cfoutput>.<cfoutput>#column_name#</cfoutput>%" validate="url" message="Enter correct url" />
					<cfelse>
					<%input type="text" class="form-control" name="<cfoutput>#variables.table#_#column_name#</cfoutput>" id="<cfoutput>#variables.table#_#column_name#</cfoutput>" <cfif is_nullable eq "no">required="true" message="<cfoutput>#column_name#</cfoutput> is required"</cfif> maxlength="<cfoutput>#column_size#</cfoutput>" value="%<cfoutput>#variables.table#</cfoutput>.<cfoutput>#column_name#</cfoutput>%" />
					</cfif>
			<%/div>
			</cfif>
			</cfloop>
		<%/fieldset>
		<%div class="buttons">
			<%input type="hidden" name="method" value="<%cfif action eq 'add'>create<%cfelse>update<%/cfif>" />
			<%input type="hidden" name="<cfoutput>#variables.table#_#variables.tableColumns.column_name#</cfoutput>" id="<cfoutput>#variables.table#_#variables.tableColumns.column_name#</cfoutput>" value="%<cfoutput>#variables.table#</cfoutput>.<cfoutput>#variables.tableColumns.column_name#</cfoutput>%" />
			<%cfswitch expression="%url.action%">
				<%cfcase value="add">
					<%input type="submit" name="action" class="btn btn-primary" value="Add"/>
				<%/cfcase>
				<%cfcase value="update">
						<%input type="submit" name="action" class="btn btn-primary" value="Update" />
						<%input type="submit" name="action" class="btn btn-danger" value="Delete" onclick="return confirm('Are you sure you want to delete this record from the database?')"/>
				<%/cfcase>
			<%/cfswitch>
		<%/div>
<%/form>
<%/cfoutput>
<%/cf_layout>

</cfprocessingdirective></cfoutput></cfsavecontent>

<cfreturn generatedForm>
</cffunction>

<!--- Pre CF8 Data Table --->
<cffunction name="generateDataTable" access="public" returntype="string" hint="Generates code for the html data table">
<cfsavecontent variable="generatedDataTable"><cfoutput><cfprocessingdirective suppresswhitespace="true">
<%cfprocessingdirective suppresswhitespace="true">

<%!--- get all the <cfoutput>#variables.table#</cfoutput> in the database --->
<%cfset <cfoutput>#variables.table#</cfoutput>Gateway = CreateObject("component", "<cfoutput>#variables.datasource#</cfoutput>.app.dataobjects.<cfoutput>#variables.table#</cfoutput>Gateway").init(<cfif variables.pathType EQ "useAppPath">Application.datasource<cfelse>'<cfoutput>#variables.datasource#</cfoutput>'</cfif>) />
<%cfset getAllRecords = <cfoutput>#variables.table#</cfoutput>Gateway.getAllRecords() />

<%cfset perpage = 10>

<%cfparam name="url.start" default="1">
<%cfif not isNumeric(url.start) or url.start lt 1 or url.start gt	getAllRecords.recordCount or round(url.start) neq url.start>
	<%cfset url.start = 1>
<%/cfif>

<cfif appCFC EQ false>
<%cfif %cgi.HTTP_HOST% EQ "localhost">
	<%cfset urlString = %mid(cgi.PATH_INFO, 2, 200)%>
    <%cfset localhostFolderName = %spanexcluding(urlString, "/")%>
<%/cfif>
</cfif>

<%cfoutput>
	<%cfif isDefined('url.success')>
		<%div>
			<%cfif url.success EQ false>ERROR: <%/cfif>%url.message%
		<%/div>
	<%/cfif>
<%/cfoutput>
<%div class="pull-right"><%a href="edit.cfm?action=add">Add New <cfoutput>#variables.revTable#</cfoutput><%/a><%/div>
<%table class="list table table-striped responsive">
<%thead>
	<%tr>
	<cfloop query="tableColumns">
		<cfif tableColumns.currentrow LTE 5>
			<cfif  NOT (#type_name# EQ "varchar" AND #column_size# GT 255) OR #type_name# EQ 'text' OR #type_name# EQ 'ntext' OR #type_name# EQ 'nvarchar'>
				<%th><cfoutput>#column_name#</cfoutput><%/th>
			</cfif>
		</cfif>
	</cfloop>
	<%th><cfoutput>Edit</cfoutput><%/th>
	<%th><cfoutput>Delete</cfoutput><%/th>
	<%/tr>
	<%/thead>
	<%cfloop query="getAllRecords" startrow="%url.start%" endrow="%url.start + perpage%">
		<%tr>
			<cfloop query="tableColumns">
				<cfif tableColumns.currentrow LTE 5>
					<cfif  NOT (#type_name# EQ "varchar" AND #column_size# GT 255) OR #type_name# EQ 'text' OR #type_name# EQ 'ntext' OR #type_name# EQ 'nvarchar'>
						<cfif #type_name# EQ "date" OR #type_name# EQ "datetime" OR #type_name# EQ "timestamp" OR #type_name# EQ "smalldatetime" >
							<%cfif dateformat(<cfoutput>#column_name#</cfoutput>, 'yyyy-mm-dd') NEQ '1899-12-31'>
								<%cfif timeformat(<cfoutput>#column_name#</cfoutput>, 'h:mm:ss tt') EQ '12:00:00 AM'>
									<%!-- Format as Date -->
									<%td data-title="<cfoutput>#column_name#</cfoutput>">%dateformat(<cfoutput>#column_name#</cfoutput>, 'm/d/yy')%<%/td>
								<%cfelse>
									<%!-- Format as Time -->
									<%td data-title="<cfoutput>#column_name#</cfoutput>">%timeformat(<cfoutput>#column_name#</cfoutput>, 'h:mm tt')%<%/td>
								<%/cfif>
							<%cfelse>
								<%td data-title="<cfoutput>#column_name#</cfoutput>">&nbsp;<%/td>
							<%/cfif>
						<cfelse>
							<%td data-title="<cfoutput>#column_name#</cfoutput>">%<cfoutput>#column_name#</cfoutput>%<%/td>
						</cfif>
					</cfif>
				</cfif>
			</cfloop>
			<%td><%a href="edit.cfm?<cfoutput>#variables.tableColumns.column_name#</cfoutput>=%<cfoutput>#variables.tableColumns.column_name#</cfoutput>%&action=update&start=%url.start%" title="Edit">Edit<%/a><%/td>
			<%td><%a href="edit.cfm?<cfoutput>#variables.tableColumns.column_name#</cfoutput>=%<cfoutput>#variables.tableColumns.column_name#</cfoutput>%&action=delete&start=%url.start%" title="Delete">Delete<%/a><%/td>
		<%/tr>
	<%/cfloop>
<%/table>

<%div>
	<%ul class="pager">
		<%li>
			<%cfif url.start gt 1>
				<%cfset link = cgi.script_name & "?start=" & (url.start - perpage)>
				<%cfoutput><%a href="%link%" title="Previous" rel="prev" accesskey="p">&laquo; Previous Page<%/a><%/cfoutput>
			<%cfelse>

			<%/cfif>
		<%/li>
		<%li>
			<%cfif (url.start + perpage - 1) lt getAllRecords.recordCount>
				<%cfset link = cgi.script_name & "?start=" & (url.start + perpage)>
				<%cfoutput><%a href="%link%" title="Next" rel="next" accesskey="n">Next Page &raquo;<%/a><%/cfoutput>
			<%cfelse>

			<%/cfif>
		<%/li>
	<%/ul>
<%/div>
<%/cfprocessingdirective>

</cfprocessingdirective></cfoutput></cfsavecontent>

<cfreturn generatedDataTable>
</cffunction>
<!--- default Generator, don't use the grid one --->
<cffunction name="generatedefault" access="public" returntype="string" hint="Generates code for default">
<cfsavecontent variable="generateddefault"><cfoutput><cfprocessingdirective suppresswhitespace="true">
<%cfprocessingdirective suppresswhitespace="true">
<%cf_layout title="#variables.table#" page_title="#variables.table#">
	<%cfoutput>
	#generateDataTable(argumentCollection=arguments)#
	<%/cfoutput>
<%/cf_layout>
<%/cfprocessingdirective>
</cfprocessingdirective></cfoutput></cfsavecontent>

<cfreturn generateddefault>
</cffunction>

<!--- Application CFC Generator --->

<cffunction name="generateApplicationCFC" access="public" returntype="string" hint="Generates code for Application CFC">
<cfsavecontent variable="generatedApplicationCFC"><cfoutput><cfprocessingdirective suppresswhitespace="true">

<%cfcomponent output="false">

	<%!--- APPLICATION VARIABLES --->
	<%cfset THIS.applicationTimeout = createTimeSpan(0,2,0,0)>
	<%cfset THIS.sessionManagement="Yes">
	<%cfset THIS.clientManagement = false>
	<%cfset THIS.clientStorage = "cookie">
	<%cfset THIS.loginStorage = "cookie">
	<%cfset THIS.setDomainCookies = false>
	<%cfset THIS.scriptProtect = true>

	<%cfset this.root = getDirectoryFromPath(getCurrentTemplatePath()) />
	<%cfset this.directory = listLast(this.root, "\") />
	<%cfset this.mappings = setAppMappings() />
	<%cfset this.project = "#variables.datasource#" />
  	<%cfset THIS.name = getName() />

	<%cfset THIS.datasource = "#variables.datasource#">
	<%cfset this.customtagpaths = "%this.root%app\views\">
	<%cfif %cgi.HTTP_HOST% NEQ "localhost">
    	<%cfset THIS.dirpath = "http://%cgi.http_host%">
		<%cfset THIS.componentPath = "cfcs.">
    <%cfelse>
		<%cfset urlString = %mid(cgi.PATH_INFO, 2, 200)%>
        <%cfset THIS.localhostFolderName = %spanexcluding(urlString, "/")%>
    	<%cfset THIS.dirpath = "http://localhost/%THIS.localhostFolderName%">
		<%cfset THIS.componentPath = "%THIS.localhostFolderName%.cfcs.">
	<%/cfif>

  <%cfset THIS.sessiontimeout = createtimespan(0,0,30,0)>
  <%cfset THIS.setClientCookies = true>

	<%cffunction name="onApplicationStart" returntype="void">
		<%cfset APPLICATION.name = THIS.name>
		<%cfset APPLICATION.datasource = THIS.datasource>
		<%cfset APPLICATION.dirpath = THIS.dirpath>
		<%cfset application.path=expandPath("%getContextRoot()&"/"&this.project%/")>
		<%cfset APPLICATION.componentPath = THIS.componentPath>
		<%cfset application.grid.Width = "700px">
		<%cfset application.grid.PageSize = "25">
		<%!--- remove comments if you have coldspring
		<%cfset application.beanFactory = createObject("component","coldspring.beanutils.DynamicBeanFactory").init("config/beans.xml") />
		--->
		<%cfif %cgi.HTTP_HOST% EQ "localhost">
			<%cfset APPLICATION.localhostFolderName = THIS.localhostFolderName>
		<%/cfif>
		<%cfset application.urlroot= application.dirpath & this.directory &"/" />
		<%cfset application.views=application.urlroot&"app/views/" />
    <%/cffunction>

    <%cffunction name="onRequestStart" returntype="void">

		<%cfif structKeyExists(url, "reinit")>
			<%cfset onApplicationStart()>
		<%/cfif>

	<%/cffunction>

	<%!------>

	<%cffunction name="setAppMappings" access="private" output="false" returntype="struct">

		<%cfset var local = {} />

		<%!--- create the necessary mappings --->
		<%cfset local.mappings = {} />

		<%!--- grab the current directory --->
		<%cfset local.path = lcase(this.root) />

		<%!--- set the root to one level higher than the current project --->
		<%cfset local.webroot = left(local.path, len(local.path)-(len(this.directory)+1)) />

		<%!--- project specific mappings --->
		<%cfset local.mappings["/#variables.datasource#"] = local.path />
		<%cfset local.mappings["/views"] = local.path & "app\views\" />

		<%cfreturn local.mappings />

	<%/cffunction>

	<%!------>

	<%cffunction name="getName" access="private" output="false" returntype="string">

		<%cfset var local = {} />

		<%!--- build out a dynamic application name based on the path to the code --->
		<%cfset local.directory = reReplace(hash(lcase(getCurrentTemplatePath())), "[^a-zA-Z]", "", "all") />

		<%cfset local.name = this.project & "_" & local.directory />

		<%cfreturn left(local.name, 64) />

	<%/cffunction>

<%!---

    <%cffunction name="onRequestEnd" returntype="void">
    <%/cffunction>



    <%cffunction name="onSessionStart" returntype="void">
    <%/cffunction>



    <%cffunction name="onRequest" returntype="void">
    <%/cffunction>



    <%cffunction name="onSessionEnd" returntype="void">
    <%/cffunction>



    <%cffunction name="onApplicationEnd" returntype="void">
    <%/cffunction>



    <%cffunction name="onError" returntype="void">
    <%/cffunction>



    <%cffunction name="onMissingTemplate" returntype="void">
    <%/cffunction>

--->

<%/cfcomponent>

</cfprocessingdirective></cfoutput></cfsavecontent>

<cfreturn generatedApplicationCFC>
</cffunction>

<!--- layout Generator --->
<cffunction name="generateLayout" access="public" returntype="string" hint="Generates code for Layout">
<cfsavecontent variable="generatedLayout"><cfoutput><cfprocessingdirective suppresswhitespace="true">
<%cfprocessingdirective suppresswhitespace="true">
<%cfparam name="attributes.title" default="">
<%cfparam name="attributes.page_title" default="">

<%cfif thisTag.executionMode is "start">
<%!DOCTYPE html>
<%html lang="en" >
<%head>
<%cfoutput>
<%title>%attributes.title% > %attributes.page_title%<%/title>
<link rel="shortcut icon" href="http://flickholdr.com/16/16/" />
<%/cfoutput>
<%meta name="viewport" content="width=device-width, initial-scale=1.0">
<%!-- Latest compiled and minified CSS -->
<%link rel="stylesheet" href="//netdna.bootstrapcdn.com/bootstrap/3.0.0/css/bootstrap.min.css">

<%!-- Optional theme -->
<%link rel="stylesheet" href="//netdna.bootstrapcdn.com/bootstrap/3.0.0/css/bootstrap-theme.min.css">

<%link rel="stylesheet" type="text/css" href="<%cfoutput>%application.urlroot%<%/cfoutput>assets/css/#datasource#.css" />
<%meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<%meta content="text/html" name="DC.format" />
<%meta content="en" name="DC.language" />
<%meta content="<%cfoutput>%dateformat(now(),"yyyy-mm-dd")%<%/cfoutput>" name="DC.date" />
<%link href="http://purl.org/dc/elements/1.1/" rel="schema.DC" />
<%meta name="keywords" content="" />
<%meta name="description" content="" />
<%meta name="dc.author" content="CRACK"/>
<%meta name="dc.title" content="#datasource#" />
<%/head>

<%body>
	<%div class="navbar navbar-fixed-top navbar-inverse" role="navigation">
      <%div class="container">
        <%div class="navbar-header">
          <%button type="button" class="navbar-toggle" data-toggle="collapse" data-target=".navbar-collapse">
            <%span class="icon-bar"><%/span>
            <%span class="icon-bar"><%/span>
            <%span class="icon-bar"><%/span>
          <%/button>
          <%cfoutput><%a class="navbar-brand" href="%%">#datasource#<%/a><%/cfoutput>
        <%/div>
      <%/div><%!-- /.container -->
    <%/div><%!-- /.navbar -->
<%div class="container">

<%div class="row row-offcanvas row-offcanvas-right">
	<%div class="col-xs-12 col-sm-9">
		<%p class="pull-right visible-xs">
			<%button type="button" class="btn btn-primary btn-xs" data-toggle="offcanvas">Toggle nav</button>
		<%/p>

		<%div class="page-header">
			<%cfoutput><%h1>%attributes.page_title%<%/h1><%/cfoutput>
		<%/div>

		<%div class="row content">
<%cfelse>
	<%/div><!--/row-->
	<%/div><!--/span-->

		<%div class="col-xs-6 col-sm-3 sidebar-offcanvas" id="sidebar" role="navigation">
			<%div class="well sidebar-nav">
			<%cfset navigation=CreateObject("component", "#datasource#.app.helpers.hlp_navigation").init() />
			<%cfoutput>%trim(navigation)%<%/cfoutput>
			<%/div><%!--/.well -->
		<%/div><%!--/span-->
	<%/div><%!--/row-->

	<%footer><%/footer>

<%/div><%!--/.container-->

<%script src="//code.jquery.com/jquery.js"></script>
<%!-- Latest compiled and minified JavaScript -->
<%script src="//netdna.bootstrapcdn.com/bootstrap/3.0.0/js/bootstrap.min.js"></script>
<%/body>
<%/html>

<%/cfif>
<%/cfprocessingdirective>
</cfprocessingdirective></cfoutput></cfsavecontent>

<cfreturn generatedLayout>
</cffunction>


<!--- basic css Generator --->
<cffunction name="generateCSS" access="public" returntype="string" hint="Generates code for CSS">
<cfsavecontent variable="generatedCSS"><cfoutput><cfprocessingdirective suppresswhitespace="true">
body {
  padding-top: 70px;
}
footer {
  padding-left: 15px;
  padding-right: 15px;
}



@media screen and (max-width: 768px) {
  .row-offcanvas {
    position: relative;
    transition: all 0.25s ease-out;
  }

  .row-offcanvas-right
  .sidebar-offcanvas {
    right: -50%; /* 6 columns */
  }

  .row-offcanvas-left
  .sidebar-offcanvas {
    left: -50%; /* 6 columns */
  }

  .row-offcanvas-right.active {
    right: 50%; /* 6 columns */
  }

  .row-offcanvas-left.active {
    left: 50%; /* 6 columns */
  }

  .sidebar-offcanvas {
    position: absolute;
    top: 0;
    width: 50%; /* 6 columns */
  }
}
</cfprocessingdirective></cfoutput></cfsavecontent>

<cfreturn generatedCSS>
</cffunction>


<!--- Helper Navigation Generator --->
<cffunction name="generateHelperNavigation" access="public" returntype="string" hint="Generates code for a Helper Navigation Object">
<cfsavecontent variable="generatedHelperNavigation"><cfoutput><cfprocessingdirective suppresswhitespace="true">
<%cfcomponent name="navigation" displayname="navigation" output="false" hint="creates navigational menu">
<%cffunction name="init" access="public" output="false" returntype="any" hint="Constructor for this CFC">
<%!--- menu.xml in current directory --->
<%CFSET cur_dir=GetDirectoryFromPath(GetTemplatePath())>
<%CFSET menu_file="%application.path%app/helpers/menu.xml">

<%cfif not fileExists(%menu_file%)>
	<%cfset write=CreateObject("component", "#datasource#.app.helpers.hlp_navigation").createMenuXML() />
<%/cfif>
<%!--- Read XML file --->
<%CFFILE ACTION="read"	FILE="%menu_file%"	VARIABLE="menu_data">

<%CFSET menu=BuildMenu(menu_data, MenuAsList)>
<%cfreturn menu/>
<%/cffunction>

<%!---
GetItem
Parses XML and gets each item, called recursivley
for nested menus.
This function should not be called directly, it should
only be called by the primay menu interface and by
itself.
--->

<%cffunction name="getitem" returntype="string" output="no">
	<%cfargument name="menu" required="yes">
	<%cfargument name="callback" required="yes">

	<%!--- local variables --->
	<%cfset var result="">
	<%cfset var i1=0>
	<%cfset var i2=0>
	<%cfset var item_name="">
	<%cfset var item_link="">
	<%!--- loop through menu items --->
	<%cfloop from="1"
			to="%arraylen(menu)%"
			index="i1">
		<%!--- is this an item or a menu? --->
		<%cfif menu[i1].xmlname is "item">
			<%!--- it's an item, loop to get text and link --->
			<%cfloop from="1"
					to="%arraylen(menu[i1].xmlchildren)%"
					index="i2">
				<%cfif menu[i1].xmlchildren[i2].xmlname is "text">
					<%cfset item_name=menu[i1].xmlchildren[i2].xmltext>
				<%cfelseif menu[i1].xmlchildren[i2].xmlname is "link">
					<%cfset item_link=menu[i1].xmlchildren[i2].xmltext>
				<%/cfif>
			<%/cfloop>
			<%!--- now pass this one to the callback function --->
			<%cfset result=result & callback("item",
							item_name,
							item_link)>
		<%!--- it's a submenu --->
		<%cfelseif menu[i1].xmlname is "menu">
			<%!--- start submenu --->
			<%cfset result=result &
			callback("submenu_start", menu[i1].xmlattributes.name)>
			<%!--- recurse to get child submenu items --->
			<%cfset result=result & getitem(menu[i1].xmlchildren, callback)>
			<%!--- end submenu --->
			<%cfset result=result & callback("submenu_end")>
		<%/cfif>
	<%/cfloop>

	<%!--- and return it --->
	<%cfreturn result>
<%/cffunction>

<%!---
BuildMenu
This is the menu entry point. Pass it the XML for the menu
and a callback function and it does the rest. It returns
a complete menu as a string (built by the callback function
calls).
--->
<%cffunction name="buildmenu" returntype="string" output="no">
	<%cfargument name="menu_xml" type="string" required="yes">
	<%cfargument name="callback" required="yes">

	<%!--- local variables --->
	<%cfset var menu=xmlparse(menu_xml)>
	<%cfset var meta_data="">
	<%cfset var proceed="yes">

	<%!--- make sure "callback" is a valid udf --->
	<%cfif not iscustomfunction(callback)>
		<%cfthrow message="callback function must be a udf">
	<%/cfif>

	<%!--- get callback meta data --->
	<%cfset meta_data=getmetadata(callback)>

	<%!--- now make sure callback returns right type --->
	<%cfif meta_data.returntype is not "string">
		<%cfthrow message="callback function must return a string">
	<%/cfif>

	<%!--- make sure it accepts the right params --->
	<%cfif arraylen(meta_data.parameters) is not 3
		or meta_data.parameters[1].type is not "string"
		or meta_data.parameters[2].type is not "string"
		or meta_data.parameters[3].type is not "string">
		<%cfthrow message="callback function must accept three string arguments">
	<%/cfif>

	<%!--- build and return menu --->
	<%cfreturn callback("menu_start") &	getitem(menu.menu.xmlchildren, callback) & callback("menu_end")>

<%/cffunction>

<%!---
MenuAsList
This is the callback function, this one creates a nested
unordered list, it can be replaced with any other function
(the name of which must be passed as a parameter to
BuildMenu().
When called three parameters will be passed to it:
 TYPE: One of the following:
		MENU_START = start of menu
		MENU_END = end of menu
		SUBMENU_START = start of submenu
		SUBMENU_END = end of submenu
		ITEM = menu item
 TEXT:  Item text (only for SUBMENU_START and ITEM)
 LINK:  Link URL (only for ITEM)
--->

<%cffunction name="menuAsList" returntype="string" output="no">
	<%cfargument name="type" type="string" default="">
	<%cfargument name="text" type="string" default="">
	<%cfargument name="link" type="string" default="">

	<%!--- local variable for result --->
	<%cfset var result="">

	<%!--- build result based on type --->
	<%cfswitch expression="%type%">
		<%cfcase value="menu_start">
			<%cfset result="<%ul class='nav'>">
		<%/cfcase>
		<%cfcase value="menu_end">
			<%cfset result="<%/ul>">
		<%/cfcase>
		<%cfcase value="submenu_start">
			<%cfset result="<%li>%text%<%ul>">
		<%/cfcase>
		<%cfcase value="submenu_end">
			<%cfset result="<%/ul><%/li>">
		<%/cfcase>
		<%cfcase value="item">
			<%cfset result="<%li><%a href=""%application.views&link%"" title=""%text%"">%text%<%/a><%/li>">
		<%/cfcase>
	<%/cfswitch>

	<%!--- and return it --->
	<%cfreturn trim(result)>
<%/cffunction>

<%!------>

<%cffunction name="createMenuXML" returntype="any" output="no">
<%cfdirectory action="list" directory="%application.path%app\views\" name="dirQuery">
<%cfset dirsArray=arraynew(1)>
<%cfset i=1>
<%cfloop query="dirQuery">
<%cfif dirQuery.type IS "dir" and dirQuery.name neq "layouts">
    <%cfset dirsArray[i]=dirQuery.name>
    <%cfset i = i + 1>
<%/cfif>
<%/cfloop>
<%cfsavecontent variable="writeThis">
<%menu name="Menu">
	<%item>
		<%text>Home<%/text>
		<%link>default.cfm<%/link>
	<%/item>
<%cfloop array="%dirsArray%" index="idx">
	<%item>
	<%cfoutput>
		<%text>%idx%<%/text>
		<%link>%idx%/default.cfm<%/link>
	<%/cfoutput>
	<%/item>
<%/cfloop>
<%/menu>
<%/cfsavecontent>
<%cffile action = "write" file = "%application.path%app\helpers\menu.xml" output = "%writeThis%">

<%/cffunction>

<%/cfcomponent>
</cfprocessingdirective></cfoutput></cfsavecontent>

<cfreturn generatedHelperNavigation>
</cffunction>

	<!------>

</cfcomponent>