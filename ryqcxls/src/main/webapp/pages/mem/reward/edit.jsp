<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="../commons/taglib.jsp" %>
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
<title>会员积分调整</title>
</head>
<body class="bodycolor">
<div class="frmContent">
	<form action="" name="frmId" id="frmId"  target="_parent">
		<s:token></s:token>
		<input type="hidden" name="reward.dbid" id="dbid" value="${reward.dbid }">
		<input type="hidden" name="memberId" id="memberId" value="${member.dbid}">
		<input type="hidden" name="directType" id="directType" value="${param.directType }">
		<table border="0" align="center" cellpadding="0" cellspacing="0" style="width: 92%;">
			<tr height="42">
				<td class="formTableTdLeft">会员名称:&nbsp;</td>
				<td ><input type="text" name="" id=""
					value="${member.name }" disabled="disabled" class="largex text" title="会员名称"></td>
				<td class="formTableTdLeft">总返利:&nbsp;</td>
				<td ><input type="text" name="" id=""
					value="${member.reward }" disabled="disabled" class="largex text" ></td>
			</tr>
			<tr height="42">
				<td class="formTableTdLeft">返利金额:&nbsp;</td>
				<td ><input type="text" name="reward.rewardMoney" id="rewardMoney"
					value="${reward.rewardMoney }" class="largex text" title="返利金额"	checkType="float" tip="请输入返利金额"><span style="color: red;">*</span></td>
				<td class="formTableTdLeft">调整项目:&nbsp;</td>
				<td ><input type="text" name="reward.rewardFrom" id="rewardFrom"
					value="${reward.rewardFrom }" class="largex text" title="调整项目"	checkType="string,1,50" tip="请输入调整项目"><span style="color: red;">*</span></td>
			</tr>
			<tr height="32">
				<td class="formTableTdLeft">备注:&nbsp;</td>
				<td colspan="3">
					<textarea class="text textarea" rows="8" cols="60" name="reward.note" id="note">${reward.note }</textarea>
				</td>
			</tr>
		</table>
	</form>
	<div class="formButton">
		<a href="javascript:void(-1)"	onclick="$.utile.submitForm('frmId','${ctx}/memReward/save')"	class="but butSave">保&nbsp;&nbsp;存</a> 
	    <a href="${ctx}/member/queryList"	target="contentUrl" class="but butCancle">取&nbsp;&nbsp;消</a>
	</div>
	</div>
</body>
</html>