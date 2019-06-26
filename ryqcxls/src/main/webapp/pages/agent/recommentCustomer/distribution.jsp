<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="../../commons/taglib.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html lang="en">
<head>
<title>车型 添加</title>
<meta charset="UTF-8" />
<meta name="viewport" content="width=device-width, initial-scale=1.0" />
<link href="${ctx }/css/common.css" type="text/css" rel="stylesheet">
<link  href="${ctx }/widgets/easyvalidator/css/validate.css" rel="stylesheet" type="text/css" />
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<style type="text/css">
	#carSeriyId{
		width: 240px;
	}
</style>
</head>
<body>
<div class="frmContent">
	<form class="form-horizontal" method="post" action="" 	name="frmId" id="frmId" target="_parent">
		<input type="hidden" value="${recommendCustomer.dbid }" id="dbid" name="dbid">
		<table border="0" align="center" cellpadding="0" cellspacing="0" style="width: 92%;">
				<tr>
					<td class="formTableTdLeft">客户姓名：</td>
					<td>
						${recommendCustomer.name }（<span style="color: red;">${recommendCustomer.sex }</span>)
					</td>
					<td class="formTableTdLeft">联系电话：</td>
					<td>
						${recommendCustomer.mobilePhone }
					</td>
				</tr>
				<tr>
					<td class="formTableTdLeft">推荐人：</td>
					<td colspan="">
						${recommendCustomer.agentName }
					</td>
					<td class="formTableTdLeft">推荐人电话：</td>
					<td>
						${recommendCustomer.agentPhone }
					</td>
				</tr>
				<tr>
					<td class="formTableTdLeft">推荐车型：</td>
					<td colspan="">
						${recommendCustomer.brand.name }
						${recommendCustomer.carSeriy.name }
						${recommendCustomer.carModel.name }
					</td>
				</tr>
				<tr>
					<td class="formTableTdLeft">购车预算</td>
					<td >${recommentCustomer.budgetMoney }</td>
				</tr>
				<tr>
					<td class="formTableTdLeft">销售顾问：</td>
					<td>
						<select name="salerId" id="salerId" class="largeX text" checkType="integer,1" tip="请选择销售顾问">
					        <option value="-1" >请选择...</option>
							<c:forEach items="${users }" var="user">
						        <option value="${user.dbid }">${user.realName }</option>
							</c:forEach>
					      </select>
					</td>
				</tr>
		</table>
	</form>
	<div class="formButton">
			<a href="javascript:void()"	onclick="$.utile.submitForm('frmId','${ctx}/recommendCustomer/saveDistribution')"	class="but butSave">保&nbsp;&nbsp;存</a> 
	    <a href="javascript:void(-1)"	onclick="art.dialog.close();" class="but butCancle">关&nbsp;&nbsp;闭</a>
	</div>
</div>
</body>
<script type="text/javascript" src="${ctx }/widgets/bootstrap3/jquery.min.js"></script>
<script type="text/javascript" src="${ctx }/widgets/utile/utile.js"></script>
<script type="text/javascript" src="${ctx }/widgets/easyvalidator/js/easy_validator.pack.js"></script>
<script type="text/javascript" src="${ctx }/widgets/artDialog/artDialog.js?skin=default"></script>
<script type="text/javascript" src="${ctx }/widgets/artDialog/plugins/iframeTools.source.js"></script>
<script type="text/javascript" src="${ctx }/widgets/utile/utile.js"></script>
<script type="text/javascript">
</script>
</html>
