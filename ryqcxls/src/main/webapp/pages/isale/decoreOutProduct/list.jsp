<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../../commons/taglib.jsp" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link href="${ctx }/css/common.css" type="text/css" rel="stylesheet"/>
<script type="text/javascript" src="${ctx }/widgets/My97DatePicker/WdatePicker.js"></script>
<title>出货商品明细</title>
</head>
<body class="bodycolor">
 <div class="location">
	<img src="${ctx}/images/homeIcon.png"/> &nbsp;
	<a href="javascript:void(-1);" onclick="window.parent.location.href='${ctx}/main/index'">首页</a>-
	<a href="javascript:void(-1);" onclick="window.location.href='${ctx}/purchaseProduct/queryList'">出货商品明细</a>-
</div>
 <!--location end-->
<div class="line"></div>
<div class="listOperate">
	<div class="operate">
		<a class="but butSave" href="javascript:void();" onclick="exportExcel('searchPageForm')">导出EXCEL</a>
   </div>
  	<div class="seracrhOperate">
  		<form name="searchPageForm" id="searchPageForm" action="${ctx}/decoreOutProduct/queryList" method="post">
		<input type="hidden" id="currentPage" name="currentPage" value='${page.currentPageNo}'>
		<input type="hidden" id="paramPageSize" name="pageSize" value='${page.pageSize}'>
		<table cellpadding="0" cellspacing="0" class="searchTable" >
  			<tr>
  				<td><label>类型：</label></td>
  				<td>
  					<select id="type" name="type" class="text small" onchange="$('#searchPageForm')[0].submit()">
  						<option value="-1">请选择...</option>
  						<option value="1" ${param.type==1?'selected="selected"':'' } >保有客户</option>
  						<option value="2" ${param.type==2?'selected="selected"':'' } >零售客户</option>
  					</select>
				</td>
  				<td><label>客户名称：</label></td>
  				<td>
  					<input type="text" id="custName" name="custName" value="${param.custName }" class="text small">
				</td>
  				<td><label>联系电话：</label></td>
  				<td>
  					<input class="small text" id="mobilePhone" name="mobilePhone"  value="${param.mobilePhone }" >
				</td>
  				<td><label>车架号：</label></td>
  				<td>
  					<input class="small text" id="vinCode" name="vinCode"  value="${param.vinCode }" >
				</td>
   			</tr>
  			<tr>
  				<td><label>商品名称：</label></td>
  				<td>
  					<input type="text" id="name" name="name" value="${param.name }" class="text small">
				</td>
  				<td><label>出库日期开始：</label></td>
  				<td>
  					<input class="small text" id="startTime" name="startTime" onFocus="WdatePicker({isShowClear:true})" value="${param.startTime }" >
  				</td>
  				
  				<td><label>出库日期结束：</label></td>
  				<td>
  					<input class="small text" id="endTime" name="endTime" onFocus="WdatePicker({isShowClear:true})" value="${param.endTime }">
				</td>
  				<td><div href="javascript:void(-1)" onclick="$('#searchPageForm')[0].submit()" class="searchIcon"></div></td>
   			</tr>
   		</table>
   		</form>
   	</div>
   	<div style="clear: both;"></div>
</div>
<c:if test="${empty(page.result) }">
	<div class="alert alert-error">
		系统无该商品库存
	</div>
</c:if>
<c:if test="${!empty(page.result) }">
<table width="100%"  cellpadding="0" cellspacing="0" class="mainTable" border="0">
	<thead  class="TableHeader">
		<tr>
			<td class="span3">出库时间</td>
			<td class="span3">客户名称</td>
			<td class="span2">分店</td>
			<td class="span4">车型</td>
			<td class="span2">商品名称</td>
			<td class="span2">出库数量</td>
			<td class="span2">含税成本</td>
			<td class="span2">含税总额</td>
			<td class="span2">进货单价</td>
			<td class="span2">进货总价</td>
			<td class="span2">结算单价</td>
			<td class="span2">结算总价</td>
			<td class="span2">销售单价</td>
			<td class="span2">销售总额</td>
		</tr>
	</thead>
	<c:forEach var="decoreOutProduct" items="${page.result }">
		<c:set value="${decoreOutProduct.decoreOut }" var="decoreOut"></c:set>
		<c:set value="${decoreOutProduct.product }" var="product"></c:set>
		<c:set value="${decoreOut.customer }" var="customer"></c:set>
		<c:set value="${customer.customerPidBookingRecord }" var="customerPidBookingRecord"></c:set>
		<tr height="32" align="center">
			<td >
				<fmt:formatDate value="${decoreOut.createDate}" pattern="yyyy-MM-dd HH:mm"/> 
			</td>
			<td style="text-align: left;">
				${decoreOut.customerName }
				（
					<c:if test="${decoreOut.type==1 }">
						保有
					</c:if>
					<c:if test="${decoreOut.type==2 }">
						零售
					</c:if>
				）
				<br>
				${decoreOut.mobilePhone }
			</td>
			<td>
				<c:if test="${!empty(customer.enterprise) }">
					${customer.enterprise.name}
				</c:if>
				<c:if test="${empty(customer.enterprise) }">
					${decoreOut.department.name}
				</c:if>
				<br>
				${decoreOut.department.name}
			</td>
			<c:set value="${customer.customerBussi.carSeriy.name}${ customer.customerBussi.carModel.name }" var="carModel"></c:set>
			<td title="${carModel} ${customer.carModelStr}" style="text-align: left;">
				${customer.customerBussi.brand.name } ${carModel} ${customer.carModelStr}
				<c:if test="${!empty(customer.customerPidBookingRecord.carColor) }">
					${customer.customerPidBookingRecord.carColor.name }	
				</c:if>
				${customerPidBookingRecord.vinCode}
			</td>
			<td>
				${decoreOutProduct.productName}
			</td>
			<td>
				${decoreOutProduct.num}
			</td>
			<td>
				${product.costPrice}
			</td>
			<td>
				<span style="color: red">${product.costPrice*decoreOutProduct.num}</span>
			</td>
			<td>
				${decoreOutProduct.purchasePrice}
			</td>
			<td>
				<span style="color: red">${decoreOutProduct.purchasePrice*decoreOutProduct.num}</span>
			</td>
			<td>
				${decoreOutProduct.salerPrice}
			</td>
			<td>
				<span style="color: red">${decoreOutProduct.salerPrice*decoreOutProduct.num}</span>
			</td>
			<td>
				${decoreOutProduct.price}
			</td>
			<td>
				<span style="color: red">${decoreOutProduct.price*decoreOutProduct.num}</span>
			</td>
		</tr>
	</c:forEach>
</table>
<div id="fanye">
	<%@ include file="../../commons/commonPagination.jsp" %>
</div>
</c:if>
</body>
<script type="text/javascript" src="${ctx }/widgets/bootstrap3/jquery.min.js"></script>
<script type="text/javascript" src="${ctx }/widgets/utile/utile.js"></script>
<script type="text/javascript" src="${ctx }/widgets/easyvalidator/js/easy_validator.pack.js"></script>
<script type="text/javascript" src="${ctx }/widgets/artDialog/artDialog.js?skin=default"></script>
<script type="text/javascript" src="${ctx }/widgets/artDialog/plugins/iframeTools.source.js"></script>
<script type="text/javascript">
function exportExcel(searchFrm){
 	var params;
 	if(null!=searchFrm&&searchFrm!=undefined&&searchFrm!=''){
 		params=$("#"+searchFrm).serialize();
 	}
 	window.location.href='${ctx}/decoreOutProduct/exportExcel?'+params;
 }
</script>
</html>