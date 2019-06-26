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
<title>保险险种</title>
</head>
<body class="bodycolor">
<div class="location">
	<img src="${ctx}/images/homeIcon.png"/> &nbsp;
	<a href="javascript:void(-1);" onclick="window.parent.location.href='${ctx}/main/index'">首页</a>-
	<a href="javascript:void(-1);" onclick="">保险险种</a>
</div>
 <!--location end-->
<div class="line"></div>
<div class="listOperate">
	<div class="operate">
		<a class="but button" href="javascript:void();" onclick="window.location.href='${ctx}/insuranceItem/add'">添加</a>
		<a class="but butCancle" href="javascript:void();" onclick="$.utile.deleteIds('${ctx }/insuranceItem/delete','searchPageForm')">删除</a>
   </div>
  	<div class="seracrhOperate">
  		<form name="searchPageForm" id="searchPageForm" action="${ctx}/insuranceItem/queryList" method="post">
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
			<td class="span1">类型</td>
			<td class="span1">不计免赔</td>
			<td class="span1">候选</td>
			<td class="span4">计算说明</td>
			<td class="span2">创建日期</td>
			<td class="span1">排序</td>
			<td class="span2">操作</td>
		</tr>
	</thead>
	<c:forEach var="insuranceItem" items="${page.result }">
		<tr height="32" align="center">
			<td><input type='checkbox' name="id" id="id1" value="${insuranceItem.dbid }"/></td>
			<td style="text-align: left;">${insuranceItem.name }</td>
			<td style="text-align: center;">
				<c:if test="${insuranceItem.type==1 }">
					强制保险
				</c:if>
				<c:if test="${insuranceItem.type==2 }">
					商业保险
				</c:if>
			</td>
			<td style="text-align: center;">
				<c:if test="${insuranceItem.nonDeductibleStatus==1 }">
					<span style="color: red;">否</span>
				</c:if>
				<c:if test="${insuranceItem.nonDeductibleStatus==2 }">
					<span style="color: green;">是</span>
					（${insuranceItem.nonDeductiblePer }%）
				</c:if>
			</td>
			<td style="text-align: center;">
				<c:if test="${insuranceItem.singleStatus==1 }">
					<span style="color: green;">否</span>
				</c:if>
				<c:if test="${insuranceItem.singleStatus==2 }">
					<span style="color: red;">是</span>
				</c:if>
			</td>
			<td style="text-align: left;">${insuranceItem.details }</td>
			<td style="text-align: center;">${insuranceItem.createDate} </td>
			<td style="text-align: center;">${insuranceItem.orderNum} </td>
			<td><a href="#" class="aedit"
				onclick="window.location.href='${ctx }/insuranceItem/edit?dbid=${insuranceItem.dbid}'">编辑</a>
				<a href="#" class="aedit"
				onclick="$.utile.deleteById('${ctx }/insuranceItem/delete?dbids=${insuranceItem.dbid}')">删除</a>
		</tr>
	</c:forEach>
</table>
<div id="fanye">
	<%@ include file="../../commons/commonPagination.jsp" %>
</div>
</body>
</html>