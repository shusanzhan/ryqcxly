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
<title>分享记录</title>
</head>
<body class="bodycolor">
<div class="location">
	<img src="${ctx}/images/homeIcon.png"/> &nbsp;
	<a href="javascript:void(-1);" onclick="window.parent.location.href='${ctx}/main/index'">首页</a>-
	<a href="javascript:void(-1);" onclick="">分享记录</a>
</div>
 <!--location end-->
<div class="line"></div>
<div class="listOperate">
	<div class="operate">
		<%-- <a class="but button" href="javascript:void();" onclick="window.location.href='${ctx}/pages/recShareRecord/edit.jsp'">添加</a> --%>
   </div>
  	<div class="seracrhOperate">
  		<form name="searchPageForm" id="searchPageForm" action="${ctx}/recShareRecord/queryList" metdod="get">
		<input type="hidden" id="currentPage" name="currentPage" value='${page.currentPageNo}'>
		<input type="hidden" id="paramPageSize" name="pageSize" value='${page.pageSize}'>
   		</form>
   	</div>
</div>
<table width="100%"  cellpadding="0" cellspacing="0" class="mainTable" border="0">
	<thead  class="TableHeader">
		<tr>
			<td class="span2">会员名称</td>
			<td class="span2">会员ID</td>
			<td class="span4">分享项目</td>
			<td class="span2">分享时间</td>
			<td class="span1">备注</td>
			<td class="span2">微信ID</td>
		</tr>
	</thead>
	<c:forEach var="recShareRecord" items="${page.result }">
		<tr height="32" align="center">
			<c:if test="${!empty(recShareRecord.member) }">
				<td >
				${recShareRecord.member.name }</td>
				<td >${recShareRecord.member.mobilePhone }</td>
			</c:if>
			<c:if test="${empty(recShareRecord.member) }">
				<td >
					无
				</td>
				<td>
					无
				</td>
			</c:if>
			<td style="text-align: left;">${recShareRecord.project }</td>
			<td style="text-align: left;">
			    <fmt:formatDate value="${recShareRecord.shareTime }"  pattern="yyyy年MM月dd日 HH:mm"/>	
			</td>
			<td >${recShareRecord.note} </td>
			<td >${recShareRecord.wechatId} </td>
		</tr>
	</c:forEach>
</table>
<div id="fanye" >
	<%@ include file="../../commons/commonPagination.jsp" %>
	<div style="clear: both;"></div>
</div>
</body>
</html>