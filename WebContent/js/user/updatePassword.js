var xmlHttp;
function showPwContent() {
	$("#passwordLoadingDiv").hide();
	$("#passwordContent").show();

}
//过滤一些敏感字符函数
function filterSqlStr(value){
	
	var sqlStr=sql_str().split(',');
	var flag=false;
	for(var i=0;i<sqlStr.length;i++){
		
		if(value.toLowerCase().indexOf(sqlStr[i])!=-1){
			flag=true;
			break;			
		}
	}
	return flag;
}
function sql_str(){
	var str="and,delete,or,exec,insert,select,union,update,count,*,',join,>,<";
	return str;

}
function updatePw() {
	$("#passwordContent").hide();
	$("#passwordLoadingDiv").show();
	var newPassword = $("#newPassword").val();
	var newPasswordAgain = $("#newPasswordAgain").val();
	re= /select|update|delete|exec|count|'|"|=|;|>|<|%/i;
	var str="and,delete,or,exec,insert,select,union,update,count,*,',join,>,<";
	if(newPassword != newPasswordAgain){
		toastr.warning("两次密码不一致!");
		$("#passwordLoadingDiv").hide();
		$("#passwordContent").show();
	}else if ( filterSqlStr(newPassword)){
		toastr.error("用户名或密码字符中包含了敏感字符"+sql_str()+",请重新输入！");
		$("#passwordLoadingDiv").hide();
		$("#passwordContent").show();
		return false;	
	}else {
		getXmlHttp();
		var oldPassword = $("#oldPassword").val();
		xmlHttp.open("POST","/rlzyos/user/user_updatePassword",true);
		var formData = new FormData();
		formData.append("oldPassword",oldPassword);
		formData.append("newPassword",newPassword);
		xmlHttp.send(formData);
		xmlHttp.onreadystatechange = function(){
			if(isBack()){
				var result = xmlHttp.responseText;
				if(result == "oldPasswordError") {
					toastr.error("原密码错误！");
					$("#passwordLoadingDiv").hide();
					$("#passwordContent").show();
				} else if(result == "updateFail") {
					toastr.error("修改失败请重新登录！");
					$("#passwordLoadingDiv").hide();
					$("#passwordContent").show();
				} else if(result == "updateSuccess") {
					toastr.success("修改成功！");
					$("#oldPassword").val("");
					$("#newPassword").val("");
					$("#newPasswordAgain").val("");
					$("#passwordLoadingDiv").hide();
					$("#passwordContent").show();
				}
			}
			
		}
		
	}	
}

function getXmlHttp() {
	if(window.XMLHttpRequest) {
		// IE7+, Firefox, Chrome, Opera, Safari 浏览器执行代码
		xmlHttp = new XMLHttpRequest();
	}else{
		// IE7+, Firefox, Chrome, Opera, Safari 浏览器执行代码
		xmlHttp = new ActiveXObject("Microsoft.XMLHTTP");
	}
	
}

function isBack(){
	if(xmlHttp.readyState == 4 && xmlHttp.status == 200) {
		return true;
	} else {
		return false;
	}
	
}
