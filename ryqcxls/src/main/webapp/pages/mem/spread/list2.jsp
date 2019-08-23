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
<title>渠道管理</title>
</head>
<body class="bodycolor">
<div class="location">
	<img src="${ctx}/images/homeIcon.png"/> &nbsp;
	<a href="javascript:void(-1);" onclick="window.parent.location.href='${ctx}/main/index'">首页</a>-
	<a href="javascript:void(-1);" onclick="">渠道管理</a>
</div>
 <!--location end-->
<div class="line"></div>
<div class="listOperate">
	<div class="operate">
		<a class="but button" href="javascript:void();" onclick="window.location.href='${ctx}/memSpread/add'">添加</a>
		<a class="but butCancle" href="javascript:void();" onclick="window.location.href='${ctx}/memSpread/add'">删除</a>
   </div>
  	<div class="seracrhOperate">
  		<form name="searchPageForm" id="searchPageForm" action="${ctx}/memSpread/queryList" method="post">
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
			<td class="span2">引流</td>
			<td class="span2">扫码</td>
			<td class="span2">创建日期</td>
			<td class="span4">分组</td>
			<td class="span2">操作</td>
		</tr>
	</thead>
	<c:forEach var="spread" items="${page.result }">
		<tr height="32" align="center">
			<td><input type='checkbox' name="id" id="id1" value="${spread.dbid }"/></td>
			<td>${spread.name }</td>
			<td>${spread.spreadNum }</td>
			<td>${spread.scanCodeNum }</td>
			<td>${spread.createDate }</td>
			<td style="text-align: left;">
				<c:if test="${!empty(spread.spreadGroups)&&fn:length(spread.spreadGroups)>0 }">
					<c:forEach var="spreadGroup" items="${spread.spreadGroups }">
						${spreadGroup.name },
					</c:forEach>
				</c:if>
				<a href="#" style="color: #2b7dbc" class="aedit" onclick="window.location.href='${ctx }/memSpread/spreadGroupList?spreadId=${spread.dbid}'">管理</a>
			</td>
			<td>
				<a href="#" class="aedit" onclick="window.location.href='${ctx }/spreadDetail/queryList?spreadId=${spread.dbid}'">二维码</a>
				|
				<a href="#" class="aedit" onclick="window.location.href='${ctx }/memSpread/edit?dbid=${spread.dbid}'">编辑</a>
				|
				<a href="#" class="aedit" onclick="$.utile.deleteById('${ctx }/memSpread/delete?dbids=${spread.dbid}')">删除</a>
		</tr>
	</c:forEach>
</table>
<div id="fanye">
	<%@ include file="../../commons/commonPagination.jsp" %>
</div>
</body>
</html>