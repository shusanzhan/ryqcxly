<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../../commons/taglib.jsp" %>
<link rel="stylesheet" href="${ctx }/css/print.css" />
<script src="${ctx }/widgets/bootstrap3/jquery.min.js"></script>
<style type="text/css" media="print">
.bar {
	display: none;
}
</style>
<script type="text/javascript">
$().ready(function() {
	var $print = $("#print");
	$print.click(function() {
		window.print();
		return false;
	});
});
</script>
<style type="text/css">
.body{
	font-size: 16px;
}
.contentTable{
}
.contentTable tr{
	height: 60px;
}
</style>
</head>
<body class="body">
<div class="bar">
	<a href="javascript:;" id="print" class="btn btn-success " style="margin-left: 5px;">打 印</a>
	<a href="javascript:;" id="" onclick="window.history.go(-1)" class="btn btn-success " style="margin-left: 5px;">返 回</a>
</div>
<c:if test="${empty(productItems) }">
	<div class="alert alert-error">
		系统无该商品库存
	</div>
</c:if>
<c:if test="${!empty(productItems) }">
<c:forEach var="productItem" items="${productItems }">
<div style="text-align: center;width: 250px;margin-left: -20px;height:110px;;">
		<p style="font-size: 14px;color: black;font-family: '黑体'">
			<c:if test="${fn:length(productItem.purchaseProduct.product.name)>0 }">
				${productItem.purchaseProduct.product.name }
			</c:if>
		</p>
		<img alt="" src="${productItem.cli }" style="height: 65px;width:320px;margin-left: -30px;margin-top: 2px;"> 
		<p style="font-size: 14px;color: black;">${productItem.no }</p>
</div>
</c:forEach>
</c:if>
</body>
<script type="text/javascript" src="${ctx }/widgets/bootstrap3/jquery.min.js"></script>
<script type="text/javascript" src="${ctx }/widgets/utile/utile.js"></script>
<script type="text/javascript" src="${ctx }/widgets/easyvalidator/js/easy_validator.pack.js"></script>
<script type="text/javascript" src="${ctx }/widgets/artDialog/artDialog.js?skin=default"></script>
<script type="text/javascript" src="${ctx }/widgets/artDialog/plugins/iframeTools.source.js"></script>
</html>