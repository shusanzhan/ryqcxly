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
<title>入库单</title>
</head>
<body class="bodycolor">
<div class="location">
	<img src="${ctx}/images/homeIcon.png"/> &nbsp;
	<a href="javascript:void(-1);" onclick="window.parent.location.href='${ctx}/main/index'">首页</a>-
	<a href="javascript:void(-1);" onclick="">入库单</a>
</div>
 <!--location end-->
<div class="line"></div>
<div class="listOperate">
	<div class="operate">
		<a class="but button" href="javascript:void();" onclick="window.location.href='${ctx}/purchaseStorage/add'">添加</a>
		<a class="but butCancle" href="javascript:void();" onclick="$.utile.deleteIds('${ctx }/purchaseStorage/delete','searchPageForm')">删除</a>
   </div>
  	<div class="seracrhOperate">
  		<form name="searchPageForm" id="searchPageForm" action="${ctx}/purchaseStorage/queryList" method="post">
		<input type="hidden" id="currentPage" name="currentPage" value='${page.currentPageNo}'>
		<input type="hidden" id="paramPageSize" name="pageSize" value='${page.pageSize}'>
   		</form>
   	</div>
   	<div style="clear: both;"></div>
</div>
 <c:if test="${empty(page)||fn:length(page.result)<=0 }" var="status">
 	<div class="alert alert-error">无入库单信息</div>
 </c:if>
 <c:if test="${status==false }">
<table width="100%"  cellpadding="0" cellspacing="0" class="mainTable" border="0">
	<thead  class="TableHeader">
		<tr>
			<td class="sn"><input type='checkbox' id="selectAllCheck" onclick="selectAll(this,'id')" /></td>
			<td class="span2">单据号</td>
			<td class="span2">供应商</td>
			<td class="span4">入库商品</td>
			<td class="span1">进货金额</td>
			<td class="span1">折后金额</td>
			<td class="span1">付款金额</td>
			<td class="span1">单据日期</td>
			<td class="span1">支出状态</td>
			<td class="span3">说明</td>
			<td class="span2">操作</td>
		</tr>
	</thead>
	<c:forEach var="purchaseStorage" items="${page.result }">
		<tr height="32" align="center">
			<td><input type='checkbox' name="id" id="id1" value="${purchaseStorage.dbid }"/></td>
			<td style="text-align: left;">${purchaseStorage.sn }</td>
			<td style="text-align: center;">${purchaseStorage.supplier.name} </td>
			<td style="text-align: left;">
				<c:forEach items="${purchaseStorage.purchaseProducts }" var="purchaseProduct">
					<div>
						${purchaseProduct.productName }
						进货：${purchaseProduct.num }，已售：${purchaseProduct.saleNum }
					</div>
				</c:forEach>
			</td>
			<td style="text-align: center;">${purchaseStorage.purchaseMoney} </td>
			<td style="text-align: center;">${purchaseStorage.disMoney} </td>
			<td style="text-align: center;">${purchaseStorage.payMoney} </td>
			<td style="text-align: center;">${purchaseStorage.kpDate} </td>
			<td style="text-align: center;">
				<c:if test="${purchaseStorage.expenditureStats==1 }">
					<span style="color:red">待支出</span>
				</c:if>
				<c:if test="${purchaseStorage.expenditureStats==2 }">
					<span style="color:green">已支出</span>
				</c:if>
			</td>
			<td style="text-align: left;">
				${purchaseStorage.note }
			</td>
			<td >
				<a href="#" class="aedit" onclick="window.location.href='${ctx }/purchaseStorage/cliList?dbid=${purchaseStorage.dbid}'">查看明细</a>
				<c:if test="${purchaseStorage.expenditureStats==1 }">
					|
					<a href="#" class="aedit" onclick="window.location.href='${ctx }/purchaseStorage/edit?dbid=${purchaseStorage.dbid}'">编辑</a>
					|
					<a href="#" class="aedit"	onclick="$.utile.deleteById('${ctx }/purchaseStorage/delete?dbids=${purchaseStorage.dbid}')">删除</a>
				</c:if>
				
		</tr>
	</c:forEach>
</table>
<div id="fanye">
	<%@ include file="../../commons/commonPagination.jsp" %>
</div>
</c:if>
</body>
</html>