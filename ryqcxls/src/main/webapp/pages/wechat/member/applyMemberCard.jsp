<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../../commons/taglib.jsp" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta name="viewport" content="width=device-width,height=device-height,inital-scale=1.0,maximum-scale=1.0,user-scalable=no;">
<meta name="format-detection" content="telephone=no">
<meta name="apple-mobile-web-app-capable" content="yes">
<meta name="apple-mobile-web-app-status-bar-style" content="black">
<link rel="stylesheet" type="text/css"  href="${ctx }/css/weixin.css"/>
<script type="text/javascript" src="${ctx }/widgets/bootstrap3/jquery.min.js"></script>
<script type="text/javascript"  src="${ctx }/widgets/utile/weixin.js"></script>
<script type="text/javascript">
function validateFrm(){
	var hasCar=$('input[name="member.hasCar"]:checked').val();
	var name=$("#name").val();
	var phone=$("#mobilePhone").val();
	if(hasCar==undefined||hasCar==''||hasCar.length<=0){
		alert("请选择您有车情况！");
		$("#member.hasCar").focus();
		return false;
	}
	if(name==''||name.length<=0){
		$("#name").focus();
		return false;
	}
	if(phone==''||phone.length<=0){
		$("#mobilePhone").focus();
		return false;
	}else{
		if(checkMobilePhone(phone)==true||checkPhone(phone)==true){
		}else{
			$("#mobilePhone").focus();
			return false;
		}
	}
	return true;	
}
function ajaxSubmit(url){
	var state=validateFrm();
	if(state){
		var params = $("#frmId").serialize();
		$.post(url,params,function callBack(data) {
			if (data[0].mark == 0) {// 返回标志为0表示添加数据成功
				// 保存数据成功时页面需跳转到列表页面
				$("#message").addClass("alert alert-success");
				$("#message").text(data[0].message);
				$("#message").css("display","");
				$("#message").show();
				$("#subButton").attr("onclick","")
				$("#subButton").find("a").css("color","#E3E0D5");
				window.location.href=data[0].url;
				///window.setTimeout("window.location.href='"+data[0].url+"'",1000);
			}
			if (data[0].mark == 1) {// /返回标志为1表示保存数据失败
				// 保存失败时页面停留在数据编辑页面
				$("#message").addClass("alert alert-error");
				$("#message").text(data[0].message);
				$("#message").css("display","");
				$("#message").show();
			}
			return;
		});
	}
}
function submitAjaxForm (url) {
	try {
		if (undefined != frmId && frmId != "") {
			var state=validateFrm();
			if (state == true) {
				var params = $("#frmId").serialize();
				var url2="";
				$.ajax({	
					url : url, 
					data : params, 
					async : false, 
					timeout : 20000, 
					dataType : "json",
					type:"post",
					success : function(data, textStatus, jqXHR){
						//alert(data.message);
						var obj;
						if(data.message!=undefined){
							obj=$.parseJSON(data.message);
						}else{
							obj=data;
						}
						if(obj[0].mark==1){
							//错误
							// 保存失败时页面停留在数据编辑页面
							$("#message").addClass("alert alert-error");
							$("#message").text(data[0].message);
							$("#message").css("display","");
							$("#message").show();
							$(".button").attr("onclick",url2);
							return ;
						}else if(obj[0].mark==0){
							$("#message").addClass("alert alert-success");
							$("#message").text(data[0].message);
							$("#message").css("display","");
							$("#message").show();
							window.location.href=data[0].url;
							// 保存数据成功时页面需跳转到列表页面
						}
					},
					complete : function(jqXHR, textStatus){
						$(".button").attr("onclick",url2);
						var jqXHR=jqXHR;
						var textStatus=textStatus;
					}, 
					beforeSend : function(jqXHR, configs){
						url2=$(".button").attr("onclick");
						$(".button").attr("onclick","");
						var jqXHR=jqXHR;
						var configs=configs;
					}, 
					error : function(jqXHR, textStatus, errorThrown){
						$("#message").addClass("alert alert-error");
						$("#message").text(data[0].message);
						$("#message").css("display","");
						$("#message").show();
						$(".button").attr("onclick",url2);
					}
				});
			} else {
				return;
			}
		} else {
			return;
		}
	} catch (e) {
		alert(e);
		return;
	}
}
</script>
<title>领取会员卡</title>
</head>
<body>
 <%--  <div class="head">
    <div  class="title">瑞一奇瑞试乘试驾在线预约</div>
    <div  class="titlePhone"><a href="tel:02887462277"><img src="${ctx }/images/weixin/phoneIcon.png"></a></div>
    <div class="clear"></div>
  </div> --%>
  <div class="formContent" style="min-height: 360px;">
  	<div id="message" class="" style="display: none;">
  	</div>
  	<form action="" id="frmId" method="post">
  		<input type="hidden" value="${param.wechat_id}" id="wechat_id" name="wechat_id">
  		<div class="memberLabel" style="margin-top: 25px;">
  			<label>会员</label>
  		</div>
  		<div class="memberInput frist">
  			<span style="color: red;">*</span>
  			<label><input type="radio"  name="member.hasCar" id="hasCar" value="1" /> 我有奇瑞车</label>
  			<label><input type="radio" name="member.hasCar" id="hasCar" value="2" /> 我没车</label>
  			<label><input type="radio" name="member.hasCar" id="hasCar" value="3" /> 我有车</label>
  		</div>
  		<div class="memberLabel">
  			<label><span style="color: red;">*</span>会员名称</label>
  		</div>
  		<div class="memberInput">
  			<input type="text"  placeholder="请填写您的真实姓名"  name="member.name" id="name" class="textfield" />
  		</div>
  		<div class="memberLabel">
  			<label><span style="color: red;">*</span>手机</label>
  		</div>
  		<div class="memberInput">
  			<input type="text"  placeholder="您的手机号将作为您的会员卡号" name="member.mobilePhone" id="mobilePhone"  class="textfield" />
  		</div>
  		<div class="dataDiv" style="margin-top: 30px;margin-bottom: 30px;">
  			<div class="button" id="subButton" onclick="submitAjaxForm('${ctx}/memberWeixin/saveApplymemberCard')"><a href="javascript:void(-1)">领取会员卡</a></div>
  		</div>
  	</form>
  </div>
</body>
<script type="text/javascript">
	
</script>
</html>
