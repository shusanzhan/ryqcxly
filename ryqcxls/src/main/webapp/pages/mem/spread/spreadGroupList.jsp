<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../../commons/taglib.jsp" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link href="${ctx }/css/common.css" type="text/css" rel="stylesheet"/>
<script type="text/javascript" src="${ctx }/widgets/bootstrap3/jquery.min.js"></script>
<script type="text/javascript" src="${ctx }/widgets/utile/utile.js"></script>
<script type="text/javascript" src="${ctx }/widgets/easyvalidator/js/easy_validator.pack.js"></script>
<script type="text/javascript" src="${ctx }/widgets/artDialog/artDialog.js?skin=default"></script>
<script type="text/javascript" src="${ctx }/widgets/artDialog/plugins/iframeTools.source.js"></script>
<title>分组管理</title>
</head>
<body class="bodycolor">
<div class="location">
	<img src="${ctx}/images/homeIcon.png"/> &nbsp;
	<a href="javascript:void(-1);" onclick="window.parent.location.href='${ctx}/main/index'">首页</a>-
	<a href="javascript:void(-1);" onclick="">分组管理</a>
</div>
 <!--location end-->
<div class="line"></div>
<div class="listOperate">
	<div class="operate">
		<a class="but button" href="javascript:void();" onclick="window.location.href='${ctx}/spread/editSpreadGroup?spreadId=${spread.dbid }'">添加</a>
		<a class="but butCancle" href="javascript:void();" onclick="window.location.href='${ctx}/spread/queryList'">返回</a>
   </div>
  	<div class="seracrhOperate">
  		<form name="searchPageForm" id="searchPageForm" action="${ctx}/spread/queryList" method="post">
		<input type="hidden" id="currentPage" name="currentPage" value='${page.currentPageNo}'>
		<input type="hidden" id="paramPageSize" name="pageSize" value='${page.pageSize}'>
   		</form>
   	</div>
   	<div style="clear: both;"></div>
</div>
<table width="100%"  cellpadding="0" cellspacing="0" class="mainTable" border="0">
	<thead  class="TableHeader">
		<tr>
			<td class="sn"><input type='checkbox' id="selectAllCheck" onclick="selectAll(this,'id')" /></td>
			<td class="span2">名称</td>
			<td class="span4">备注</td>
			<td class="span2">操作</td>
		</tr>
	</thead>
	<c:forEach var="spreadGroup" items="${spreadGroups }">
		<tr height="32" align="center">
			<td><input type='checkbox' name="id" id="id1" value="${spreadGroup.dbid }"/></td>
			<td>${spreadGroup.name }</td>
			<td>
				${spreadGroup.note }
			</td>
			<td>
				<a href="#" class="aedit" onclick="window.location.href='${ctx }/spread/editSpreadGroup?dbid=${spreadGroup.dbid}&spreadId=${spread.dbid }'">编辑</a>
				<a href="#" class="aedit" onclick="$.utile.deleteById('${ctx }/spread/deleteSpreadGroup?dbids=${spreadGroup.dbid}&spreadId=${spread.dbid }')">删除</a>
			</td>
		</tr>
	</c:forEach>
</table>
<div id="fanye">
	<%@ include file="../../commons/commonPagination.jsp" %>
</div>
</body>
</html>