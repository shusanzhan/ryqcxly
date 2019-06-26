
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../../commons/taglib.jsp" %>
<!doctype html>
<html  lang="en">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
 <meta charset="UTF-8">
    <meta content="width=device-width, initial-scale=1.0, minimum-scale=1.0, maximum-scale=1.0, user-scalable=no" name="viewport">
    <!-- Mobile Devices Support @begin -->
    <meta content="application/xhtml+xml;charset=UTF-8" http-equiv="Content-Type">
    <meta content="no-cache,must-revalidate" http-equiv="Cache-Control">
    <meta content="no-cache" http-equiv="pragma">
    <meta content="0" http-equiv="expires">
    <meta content="telephone=no, address=no" name="format-detection">
    <meta name="apple-mobile-web-app-capable" content="yes" />
    <meta name="apple-mobile-web-app-status-bar-style" content="black-translucent" />
   	<link rel="stylesheet" href="${ctx }/weui-master/css/weui.css"/>
    <link rel="stylesheet" href="${ctx }/weui-master/css/weuix.css"/>
<title>给${bussiCard.name }留言</title>
<style type="text/css">
	.header{
		background: #fb6969;height: 36px;line-height: 36px;font-size: 14px;color: #FFF
	}
	.b-pink {
    color: #fb6969;
    border: 1px solid #fb6969!important;
}
.b-pink:ACTIVE{
	color: #fb6969;
}
</style>
</head>
<body>
<div class="weui-cell weui-cell_switch header" onclick="window.history.go(-1)">
	<i class="icon icon-109">返回</i>
</div>
<form action="" id="frmId" name="frmId">
<input type="hidden" value="${bussiCard.code }" name="cardCode" id="cardCode">
<input type="hidden" value="${param.code }" name="code" id="code">
<div class="weui-cell weui-cell_switch">
        <div class="weui-cell__bd">匿名留言</div>
        <div class="weui-cell__ft">
            <label for="switchCP" class="weui-switch-cp">
                <input id="switchCP" class="weui-switch-cp__input" name="anonymousStatus"  type="checkbox" value="1" onclick="onsh()">
                <div class="weui-switch-cp__box"></div>
            </label>
        </div>
</div>
<div id="ann">
<div class="weui-cells__title weui-start"> 姓名</div>
<div class="weui-form weui-cell_warn">
    <div class="weui-form-li">
        <input type="text" name="name" id="name" placeholder="请输姓名"  class="weui-form-input">
    </div>
</div>
<div class="weui-cells__title weui-start">联系电话</div>
<div class="weui-form">
    <div class="weui-form-li">
        <input type="text" class="weui-form-input" name="mobilePhone" id="mobilePhone" type="number" pattern="[0-9]*" placeholder="请输入号码" checkType="mobilePhone">
    </div>
</div>
</div>
<div class="weui-cells__title weui-start">留言</div>
<div class="weui-form">
    <div class="weui-form-li">
        <textarea class="weui-form-area" id="content" name="content" rows="5" cols="60"></textarea>
    </div>
</div>
<div class="weui-form" style="padding: 0 16px;">
	<a href="javascript:;" class="weui-btn  b-pink" id="showTooltips" onclick="ajaxSubmit('${ctx}/bussiCardWechat/save','frmId')">提交</a>
</div>
</form>
</body>
 <script src="${ctx }/weui-master/js/zepto.min.js"></script>
 <script src="${ctx }/weui-master/js/swipe.js"></script>
 <script src="${ctx }/weui-master/js/zepto.weui.min.js"></script>
 <script type="text/javascript">
	function onsh(){
		if($("#switchCP")[0].checked){
			$("#ann").hide();
		}else{
			$("#ann").show();
		}
	}
	function checkMobilePhone(value) {
		var valid = false;
		valid = /(^0{0,1}1[3|4|5|6|7|8|9][0-9]{9}$)/.test(value);
		return valid;
	}
	function validateForm(){
		if(!$("#switchCP")[0].checked){
			var name=$("#name").val();
			if(name==null||name==''){
				$.toptip("姓名不能为空",2000);
				$("#name").focus();
				return false;
			}else{
				if(name.length>20){
					$.toptip("姓名不能大于20个字符",2000);	
					$("#mobilePhone").focus();
					return false;
				}
			}
			var mobilePhone=$("#mobilePhone").val();
			if(mobilePhone==null||mobilePhone==''){
				$.toptip("联系电话不能为空",2000);
				$("#mobilePhone").focus();
				return false;
			}else{
				var status=checkMobilePhone(mobilePhone);
				if(!status){
					$.toptip("联系电话格式错误",2000);	
					$("#mobilePhone").focus();
					return false;
				}
			}
		}
		var content=$("#content").val();
		if(content==null||content==''){
			$.toptip("留言内容不能为空",2000);
			$("#content").focus();
			return false;
		}else{
			if(content.length<5){
				$.toptip("留言内容不能小于5个字符",2000);	
				$("#content").focus();
				return false;
			}
			if(content.length>2000){
				$.toptip("留言内容不能大于2000个字符",2000);	
				$("#content").focus();
				return false;
			}
		}
		return true;
	}
	function ajaxSubmit(url,frmId){
		var validata = validateForm(frmId);
		if(validata){
			var params = $("#"+frmId).serialize();
			var url2="";
			$.ajax({	
				url : url, 
				data : params, 
				async : false, 
				timeout : 20000, 
				dataType : "json",
				type:"post",
				success : function(data, textStatus, jqXHR){
					var obj;
					if(data.message!=undefined){
						obj=$.parseJSON(data.message);
					}else{
						obj=data;
					}
					if(obj[0].mark==1){
						$.toptip(obj[0].message,'error');
						//错误
						$("#showTooltips").attr("onclick",url2);
						$("#showTooltips").removeClass("weui-btn_plain-disabled");
						return ;
					}else if(obj[0].mark==0){
						$.toptip('留言成功','success')
		                setTimeout(function () {
		                	window.location.href = data[0].url;
		                }, 2000);
					}
				},
				complete : function(jqXHR, textStatus){
					$("#showTooltips").attr("onclick",url2);
					var jqXHR=jqXHR;
					var textStatus=textStatus;
				}, 
				beforeSend : function(jqXHR, configs){
					url2=$("#showTooltips").attr("onclick");
					$("#showTooltips").attr("onclick","");
					$("#showTooltips").addClass("weui-btn_plain-disabled");
					var jqXHR=jqXHR;
					var configs=configs;
				}, 
				error : function(jqXHR, textStatus, errorThrown){
						alert("系统请求超时");
						$("#showTooltips").attr("onclick",url2);
						$("#showTooltips").removeClass("weui-btn_plain-disabled");
				}
			});
		}
	}
	</script>
</html>