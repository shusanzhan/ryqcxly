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
<title>指标登记设置</title>
</head>
<body >
<div class="frmContent">
	<form action="" name="frmId" id="frmId"  target="_self">
		<s:token></s:token>
		<input type="hidden" name="staAssessmentIndexLevel.dbid" id="dbid" value="${staAssessmentIndexLevel.dbid }">
		<input type="hidden" name="staAssessmentIndexId" id="staAssessmentIndexId" value="${param.staAssessmentIndexId }">
		<table border="0" align="center" cellpadding="0" cellspacing="0" style="width: 92%;">
			<tr height="42">
				<td class="formTableTdLeft">等级:&nbsp;</td>
				<td >
					<select id="type" name="staAssessmentIndexLevel.type" checkType="integer,1" class="largeX text">
						<option value="-1">请选择...</option>
						<option value="1" ${staAssessmentIndexLevel.type==1?'selected="selected"':'' } >优秀</option>
						<option value="2" ${staAssessmentIndexLevel.type==2?'selected="selected"':'' }>达标</option>
						<option value="3" ${staAssessmentIndexLevel.type==3?'selected="selected"':'' }>未达标</option>
					</select>
				<span style="color: red;">*</span></td>
			</tr>
			<tr height="42">
				<td class="formTableTdLeft">初始值:&nbsp;</td>
				<td ><input type="text" name="staAssessmentIndexLevel.beginNum" id="beginNum"
					value="${staAssessmentIndexLevel.beginNum }" class="largeX text" title="初始值"	checkType="integer,0,100" tip="请输入初始值,0-100之间"><span style="color: red;">*</span></td>
			</tr>
			<tr height="42">
				<td class="formTableTdLeft">结束值:&nbsp;</td>
				<td ><input type="text" name="staAssessmentIndexLevel.endnum" id="endNum"
					value="${staAssessmentIndexLevel.endnum }" class="largeX text" title="结束值"	checkType="integer,1,100" tip="请输入结束值，1-100之间"><span style="color: red;">*</span></td>
			</tr>
			<tr height="32" style="height: 60px;">
				<td class="formTableTdLeft">公司建议:&nbsp;</td>
				<td>
					<textarea class="text textarea" rows="8" cols="60" name="staAssessmentIndexLevel.entSugg" id="entSugg" checkType="string,1,2000" canEmpty="Y" style="height: 40px;" tip="请控制在2000字以内" placeholder="请控制在2000字以内">${staAssessmentIndexLevel.entSugg }</textarea>
				</td>
			</tr>
			<tr height="32" style="height: 60px;">
				<td class="formTableTdLeft">部门建议:&nbsp;</td>
				<td>
					<textarea class="text textarea" rows="8" cols="60" name="staAssessmentIndexLevel.depSugg" id="depSugg" checkType="string,1,2000" canEmpty="Y" style="height: 40px;" tip="请控制在2000字以内" placeholder="请控制在2000字以内">${staAssessmentIndexLevel.depSugg }</textarea>
				</td>
			</tr>
			<tr height="32" style="height: 60px;">
				<td class="formTableTdLeft">业务员建议:&nbsp;</td>
				<td>
					<textarea class="text textarea" rows="8" cols="60" name="staAssessmentIndexLevel.salSugg" id="salSugg" checkType="string,1,2000" canEmpty="Y" style="height: 40px;" tip="请控制在2000字以内" placeholder="请控制在2000字以内">${staAssessmentIndexLevel.salSugg }</textarea>
				</td>
			</tr>
		</table>
	</form>
</div>
</body>
</html>