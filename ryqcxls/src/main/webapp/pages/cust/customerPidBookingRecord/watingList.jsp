<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="../../commons/taglib.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html lang="en">
<head>
<title>代交车客户管理</title>
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
	<a href="javascript:void(-1);" onclick="">客户管理</a>
</div>
<!--location end-->
<div class="line"></div>
<div class="listOperate">
	<div class="operate">
		<a class="but button" href="javascript:void();" onclick="operator('${ctx }/customer/handerOverCar')">交车确认单</a>
		<a class="but button" href="javascript:void();" onclick="operatorLocation('${ctx }/customerFile/index')">客户档案信息</a>
		<a href="javascript:void(-1)" class="but button" onclick="operator('${ctx }/customer/trakingCard')">意向跟踪卡</a> 
   </div>
  	<div class="seracrhOperate">
  		<form name="searchPageForm" id="searchPageForm"  action="${ctx}/customerPidBookingRecord/queryWatingList" method="post" >
		<input type="hidden" id="currentPage" name="currentPage" value='${page.currentPageNo}'>
		<input type="hidden" id="paramPageSize" name="pageSize" value='${page.pageSize}'>
		<table cellpadding="0" cellspacing="0" class="searchTable" >
  			<tr>
  				
  				<td><label>物流部处理状态：</label></td>
  				<td>
  					<select class="midea text" id="wlStatus" name="wlStatus" onchange="$('#searchPageForm')[0].submit()" >
					<option value="">请选择...</option>
						<option value="1" ${param.wlStatus==1?'selected="selected"':'' } >未提交物流部处理</option>
						<option value="2" ${param.wlStatus==2?'selected="selected"':''  }>等待物流部处理</option>
						<option value="3" ${param.wlStatus==3?'selected="selected"':''  }>物流部已处理</option>
					</select>
				</td>
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
			<td style="width: 60px;">姓名</td>
			<td style="width: 60px;">电话</td>
			<td style="width: 50px;">品牌</td>
			<td style="width:180px;">车型</td>
			<td style="width: 70px;">合同状态</td>
			<td style="width: 60px;">物流状态</td>
			<td style="width: 50px;">车源</td>
			<td style="width: 60px;">车架号</td>
			<td style="width: 60px;">奖励</td>
			<td style="width: 80px;">创建时间</td>
			<td style="width: 100px;">操作</td>
		</tr>
	</thead>
	<tbody>
		<c:forEach items="${page.result }" var="customer">
		<tr>
			<td style="text-align: center;">
					<input type="checkbox"   name="id" id="id1" value="${customer.dbid }">
			</td>
			<td>
				<div class="dropDownContent" onmousemove="fn(this,event)" onmouseout="hiden(this)">
					<c:if test="${fn:length(customer.name)>12 }" var="status">
						${fn:substring(customer.name,0,12) }...
					</c:if>
					<c:if test="${status==false }">
						${customer.name }
					</c:if>
					<div class="drop_down_menu hiden" onmousemove="show(this)" onmouseout="hi(this)" >
					    <ul>
					      <li class="drop_down_menu_active"><a href="javascript:void(-1)" class="aedit" onclick="window.location.href='${ctx}/customer/edit?dbid=${customer.dbid}&parentMenu=1'">编辑明细</a></li>
					      <li><a href="javascript:void(-1)" class="aedit" onclick="$.utile.openDialog('${ctx}/customerTrack/add?customerId=${customer.dbid }','添加跟进记录',900,500)">添加跟进记录</a> </li>
					      <li><a href="javascript:void(-1)" class="aedit" onclick="window.open('${ctx}/orderContract/viewApprovalRecord?dbid=${customer.orderContract.dbid }')">订单审批记录</a></li>
					      <li><a href="javascript:void(-1)" class="aedit" onclick="window.open('${ctx}/orderContract/printContract?dbid=${customer.orderContract.dbid }')">补打合同</a> </li>
					       <li><a href="javascript:void(-1)" class="aedit" onclick="window.location.href='${ctx}/customer/customerFile?dbid=${customer.dbid}&type=1'">客户综合信息</a> </li>
					    </ul>
					  </div>
				</div>
			</td>
			<td>
				${customer.mobilePhone}
			</td>
			<td>
				${customer.customerBussi.brand.name}
			</td>
			<c:set value="${customer.customerBussi.carSeriy.name}${ customer.customerBussi.carModel.name }${customer.customerLastBussi.carColor.name }${customer.carColorStr}" var="carModel"></c:set>
			<td title="${carModel }${customer.carModelStr}">
				<c:if test="${fn:length(carModel)>28 }" var="status">
					${fn:substring(carModel,0,28) }...
				</c:if>
				<c:if test="${ status==false}">
					${carModel }${customer.carModelStr}
				</c:if>
			</td>
			<td>
				<c:if test="${customer.customerPidBookingRecord.pidStatus==1 }">
					<span style="color: blue">已打印合同</span>
				</c:if>
				<c:if test="${customer.customerPidBookingRecord.pidStatus==2 }">
					<span style="color: blue">已经归档</span>
				</c:if>
				<c:if test="${customer.customerPidBookingRecord.pidStatus==3 }">
					<span style="color: #DD9A4B;">合同流失待审批</span>
				</c:if>
				<c:if test="${customer.customerPidBookingRecord.pidStatus==4 }">
					<span style="color: #DD9A4B;">合同流失</span>
				</c:if>
				<c:if test="${customer.customerPidBookingRecord.pidStatus==5 }">
					<span style="color: red;">审批驳回</span>
				</c:if>
			</td>
			
			<td>
				
				<c:if test="${customer.customerPidBookingRecord.wlStatus==0 }">
					<span class="dropDownContent">未提交</span>
				</c:if>
				<c:if test="${customer.customerPidBookingRecord.wlStatus==1 }">
					<span style="color: red;" class="dropDownContent">等待处理</span>
				</c:if>
				<c:if test="${customer.customerPidBookingRecord.wlStatus==2 }">
					<span class="dropDownContent" onclick="$.utile.openDialog('${ctx}/customerPidBookingRecord/viewWlbCustomerPidRecord?customerId=${customer.dbid }','查看处理记录',1024,380)">已经处理</span>
				</c:if>
			</td>
			<td>
				<c:if test="${customer.customerPidBookingRecord.hasCarOrder==1 }">
					<span style="color: blue;">现车订单</span>
				</c:if>
				<c:if test="${customer.customerPidBookingRecord.hasCarOrder==2 }">
					<span style="color: green;">在途订单</span>
				</c:if>
				<c:if test="${customer.customerPidBookingRecord.hasCarOrder==3 }">
					<span style="color: red;">无车订单</span>
				</c:if>
			</td>
			<td>
					<a href="${ctx }/factoryOrder/factoryOrderDetail?vinCode=${customer.customerPidBookingRecord.vinCode}&type=1">${customer.customerPidBookingRecord.vinCode}</a>
					<c:if test="${customer.customerPidBookingRecord.outStockCheckStatus==2 }">
						<div class="seal"></div>
					</c:if>
			</td>
			<td>
				${customer.customerPidBookingRecord.rewardMoney }
			</td>
			<td>
				<fmt:formatDate value="${customer.createFolderTime }"/>
			</td>
			<td style="text-align: center;">
				<c:if test="${customer.customerPidBookingRecord.pidStatus==1||customer.customerPidBookingRecord.pidStatus==5 }">
					<a href="javascript:void(-1)" class="aedit" onclick="$.utile.openDialog('${ctx}/customerPidBookingRecord/orderContractCancel?customerId=${customer.dbid }','合同流失申请',720,380)">合同流失申请</a>
				</c:if>
				<c:if test="${customer.customerPidBookingRecord.pidStatus>=3 }">
					<a href="javascript:void(-1)" class="aedit" onclick="window.location.href='${ctx}/processRun/viewCpidProcessFrom?customerId=${customer.dbid }'" title="查看审批记录">审批记录</a>
				</c:if>
				<%-- <c:if test="${customer.customerPidBookingRecord.pidStatus==5 }">
					<a href="javascript:void(-1)" class="aedit" onclick="$.utile.operatorDataByDbid('${ctx }/customerPidBookingRecord/cancelContract?customerId=${customer.dbid }','searchPageForm','提示：合同流失后该客户将会还原成来店登记客户，同时删除该客户合同记录，客户意向等级降为【A】级，请慎重操作！')">合同流失</a>
					<br>
					<a href="javascript:void(-1)" class="aedit" onclick="$.utile.operatorDataByDbid('${ctx }/customerPidBookingRecord/turnBackContract?customerId=${customer.dbid }','searchPageForm','提示：撤销合同流失变更为合同有效状态！')">撤销合同流失</a>
				</c:if>
				<ystech:emptyOrderExpressTag customerId="${customer.dbid }"/> --%>
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
