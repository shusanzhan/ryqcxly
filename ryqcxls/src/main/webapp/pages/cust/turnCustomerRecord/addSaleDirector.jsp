<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="../../commons/taglib.jsp" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link href="${ctx }/css/common.css" type="text/css" rel="stylesheet">
<link  href="${ctx }/widgets/easyvalidator/css/validate.css" rel="stylesheet" type="text/css" />
<script type="text/javascript" src="${ctx }/widgets/bootstrap3/jquery.min.js"></script>
<script type="text/javascript" src="${ctx }/widgets/utile/utile.js"></script>
<script type="text/javascript" src="${ctx }/widgets/easyvalidator/js/jquery.bgiframe.min.js"></script>
<script type="text/javascript" src="${ctx }/widgets/easyvalidator/js/easy_validator.pack.js"></script>
<script type="text/javascript" src="${ctx }/widgets/artDialog/artDialog.js?skin=default"></script>
<script type="text/javascript" src="${ctx }/widgets/artDialog/plugins/iframeTools.source.js"></script>
<title>转单操作</title>
</head>
<body class="bodycolor" style="">
	<div class="location">
       	<img src="${ctx}/images/homeIcon.png"/> &nbsp;
       	<a href="javascript:void(-1);" onclick="window.parent.location.href='${ctx}/main/index'">首页</a>-
		<a href="javascript:void(-1);" onclick="window.location.href='${ctx}/turnCustomerRecord/queryList'">转单操作</a>
	</div>
	<div class="line"></div>
	<div class="frmContent">
	<form action="" name="frmId" id="frmId"  target="_self">
		<input type="hidden" value="3" name="type" id="type">
		<s:token></s:token>
		<table border="0" align="center" cellpadding="0" cellspacing="0" style="width: 92%;">
			<tr height="32">
				<td class="formTableTdLeft" >原销售人员:&nbsp;</td>
				<td>
					<select class="select text" id="reBussiStaff" name="reBussiStaff" tip="请选择原来销售人员！">
						<option value="">请选择...</option>
						<c:forEach var="user" items="${users }">
							<option value="${user.dbid }" >${user.realName }</option>
						</c:forEach>
					</select>
				</td>
			</tr>
			
			<tr height="42">
				<td class="formTableTdLeft" >转单客户:&nbsp;</td>
				<td>
					<input type="hidden" id="customerIds" name="customerIds">
					<textarea readonly="readonly" class="text largeXX textarea "  name="customerNames" id="customerNames"	value="" checkType="string,1" tip="请选择转单客户"></textarea>
					<a href="javascript:void(-1)" onclick="customerSelect('customerIds','customerNames',$('#reBussiStaff').val())">选择转单客户</a>
				</td>
			</tr>
			<tr height="42">
			    <td class="formTableTdLeft" >目标销售人员:&nbsp;</td>
				<td ><select class="select text" id="tarBussiStaff" name="tarBussiStaff" checkType="integer,1" tip="请选择目标销售人员！">
						<option value="">请选择...</option>
						<c:forEach var="user" items="${users }">
							<option value="${user.dbid }" >${user.realName }</option>
						</c:forEach>
					</select>
				</td>
			</tr>
			<tr>
				<td class="formTableTdLeft" >备注信息:&nbsp;</td>
				<td colspan="1">
					<textarea class="text largeXX textarea "  name="note" id="note"	value="" ></textarea>
				</td>
			</tr>
		</table>
		</form>
		<div class="formButton">
			<a href="javascript:void()"	onclick="$('#type').val(2);$.utile.submitAjaxForm('frmId','${ctx}/turnCustomerRecord/save')"	class="but butSave">保&nbsp;&nbsp;存</a> 
			<a href="javascript:void()"	onclick="$('#type').val(5);$.utile.submitAjaxForm('frmId','${ctx}/turnCustomerRecord/save')"	class="but butSave">保存并继续</a> 
		    <a href="javascript:void(-1)"	onclick="goBack()" class="but butCancle">取&nbsp;&nbsp;消</a>
		</div>
	</div>
</body>
<script type="text/javascript">
/* function ajaxCustomer(dbid){
	$.post('${ctx}/turnCustomerRecord/ajaxCustomer?dbid='+dbid,{},function (data){
		if(data=="1"){
		 var su="<tr>"	+
				  "<td>无客户信息</td>"+
				"</tr>";
			$("#select").append(su);
		}else{
			$("#select").append(data);
		}
	})
} */
function ajaxCustomer(dbid){
	window.location.href="${ctx}/turnCustomerRecord/add?dbid="+dbid;
}
</script>
</html>