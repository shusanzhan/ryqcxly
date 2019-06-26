<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
   <%@ include file="../commons/taglib.jsp" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title> ${systemInfo.name }登录</title>
<link href="${ctx }/css/login.css" type="text/css" rel="stylesheet"/>
</head>
<body>
  <div  id="title" class="title" style="text-align: center;font-size:24px ">
  	<c:if test="${empty(systemInfo.nameImage)}">
	  	${systemInfo.name }
  	</c:if>
  	<c:if test="${!empty(systemInfo.nameImage)}">
	  	<img src="${systemInfo.nameImage }"/>
  	</c:if>
  </div>
  <div class="mainbg">
    <div class="container">
      <div class="center">
        <div class="logo" >
	        <c:if test="${!empty(systemInfo.loginLogo) }">
	       		<img src="${systemInfo.loginLogo}" />
	        </c:if>
	        <c:if test="${empty(systemInfo.loginLogo) }">
	       		<img src="${ctx}/images/login/logo_05.png"  />
	        </c:if>
        </div>
        <div class="login">
          <form id="frm" action="${ctx }/j_spring_security_check" name="frm" method="post">
            <div class="login_un">
              <div class="icon_un"></div>
              <div style="float:right;"><input type="text" id="name" name="j_username"  class="user" value="" placeholder="用户名"/></div>
              <div class="clear"></div>
            </div>
            <div class="login_pwd">
              <div class="icon_pwd"></div>
              <div style="float:right;"><input type="password"  id="password" name="j_password" class="password" value="" placeholder="密码"/></div>
            </div>
          </form>
          <div  class="button">
            <a href="javascript:void(-1)" id="sbmId" onclick="if(checkForm()){$('#frm')[0].submit();}"><img src="${ctx}/images/login/button_05.png" /></a>
          </div> 
        </div>
      </div>
    </div> 
  </div>
</body>
<script src="${ctx }/widgets/bootstrap3/jquery.min.js"></script>
<script type="text/javascript">
if (window != top){
    top.location.href = location.href;
}
$(document).ready(function(){
	 var wHeight = (window.document.documentElement.clientHeight || window.document.body.clientHeight || window.innerHeight);
	 var marginHeight=(wHeight-345)/4;
	 $("#title").css({"margin-top":marginHeight-20,"margin-bottom":marginHeight});
	 $('#sbmId').keydown(function(e){
		 if(e.keyCode==13){
			 $('#frm')[0].submit(); //处理事件
		 }
	});
	 var error="${param.error}";
	if(error=="1"){
		alert("用户名或密码错误");
		return;
	}
})
function checkForm()
{
	var name=document.getElementById("name").value;
	var password=document.getElementById("password").value;
	if(name==null||name.length<=0){
		alert("请输入用户名！");
		document.getElementById("name").focus();
		return false;
	}
	if(password==null||password.length<=0){
		alert("请输入密码！");
		document.getElementById("password").focus();
		return false;
	}
   return true;
}
 document.onkeydown=function(event){ 
	 e = event ? event :(window.event ? window.event : null); 
	 if(e.keyCode==13){ 
		 if(e.keyCode==13){
			 $('#frm')[0].submit(); //处理事件
		 }
	 } 
}  
</script> 
</html>
