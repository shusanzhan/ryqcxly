<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="../../commons/taglib.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html lang="en">
<head>
<title>成交客户管理-领导管理</title>
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
	<a href="javascript:void(-1);" onclick="">成交管理</a>
</div>
<!--location end-->
<div class="line"></div>
<div class="listOperate">
	<div class="operate">
		<%-- <a class="but button" href="javascript:void();" onclick="operator('${ctx }/customer/handerOverCar')">交车确认单</a>
		<a class="but button" href="javascript:void();" onclick="operator('${ctx }/customer/customerFolder')">客户综合信息</a>
		<a href="javascript:void(-1)" class="but button" onclick="operator('${ctx }/customer/trakingCard')">意向跟踪卡</a> --%> 
   </div>
  	<div class="seracrhOperate">
  		<form name="searchPageForm" id="searchPageForm"  action="${ctx}/customerPidBookingRecord/customerManageSuccess" method="post" >
		<input type="hidden" id="currentPage" name="currentPage" value='${page.currentPageNo}'>
		<input type="hidden" id="paramPageSize" name="pageSize" value='${page.pageSize}'>
		<table cellpadding="0" cellspacing="0" class="searchTable" >
  			<tr>
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
  				<td><label>车型：</label></td>
  				<td>
  					<select class="text small" id="carModelId" name="carModelId"  onchange="$('#searchPageForm')[0].submit()">
						<option value="0" >请选择...</option>
						<c:forEach var="carModel" items="${carModels }">
							<option value="${carModel.dbid }" ${param.carModelId==carModel.dbid?'selected="selected"':'' } >${carModel.name }</option>
						</c:forEach>
					</select>
  				</td>
  				<td><label>颜色：</label></td>
  				<td>
  					<select class="text small" id="carColorId" name="carColorId"  onchange="$('#searchPageForm')[0].submit()">
						<option value="0" >请选择...</option>
						<c:forEach var="carColor" items="${carColors }">
							<option value="${carColor.dbid }" ${param.carColorId==carColor.dbid?'selected="selected"':'' } >${carColor.name }</option>
						</c:forEach>
					</select>
  				</td>
  			</tr>
  			<tr>
  				<td><label>类型：</label></td>
  				<td>
  					<select class="text small" id="comeType" name="comeType"  onchange="$('#searchPageForm')[0].submit()">
						<option value="-1" >请选择...</option>
						<option value="1" ${param.comeType==1?'selected="selected"':'' } >来店</option>
						<option value="2"  ${param.comeType==2?'selected="selected"':'' }>来电</option>
						<option value="3"  ${param.comeType==3?'selected="selected"':'' }>网销</option>
						<option value="4"  ${param.comeType==4?'selected="selected"':'' }>活动</option>
						<option value="5"  ${param.comeType==5?'selected="selected"':'' }>其他</option>
					</select>
	  				</td>
  				<td><label>信息来源：</label></td>
  				<td>
  					<select class="text small" id="customerInfromId" name="customerInfromId"  onchange="$('#searchPageForm')[0].submit()">
						<option value="-1" >请选择...</option>
						${customerInfromSelect }
					</select>
  				</td>
	  				<td><label>试乘试驾：</label></td>
	  				<td>
	  					<select class="small text" id="tryCarStatus" name="tryCarStatus" onchange="$('#searchPageForm')[0].submit()" >
							<option value="">请选择...</option>
							<option value="1" ${param.tryCarStatus==1?'selected="selected"':''}>未试驾</option>
							<option value="2" ${param.tryCarStatus==2?'selected="selected"':''}>已试驾</option>
						</select>
	  				</td>
	  				<td><label>部门：</label></td>
	  				<td>
	  					<select id="departmentId" name="departmentId"  class="text small" onchange="$('#searchPageForm')[0].submit()">
							<option value="">请选择...</option>
							${departmentSelect }
						</select>
					</td>
  			</tr>
  			<tr>
  				<td><label>vin码：</label></td>
  				<td><input type="text" id="vinCode" name="vinCode" class="text small" value="${param.vinCode}"></input></td>
  				<td><label>销售顾问：</label></td>
  				<td>
  					<input type="text" id="userName" name="userName" class="text small" value="${param.userName}"></input>
				</td>
  				
  				<td><label>姓名：</label></td>
  				<td><input type="text" id="customerName" name="customerName" class="text small" value="${param.customerName}"></input></td>
  				<td><label>常用手机号：</label></td>
  				<td><input type="text" id="mobilePhone" name="mobilePhone" class="text small" value="${param.mobilePhone}"></input></td>
   			</tr>
   			<tr>
  				<td><label>开始时间：</label></td>
  				<td>
  					<input class="small text" id="startTime" name="startTime" onFocus="WdatePicker({isShowClear:true})" value="${param.startTime }" >
				</td>
  				<td><label>结束时间：</label></td>
  				<td>
  					<input class="small text" id="endTime" name="endTime" onFocus="WdatePicker({isShowClear:true})" value="${param.endTime }">
  				</td>
  				<td><label>归档开始：</label></td>
  				<td colspan="1">
  					<input class="text small" id="successStartTime" name="successStartTime" onFocus="WdatePicker({isShowClear:true})" value="${param.successStartTime }" >
  				</td>
  				<td>
  					归档结束
  				</td>
  				<td>
  					<input class="text small" id="successEndTime" name="successEndTime" onFocus="WdatePicker({isShowClear:true})" value="${param.successEndTime }">
				</td>
  			</tr>
  			<tr>
  				<td><label>客户类型：</label></td>
  				<td>
  					<select class="text small" id="customerType" name="customerType"  onchange="$('#searchPageForm')[0].submit()">
						<option value="-1" >请选择...</option>
						<option value="1" ${param.customerType==1?'selected="selected"':'' } >自有店</option>
						<option value="2"  ${param.customerType==2?'selected="selected"':'' }>二网</option>
					</select>
	  			</td>
				<c:if test="${systemInfo.dccInvationAndRecpStatus==2 }">
	  				<td><label>邀约人：</label></td>
	  				<td>
	  					<input class="small text" id="invitationSalerName" name="invitationSalerName"  value="${param.invitationSalerName }" >
	  				</td>
	  				<td><label>谈判人：</label></td>
	  				<td>
	  					<input class="small text" id="receptierSalerName" name="receptierSalerName"  value="${param.receptierSalerName }" >
	  				</td>
				</c:if>
			</tr>
  			<tr>
  				<td><label>试驾开始：</label></td>
  				<td>
  					<input class="small text" id="tryCarStartTime" name="tryCarStartTime" onFocus="WdatePicker({isShowClear:true})" value="${param.tryCarStartTime }" >
				</td>
  				<td><label>结束时间：</label></td>
  				<td>
  					<input class="small text" id="tryCarEndTime" name="tryCarEndTime" onFocus="WdatePicker({isShowClear:true})" value="${param.tryCarEndTime }">
  				</td>
  				<td><label>来店开始：</label></td>
  				<td>
  					<input class="small text" id="comeShopStartTime" name="comeShopStartTime" onFocus="WdatePicker({isShowClear:true})" value="${param.comeShopStartTime }" >
				</td>
  				<td><label>结束时间：</label></td>
  				<td>
  					<input class="small text" id="comeShopEndTime" name="comeShopEndTime" onFocus="WdatePicker({isShowClear:true})" value="${param.comeShopEndTime }">
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
			<td style="width: 60px;">姓名</td>
			<td style="width:120px;">来源</td>
			<td style="width:160px;">车型</td>
			<td style="width:80px;">VIN码</td>
			<td style="width:80px;">初次级别</td>
			<td style="width: 80px;">部门</td>
			<td style="width: 60px;">业务员</td>
			<td style="width: 60px;">奖励金额</td>
			<td style="width: 60px">进店状态</td>
			<td style="width: 60px">试驾状态</td>
			<td style="width: 80px;">创建时间</td>
			<td style="width: 80px;">成交时间</td>
			<c:if test="${systemInfo.dccInvationAndRecpStatus==2 }">
				<td style="width: 80px;">邀约/谈判人</td>
			</c:if>
		</tr>
	</thead>
	<tbody>
		<c:forEach items="${page.result }" var="customer">
		<tr>
			<td style="text-align: left;">
				<div class="dropDownContent" onmousemove="fn(this,event)" onmouseout="hiden(this)">
					<c:if test="${fn:length(customer.name)>12 }" var="status">
						${fn:substring(customer.name,0,12) }...
					</c:if>
					<c:if test="${status==false }">
						${customer.name }
					</c:if>
					<br>
					${customer.mobilePhone}
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
			<td style="text-align: left;">
				<c:if test="${customer.customerType==1 }">
					<c:if test="${customer.type==1 }">
						<span style="color: red;">来店</span>
					</c:if>
					<c:if test="${customer.type==2 }">
						<span style="color:green;">来电</span>
					</c:if>
					<c:if test="${customer.type==3 }">
						<span style="color: blue;">网销</span>
					</c:if>
					<c:if test="${customer.type==4 }">
						<span style="color:orange;">活动</span>
					</c:if>
					<c:if test="${customer.type==5 }">
						<span style="color:orange;">其他</span>
					</c:if>
					<br>
					【${customer.customerInfrom.name }】
				</c:if>
				<c:if test="${customer.customerType==2 }">
					二网
				</c:if>
			</td>
			<c:set value="${customer.customerBussi.carSeriy.name}${ customer.customerBussi.carModel.name }" var="carModel"></c:set>
			<td style="text-align: left;" title="${carModel}  ${customer.carModelStr}">
				${customer.customerBussi.brand.name}
				${customer.customerLastBussi.carSeriy.name}${ customer.customerLastBussi.carModel.name }${ customer.customerLastBussi.carColor.name }
			</td>
			<td>
				${customer.customerPidBookingRecord.vinCode}
			</td>
			<td>${customer.firstCustomerPhase.name }</td>
			<td>
				${customer.successDepartment.name }/${customer.department.name }
			</td>
			<td>
				${customer.bussiStaff}
			</td>
			<td>
				${customer.customerPidBookingRecord.rewardMoney}
			</td>
			<td>
				<c:if test="${customer.comeShopStatus==1||empty(customer.comeShopStatus)}">
					未到店				
				</c:if>
				<c:if test="${customer.comeShopStatus==2 }">
					<span style="color: red;">首次到店</span>			
					<fmt:formatDate value="${customer.comeShopDate }" pattern="yyyy-MM-dd"/>			
				</c:if>
				<c:if test="${customer.comeShopStatus==3 }">
					<span style="color: red;">二次到店</span>			
					<fmt:formatDate value="${customer.twoComeShopDate }" pattern="yyyy-MM-dd"/>			
				</c:if>
				<br>
			</td>
			<td>
				<c:if test="${customer.tryCarStatus==1||empty(customer.tryCarStatus)}">
					未试驾				
				</c:if>
				<c:if test="${customer.tryCarStatus==2 }">
					<span style="color: red;">已试驾</span>
					<fmt:formatDate value="${customer.tryCarDate }" pattern="yyyy-MM-dd"/>			
				</c:if>
			</td>
			<td>
				<fmt:formatDate value="${customer.createFolderTime }" pattern="yyyy-MM-dd HH:mm"/>
			</td>
			<td>
				<fmt:formatDate value="${customer.customerPidBookingRecord.modifyTime }" pattern="yyyy-MM-dd"/>
			</td>
			<c:if test="${systemInfo.dccInvationAndRecpStatus==2 }">
				<td>
					${customer.invitationSalerName }/${customer.receptierSalerName }
				</td>
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
