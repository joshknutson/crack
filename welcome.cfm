<!--- If we have picked a DSN, move away. --->
<cfif len(session.dsn)>
	<cflocation url="main.cfm" addToken="false">
</cfif>

<h1>Welcome to the CRACK</h1>
<p>
To begin - select a datasource. You will then be able to select a table on the left, then create the files needed for the events.
</p>
