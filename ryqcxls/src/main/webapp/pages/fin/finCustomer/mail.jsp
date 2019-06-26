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
<title>添加追踪记录</title>
</head>
<body class="bodycolor">
	<div class="frmContent">
	<form action="" name="frmId" id="frmId" style="margin-bottom: 40px;" target="_parent">
		<input type="hidden" name="finCustomerId" id="finCustomerId" value="${finCustomer.dbid}">
		<s:token></s:token>
		<table border="0" align="center" cellpadding="0" cellspacing="0" style="width: 92%;">
			<tr height="42">
				<td class="formTableTdLeft">客户名称:&nbsp;</td>
				<td >
						<input  type="text" name="customerName" id="customerName" readonly="readonly"	value='${finCustomer.name }' class="large text" >
				</td>
			</tr>
			<tr>
				<td class="formTableTdLeft">联系电话:&nbsp;</td>
				<td >
					<input  type="text" name="mobilePhone" id="mobilePhone" readonly="readonly"	value='${finCustomer.mobilePhone }' class="large text" >
				</td>
			</tr>
			<tr height="42">
				<td class="formTableTdLeft">邮寄时间:&nbsp;</td>
				<td >
					<input  type="text" name="mailDate" id="mailDate"	value='${finCustomer.mailDate }' class="large text" onfocus="WdatePicker()" checkType="string,1" tip="请选择邮寄时间,不能为空">
					<span style="color: red;">*</span>
				</td>
			</tr>
			<tr height="42">
				<td class="formTableTdLeft">邮寄单号:&nbsp;</td>
				<td >
					<input  type="text" name="mailNo" id="mailNo"	value='${finCustomer.mailNo }' class="large text" checkType="string,4" tip="邮寄单位不能为空！">
					<span style="color: red;">*</span>
				</td>
			</tr>
			<tr height="42">
				<td class="formTableTdLeft">备注:&nbsp;</td>
				<td >
					<textarea  name="mailNote" id="mailNote"	 class="largeXX text" style="height: 80px;width: 320px" checkType="string,1,2000"	tip="请输入备注,必须小于2000个字符">${finCustomer.mailNote}</textarea>
				</td>
			</tr>
		</table>
	</form>
	<div class="formButton">
		<a href="javascript:void(-1)"	onclick="$.utile.submitAjaxForm('frmId','${ctx}/finCustomer/saveMail')"	class="but butSave">保&nbsp;&nbsp;存</a> 
		<a href="javascript:void(-1)"	onclick="art.dialog.close()"	class="but butCancle">关闭</a> 
	</div>
</div>
</body>
<script type="text/javascript" src="${ctx }/widgets/My97DatePicker/WdatePicker.js"></script>
<script type="text/javascript">
function addDate(value){
    var d=new Date(); 
    var mm="";
    var dd="";
	if(value=="2"){
	    d.setDate(d.getDate()+7); 
	}
	if(value=="3"){
	    d.setDate(d.getDate()+10); 
	}
	if(value=="4"){
	    d.setDate(d.getDate()+15); 
	}
    var m=d.getMonth()+1; 
    if(m<10){
    	mm="0"+m;
    }else{
    	mm=m;
    }
    if(d.getDate()<10){
    	dd="0"+d.getDate();
    }else{
    	dd=d.getDate();
    }
    $("#maxDay").val(d.getFullYear()+'-'+mm+'-'+dd+' '+d.getHours()+':'+d.getMinutes());
  } 
</script>
</html>