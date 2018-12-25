document.addEventListener("DOMContentLoaded",function()
{
	$("[type='checkbox']").change(function()
	{
		generateScript();
	});
});

function generateScript()
{
	var script = "#!/bin/bash\n", useful = false;
	script += "\n";
	script += "cd $HOME\n";
	script += "echo \"#!/bin/bash\" > maintainance.sh\n";
	script += "echo \"\" >> maintainance.sh\n";
	$("[type='checkbox']").each(function()
	{
		if(this.checked)
		{
			script += "echo \"echo -ne \\\"" + this.name + ": preparing" + " ".repeat(19 - this.name.length) + "\\\\r\\\"\" >> maintainance.sh\n";
			script += "echo \"wget -qO- " + location.href + this.name + ".sh | bash\" >> maintainance.sh\n";
			useful = true;
		}
	});
	script += "echo \"echo \\\"Thanks for using Maintainance.Hell.sh.\\\"\" >> maintainance.sh\n";
	script += "chmod +x maintainance.sh\n";
	script += "echo \"You may now run ~/maintainance.sh whenever you feel like it.\"\n";
	if(useful)
	{
		$("#download").removeClass("uk-disabled").attr("href", "data:text/x-sh;base64," + btoa(script));
	}
	else
	{
		$("#download").addClass("uk-disabled");
	}
}
