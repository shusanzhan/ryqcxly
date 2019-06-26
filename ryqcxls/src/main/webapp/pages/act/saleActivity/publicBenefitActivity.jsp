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
<title>奇瑞汽车免费午餐公益活动</title>
</head>
<body class="bodycolor">
<div class="location">
     	<img src="${ctx}/images/homeIcon.png"/> &nbsp;
     	<a href="javascript:void(-1);" onclick="window.parent.location.href='${ctx}/main/index'">首页</a>-
<a href="javascript:void(-1);" onclick="window.location.href='${ctx}/publicBenefitActivity/queryList'">奇瑞汽车免费午餐公益活动</a>-
</div>
<div class="line"></div>
<div class="frmContent">
	<div style="width: 520px;height: 60px;text-align: center;margin: 0 auto;margin-top: 12px;">
		<div class="programActive">
			1、基础设置
		</div>
		<div  class="programActive">
			2、活动简介
		</div>
		<div class="program">
			3、学校介绍
		</div>
		<div class="clear"></div>
	</div>
	<form action="" name="frmId" id="frmId"  target="_self">
		<s:token></s:token>
		<input type="hidden" name="saleActivityId" id="saleActivityId" value="${saleActivity.dbid }">
		<input type="hidden" name="publicBenefitActivity.dbid" id="dbid" value="${publicBenefitActivity.dbid }">
		<table border="0" align="center" cellpadding="0" cellspacing="0" style="width: 92%;">
			<tr height="42">
				<td class="formTableTdLeft">标题:&nbsp;</td>
				<td ><input type="text" name="publicBenefitActivity.title" id="title"	value="${publicBenefitActivity.title }" class="largeX text" title="名称" placeholder="请输入标题"	checkType="string,1,30" tip="标题不能为空"><span style="color: red;">*</span>不能超过30个字</td>
			</tr>
				<tr height="42">
				<td class="formTableTdLeft">活动简绍：&nbsp;</td>
				<td >
					<textarea  name="publicBenefitActivity.intro" id="intro" style="margin: 5px;height: 80px;width: 270px;"	 class="largeX text" title="赠送积分量" placeholder="请输赠送积分量"	checkType="integer,1,50000" tip="赠送积分量不能为空">${publicBenefitActivity.intro }
					</textarea>
				
				<span style="color: red;">*</span></td>
			</tr>
				<tr height="42">
				<td class="formTableTdLeft">活动内容：&nbsp;</td>
				<td >
					<textarea  name="publicBenefitActivity.content" id="content" style="margin: 5px;height: 80px;width: 270px;"	 class="largeX text" title="赠送积分量" placeholder="请输赠送积分量"	checkType="integer,1,50000" tip="赠送积分量不能为空">
						${publicBenefitActivity.content }
					</textarea>
				<span style="color: red;">*</span></td>
			</tr>
		</table>
	</form>
	<div class="formButton">
	    <a href="javascript:void(-1)"	onclick="window.history.go(-1)" class="but butCancle">退后</a>
		<a href="javascript:void(-1)"  onclick="submitAjaxForm('frmId','${ctx}/saleActivity/savePublicBenefitActivity')" class="but butSave">下一步</a> 
	</div>
	</div>
</body>
<script type="text/javascript" src="${ctx }/widgets/My97DatePicker/WdatePicker.js"></script>
<script type="text/javascript" src="${ctx }/widgets/ckeditor/ckeditor.js"></script>
<script type="text/javascript" src="${ctx }/widgets/My97DatePicker/WdatePicker.js"></script>
<script type="text/javascript">
var editor=CKEDITOR.replace("content",{content : 'MyToolbar'});
var editor=CKEDITOR.replace("intro",{toolbar : 'MyToolbar'});
function getParam2(frmId) {
	// 富文本编辑器取数据
		$('#content').val(CKEDITOR.instances.content.getData());
		$('#intro').val(CKEDITOR.instances.intro.getData());
	var params = $("#" + frmId).serialize();
	return params;
}
 function submitAjaxForm(frmId, url) {
	var target = $("#" + frmId).attr("target") || "_self";
	try {
		if (undefined != frmId && frmId != "") {
			var validata = validateForm(frmId);
			if (validata == true) {
				var params = getParam2(frmId);
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
</html>