<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="../../commons/taglib.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html lang="en">
<head>
<title>支付方式管理</title>
<meta charset="UTF-8" />
<meta name="viewport" content="width=device-width, initial-scale=1.0" />
<link href="${ctx }/css/common.css" type="text/css" rel="stylesheet"/>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
</head>
<body class="bodycolor">
<div class="location">
	<img src="${ctx}/images/homeIcon.png"/> &nbsp;
	<a href="javascript:void(-1);" onclick="window.parent.location.href='${ctx}/main/index'">首页</a>-
	<a href="javascript:void(-1);" onclick="">开票类型管理</a>
</div>
 <!--location end-->
<div class="line"></div>
<div class="listOperate">
	<div class="operate">
		<a class="but button" href="javascript:void();" onclick="window.location.href='${ctx}/openBillingType/add'">添加</a>
   </div>
  	<div class="seracrhOperate">
  		<form name="searchPageForm" id="searchPageForm" action="${ctx}/openBillingType/queryList"  method="post">
		<input type="hidden" id="currentPage" name="currentPage" value='${page.currentPageNo}'>
		<input type="hidden" id="paramPageSize" name="pageSize" value='${page.pageSize}'>
		<table cellpadding="0" cellspacing="0" class="searchTable" >
  			<tr>
				<td>
					名称&nbsp;
				</td>
				<td>
					<input type="text" class="mideaX text" name="name"	id="name" value="${param.name }"   />
				</td>
				<td><div href="javascript:void(-1)" onclick="$('#searchPageForm')[0].submit()" class="searchIcon"></div></td>
			</tr>
		</table>
   		</form>
   	</div>
   		<div style="clear: both;"></div>
</div>
<c:if test="${empty(page.result) }" var="status">
	<div class="alert alert-info">
		<strong>提示!</strong> 当前未添加数据.
	</div>
</c:if>
<c:if test="${!empty(page.result) }">
<table width="100%" border="0" class="mainTable" cellpadding="0" cellspacing="0">
		<thead class="TableHeader">
			<tr>
				<td class="span2" style="text-align: left;">名称</td>
				<td class="span2">税率</td>
				<td class="span2">创建时间</td>
				<td class="span2">排序号</td>
				<td class="span2">操作</td>
			</tr>
		</thead>
		<tbody>
			<c:forEach items="${page.result }" var="openBillingType">
			<tr>
				<td style="text-align: left;">${openBillingType.name }</td>
				<td>${openBillingType.taxRate}</td>
				<td><fmt:formatDate value="${openBillingType.createTime }" pattern="yyyy-MM-dd HH:MM"/> </td>
				<td>${openBillingType.orderNum }</td>
				<td style="text-align: center;">
					<c:if test="${openBillingType.addDataState eq 1}">
						<a href="javascript:void(-1)"  class="aedit" onclick="window.location.href='${ctx}/openBillingType/edit?dbid=${openBillingType.dbid}&parentMenu=1'" style="color: #2b7dbc;">编辑</a> (系统默认)
					</c:if>
					<c:if test="${openBillingType.addDataState eq 2 }">
						<a href="javascript:void(-1)"  class="aedit" onclick="window.location.href='${ctx}/openBillingType/edit?dbid=${openBillingType.dbid}&parentMenu=1'" style="color: #2b7dbc;">编辑</a> |
						<a href="javascript:void(-1)"  class="aedit" onclick="$.utile.deleteById('${ctx}/openBillingType/delete?dbids=${openBillingType.dbid}','searchPageForm')" title="删除" style="color: #2b7dbc;">删除</a>(自定义) 
					</c:if>
				</td>
			</tr>
		</c:forEach>
	</tbody>
</table>
</c:if>
<div id="fanye">
	<%@ include file="../../commons/commonPagination.jsp" %>
</div>
<script type="text/javascript" src="${ctx }/widgets/bootstrap3/jquery.min.js"></script>
<script type="text/javascript" src="${ctx }/widgets/utile/utile.js"></script>
<script type="text/javascript" src="${ctx }/widgets/easyvalidator/js/easy_validator.pack.js"></script>
<script type="text/javascript" src="${ctx }/widgets/artDialog/artDialog.js?skin=default"></script>
<script type="text/javascript" src="${ctx }/widgets/artDialog/plugins/iframeTools.source.js"></script>
</body>
</html>
