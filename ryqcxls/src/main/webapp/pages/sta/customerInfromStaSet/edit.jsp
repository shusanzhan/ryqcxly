<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../../commons/taglib.jsp" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link href="${ctx }/css/common.css" type="text/css" rel="stylesheet"/>
<script type="text/javascript" src="${ctx }/widgets/bootstrap3/jquery.min.js"></script>
<script type="text/javascript" src="${ctx }/widgets/easyvalidator/js/easy_validator.pack.js"></script>
<script type="text/javascript" src="${ctx }/widgets/artDialog/artDialog.js?skin=default"></script>
<script type="text/javascript" src="${ctx }/widgets/artDialog/plugins/iframeTools.source.js"></script>
<script type="text/javascript" src="${ctx }/widgets/utile/utile.js"></script>
<title>统计分析设置</title>
</head>
<body class="bodycolor">
<div class="frmContent">
	<form action="" name="frmId" id="frmId" style="margin-bottom: 40px;" target="_parent">
		<table width="100%" border="0" class="mainTable" cellpadding="0" cellspacing="0">
		<thead class="TableHeader">
			<tr>
				<td class="span2">序号</td>
				<td class="span2">名称</td>
				<td class="span2">统计状态</td>
				<td class="span2">统计代码</td>
				<td class="span2">别名</td>
			</tr>
		</thead>
		<c:forEach var="customerInfromStaSet" items="${customerInfromStaSets }" varStatus="i">
			<tr height="32" align="center">
				<td>
					${i.index+1 }
				</td>
				<td>
					${customerInfromStaSet.customerInfrom.name }
				</td>
				<td>
					<select id="staStatus" name="staStatus" class="text small">
						<option value="1" ${customerInfromStaSet.staStatus==1?'selected="selected"':'' } >统计</option>
						<option value="2" ${customerInfromStaSet.staStatus==2?'selected="selected"':'' }>不统计</option>
					</select>
				</td>
				<td>
					<input type="hidden" value="${customerInfromStaSet.dbid }" class="text small" name="dbid" id="dbid" >
					<input type="text" value="${customerInfromStaSet.codeNum }" class="text small" name="codeNum" id="codeNum" >
				</td>
				<td>
					<input type="text" value="${customerInfromStaSet.alias }" class="text small" name="alias" id="alias" >
				</td>
			</tr>
		</c:forEach>
	</table>
	</form>
	<div class="formButton">
		<a href="javascript:void()"	onclick="$.utile.submitForm('frmId','${ctx}/customerInfromStaSet/save')"	class="but butSave">保&nbsp;&nbsp;存</a> 
	    <a href="javascript:void(-1)"	onclick="art.dialog.close(-1)" class="but butCancle">取&nbsp;&nbsp;消</a>
	</div>
</div>
</body>
</html>