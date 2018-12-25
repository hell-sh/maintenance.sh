var script="";
function generateScript()
{
	script="cd $HOME&&ex='!'&&echo \"#$ex/bin/bash\">maintainance.sh&&echo \"\">>maintainance.sh&&";
	document.querySelectorAll("[type='checkbox']").forEach(c=>{
		if(c.checked)
			script+="echo \"echo -ne \\\""+c.name+": preparing"+" ".repeat(19-c.name.length)+"\\\\\\\\r\\\"\">>maintainance.sh&&echo \"wget -qO- "+location.href+c.name+".sh | bash\">>maintainance.sh&&"
	});
	script+="echo \"echo \\\"Thanks for using Maintainance.Hell.sh.\\\"\">>maintainance.sh&&";
	script+="chmod +x maintainance.sh&&";
	script+="echo \"You may now run ~/maintainance.sh whenever you feel like it.\"";
	if(script.indexOf("preparing")>-1)
		document.getElementById("copy-install").classList.remove("uk-disabled");
	else document.getElementById("copy-install").classList.add("uk-disabled")
}
document.querySelectorAll("[type='checkbox']").forEach(c=>c.onchange=generateScript);
document.getElementById("copy-install").onclick=()=>navigator.clipboard.writeText(script)
