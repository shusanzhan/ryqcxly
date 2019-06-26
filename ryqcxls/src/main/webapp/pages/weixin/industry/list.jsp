<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="../../commons/taglib.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html lang="en">
<head>
<title>行业管理</title>
<meta charset="UTF-8" />
<meta name="viewport" content="width=device-width, initial-scale=1.0" />
<link href="${ctx }/css/common.css" type="text/css" rel="stylesheet"/>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
</head>
<body class="bodycolor">
<div class="location">
	<img src="${ctx}/images/homeIcon.png"/> &nbsp;
	<a href="javascript:void(-1);" onclick="window.parent.location.href='${ctx}/main/index'">首页</a>-
	<a href="javascript:void(-1);" onclick="">行业管理</a>
</div>
 <!--location end-->
<div class="line"></div>
<div class="listOperate">
	<div class="operate">
		<a class="but button" href="javascript:void();" onclick="window.location.href='${ctx}/industry/add'">添加</a>
   </div>
  	<div class="seracrhOperate">
  		<form name="searchPageForm" id="searchPageForm" action="${ctx}/profession/queryList" metdod="get">
		<input type="hidden" id="currentPage" name="currentPage" value='${page.currentPageNo}'>
		<input type="hidden" id="paramPageSize" name="pageSize" value='${page.pageSize}'>
   		</form>
   	</div>
   		<div style="clear: both;"></div>
</div>
<c:if test="${empty(industries)||industries==null }" var="status">
	<div class="alert alert-info">
		<strong>提示!</strong> 当前未添加数据.
	</div>
</c:if>
<c:if test="${status==false }">
<table width="100%" border="0" class="mainTable" cellpadding="0" cellspacing="0">
		<thead class="TableHeader">
			<tr>
				<td class="span2" style="text-align: left;">名称</td>
				<td class="span2">代码</td>
				<td class="span4" style="text-align: left;">备注</td>
				<td class="span2">创建时间</td>
				<td class="span2">顺序号</td>
				<td class="span2">操作</td>
			</tr>
		</thead>
		<tbody>
			<c:forEach items="${industries }" var="industry">
			<tr>
				<td style="text-align: left;">${industry.name }</td>
				<td style="text-align: center;">${industry.code }</td>
				<td style="text-align: left;">${industry.note }</td>
				<td><fmt:formatDate value="${industry.createDate }" pattern="yyyy-MM-dd"/> </td>
				<td>${industry.num }</td>
				<td style="text-align: center;">
				<a href="javascript:void(-1)"  class="aedit" onclick="window.location.href='${ctx}/industry/edit?dbid=${industry.dbid}&parentMenu=1'">编辑</a> | 
				<a href="javascript:void(-1)"  class="aedit" onclick="$.utile.deleteById('${ctx}/industry/delete?dbid=${industry.dbid}','searchPageForm')" title="删除">删除</a></td>
			</tr>
			<ystech:industry dbid="${industry.dbid }"/>
		</c:forEach>
	</tbody>
</table>
</c:if>
<div id="fanye">
	<%@ include file="../../commons/commonPagination.jsp" %>
</div>
<script type="text/javascript" src="${ctx }/widgets/bootstrap3/jquery.min.js"></script>
<script type="text/javascript" src="${ctx }/widgets/utile/utile.js"></script>
<script type="text/javascript" src="${ctx }/widgets/easyvalidator/js/easy_validator.pack4.js"></script>
<script type="text/javascript" src="${ctx }/widgets/artDialog/artDialog.js?skin=default"></script>
<script type="text/javascript" src="${ctx }/widgets/artDialog/plugins/iframeTools.source.js"></script>
</body>
</html>
