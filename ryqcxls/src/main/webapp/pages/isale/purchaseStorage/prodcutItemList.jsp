<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../../commons/taglib.jsp" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link href="${ctx }/css/common.css" type="text/css" rel="stylesheet"/>
<title>商品选择列表</title>
</head>
<body class="bodycolor">
 <div class="location">
	<img src="${ctx}/images/homeIcon.png"/> &nbsp;
	<a href="javascript:void(-1);" onclick="window.parent.location.href='${ctx}/main/index'">首页</a>-
	<a href="javascript:void(-1);" onclick="window.location.href='${ctx}/purchaseStorage/queryList'">入库单</a>-
	<a href="javascript:void(-1);" onclick="">查看单品</a>
</div>
 <!--location end-->
<div class="line"></div>
<div class="listOperate">
	<div class="operate">
		<a class="but butCancle" href="javascript:void();" onclick="window.history.go(-1)">返回</a>
   </div>
  	<div class="seracrhOperate">
  		<form name="searchPageForm" id="searchPageForm" action="${ctx}/purchaseStorage/queryList" method="post">
		<input type="hidden" id="currentPage" name="currentPage" value='${page.currentPageNo}'>
		<input type="hidden" id="paramPageSize" name="pageSize" value='${page.pageSize}'>
   		</form>
   	</div>
   	<div style="clear: both;"></div>
</div>
<form action="">
	<input type="hidden"  value="" id="targets" name="targets" >
	<input type="hidden" value="" id="result" name="result" >
	<input type="hidden" value="" id="totalCostPrice" name="totalCostPrice" >
	<input type="hidden" value="success" id="message" name="message" >
</form>
<c:if test="${empty(productItems) }">
	<div class="alert alert-error">
		系统无该商品库存
	</div>
</c:if>
<c:if test="${!empty(productItems) }">
<table width="100%"  cellpadding="0" cellspacing="0" class="mainTable" border="0">
	<thead  class="TableHeader">
		<tr>
			<td class="span2">单品序号</td>
			<td class="span2">编码</td>
			<td class="span2">出库状态</td>
			<td class="span2">二维码</td>
			<td class="span2">操作</td>
		</tr>
	</thead>
	<c:forEach var="productItem" items="${productItems }">
		<tr height="32" align="center">
			<td align="left" style="text-align: left;">
				<label>
				&nbsp;&nbsp;
				${productItem.num}
				</label>
			</td>
			<td>
				${productItem.no}
			</td>
			<td>
				<c:if test="${productItem.saleStatus==1}">
					<span style="font-size: 14px;color: green;">
						在库
					</span>
				</c:if>
				<c:if test="${productItem.saleStatus==2}">
					<span style="font-size: 14px;color: red;">
						出库
					</span>
				</c:if>
			</td>
			<td>
				<span style="font-size: 14px;color: red;">
					<img alt="" src="${productItem.cli }"> 
				</span>
			</td>
			<td>
				<a href="#" class="aedit" onclick="window.location.href='${ctx }/purchaseStorage/printCliSingle?productItemId=${productItem.dbid}'">打印条码</a>
			</td>
		</tr>
	</c:forEach>
</table>
</c:if>
</body>
<script type="text/javascript" src="${ctx }/widgets/bootstrap3/jquery.min.js"></script>
<script type="text/javascript" src="${ctx }/widgets/utile/utile.js"></script>
<script type="text/javascript" src="${ctx }/widgets/easyvalidator/js/easy_validator.pack.js"></script>
<script type="text/javascript" src="${ctx }/widgets/artDialog/artDialog.js?skin=default"></script>
<script type="text/javascript" src="${ctx }/widgets/artDialog/plugins/iframeTools.source.js"></script>
</html>