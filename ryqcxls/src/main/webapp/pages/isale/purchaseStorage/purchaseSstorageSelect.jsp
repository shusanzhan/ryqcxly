<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../../commons/taglib.jsp" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link href="${ctx }/css/common.css" type="text/css" rel="stylesheet"/>
<script type="text/javascript">
/** 获取checkBox的value* */
function getCheckBoxproduct() {
		var result="";
	    var totalNum="${orderContractDecoreItem.quality}";
	    var message="success";
		var array = new Array();
		var arrayNames = new Array();
		var numTotal=0;
		var numTotalJ=totalNum;
		var checkeds = $("input[type='checkbox'][name='id']");
		var j=0;
		var status=false;
		var totalCostPrice=0;
		$.each(checkeds, function(i, checkbox) {
			if (checkbox.checked) {
				var num=$(checkbox).attr("num");
				var sn=$(checkbox).attr("sn");
				if(null!=num&&num!=''){
					num=parseInt(num);
				}else{
					num=0;
				}
				numTotal=numTotal+num;
				if(numTotal<=totalNum){
					result=result+'<div style="width: 100%;height: 24px;line-height: 24px;">';
					result=result+'<div style="float: left;width: 100px;">'+sn+'</div>';
					result=result+'<div style="float: left;width: 40px;color:red;">'+num+'</div>';
					totalCostPrice=totalCostPrice+(num*$(checkbox).attr("price"));
					result=result+'<div style="float: left;margin-left: 5px;width: 60px;font-size:14px;color:red;">'+$(checkbox).attr("price");+'</div>';
					result=result+'<div style="clear: both;"></div>'
					result=result+'</div>';
					arrayNames.push(sn);
					array.push(checkbox.value);
				}
				numTotalJ=numTotalJ-num;
				if(numTotal>totalNum&&status==false){
					result=result+'<div style="width: 100%;height: 24px;line-height: 24px;">';
					result=result+'<div style="float: left;width: 100px;">'+sn+'</div>';
					if(numTotalJ>=0){
						result=result+'<div style="float: left;width: 40px;">'+num+'</div>';
						totalCostPrice=totalCostPrice+(num*$(checkbox).attr("price"));
					}else{
						var re=(num+numTotalJ);
						result=result+'<div style="float: left;width: 40px;font-size:14px;color:red;">'+re+'</div>';
						totalCostPrice=totalCostPrice+(re*$(checkbox).attr("price"));
					}
					result=result+'<div style="float: left;margin-left: 5px;width: 60px;font-size:14px;color:red;">'+$(checkbox).attr("price");+'</div>';
					result=result+'<div style="clear: both;"></div>'
					result=result+'</div>';
					arrayNames.push(sn);
					array.push(checkbox.value);
					status=true;
				}
				j=j+1;
			}
		});
		
		
		if(numTotal<totalNum){
			message="库存不足，请先入库在销售";
		}
		$("#targets").val(array.toString()+"|"+arrayNames.toString());
		$("#result").val(result);
		$("#message").val(message);
		$("#totalCostPrice").val(totalCostPrice);
}
</script>
<title>商品选择列表</title>
</head>
<body class="bodycolor">
 <!--location end-->
<div class="listOperate">
  	<div class="seracrhOperate">
   	</div>
   	<div style="clear: both;"></div>
</div>
<form action="">
	<input type="hidden"  value="" id="targets" name="targets" >
	<input type="hidden" value="" id="result" name="result" >
	<input type="hidden" value="" id="totalCostPrice" name="totalCostPrice" >
	<input type="hidden" value="success" id="message" name="message" >
</form>
<table border="0" align="center" cellpadding="0" cellspacing="0" style="width: 92%;margin-top: 12px">
	<tr height="32">
		<td class="formTableTdLeft">商品名称:&nbsp;</td>
		<td >
			${product.name }
		</td>
		<td class="formTableTdLeft">编号:&nbsp;</td>
		<td >
			${product.sn }
		</td>
	</tr>
	<tr height="32">
		<td class="formTableTdLeft">销售价:&nbsp;</td>
		<td >
			${product.price }
		</td>
		<td class="formTableTdLeft">成本价:&nbsp;</td>
		<td >
			${product.costPrice }
		</td>
	</tr>
	<tr height="32">
		<td class="formTableTdLeft">库存量:&nbsp;</td>
		<td >
			<span style="font-size: 16px;color: red;">
				<c:if test="${empty(product.stockNum)}">
					0	
				</c:if>
				<c:if test="${!empty(product.stockNum)}">
					${product.stockNum }	
				</c:if>
			</span>
		</td>
		<td class="formTableTdLeft">进货价:&nbsp;</td>
		<td >
			<c:if test="${empty(product.salerCostPrice)}">
					0	
				</c:if>
				<c:if test="${!empty(product.salerCostPrice)}">
					${product.salerCostPrice }	
				</c:if>
		</td>
	</tr>
</table>
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
			<td class="span1">已售</td>
		</tr>
	</thead>
	<c:forEach var="purchaseProduct" items="${purchaseProducts }">
		<c:set var="product" value="${purchaseProduct.product }"></c:set>
		<tr height="32" align="center">
			<td align="left" style="text-align: left;">
				<label>
				<input type="checkbox"   name="id" id="id1" value="${purchaseProduct.dbid }" sn="${purchaseProduct.purchaseStorage.sn }" num="${purchaseProduct.num }" price="${purchaseProduct.price }" onclick="getCheckBoxproduct()">
				&nbsp;&nbsp;
				${purchaseProduct.purchaseStorage.sn}
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
				<span style="font-size: 14px;color: red;">
					${purchaseProduct.saleNum }
				</span>
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