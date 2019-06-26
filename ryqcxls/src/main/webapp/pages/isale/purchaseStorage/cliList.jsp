<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../../commons/taglib.jsp" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link href="${ctx }/css/common.css" type="text/css" rel="stylesheet"/>
<title>商品选择列表</title>
<style type="text/css">
table{
	border-top: 1px solid  #cccccc;
	border-left: 1px solid  #cccccc;
}
table th, table td {
	border-bottom: 1px solid  #cccccc;
	border-right: 1px solid  #cccccc;
}
.frmContent form table tr td {
    padding-left: 5px;
}
#noLine{
	border-top: 0;
	border-left: 0;
}
#noLine td{
	border: 0;
}
</style>
</head>
<body class="bodycolor">
 <div class="location">
	<img src="${ctx}/images/homeIcon.png"/> &nbsp;
	<a href="javascript:void(-1);" onclick="window.parent.location.href='${ctx}/main/index'">首页</a>-
	<a href="javascript:void(-1);" onclick="window.location.href='${ctx}/purchaseStorage/queryList'">入库单</a>-
	<a href="javascript:void(-1);" onclick="">查看明细</a>
</div>
 <!--location end-->
<div class="line"></div>
<div class="listOperate">
	<div class="operate">
		<a class="but butCancle" href="javascript:void();" onclick="window.location.href='${ctx}/purchaseStorage/queryList'">返回</a>
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
<c:if test="${empty(purchaseProducts) }">
	<div class="alert alert-error">
		系统无该商品库存
	</div>
</c:if>
<c:if test="${!empty(purchaseProducts) }">
<table width="100%"  cellpadding="0" cellspacing="0" class="mainTable" border="0">
	<thead  class="TableHeader">
		<tr>
			<td class="span2">进货编号</td>
			<td class="span2">类型</td>
			<td class="span2">品牌</td>
			<td class="span2">名称</td>
			<td class="span2">进货价</td>
			<td class="span1">数量</td>
			<td class="span1">操作</td>
		</tr>
	</thead>
	<c:forEach var="purchaseProduct" items="${purchaseProducts }">
		<c:set var="product" value="${purchaseProduct.product }"></c:set>
		<tr height="32" align="center">
			<td align="left" style="text-align: left;">
				<label>
				&nbsp;&nbsp;
				<a href="#" class="aedit"  onclick="window.location.href='${ctx }/purchaseStorage/prodcutItemList?purchaseProductId=${purchaseProduct.dbid}'">${purchaseProduct.purchaseStorage.sn}</a>	
				</label>
			</td>
			<td>
					${product.productcategory.name }
			</td>
			<td>${product.brand.name }</td>
			<td>${product.name }</td>
			<td>
				<span style="font-size: 14px;color: red;">
					${purchaseProduct.price }
				</span>
			</td>
			<td>
				<span style="font-size: 14px;color: red;">
					${purchaseProduct.num }
				</span>
			</td>
			<td>
				<a href="#" class="aedit" onclick="window.location.href='${ctx }/purchaseStorage/printCli?purchaseProductId=${purchaseProduct.dbid}'">打印条码</a>
			</td>
		</tr>
	</c:forEach>
</table>
</c:if>
<br>
<table width="100%"  cellpadding="0" cellspacing="0" class="mainTable" border="0">
	<tr height="32" style="background-color: #eeeeee; border-color:#eeeeee;font-size: 16px;font-weight: bold;">
		<td colspan="4" style="text-align: left;padding-right: 12px;">
			采购的信息
		</td>
	</tr>
	<tr style='height:40px'>
		<td style="width: 120px;">进货单号</td>
		<td style="text-align: left;">${purchaseStorage.sn }</td>
		<td style="width: 120px;">供货商</td>
		<td style="text-align: left;;width: 320px;">${purchaseStorage.supplier.name} </td>
	</tr>
	<tr style='height:40px'>
		<td style="width: 120px;">进货金额</td>
		<td style="text-align: left;">${purchaseStorage.purchaseMoney }</td>
		<td style="width: 120px;">折扣金额</td>
		<td style="text-align: left;;width: 320px;">${purchaseStorage.disMoney} </td>
	</tr>
	<tr style='height:40px'>
		<td style="width: 120px;">>进货时间</td>
		<td style="text-align: left;">
			${purchaseStorage.kpDate }
		</td>
		<td style="width: 120px;">备注</td>
		<td style="text-align: left;width: 320px;">${purchaseStorage.note }</td>
	</tr>
	<c:if test="${purchaseStorage.expenditureStats==2 }">
		<tr height="32" style="background-color: #eeeeee; border-color:#eeeeee;font-size: 16px;font-weight: bold;">
			<td colspan="4" style="text-align: left;padding-right: 12px;">
				支付信息
			</td>
		</tr>
		<c:if test="${!empty(purchaseStorage.expenditure) }">
			<tr style='height:40px'>
				<td style="width: 120px;">支出单号</td>
				<td colspan="3" style="text-align: left;width: 320px;color: red;">
					<a class="aedit" style="color: #2b7dbc;" href="${ctx }/expenditureManagement/expenditureDetail?expenditureId=${purchaseStorage.expenditure.dbid}">${purchaseStorage.expenditure.expenditureSingleNumber }</a>
				</td>
			</tr>
		</c:if>
		<tr style='height:40px'>
			<td style="width: 120px;">支出状态</td>
			<td style="text-align: left;width: 320px;color: red;">已经支出</td>
			<td style="width: 120px;">支出人</td>
			<td style="text-align: left;width: 320px;"> ${purchaseStorage.expenditurePerson }</td>
		</tr>
		<tr style='height:40px'>
			<td style="width: 120px;">支出时间</td>
			<td style="text-align: left;;width: 320px;">
				${purchaseStorage.expentitureDate }
			</td>
			<td style="width: 120px;">支金额</td>
			<td style="text-align: left;width: 320px;">${purchaseStorage.expenditureMondy }</td>
		</tr>
	</c:if>
</table>
<br>
<br>
</body>
<script type="text/javascript" src="${ctx }/widgets/bootstrap3/jquery.min.js"></script>
<script type="text/javascript" src="${ctx }/widgets/utile/utile.js"></script>
<script type="text/javascript" src="${ctx }/widgets/easyvalidator/js/easy_validator.pack.js"></script>
<script type="text/javascript" src="${ctx }/widgets/artDialog/artDialog.js?skin=default"></script>
<script type="text/javascript" src="${ctx }/widgets/artDialog/plugins/iframeTools.source.js"></script>
</html>