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
<script type="text/javascript" src="${ctx }/widgets/My97DatePicker/WdatePicker.js"></script>
<script type="text/javascript" src="${ctx }/widgets/artDialog/artDialog.js?skin=default"></script>
<script type="text/javascript" src="${ctx }/widgets/artDialog/plugins/iframeTools.source.js"></script>
<title>付款</title>
</head>
<body class="bodycolor">
<c:if test="${empty(supp) }">
<div class="location">
	<img src="${ctx}/images/homeIcon.png"/> &nbsp;
	<a href="javascript:void(-1);" onclick="window.parent.location.href='${ctx}/main/index'">首页</a>-
	<a href="javascript:void(-1);" onclick="window.parent.location.href='${ctx}/payment/queryList'">付款记录</a>
	<a href="javascript:void(-1);" onclick="">添加付款记录</a>
</div>
 <!--location end-->
<div class="line"></div>
</c:if>
<div class="frmContent">
<c:if test="${empty(supp) }">
	<form action="" name="frmId" id="frmId"  target="_self">
</c:if>
<c:if test="${!empty(supp) }">
	<form action="" name="frmId" id="frmId"  target="_parent">
</c:if>
		<s:token></s:token>
		<input type="hidden" name="payment.dbid" id="dbid" value="${payment.dbid }">
		<c:if test="${empty(supp) }">
			<input type="hidden" name="type" id="type" value="1">
		</c:if>
		<c:if test="${!empty(supp) }">
			<input type="hidden" name="type" id="type" value="2">
		</c:if>
		<input type="hidden" name="payment.createDate" id="createDate" value="${payment.createDate }">
		<table border="0" align="center" cellpadding="0" cellspacing="0" style="width: 92%;">
			<tr height="42">
				<td class="formTableTdLeft">供货商名称:&nbsp;</td>
				<td>
					<select id="supplierId" name="supplierId" class="media text" checkType="integer,1" tip="请选择供货商" style="width: 180px;">
						<option value="0">请选择...</option>
						<c:forEach var="supplier" items="${suppliers }">
							<option value="${supplier.dbid }" ${supp.dbid==supplier.dbid?'selected="selected"':'' } >${supplier.name }</option>
						</c:forEach>
					</select>
				<span style="color: red;">*</span></td>
			</tr>
			<tr height="42">
				<td class="formTableTdLeft">业务日期:&nbsp;</td>
				<td >
					<c:if test="${empty(payment) }">
						<fmt:formatDate value="${now }" var="nw"/>
						<input type="text" onfocus="new WdatePicker();" name="payment.busiDate" id="busiDate" value="${nw }" class="media text" title="业务日期"	><span style="color: red;">*</span>
					</c:if>
					<c:if test="${!empty(payment) }">
						<input type="text" onfocus="new WdatePicker();" name="payment.busiDate" id="busiDate" value="${payment.busiDate }" class="media text" title="业务日期"	><span style="color: red;">*</span>
					</c:if>
				</td>
				
			</tr>
			<tr>
				<td class="formTableTdLeft">付款金额:&nbsp;</td>
				<td >
						<input type="text" name="payment.payMoney" id="payMoney" value="${payment.payMoney }" placeholder="0.0" class="media text" checkType="float,1" tip="付款金额不能为空"><span style="color: red;">*</span>
				</td>
			</tr>
			<tr height="32">
				<td class="formTableTdLeft">备注:&nbsp;</td>
				<td colspan="3">
					<c:if test="${empty(payment) }">
						<textarea name="payment.note" id="note" title="内容简介"  class="mediaX text" style="height: 40px;width: 240px;">付定金/欠款</textarea>
					</c:if>
					<c:if test="${!empty(payment) }">
						<textarea name="payment.note" id="note" title="内容简介"  class="mediaX text" style="height: 40px;width: 240px;">${payment.note }</textarea>
					</c:if>
				</td>
			</tr>
		</table>
	</form>
	<div class="formButton">
		<a href="javascript:void(-1)"	onclick="$.utile.submitForm('frmId','${ctx}/payment/savePayment')"	class="but butSave">保&nbsp;&nbsp;存</a>
		<c:if test="${!empty(supp) }">
		    <a href="javascript:void(-1)"	onclick="art.dialog.close(-1)" class="but butCancle">取&nbsp;&nbsp;消</a>
		</c:if> 
		<c:if test="${empty(supp) }">
		    <a href="javascript:void(-1)"	onclick="window.history.go(-1)" class="but butCancle">返回</a>
		</c:if> 
	</div>
	</div>
</body>
<script type="text/javascript">
</script>
</html>