<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="../../commons/taglib.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html lang="en">
<head>
<title>工厂订单</title>
<meta charset="UTF-8" />
<meta name="viewport" content="width=device-width, initial-scale=1.0" />
<link href="${ctx }/css/common.css" type="text/css" rel="stylesheet"/>
<script type="text/javascript" src="${ctx }/widgets/bootstrap3/jquery.min.js"></script>
<script type="text/javascript" src="${ctx }/widgets/utile/utile.js"></script>
<script type="text/javascript" src="${ctx }/widgets/artDialog/artDialog.js?skin=default"></script>
<script type="text/javascript" src="${ctx }/widgets/artDialog/plugins/iframeTools.source.js"></script>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<style type="text/css">
</style>
</head>
<body class="bodycolor">
<div class="location">
	<img src="${ctx}/images/homeIcon.png"/> &nbsp;
	<a href="javascript:void(-1);" onclick="window.parent.location.href='${ctx}/main/index'">首页</a>-
	<a href="javascript:void(-1);" onclick="">重复数据管理</a>
</div>
 <!--location end-->
<div class="line"></div>
<div class="alert alert-error">
		<strong>提示:</strong>
		<p>请删除冗余数据，保留需要数据！</p>
</div>
<div class="listOperate">
	<div class="operate">
		<a class="but butCancle" href="javascript:void();" onclick="$.utile.deleteIds('${ctx }/factoryOrder/deleteByDu','searchPageForm')">删除</a>
		<a class="but butSave" href="javascript:void();" onclick="window.location.href='${ctx}/factoryOrder/queryList'">返回</a>
   	</div>
  	<div class="seracrhOperate">
   	</div>
   	<div style="clear: both;"></div>
</div>

<c:if test="${empty(factoryOrders)||factoryOrders==null }" var="status">
	<div class="alert alert-info">
		<strong>提示!</strong> 当前未添加数据.
	</div>
</c:if>
<c:if test="${status==false }">
<table width="100%" border="0" class="mainTable" cellpadding="0" cellspacing="0">
	<thead>
		<tr>
			<td style="width: 20px;"><div class="checker" id="uniform-title-table-checkbox">
					<span><input type="checkbox" name="title-table-checkbox" id="title-table-checkbox" onclick="selectAll(this,'id')"></span>
				</div></td>
			<td style="width: 200px;">名称</td>
			<td style="width: 80px;">vin码</td>
			<td style="width: 80px;">物料号</td>
			<td style="width: 50px;">执行价</td>
			<td style="width: 50px;">工厂价</td>
			<td style="width:70px;">工厂日期</td>
			<td style="width:50px;">惠民</td>
			<td style="width:60px;">性质</td>
			<td style="width:60px;">种类</td>
			<td style="width:80px;">创建时间</td>
	</thead>
	<tbody>
		<c:forEach items="${factoryOrders }" var="factoryOrder">
		<tr >
			<td style="text-align: center;">
					<input type="checkbox"   name="id" id="id1" value="${factoryOrder.dbid }">
			</td>
			<td>
				${factoryOrder.carSeriy.name }
				${factoryOrder.carModel.name }
				${factoryOrder.carColor.name }
			</td>
			<td>
				${factoryOrder.vinCode}
			</td>
			<td class="tip" tip="物料描述：${factoryOrder.materialDes}">
				<a href="javascript:void(-1)" class="" style="color: #46A0DE;">${factoryOrder.materialNumber}</a>
			</td>
			<td>
				${factoryOrder.marketPrice}
			</td>
			<td>
				${factoryOrder.factoryPrice}
			</td>
			<td>
				<fmt:formatDate value="${factoryOrder.factoryOrderDate}" pattern="yyyy-MM-dd"/> 
			</td>
			<td>
				${factoryOrder.huimin }
			</td>
			<td>
				${factoryOrder.orderAttr }
			</td>
			<td>
				${factoryOrder.orderType }
			</td>
 
			<td>
				<fmt:formatDate value="${factoryOrder.createDate}" pattern="yyyy-MM-dd"/> 
			</td>
		</tr>
		</c:forEach>
	</tbody>
</table>
</c:if>
<div id="fanye">
	<%@ include file="../../commons/commonPagination.jsp" %>
</div>
</body>
</html>
