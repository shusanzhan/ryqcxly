<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="../../commons/taglib.jsp" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link href="${ctx }/css/common.css" type="text/css" rel="stylesheet"/>
<link  href="${ctx }/widgets/easyvalidator/css/validate.css" rel="stylesheet" type="text/css" />
<script type="text/javascript" src="${ctx }/widgets/bootstrap3/jquery.min.js"></script>
<script type="text/javascript" src="${ctx }/widgets/utile/utile.js"></script>
<script type="text/javascript" src="${ctx }/widgets/easyvalidator/js/jquery.bgiframe.min.js"></script>
<script type="text/javascript" src="${ctx }/widgets/easyvalidator/js/easy_validator.pack.js"></script>
<script type="text/javascript" src="${ctx }/widgets/artDialog/artDialog.js?skin=default"></script>
<script type="text/javascript" src="${ctx }/widgets/artDialog/plugins/iframeTools.source.js"></script>
<script type="text/javascript">
function submitAjaxForm (frmId, url, state) {
	var target = $("#" + frmId).attr("target") || "_self";
	try {
		if (undefined != frmId && frmId != "") {
			var validata = validateForm(frmId);
			if (validata == true) {
				var params = getParam(frmId, state);
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
							$.utile.tips(obj[0].message);
							$(".butSave").attr("onclick",url2);
							return ;
						}else if(obj[0].mark==0){
							$.utile.tips(data[0].message);
							if (target == "_self") {
								setTimeout(
										function() {
											window.location.href = obj[0].url
										}, 1000);
							}
							if (target == "_parent") {
								// 同时关闭弹出窗口
								var parent = window.parent;
								window.parent.frames["contentUrl"].location=obj[0].url;
							}
							// 保存数据成功时页面需跳转到列表页面
						}
					},
					complete : function(jqXHR, textStatus){
						$(".butSave").attr("onclick",url2);
						var jqXHR=jqXHR;
						var textStatus=textStatus;
					}, 
					beforeSend : function(jqXHR, configs){
						url2=$(".butSave").attr("onclick");
						$(".butSave").attr("onclick","");
						var jqXHR=jqXHR;
						var configs=configs;
					}, 
					error : function(jqXHR, textStatus, errorThrown){
							$.utile.tips("系统请求超时");
							$(".butSave").attr("onclick",url2);
					}
				});
			} else {
				return;
			}
		} else {
			return;
		}
	} catch (e) {
		$.utile.tips(e);
		return;
	}
}
</script>
<title>发送短信</title>
</head>
<body class="bodycolor">
<div class="location">
     	<img src="${ctx}/images/homeIcon.png"/> &nbsp;
     	<a href="javascript:void(-1);" onclick="window.parent.location.href='${ctx}/main/index'">首页</a>-
<a href="javascript:void(-1);">
	发送短信</a>
</div>
<div class="line"></div>
<div class="frmContent" style="margin-bottom: 60px;">
	 <div class="alert alert-error" >
				<strong>提示!请【选择接收客户】并【选择短信模板】</strong> ,点击我的短信可以查看短信是否发送成功，请勿重复发送短信！
		</div>
	<form action="" name="frmId" id="frmId"  target="_self">
		<s:token></s:token>
		<table border="0" align="center" cellpadding="0" cellspacing="0" style="width: 92%;">
			<tr height="42" style="height: 130px;">
				<td class="formTableTdLeft">接收客户:&nbsp;</td>
				<td colspan="2">
				<textarea readonly="readonly"  class="largeXX textarea" name="customerNames" id="customerNames" cols="60" rows="120" placeholder="可多次点击【选择接收客户】进行叠加" style="height: 120px;width: 620px;" tip="请输入短信内容" checkType="string,1">${phones}</textarea>
				<span style="color: red;">* </span></td>
			</tr>
			<tr height="42" style="height: 130px;">
				<td class="formTableTdLeft">接收电话:&nbsp;</td>
				<td colspan="2" >
					<div style="float: left;height: 125px;">
						<textarea readonly="readonly"  class="largeXX textarea" name="phones" id="phones" cols="60" rows="120" style="height: 120px;width: 620px;" tip="请输入短信内容" checkType="string,6" >${phones}</textarea>
						<span style="color: red;">* </span>
					</div>
					<div style="float: left;height: 125px;margin-top: px;">
						<a href="javascript:void(-1)" class="but" style="margin-top: 40px;position: relative;background-color: #1476F1" onclick="commonSelect('选择客户','${ctx}/custCustomer/customerSelect','customerNames','phones','smsTemplates',900,500,true)">选择接收客户</a>
						<a href="Javascript:void(-1)" class="but butCancle" style="" onclick="$('#customerNames').val('');$('#phones').val('')">清除</a>
					</div>
					<div  style="clear: both;"></div>
				</td>
			</tr>
			
			<tr height="42" style="height: 130px;">
				<td class="formTableTdLeft">短信内容:&nbsp;</td>
				<td colspan="2">
					<div style="float: left;height: 125px;">
						<textarea  readonly="readonly" class="largeXX textarea" name="smsTemplateContent" id="smsTemplateContent" cols="60" rows="120" style="height: 120px;width: 620px;" tip="请输入短信内容" checkType="string,6"></textarea>
						<input type="hidden" class="largeX text" name="smsTemplateId" id="smsTemplateId" readonly="readonly"  />
						<span style="color: red;">* </span>
					</div>
					<div style="float: left;height: 125px;margin-top:">
						<a href="javascript:void(-1)"  class="but" style="margin-top: 40px;position: relative;background-color: #1476F1" onclick="smsTemplateSelect('smsTemplateId','smsTemplateContent')">选择短信模板</a>
					</div>
					<div  style="clear: both;"></div>
				</td>
			</tr>
		</table>
	</form>
	<br>
	<div class="formButton">
		<a href="javascript:void(-1)"	onclick="submitAjaxForm('frmId','${ctx}/sms/save')"	class="but butSave">发送短信</a> 
		<a href="javascript:void(-1)"	onclick="window.location.href='${ctx}/sms/queryList'"	class="but butSave">我的短信</a> 
	    <a href="javascript:void(-1)"	onclick="window.history.go(-1)" class="but butCancle">取&nbsp;&nbsp;消</a>
	</div>
</div>
</body>
</html>