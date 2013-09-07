function funNoApp(){
	document.appSettings.pathType[0].checked = true;
	document.appSettings.pathType[0].disabled = true;
	document.appSettings.pathType[1].disabled = true;
	}
	
	function funGenApp(){
	document.appSettings.pathType[1].checked = 1;
	document.appSettings.pathType[0].disabled = false;
	document.appSettings.pathType[1].disabled = false;
	}
	
	function funCF7(){
	document.appSettings.useRTE[0].checked = true;			
	document.appSettings.useRTE[0].disabled = true;
	document.appSettings.useRTE[1].disabled = true;
	}
	
	function funCF8(){
	document.appSettings.useRTE[1].checked = true;			
	document.appSettings.useRTE[0].disabled = false;
	document.appSettings.useRTE[1].disabled = false;
	}
	
	function funNoAdmin(){
	document.appSettings.adminFolder.disabled = true;
	}
	
	function funIsAdmin(){
	document.appSettings.adminFolder.disabled = false;
	}