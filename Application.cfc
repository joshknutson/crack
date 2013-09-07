<cfcomponent output="false">

	<!--- APPLICATION VARIABLES --->
	<cfset THIS.applicationTimeout = createTimeSpan(0,2,0,0)>
	<cfset this.loginStorage = "session">
	<cfset this.sessionManagement = true>
	<cfset this.sessionTimeout = createTimeSpan(0,0,20,0)>

	<cfset this.root = getDirectoryFromPath(getCurrentTemplatePath()) />
	<cfset this.directory = listLast(this.root, "\") />
	<cfset THIS.clientManagement = false>
	<cfset THIS.setDomainCookies = false>
	<cfset THIS.scriptProtect = true>
    <cfset THIS.name = "CRACK">
    <cfset THIS.customtagpaths = this.root & "/tags">

	<cfif #cgi.HTTP_HOST# NEQ "localhost">
		<cfset THIS.componentPath = "cfcs.">
        <cfset THIS.localhostFolderName = "">
    <cfelse>
		<cfset urlString = #mid(cgi.PATH_INFO, 2, 200)#>
        <cfset THIS.localhostFolderName = #spanexcluding(urlString, "/")#>
		<cfset THIS.componentPath = "#THIS.localhostFolderName#.cfcs.">
	</cfif>

	<!------>

	<cffunction name="onApplicationStart" returnType="boolean" output="false">
		<cfset application.adminObj = createObject("component","cfide.adminapi.administrator")>
		<cfset application.dsObj = createObject("component","cfide.adminapi.datasource")>
		<cfreturn true>
	</cffunction>

	<!------>

	<cffunction name="onApplicationEnd" returnType="void" output="false">
		<cfargument name="applicationScope" required="true">
	</cffunction>

	<!------>

	<cffunction name="onRequestStart" returnType="boolean" output="false">
		<cfargument name="thePage" type="string" required="true">
		<cfset var args = structNew()>

		<cfif !structKeyExists(session,"showLogin")>
			<cfset session.showLogin = true>
		</cfif>
		<cfif structKeyExists(url, "reinit")>
			<cfset onApplicationStart()>
			<cfset onSessionStart()>
		</cfif>

		<cfif isDefined("url.logout")>
			<cfset application.adminObj.logout()>
			<cfset session.dsn = "">
			<cfset session.hidetables = true>
			<cfset session.hideviews = false>
			<cfset session.generateType = "model">
			<cflogout />
		</cfif>

		<cflogin>
			<cfif structkeyexists(form,"login") and structkeyexists(form,"username") and structkeyexists(form,"password")>

				<cfset args.adminPassword = form.password>
				<cfif len(form.username)>
					<cfset args.adminUserId = form.username>
				</cfif>

				<cfif application.adminObj.login(argumentCollection=args)>
					<cfset session.showLogin = false>
					<cfset session.password = form.password>
					<cfif len(form.username)>
						<cfset session.username = form.username>
					<cfelse>
						<cfset session.username = "admin">
					</cfif>
					<cfloginuser name="#session.username#" password="#session.password#" roles="user">

				<cfelse>
					<cfset request.showautherror = true>
				</cfif>
			</cfif>

			<cfif session.showLogin>
				<cfinclude template="login.cfm">
				<cfabort>
			</cfif>
		</cflogin>

		<!--- Pick up DSN sets --->
		<cfif structKeyExists(url, "dsn")>
			<cfset session.dsn = url.dsn>
		</cfif>
		<cfif structKeyExists(url, "hidetables") and isBoolean(url.hidetables)>
			<cfset session.hidetables = url.hidetables>
		</cfif>
		<cfif structKeyExists(url, "hideviews") and isBoolean(url.hideviews)>
			<cfset session.hideviews = url.hideviews>
		</cfif>
		<cfif structKeyExists(url, "generateType")>
			<cfset session.generateType = url.generateType>
		</cfif>

		<!--- Temp hack till I find out why my darn app objects don't work --->
		<cfinvoke component="cfide.adminapi.administrator" method="login" adminPassword="#session.password#" adminUserId="#session.username#">

		<cfset APPLICATION.name = THIS.name>
        <cfset APPLICATION.localhostFolderName = THIS.localhostFolderName>
		<cfset APPLICATION.componentPath = THIS.componentPath>
		<cfreturn true>
	</cffunction>

	<!------>

	<cffunction name="onRequestEnd" returnType="void" output="false">
		<cfargument name="thePage" type="string" required="true">
	</cffunction>

	<!---
	<cffunction name="onError" returnType="void" output="true">
		<cfargument name="exception" required="true">
		<cfargument name="eventname" type="string" required="true">

		<cfif isDefined("arguments.exception.cause.type") and arguments.exception.cause.type is "coldfusion.runtime.AbortException">
			<cfreturn>
		</cfif>

		<cfoutput>exception=#arguments.exception.message#</cfoutput>
		<cfdump var="#arguments#"><cfabort>

	</cffunction>
	--->

	<cffunction name="onSessionStart" returnType="void" output="false">
		<cfset session.dsn = "">
		<cfset session.hidetables = true>
		<cfset session.hideviews = false>
		<cfset session.generateType = "model">
	</cffunction>

	<!------>

	<cffunction name="onSessionEnd" returnType="void" output="false">
		<cfargument name="sessionScope" type="struct" required="true">
		<cfargument name="appScope" type="struct" required="false">
	</cffunction>

	<!------>

</cfcomponent>


