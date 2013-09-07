<!--- If we haven't picked a DSN, move away. --->
<cfif not len(session.dsn)>
	<cflocation url="welcome.cfm" addToken="false">
</cfif>
<cfset tableList="" />
<cflayout type="border">

	<cflayoutarea position="left" size="250" name="tabletree" title="Tables" splitter="true" collapsible="true">
		<cfdbinfo datasource="#session.dsn#" name="tables" type="tables">
		<cfif tables.recordCount>
			<cfform name="tabletree_form">
			<cftree format="html" name="tabletree">
				<cfloop query="tables">
					<cfif table_type is not "System Table" and table_type is not "View" or (table_type is "System Table" and not session.hidetables)>
						<cftreeitem value="#table_name#" display="#table_name#" expand="false" img="assets/images/database_table.png" 
						href="javascript:ColdFusion.navigate('codelinks.cfm?datasource=#session.dsn#&amp;table=#table_name#&amp;appCFC=true','generateCode');">
						<cfset tableList=listappend(tableList,"#table_name#") />
					</cfif>
				</cfloop>
				<cftreeitem value="all" display="I'm lazy" expand="false" img="assets/images/database_table.png" 
					href="javascript:ColdFusion.navigate('codelinks.cfm?datasource=#session.dsn#&amp;table=#tableList#&amp;appCFC=true','generateCode');">
			</cftree>
			</cfform>
		</cfif>
	</cflayoutarea>

	<cflayoutarea position="center" name="generateCode">
		Good Job<br />
		Now you can select which tables to start generating data for.
		WARNING: this will generate a folder with the datasource name and overwrite any files if you choose to write the files
	</cflayoutarea>
	
</cflayout>
