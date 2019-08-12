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
<title>分组管理</title>
</head>
<body class="bodycolor">
<div class="frmContent">
	<form action="" name="frmId" id="frmId"  target="_self">
		<s:token></s:token>
		<input type="hidden" name="type" id="type" value="1">
		<input type="hidden" name="spreadDetail.dbid" id="dbid" value="${spreadDetail.dbid }">
		<table border="0" align="center" cellpadding="0" cellspacing="0" style="width: 92%;">
			<tr height="42">
				<td class="formTableTdLeft">渠道名称:&nbsp;</td>
				<td >
					<select id="spreadId" name="spreadId" class="largeX text" checkType="integer,1" tip="请选渠道名称" onchange="ajaxSpreadGroup(this.value)">
						<option value="0">请选择...</option>
						<c:forEach var="spread" items="${spreads }">
							<option value="${spread.dbid }" ${spread.dbid==spreadDetail.spread.dbid?'selected="selected"':'' } >${spread.name }</option>
						</c:forEach>
					</select>
					
				</td>
			</tr>
			<tr height="42">
				<td class="formTableTdLeft">分组:&nbsp;</td>
				<td >
					<select id="spreadGroupId" name="spreadGroupId" class="largeX text" checkType="integer,1" tip="请选择分组">
						<option value="0">请选择...</option>
						<c:forEach var="spreadGroup" items="${spreadGroups }">
							<option value="${spreadGroup.dbid }" ${spreadGroup.dbid==spreadDetail.spreadGroup.dbid?'selected="selected"':'' } >${spreadGroup.name }</option>
						</c:forEach>
					</select>
				</td>
			</tr>
			<tr height="42">
				<td class="formTableTdLeft">名称:&nbsp;</td>
				<td ><input type="text" name="spreadDetail.name" id="name"
					value="${spreadDetail.name }" class="largeX text" title="名称"	checkType="string,2,12" tip="长度在2到12个字符之间，不能与已有渠道重复"><span style="color: red;">*</span></td>
			</tr>
			<tr height="32">
				<td class="formTableTdLeft">备注:&nbsp;</td>
				<td>
					<textarea class="text textarea" rows="8" cols="60" name="spreadDetail.note" id="note" checkType="string,1,200" canEmpty="Y" tip="请控制在200字以内" placeholder="请控制在200字以内">${spreadDetail.note }</textarea>
				</td>
			</tr>
		</table>
	</form>
</div>
</body>
<script type="text/javascript">
	function ajaxSpreadGroup(spreadId){
		$("#spreadGroupId").empty();
		$.post('${ctx}/spread/ajaxSpreadGroup?spreadId='+spreadId+"&date="+new Date,{},function (data){
			$("#spreadGroupId").append(data);
		})
	}
</script>
</html>