<cfsilent>

<cfset onload = "" />
<cfif not structKeyExists(request, "showautherror")>
	<cfset onload="document.loginform.username.focus();" />
</cfif>

</cfsilent>
<cf_layout title="Enter ColdFusion Administrator Password" onload="#onload#">
<style type="text/css">
body{font-size:1em;font: 85%/1.3 "Lucida Grande", "Lucida Sans", Tahoma, Verdana, sans-serif;text-align: center;background:white;padding-bottom:20px;}
form{width:400px;}
fieldset{border:0;}
legend{color:white;display:block;margin-bottom:10px;}
legend span {background-color:orange;border-bottom:1px solid gray;display:block;height:24px;line-height:24px;padding-left:10px;text-align:left;width:380px;}
form input, form textarea, form select{font-size:12px;background:#efefef;}
form input:focus, form textarea:focus, form select:focus {background-color:white;}

span.title{font-size:10px;}
</style>

<cfwindow name="loginwindow" title="Enter ColdFusion Administrator Username/Password" draggable="false" closable=false resizable="false" width="450" height="250" center="true" initShow="true">
<cfoutput>

<form action="#cgi.script_name#" method="post" name="loginform">
	<fieldset>
		<legend><span>Enter ColdFusion Administrator Password.</span></legend>
		<span class="title">If your ColdFusion Administrator does not need a username leave the field blank.</span><br />
		<label for="username">username:</label>
		<input type="text" name="username" id="username" /><br />
		<label for="password">password:</label>
		<input type="password" name="password" id="password" />
	</fieldset>
	<div class="buttons">
		<input type="submit" name="login" class="button submit" value="Login" />
	</div>
</form>
</cfoutput>
</cfwindow>

<cfif structKeyExists(request, "showautherror")>
	<cfwindow name="error" title="Authentication Failed!" modal="true" closable="true" width="250" height="160" center="true" initShow="true" >
	<p>
	Your authentication failed.<br />
	Please try again.
	</p>
	<p>
	<form><input type="button" onClick="ColdFusion.Window.hide('error')" value="Ok" /></form>
	</p>
	</cfwindow>
</cfif>
