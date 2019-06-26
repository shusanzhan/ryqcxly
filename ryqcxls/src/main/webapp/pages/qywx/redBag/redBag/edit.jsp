<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="../../../commons/taglib.jsp" %>
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
<title>微信红包-红包发送设置</title>
</head>
<body class="bodycolor">
<div class="location">
     	<img src="${ctx}/images/homeIcon.png"/> &nbsp;
     	<a href="javascript:void(-1);" onclick="window.parent.location.href='${ctx}/main/index'">首页</a>-
<a href="javascript:void(-1);" onclick="window.location.href='${ctx}/factoryOrderSet/edit'">发送红包设置</a>-
</div>
<div class="line"></div>
<div class="frmContent">
	<form action="" name="frmId" id="frmId"  target="_self">
		<s:token></s:token>
		<input type="hidden" name="redBagId" id="dbid" value="${redBag.dbid }">
		<table border="0" align="center" cellpadding="0" cellspacing="0" style="width: 92%;">
			<tr height="42">
				<td class="formTableTdLeft">接受userId:&nbsp;</td>
				<td >
					<input type="text" name="userId" id="userId" 
					value="" class="largeX text" title="接受userId:"	checkType="string,1,50" tip="接受userId:不能为空"><span style="color: red;">*</span>
				</td>
			</tr>
			<tr height="42">
				<td class="formTableTdLeft">红包金额:&nbsp;</td>
				<td >
					<input type="text" name="redBagMoney" id="redBagMoney" 
					value="" class="largeX text" title="红包金额"	checkType="string,1,50" tip="红包金额"><span style="color: red;">*</span>
				</td>
			</tr>
			<tr height="42">
				<td class="formTableTdLeft">活动名称:&nbsp;</td>
				<td >
					<input type="text" name="actName" id="actName" 
					value="" class="largeX text" title="红包金额"	checkType="string,1,50" tip="活动名称"><span style="color: red;">*</span>
				</td>
			</tr>
			<tr height="42">
				<td class="formTableTdLeft">备注:&nbsp;</td>
				<td >
					<input type="text" name="remark" id="remark" 
					value="" class="largeX text" title="备注"	checkType="string,1,50" tip="备注"><span style="color: red;">*</span>
				</td>
			</tr>
			<tr height="42">
				<td class="formTableTdLeft">祝福语:&nbsp;</td>
				<td >
					<input type="text" name="wishing" id="wishing" 
					value="" class="largeX text" title="祝福语"	checkType="string,1,50" tip="祝福语"><span style="color: red;">*</span>
				</td>
			</tr>
		</table>
		<div class="formButton">
			<a href="javascript:void(-1)"	onclick="$.utile.submitForm('frmId','${ctx}/redBag/save')"	class="but butSave">保&nbsp;&nbsp;存</a> 
		</div>
	</form>
	</div>
</body>
</html>