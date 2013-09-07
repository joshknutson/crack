<cfparam name="attributes.title" default="CRACK">
<cfparam name="attributes.onload" default="">

<cfif thisTag.executionMode is "start">
<!DOCTYPE html>
<html lang="en">
	<meta charset="utf-8">

<meta name="viewport" content="width=device-width, initial-scale=1.0">
<head>
<cfoutput><title>#attributes.title#</title>

<link href="assets/css/style.css" rel="stylesheet" type="text/css" />
</head>

<body onload="#attributes.onload#">
</cfoutput>

<cfelse>

</body>
</html>

</cfif>