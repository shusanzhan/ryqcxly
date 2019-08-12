<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../../../commons/taglib.jsp" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link href="${ctx }/css/common.css" type="text/css" rel="stylesheet"/>
<script type="text/javascript" src="${ctx }/widgets/bootstrap/jquery.min.js"></script>
<script type="text/javascript" src="${ctx }/widgets/utile/utile.js"></script>
<script type="text/javascript" src="${ctx }/widgets/easyvalidator/js/easy_validator.pack.js"></script>
<script type="text/javascript" src="${ctx }/widgets/artDialog/artDialog.js?skin=default"></script>
<script type="text/javascript" src="${ctx }/widgets/artDialog/plugins/iframeTools.source.js"></script>
<title>库龄奖励</title>
</head>
<body class="bodycolor">
<div class="location">
	<img src="${ctx}/images/homeIcon.png"/> &nbsp;
	<a href="javascript:void(-1);" onclick="window.parent.location.href='${ctx}/main/index'">首页</a>-
	<a href="javascript:void(-1);" onclick="">库龄奖励</a>
</div>
 <!--location end-->
<div class="line"></div>
<div class="listOperate">
	<div class="operate">
		<a class="but button" href="javascript:void();" onclick="window.location.href='${ctx}/rewardStoreLevel/edit'">添加</a>
   </div>
  	<div class="seracrhOperate">
  		<form name="searchPageForm" id="searchPageForm" rewardStoreLevelion="${ctx}/rewardStoreLevel/queryList" metdod="get">
		<input type="hidden" id="currentPage" name="currentPage" value='${page.currentPageNo}'>
		<input type="hidden" id="paramPageSize" name="pageSize" value='${page.pageSize}'>
   		</form>
   	</div>
   		<div style="clear: both;"></div>
</div>
<c:if test="${empty(page.result)||fn:length(page.result)<=0 }" var="status">
	<div class="alert alert-error">
		无库存奖励数据
	</div>
</c:if>
<c:if test="${status==false }">
<table width="100%"  cellpadding="0" cellspacing="0" class="mainTable" border="0">
	<thead  class="TableHeader">
		<tr>
			<td class="sn"><input type='checkbox' id="selectAllCheck" onclick="selectAll(this,'id')" /></td>
			<td class="span2">库龄等级</td>
			<td class="span2">库龄周期(月)</td>
			<td class="span3">奖励</td>
			<td class="span3">备注</td>
			<td class="span2">操作</td>
		</tr>
	</thead>
	<c:forEach var="rewardStoreLevel" items="${page.result }">
		<tr height="32" align="center">
			<td><input type='checkbox' name="id" id="id1" value="${rewardStoreLevel.dbid }"/></td>
			<td>${rewardStoreLevel.storeAgeLevel.name }</td>
			<td>${rewardStoreLevel.storeAgeLevel.cycleDate }</td>
			<td >${rewardStoreLevel.rewardMoney }</td>
			<td style="text-align: left;">${rewardStoreLevel.note} </td>
			<td><a href="#" class="aedit"
				onclick="window.location.href='${ctx }/rewardStoreLevel/edit?dbid=${rewardStoreLevel.dbid}'">编辑</a>|
				<a href="#" class="aedit" onclick="$.utile.deleteById('${ctx }/rewardStoreLevel/delete?dbids=${rewardStoreLevel.dbid}')">删除</a>
		</tr>
	</c:forEach>
</table>
<div id="fanye">
	<%@ include file="../../../commons/commonPagination.jsp" %>
</div>
</c:if>
</body>
</html>