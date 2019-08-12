<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="../../commons/taglib.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html lang="en">
<head>
<title>成交客户管理</title>
<meta charset="UTF-8" />
<meta name="viewport" content="width=device-width, initial-scale=1.0" />
<link href="${ctx }/css/common.css" type="text/css" rel="stylesheet"/>
<script type="text/javascript" src="${ctx }/widgets/bootstrap3/jquery.min.js"></script>
<script type="text/javascript" src="${ctx }/widgets/utile/utile.js"></script>
<script type="text/javascript" src="${ctx }/widgets/easyvalidator/js/easy_validator.pack.js"></script>
<script type="text/javascript" src="${ctx }/widgets/artDialog/artDialog.js?skin=default"></script>
<script type="text/javascript" src="${ctx }/widgets/artDialog/plugins/iframeTools.source.js"></script>
<script type="text/javascript" src="${ctx }/widgets/My97DatePicker/WdatePicker.js"></script>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
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
		<a class="but button" href="javascript:void();" onclick="operatorLocation('${ctx }/customerFile/index')">客户档案信息</a>
   </div>
  	<div class="seracrhOperate">
  		<form name="searchPageForm" id="searchPageForm"  action="${ctx}/customerPidBookingRecord/customerSuccess" method="post" >
		<input type="hidden" id="currentPage" name="currentPage" value='${page.currentPageNo}'>
		<input type="hidden" id="paramPageSize" name="pageSize" value='${page.pageSize}'>
		<table cellpadding="0" cellspacing="0" class="searchTable" >
			<tr>
  				<td><label>类型：</label></td>
  				<td>
  					<select class="text small" id="customerTypeId" name="customerTypeId"  onchange="$('#searchPageForm')[0].submit()">
						<option value="0" >请选择...</option>
						<c:forEach var="customerType" items="${customerTypes }">
							<option value="${customerType.dbid }" ${param.customerTypeId==customerType.dbid?'selected="selected"':'' } >${customerType.name }</option>
						</c:forEach>
					</select>
  				</td>
  				<td><label>来源：</label></td>
  				<td>
  					<select class="text small" id="customerInfromId" name="customerInfromId"  onchange="$('#searchPageForm')[0].submit()">
						<option value="0" >请选择...</option>
						${customerInfromSelect}
					</select>
  				</td>
  				<td><label>品牌：</label></td>
  				<td>
  					<select class="text small" id="brandId" name="brandId"  onchange="$('#searchPageForm')[0].submit()">
						<option value="0" >请选择...</option>
						<c:forEach var="brand" items="${brands }">
							<option value="${brand.dbid }" ${param.brandId==brand.dbid?'selected="selected"':'' } >${brand.name }</option>
						</c:forEach>
					</select>
  				</td>
  				<td><label>车系：</label></td>
  				<td>
  					<select class="text small" id="carSeriyId" name="carSeriyId"  onchange="$('#searchPageForm')[0].submit()">
						<option value="0" >请选择...</option>
						<c:forEach var="carSeriy" items="${carSeriys }">
							<option value="${carSeriy.dbid }" ${param.carSeriyId==carSeriy.dbid?'selected="selected"':'' } >${carSeriy.name }</option>
						</c:forEach>
					</select>
  				</td>
  			</tr>
  			<tr>
  				<td><label>车型：</label></td>
  				<td>
  					<select class="text small" id="carModelId" name="carModelId"  onchange="$('#searchPageForm')[0].submit()">
						<option value="0" >请选择...</option>
						<c:forEach var="carModel" items="${carModels }">
							<option value="${carModel.dbid }" ${param.carModelId==carModel.dbid?'selected="selected"':'' } >${carModel.name }</option>
						</c:forEach>
					</select>
  				</td>
  					<td><label>意向级别：</label></td>
  				<td>
  					<select class="text small" id="customerPhaseId" name="customerPhaseId"  onchange="$('#searchPageForm')[0].submit()">
						<option value="0" >请选择...</option>
						<c:forEach var="customerPhase" items="${customerPhases }">
							<option value="${customerPhase.dbid }" ${param.customerPhaseId==customerPhase.dbid?'selected="selected"':'' } >${customerPhase.name }</option>
						</c:forEach>
					</select>
  				</td>
  				<td><label>到店状态：</label></td>
  				<td>
  					<select class="small text" id="comeShopStatus" name="comeShopStatus" onchange="$('#searchPageForm')[0].submit()" >
						<option value="-1">请选择...</option>
						<option value="1" ${param.comeShopStatus==1?'selected="selected"':''} >未到店</option>
						<option value="2" ${param.comeShopStatus==2?'selected="selected"':''}>首次到店</option>
						<option value="3" ${param.comeShopStatus==3?'selected="selected"':''}>二次到店</option>
					</select>
				</td>
  				<td><label>是否试驾：</label></td>
  				<td>
  					<select class="small text" id="tryCarStatus" name="tryCarStatus" onchange="$('#searchPageForm')[0].submit()" >
						<option value="">请选择...</option>
						<option value="1" ${param.tryCarStatus==1?'selected="selected"':''}>未试驾</option>
						<option value="2" ${param.tryCarStatus==2?'selected="selected"':''}>已试驾</option>
					</select>
				</td>
  			</tr>
  			<tr>
  				<td><label>姓名：</label></td>
  				<td><input type="text" id="name" name="name" class="text small" value="${param.name}"></input></td>
  				<td><label>常用手机号：</label></td>
  				<td><input type="text" id="mobilePhone" name="mobilePhone" class="text small" value="${param.mobilePhone}"></input></td>
  				<td><label>开始时间：</label></td>
  				<td>
  					<input class="small text" id="startTime" name="startTime" onFocus="WdatePicker({isShowClear:true,readOnly:true})" value="${param.startTime }" >
  				</td>
  				<td><label>~</label></td>
  				<td>
  					<input class="small text" id="endTime" name="endTime" onFocus="WdatePicker({isShowClear:true,readOnly:true})" value="${param.endTime }">
  				</td>
   			</tr>
   			<tr>
   				<td><label>订单时间：</label></td>
  				<td>
  					<input class="small text" id="startOrderTime" name="startOrderTime" onFocus="WdatePicker({isShowClear:true,readOnly:true})" value="${param.startOrderTime }" >
  				</td>
  				<td><label>~</label></td>
  				<td>
  					<input class="small text" id="endOrderTime" name="endOrderTime" onFocus="WdatePicker({isShowClear:true,readOnly:true})" value="${param.endOrderTime }">
  				</td>
  				<td><label>归档日期开始：</label></td>
  				<td>
  					<input class="small text" id="startSuccessTime" name="startSuccessTime" onFocus="WdatePicker({isShowClear:true,readOnly:true})" value="${param.startSuccessTime }" >
				</td>
  				<td><label>结束：</label></td>
  				<td>
  					<input class="small text" id="endSuccessTime" name="endSuccessTime" onFocus="WdatePicker({isShowClear:true,readOnly:true})" value="${param.endSuccessTime }">
  				</td>
   			</tr>
   			<tr>
  				<td><label>VIN码：</label></td>
  				<td><input type="text" id="vinCode" name="vinCode" class="text small" value="${param.vinCode}"></input></td>
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
			<td style="width: 80px;">姓名</td>
			<td style="width: 40px;">类型</td>
			<td style="width:60px;">来源</td>
			<td style="width:160px;">车型</td>
			<td style="width: 100px;">部门</td>
			<td style="width: 60px">VIN码</td>
			<td style="width: 60px">进店状态</td>
			<td style="width: 60px">试驾状态</td>
			<td style="width: 100px;">定金</td>
			<td style="width: 100px;">订单金额</td>
			<td style="width: 100px;">订单日期</td>
			<td style="width: 80px;">创建时间</td>
			<td style="width: 80px;">归档时间</td>
			<td style="width: 120px;">操作</td>
		</tr>
	</thead>
	<tbody>
		<c:forEach items="${page.result }" var="customer">
		<c:set value="${customer.orderContract }" var="orderContract"></c:set>
		<tr>
			<td style="text-align: center;">
					<input type="checkbox"   name="id" id="id1" value="${customer.dbid }">
			</td>
			<td style="text-align: left">
				<div class="dropDownContent" onmousemove="fn(this,event)" onmouseout="hiden(this)">
					${customer.name }<br>
					${customer.mobilePhone }
					<div class="drop_down_menu hiden" onmousemove="show(this)" onmouseout="hi(this)" >
					    <ul>
					       	  <li><a href="javascript:void(-1)" class="aedit" onclick="window.open('${ctx}/orderContract/printContract?dbid=${customer.orderContract.dbid }')">补打合同</a> </li>
						      <li>	<a href="javascript:void(-1)" class="aedit" onclick="window.location.href='${ctx}/orderContract/viewOrderContract?dbid=${customer.orderContract.dbid }'">查看订单</a> </li>
						      <li><a href="javascript:void(-1)" class="aedit" onclick="window.location.href='${ctx}/outboundOrder/viewIndex?customerId=${customer.dbid}'">查看出库</a> </li>
						      <li><a href="javascript:void(-1)" class="aedit" onclick="window.location.href='${ctx}/customer/customerFile?dbid=${customer.dbid}&type=1'">客户综合信息</a> </li>
					    </ul>
					  </div>
				</div>
			</td>
			<td>
				${customer.customerType.name }
			</td>
			<td>
				${customer.customerInfrom.name }
			</td>
			<c:set value="${customer.customerBussi.carSeriy.name}${ customer.customerBussi.carModel.name }" var="carModel"></c:set>
			<td title="${carModel }${customer.carModelStr}${customer.carModelStr}">
				${customer.customerBussi.brand.name}
				<c:if test="${fn:length(carModel)>16 }" var="status">
					${fn:substring(carModel,0,16) }...
				</c:if>
				<c:if test="${ status==false}">
					${carModel }${customer.carModelStr}
				</c:if>
				${customer.carModelStr}
			</td>
			<td>
				${customer.department.name }<br>
				${customer.bussiStaff}
			</td>
			<td>
				${customer.customerPidBookingRecord.vinCode }
			</td>
			<td>
				<c:if test="${customer.comeShopStatus==1||empty(customer.comeShopStatus)}">
					未到店				
				</c:if>
				<c:if test="${customer.comeShopStatus==2 }">
					<span style="color: red;">首次到店</span>			
				</c:if>
				<c:if test="${customer.comeShopStatus==3 }">
					<span style="color: red;">二次到店</span>			
				</c:if>
				<br>
			</td>
			<td>
				<c:if test="${customer.tryCarStatus==1||empty(customer.tryCarStatus)}">
					未试驾				
				</c:if>
				<c:if test="${customer.tryCarStatus==2 }">
					<span style="color: red;">已试驾</span>			
				</c:if>
			</td>
			<td>
				${orderContract.orderMoney}
			</td>
			<td>
				${orderContract.totalPrice}
			</td>
			<td>
				<fmt:formatDate value="${orderContract.createTime }"/>
			</td>
			<td>
				<fmt:formatDate value="${customer.createFolderTime }"/>
			</td>
			<td>
				<fmt:formatDate value="${customer.customerPidBookingRecord.modifyTime }"/>
			</td>
			<td>
				<a style="color: #2b7dbc" href="#" class="aedit" onclick="$.utile.operatorDataByDbid('${ctx}/customerPidBookingRecord/cancelCustomerFile?customerId=${customer.dbid }','searchPageForm','提示：确定撤销客户归档吗？撤销归档请在订单列表查看客户')">撤销归档</a>
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
