<cfif thisTag.executionMode eq "end">

	<cfhtmlhead text="#thisTag.generatedContent#" />

	<cfset thisTag.generatedContent = "" />

</cfif>