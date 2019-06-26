<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../../../commons/taglib.jsp" %>
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
<title>红包活动</title>
</head>
<body class="bodycolor">
<div class="location">
	<img src="${ctx}/images/homeIcon.png"/> &nbsp;
	<a href="javascript:void(-1);" onclick="window.parent.location.href='${ctx}/main/index'">首页</a>-
	<a href="javascript:void(-1);" onclick="">红包活动</a>
</div>
 <!--location end-->
<div class="line"></div>
<div class="listOperate">
	<div class="operate">
		<a class="but button" href="javascript:void();" onclick="window.location.href='${ctx}/redBag/edit'">发红包</a>
   </div>
  	<div class="seracrhOperate">
  		<form name="searchPageForm" id="searchPageForm" action="${ctx}/redBag/queryList" metdod="get">
		<input type="hidden" id="currentPage" name="currentPage" value='${page.currentPageNo}'>
		<input type="hidden" id="paramPageSize" name="pageSize" value='${page.pageSize}'>
   		</form>
   	</div>
   		<div style="clear: both;"></div>
</div>
<c:if test="${empty(page.result)||fn:length(page.result)<=0 }" var="status">
	<div class="alert alert-error">
		无红包记录
	</div>
</c:if>
<c:if test="${status==false }">

<table width="100%"  cellpadding="0" cellspacing="0" class="mainTable" border="0">
	<thead  class="TableHeader">
		<tr>
			<td class="sn"><input type='checkbox' id="selectAllCheck" onclick="selectAll(this,'id')" /></td>
			<td class="span2">编号</td>
			<td class="span2">接收人</td>
			<td class="span1">红包金额</td>
			<td class="span1">发送时间</td>
			<td class="span1">状态</td>
			<td class="span4">说明</td>
			<td class="span2">操作</td>
		</tr>
	</thead>
	<c:forEach var="redBag" items="${page.result }">
		<tr height="32" align="center">
			<td><input type='checkbox' name="id" id="id1" value="${redBag.dbid }"/></td>
			<td>${redBag.billno }</td>
			<td>${redBag.recipientName }</td>
			<td>${redBag.redBagMoney }</td>
			<td>
				<fmt:formatDate value="${redBag.sendTime }" pattern="yyyy-MM-dd HH:mm"/>
			</td>
			<td>
				<c:if test="${redBag.turnBackStatus==1 }">
					<span style="color: yellow;">待发送</span>
				</c:if>
				<c:if test="${redBag.turnBackStatus==2 }">
					<span style="color: red;">发送失败</span>
				</c:if>
				<c:if test="${redBag.turnBackStatus==3 }">
					<span style="color: green;">发送成功</span>
				</c:if>
			</td>
			<td style="text-align: left;">
				${redBag.note }
			</td>
			<td><a href="#" class="aedit"
				onclick="window.location.href='${ctx }/redBag/viewWechat?dbid=${redBag.dbid}'">微信返回数据</a>
				<c:if test="${redBag.turnBackStatus==2 }">
					<a href="#" class="aedit" onclick="$.utile.deleteById('${ctx }/act/delete?dbids=${act.dbid}')">删除</a>
				</c:if>
		</tr>
	</c:forEach>
</table>
<div id="fanye">
	<%@ include file="../../../commons/commonPagination.jsp" %>
</div>
</c:if>
</body>
</html>