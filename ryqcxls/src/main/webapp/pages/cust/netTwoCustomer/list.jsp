<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="../../commons/taglib.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html lang="en">
<head>
<title>交车预约</title>
<meta charset="UTF-8" />
<meta name="viewport" content="width=device-width, initial-scale=1.0" />
<link href="${ctx }/css/common.css" type="text/css" rel="stylesheet"/>
<script type="text/javascript" src="${ctx }/widgets/bootstrap3/jquery.min.js"></script>
<script type="text/javascript" src="${ctx }/widgets/utile/utile.js"></script>
<script type="text/javascript" src="${ctx }/widgets/easyvalidator/js/easy_validator.pack.js"></script>
<script type="text/javascript" src="${ctx }/widgets/artDialog/artDialog.js?skin=default"></script>
<script type="text/javascript" src="${ctx }/widgets/artDialog/plugins/iframeTools.source.js"></script>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<style type="text/css">
	.seal{
	background-image: url("${ctx}/images/xwqr/seal40.png");
	height: 17px;
	width: 40px;
	position: relative;
}
</style>
</head>
<body class="bodycolor">
<div class="location">
	<img src="${ctx}/images/homeIcon.png"/> &nbsp;
	<a href="javascript:void(-1);" onclick="window.parent.location.href='${ctx}/main/index'">首页</a>-
	<a href="javascript:void(-1);" onclick="">交车预约</a>
</div>
 <!--location end-->
<div class="line"></div>

<div class="alert alert-error">
	<strong>提示!</strong> 如填写资料有误，请【撤销订单】后从新创建订单.
</div>
<div class="listOperate">
	<div class="operate">
		<a class="but button" href="javascript:void();" onclick="window.location.href='${ctx}/netTwoCustomer/add'">创建订单</a>
   </div>
  	<div class="seracrhOperate">
  		<form name="searchPageForm" id="searchPageForm"  action="${ctx}/netTwoCustomer/queryList" method="post" >
		<input type="hidden" id="currentPage" name="currentPage" value='${page.currentPageNo}'>
		<input type="hidden" id="paramPageSize" name="pageSize" value='${page.pageSize}'>
		<table cellpadding="0" cellspacing="0" class="searchTable" >
  			<tr>
  				<td><label>客户名称：</label></td>
  				<td>
  					<input type="text" id="name" name="name" value="${param.name }" class="text midea">
				</td>
  				<td><label>手机号码：</label></td>
  				<td>
  					<input type="text" id="mobilePhone" name="mobilePhone" value="${param.mobilePhone }" class="text midea">
				</td>
  				<td><label>处理状态：</label></td>
  				<td>
  					<select id="wlbStatus" name="wlbStatus"  class="text midea" onchange="$('#searchPageForm')[0].submit()">
						<option value="">请选择...</option>
							<option value="1" ${param.wlbStatus==1?'selected="selected"':'' } >未处理</option>
							<option value="2" ${param.wlbStatus==2?'selected="selected"':'' } >已处理</option>
					</select>
				</td>
  				<td><div href="javascript:void(-1)" onclick="$('#searchPageForm')[0].submit()" class="searchIcon"></div></td>
   			</tr>
   		</table>
   		</form>
   	</div>
   		<div style="clear: both;"></div>
</div>

<c:if test="${empty(page.result)||page.result==null }" var="status">
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
			<td style="width: 60px;">客户名称</td>
			<td style="width: 140px;">车型</td>
			<td style="width: 90px;">创建日期</td>
			<td style="width: 80px;">处理状态</td>
			<td style="width: 50px;">车源状态</td>
			<td style="width:80px;">车架号</td>
			<td style="width: 100px;">处理时间</td>
			<td style="width: 100px;">车辆销售商</td>
			<td style="width: 100px;">操作</td>
		</tr>
	</thead>
	<tbody>
		<c:forEach items="${page.result }" var="customer">
		<tr>
			<c:set value="${customer.orderContract }" var="orderContract"></c:set>
			<td style="text-align: center;">
					<input type="checkbox"   name="id" id="id1" value="${customer.dbid }">
			</td>
			<td style="text-align: left;">
				${customer.name }<br>
				${customer.mobilePhone}
			</td>
			<td>
				${customer.customerBussi.brand.name }
				${customer.customerBussi.carSeriy.name }
				${customer.customerBussi.carModel.name }
			</td>
			<c:set var="customerPidBookingRecord" value="${customer.customerPidBookingRecord}"></c:set>
			<td style="text-align: left;">
				<fmt:formatDate value="${customerPidBookingRecord.createTime }" pattern="yyyy-MM-dd HH:mm"/>
			</td>
			<td>
				<c:if test="${customerPidBookingRecord.wlStatus==1 }">
					<span style="color: red;">等待处理</span>
				</c:if>
				<c:if test="${customerPidBookingRecord.wlStatus==2 }">
					<span class="dropDownContent" onclick="$.utile.openDialog('${ctx}/customerPidBookingRecord/viewWlbCustomerPidRecord?customerId=${customer.dbid }','查看处理记录',1024,380)">已经处理</span>
				</c:if>
			</td>
			<td>
				<c:if test="${customerPidBookingRecord.hasCarOrder==1 }">
					<span style="color: blue;">现车订单</span>
				</c:if>
				<c:if test="${customerPidBookingRecord.hasCarOrder==2 }">
					<span style="color:green;">在途订单</span>
				</c:if>
				<c:if test="${customerPidBookingRecord.hasCarOrder==3 }">
					<span style="color: red;">无车订单</span>
				</c:if>
			</td>
			<td>
				<a class="aedit" style="color: #2b7dbc" href="${ctx }/factoryOrder/factoryOrderDetail?vinCode=${customerPidBookingRecord.vinCode}&type=1">${customerPidBookingRecord.vinCode }</a>
			</td>
			<td style="text-align: left;">
				<fmt:formatDate value="${customerPidBookingRecord.wlCreateTime }" pattern="yyyy-MM-dd HH:mm"/>
				<c:if test="${customer.customerPidBookingRecord.outStockCheckStatus==2 }">
					<div class="seal"></div>
				</c:if>
			</td>
			<td style="">
				${customer.distributor.name}
			</td>
			<td style="text-align: center;">
				<c:if test="${empty( customerPidBookingRecord)||customerPidBookingRecord.outStockCheckStatus==1 }">
					<a href="javascript:void(-1)" class="aedit" onclick="window.location.href='${ctx}/netTwoCustomer/edit?customerId=${customer.dbid}'">编辑</a> |
				</c:if> 
				<c:if test="${customerPidBookingRecord.outStockCheckStatus==2 }">
					<a href="javascript:void(-1)" class="aedit" onclick="$.utile.openDialog('${ctx}/netTwoCustomer/updateCustomerIdCard?customerId=${customer.dbid }','快捷维护客户信息',700,300)" title="快捷维护客户信息">快捷维护客户信息</a>
				</c:if>
				<a href="javascript:void(-1)" class="aedit" onclick="window.location.href='${ctx}/orderContract/viewOrderContract?dbid=${customer.orderContract.dbid }'">查看订单</a>|
				<a href="javascript:void(-1)" class="aedit" onclick="$.utile.operatorDataByDbid('${ctx}/netTwoCustomer/delete?customerId=${customer.dbid}','searchPageForm','撤销订单将删除客户的所有信息,如需保留已分配的车辆资源，请先联系物流部。确定删除订单吗？')" title="撤销订单">撤销订单</a>|
				<a href="javascript:void(-1)" class="aedit" onclick="window.open('${ctx}/orderContract/printContract?dbid=${orderContract.dbid }')">打印合同</a>
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
