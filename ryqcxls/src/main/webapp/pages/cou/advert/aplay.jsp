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
<style type="text/css">
.content {
    background: none repeat scroll 0 0 rgba(255, 255, 255, 0.5);
    margin: 5px;
    overflow: hidden;
    padding: 5px 5px 5px;
    width: auto;
    min-height: 390px;
}


.cbox{
	margin:0 auto;
	margin: 12px;
	text-align: center;
	overflow: hidden;
}
.cbox .textbox{
    font-size: 16px;
    margin: auto 0;
    width: 100%;
    margin: 10px 0;
}
.cbox .textbox {
    background: none repeat scroll 0 0 rgba(247, 247, 247, 0.87);
    border: 1px solid #cecece;
    border-radius: 4px;
    box-shadow: 1px 1px 2px #e2d8d7 inset;
    padding: 12px 8px;
}
select{
	background: none repeat scroll 0 0 rgba(247, 247, 247, 0.87);
    border: 1px solid #cecece;
    border-radius: 4px;
    box-shadow: 1px 1px 2px #e2d8d7 inset;
    width: 100%;
    -webkit-appearance: none;
	-webkit-box-sizing: border-box;
	display: block;
}
.button {
    background: none repeat scroll 0 0 #F97206;
    border: medium none;
    border-radius: 5px;
    color: #fff;
    display: inline-block;
    font-size: 20px;
    padding: 10px 12px;
    width: 92%;
    font-family: '微软雅黑';
    margin: auto 0;
    margin-top: 24px;
    padding: 5px 5px 5px;
}
</style>
<script type="text/javascript" src="${ctx }/widgets/bootstrap3/jquery.min.js"></script>
<script type="text/javascript">
function validateFrmFiwa(){
	var carSeriry=$("#carSeriry").val();	
	var name=$("#name").val();
	var phone=$("#phone").val();
	if(name==''||name.length<=0){
		alert("请填写您的姓名！");
		$("#name").focus();
		return false;
	}
	if(phone==''||phone.length<=0){
		alert("请填写您的电话号码！");
		$("#mobile").focus();
		return false;
	}else{
		if(checkMobilePhone(phone)==true||checkPhone(phone)==true){
		}else{
			alert("请填写您的正确电话号码！");
			$("#mobile").focus();
			return false;
		}
	}
	if(carSeriry=='0'){
		alert("请选车型！");
		$("#carSeriry").focus();
		return false;
	}
	return true;	
}
/**
 * 功能：判断手机号码
 */
function checkMobilePhone(value) {
	var valid = false;
	valid = /(^0{0,1}1[3|4|5|6|7|8|9][0-9]{9}$)/.test(value);
	return valid;
}
/**
 * 功能：判断电话号码是否合法，电话号码的格式为：电话号码；或者 区号-电话号码
 */
function checkPhone(value) {
	var valid = false;
	valid = /^(([0\+]\d{2,3}-)?(0\d{2,3})-)?(\d{7,8})(-(\d{3,}))?$/.test(value);
	return valid;
}
function ajaxSubmitFiwa12(url){
	var state=validateFrmFiwa();
	var ms='<a class="shareButton" style="padding: 12px 0;cursor: pointer;color:blue;" onclick="window.location.href=\'http://mp.weixin.qq.com/s?__biz=MzA4OTM1MTQxOA==&mid=200182638&idx=1&sn=fac12073d80f1f3d5cafd03246bf063a#rd\'">关注瑞一奇瑞微信</a>';
	if(state){
		var params = $("#frmId").serialize();
		$.post(url,params,function callBack(data) {
			if (data[0].mark == 0) {// 返回标志为0表示添加数据成功
				// 保存数据成功时页面需跳转到列表页面
				$("#message").addClass("alert alert-success");
				$("#message").text(data[0].message).append(ms);
				$("#message").css("display","");
				//$("#message2").css("display","");
				$("#message").show();
				$("#subButton").attr("onclick","")
				$("#subButton").find("a").css("color","#E3E0D5");
				//setTimeout("delayURL()", 1000);
			}
			if (data[0].mark == 1) {// /返回标志为1表示保存数据失败
				// 保存失败时页面停留在数据编辑页面
				$("#message").addClass("alert alert-error");
				$("#message").text(data[0].message).append(ms);
				$("#message").css("display","");
				$("#message").show();
			}
			return;
		});
	}
}
function delayURL() {
	var delay=document.getElementById("time").innerHTML; 
	//最后的innerHTML不能丢，否则delay为一个对象
	if(delay>0){
	delay--;
	document.getElementById("time").innerHTML=delay;
	}else{
		window.location.href="${ctx }/shareWeixin/share";
	}
	//此处1000毫秒即每一秒跳转一次
	setTimeout("delayURL()", 1000);
} 
</script>
</script>
<title>瑞一奇瑞购车预报名</title>
</head>
<body style="background-image: url('${ctx}/images/20141001001047.jpg');">

<div class="content">
	<div id="message" style="display: none;">
		<span id="time" style="display: none;">3</span>&nbsp;秒钟之后自动跳转
	</div>
	<div id="message2" style="display: none;">
		<span id="time">3</span>&nbsp;秒钟之后自动跳转
	</div>
           <div class="inner-header">
               <div class="fl-left" style="width: 100%;text-align: center;color: #F97206;">
                   <h1 style="font-weight: normal;font-size: 22px;letter-spacing: 2px;">参与申请</h1>
               </div>
           </div>
           <div class="cbox">
               <form id="frmId" method="post" action="">
                   <div>
                       <input type="hidden" class="textbox" placeholder="请输入姓名" name="shareId"  value="${param.shareId }" id="bi_name">
                       <input type="text" class="textbox" placeholder="请输入姓名" name="name" id="name">
                       <br>
                       <input type="text" class="textbox" placeholder="请输入电话" name="phone" id="phone">
                       <br>
                       <select id="carSeriry" name="carSeriry" style="padding:12px 8px; ">
                       	<option value="0">请选择车系...</option>
                       	<c:forEach var="carSeriy" items="${carSeriys }">
                       		<option value="${carSeriy.dbid }">${carSeriy.name }</option>
                       	</c:forEach>
                        </select>
                   </div>
                   <div class="clear"></div>
                    <a class="button" onclick="ajaxSubmitFiwa12('${ctx}/shareWeixin/saveAplay')">立即参与</a>
               </form>
           </div>
</div>
</body>
</html>
