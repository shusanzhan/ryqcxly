<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="../../commons/taglib.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html lang="en">
<head>
<title>客户订单管理</title>
<meta charset="UTF-8" />
<meta name="viewport" content="width=device-width, initial-scale=1.0" />
<link href="${ctx }/css/common.css" type="text/css" rel="stylesheet"/>
<script type="text/javascript" src="${ctx }/widgets/bootstrap3/jquery.min.js"></script>
<script type="text/javascript" src="${ctx }/widgets/utile/utile.js"></script>
<script type="text/javascript" src="${ctx }/widgets/easyvalidator/js/easy_validator.pack.js"></script>
<script type="text/javascript" src="${ctx }/widgets/artDialog/artDialog.js?skin=default"></script>
<script type="text/javascript" src="${ctx }/widgets/artDialog/plugins/iframeTools.source.js"></script>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
</head>
<body class="bodycolor">
<div class="location">
	<img src="${ctx}/images/homeIcon.png"/> &nbsp;
	<a href="javascript:void(-1);" onclick="window.parent.location.href='${ctx}/main/index'">首页</a>-
	<a href="javascript:void(-1);" onclick="">客户订单记录</a>
</div>
<!--location end-->
<div class="line"></div>
<div class="alert alert-error">
		<strong>提示!</strong> 
		需要修改的订单，需先点击【取消订单】后进行重新创建！
</div>
<div class="listOperate">
  	<div class="seracrhOperate">
  		<form name="searchPageForm" id="searchPageForm"  action="${ctx}/orderContract/queryList" method="post" >
		<input type="hidden" id="currentPage" name="currentPage" value='${page.currentPageNo}'>
		<input type="hidden" id="paramPageSize" name="pageSize" value='${page.pageSize}'>
		<table cellpadding="0" cellspacing="0" class="searchTable" >
  			<tr>
  				<td><label>审批状态：</label></td>
  				<td>
 				<select id="status" name="status"  class="text midea" onchange="$('#searchPageForm')[0].submit()">
					<option value="">请选择...</option>
					<option value="1" ${param.status==1?'selected="selected"':'' } >审批中...</option>
					<option value="2" ${param.status==2?'selected="selected"':'' } >同意</option>
					<option value="3" ${param.status==3?'selected="selected"':'' } >驳回</option>
				</select>
  				</td>
  				<td><label>客户姓名：</label></td>
  				<td><input type="text" id="name" name="name" class="text midea" value="${param.name}"></input></td>
  				<td><label>常用手机号：</label></td>
  				<td><input type="text" id="mobilePhone" name="mobilePhone" class="text midea" value="${param.mobilePhone}"></input></td>
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
			<td style="width: 60px;">名称</td>
			<td style="width: 140px;">车型</td>
			<td style="width: 80px;">合同金额</td>
			<td style="width: 80px;">定金</td>
			<td style="width: 80px;">客户等级</td>
			<td style="width: 80px;">合同时间</td>
			<td style="width: 80px;">业务员</td>
			<td style="width: 80px;">创建时间</td>
			<td style="width: 80px;">审批状态</td>
			<td style="width: 120px;">操作</td>
		</tr>
	</thead>
	<tbody>
		<c:forEach items="${page.result }" var="orderContract">
		<c:set var="customer" value="${orderContract.customer }"></c:set>
		<tr>
			<td style="text-align: center;">
					<input type="checkbox"   name="id" id="id1" value="${orderContract.dbid }">
			</td>
			<td style="text-align: left;">
				<div class="dropDownContent" onmousemove="fn(this,event)" onmouseout="hiden(this)" style="">
					${customer.name }
					<br>
					${customer.mobilePhone}
					<div class="drop_down_menu hiden" onmousemove="show(this)" onmouseout="hi(this)" >
					    <ul>
					      <li class="drop_down_menu_active"><a href="javascript:void(-1)" class="aedit" onclick="window.location.href='${ctx}/customer/edit?dbid=${customer.dbid}&parentMenu=1'">编辑明细</a></li>
					      <li><a href="javascript:void(-1)" class="aedit" onclick="$.utile.openDialog('${ctx}/customerTrack/add?customerId=${customer.dbid }','添加跟进记录',900,500)">添加跟进记录</a> </li>
					      <li><a href="javascript:void(-1)" class="aedit" onclick="window.location.href='${ctx}/customer/customerFile?dbid=${customer.dbid}&type=1'">客户综合信息</a> </li>
					      <li>	<a href="javascript:void(-1)" class="aedit" onclick="window.location.href='${ctx}/orderContract/viewOrderContract?dbid=${orderContract.dbid }'">查看订单</a> </li>
					      <li>		
					      	<c:if test="${orderContract.status!=1}">
								<a href="javascript:void(-1)" class="aedit" onclick="window.location.href='${ctx}/orderContract/viewApprovalRecord?dbid=${orderContract.dbid }'">审批记录</a>
							</c:if> 
						  </li>
					    </ul>
					  </div>
				</div>
			</td>
			<c:set value="${customer.customerBussi.brand.name}${customer.customerBussi.carSeriy.name}${ customer.customerBussi.carModel.name }" var="carModel"></c:set>
			<td title="${carModel}  ${customer.carModelStr}">
					${carModel}  ${customer.carModelStr}
			</td>
			<td>
				${orderContract.totalPrice}
			</td>
			<td>
				${orderContract.orderMoney}
			</td>
			<td>
				${customer.customerPhase.name}
			</td>
			<td>
				<fmt:formatDate value="${orderContract.createTime }"/>
			</td>
			<td>${customer.bussiStaff }</td>
			<td>
				<fmt:formatDate value="${customer.createFolderTime }"/>
			</td>
			<td>
				<c:if test="${orderContract.status==1 }">
					<span style="color: #DD9A4B;">审批中...</span>
				</c:if>
				<c:if test="${orderContract.status==3 }">
					<span style="color: red;">驳回</span>
				</c:if>
				<c:if test="${orderContract.status==2 }">
					<span style="color: green;">同意</span>
				</c:if>
			</td>
			<td style="text-align: center;">
				<c:if test="${orderContract.status==3}">
					 <a href="javascript:void(-1)" class="aedit" onclick="window.location.href='${ctx}/orderContract/addOrderContract?customerId=${customer.dbid }&editType=2'">编辑订单</a> | 
					 <a href="javascript:void(-1)" class="aedit" onclick="$.utile.operatorDataByDbid('${ctx }/orderContract/cancelOrderContract?dbid=${orderContract.dbid}','searchPageForm','提示：取消订单将删除订单信息,最后成交记录信息，并将订单客户还原成最初登记客户,客户等级改为[A]级！')">取消订单</a>
					 <br> 
				</c:if>
				<c:if test="${orderContract.status==2 }">
					<a href="javascript:void(-1)" class="aedit" onclick="window.open('${ctx}/orderContract/printContract?dbid=${orderContract.dbid }')">打印合同</a>|
					<a href="javascript:void(-1)" class="aedit" onclick="window.location.href='${ctx}/customerPidBookingRecord/add?customerId=${customer.dbid }'">交车预约</a>
					<br>
				</c:if>
				<c:if test="${orderContract.status!=0}">
					<a href="javascript:void(-1)" class="aedit" onclick="window.location.href='${ctx}/orderContract/viewApprovalRecord?dbid=${orderContract.dbid }'">审批记录</a>
				</c:if> 
		</tr>
		</c:forEach>
	</tbody>
</table>
</c:if>
<div id="fanye">
	<%@ include file="../../commons/commonPagination.jsp" %>
</div>
</body>
<script type="text/javascript">
	function fn(va){
		var dd=$(".show");
		if(null!=dd){
			$(dd).removeClass("show").addClass("hiden");
		}
		var vs=$(va).find(".drop_down_menu").removeClass("hiden").addClass("show");
	}
	 function hiden(va){
		var vs=$(va).find(".drop_down_menu").removeClass("show").addClass("hiden");
	}
	 function show(va){
		 var vs=$(va).find(".hiden").removeClass("hiden").addClass("show");
			//绑定鼠标在分组类型上的移动
		 $(va).find("li").bind("click",function(){
			$(va).find(".drop_down_menu_active").removeClass("drop_down_menu_active");
			$(this).addClass("drop_down_menu_active");
		})
	 }
	 function hi(va){
		 var vs=$(va).find(".show").removeClass("show").addClass("hiden");
	 }
</script>
</html>
