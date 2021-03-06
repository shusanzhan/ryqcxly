<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="../../commons/taglib.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html lang="en">
<head>
<title>来客登记记录</title>
<meta charset="UTF-8" />
<meta name="viewport" content="width=device-width, initial-scale=1.0" />
<link href="${ctx }/css/common.css" type="text/css" rel="stylesheet"/>
<script type="text/javascript" src="${ctx }/widgets/bootstrap3/jquery.min.js"></script>
<script type="text/javascript" src="${ctx }/widgets/utile/utile.js"></script>
<script type="text/javascript" src="${ctx }/widgets/easyvalidator/js/easy_validator.pack.js"></script>
<script type="text/javascript" src="${ctx }/widgets/artDialog/artDialog.js?skin=twitter"></script>
<script type="text/javascript" src="${ctx }/widgets/artDialog/plugins/iframeTools.source.js"></script>
<script type="text/javascript" src="${ctx }/widgets/My97DatePicker/WdatePicker.js"></script>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
</head>
<body class="bodycolor">
<div class="location">
	<img src="${ctx}/images/homeIcon.png"/> &nbsp;
	<a href="javascript:void(-1);" onclick="window.parent.location.href='${ctx}/main/index'">首页</a>-
	<a href="javascript:void(-1);" onclick="">来客登记记录</a>
</div>
<!--location end-->
<div class="line"></div>
<div class="listOperate" style="	height: auto;padding: 6px 1px 6px 1px">
	<div class="operate">
		<a class="but button" href="javascript:void();" onclick="exportExcel('searchPageForm')">导出excel</a>
		<%-- <a class="but button" href="javascript:void();" onclick="window.location.href='${ctx}/turnCustomerRecord/add'">转单</a> --%>
   </div>
   	<div class="clear" style="clear: both;"></div>
</div>
<div class="listOperate" style="	height: auto;">
   <div class="seracrhOperate" >
  		<form name="searchPageForm" id="searchPageForm"  action="${ctx}/custCustomer/customerLeaderShoppingRecordqueryList" method="post" >
		<input type="hidden" id="currentPage" name="currentPage" value='${page.currentPageNo}'>
		<input type="hidden" id="paramPageSize" name="pageSize" value='${page.pageSize}'>
		<table cellpadding="0" cellspacing="0" class="searchTable" >
			<tr height="40">
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
				<td><label>意向级别：</label></td>
  				<td>
  					<select class="text small" id="customerPhaseId" name="customerPhaseId"  onchange="$('#searchPageForm')[0].submit()">
						<option value="0" >请选择...</option>
						<c:forEach var="customerPhase" items="${customerPhases }">
							<option value="${customerPhase.dbid }" ${param.customerPhaseId==customerPhase.dbid?'selected="selected"':'' } >${customerPhase.name }</option>
						</c:forEach>
					</select>
  				</td>
  			
			</tr>
			<tr>
  				<td><label>成交结果：</label></td>
  				<td>
  					<select class="text small" id="lastResult" name="lastResult"  onchange="$('#searchPageForm')[0].submit()">
						<option value="-1" >请选择...</option>
						<option value="0" ${param.lastResult==0?'selected="selected"':'' } >客户创建</option>
						<option value="1"  ${param.lastResult==1?'selected="selected"':'' }>成交购车</option>
						<option value="2"  ${param.lastResult==2?'selected="selected"':'' }>购买其他品牌产品等</option>
						<option value="3"  ${param.lastResult==3?'selected="selected"':'' }>购车计划取消</option>
					</select>
  				</td>
  				<td><label>信息来源：</label></td>
  				<td>
  					<select class="text small" id="customerInfromId" name="customerInfromId"  onchange="$('#searchPageForm')[0].submit()">
						<option value="-1" >请选择...</option>
						${customerInfromSelect }
					</select>
  				</td>
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
	  				<td><label>试乘试驾：</label></td>
	  				<td>
	  					<select class="small text" id="tryCarStatus" name="tryCarStatus" onchange="$('#searchPageForm')[0].submit()" >
							<option value="">请选择...</option>
							<option value="1" ${param.tryCarStatus==1?'selected="selected"':''}>未试驾</option>
							<option value="2" ${param.tryCarStatus==2?'selected="selected"':''}>已试驾</option>
						</select>
	  				</td>
  				</tr>
  				<tr height="40">
  					<td><label>到店状态：</label></td>
	  				<td>
	  					<select class="small text" id="comeShopStatus" name="comeShopStatus" onchange="$('#searchPageForm')[0].submit()" >
							<option value="-1">请选择...</option>
							<option value="1" ${param.comeShopStatus==1?'selected="selected"':''} >未到店</option>
							<option value="2" ${param.comeShopStatus==2?'selected="selected"':''}>首次到店</option>
							<option value="3" ${param.comeShopStatus==3?'selected="selected"':''}>二次到店</option>
						</select>
					</td>
  				<td><label>部门：</label></td>
  				<td>
  					<select id="departmentId" name="departmentId"  class="text small" onchange="$('#searchPageForm')[0].submit()">
						<option value="">请选择...</option>
						${departmentSelect }
					</select>
				</td>
  				<td><label>销售顾问：</label></td>
  				<td>
  					<input class="small text" id="userName" name="userName"  value="${param.userName }" >
				</td>
  				<td><label>姓名：</label></td>
  				<td>
  					<input class="small text" id="name" name="name"  value="${param.name }" >
  				</td>
   			</tr>
			<tr>
  				<td><label>电话：</label></td>
  				<td>
  					<input class="small text" id="mobilePhone" name="mobilePhone"  value="${param.mobilePhone }" >
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
				<td><label>客户流失审批状态：</label></td>
  				<td>
  				<select class="small text" id="approvalStatus" name="approvalStatus" onchange="$('#searchPageForm')[0].submit()" >
					<option value="-1">请选择...</option>
					<option value="0" ${param.approvalStatus==0?'selected="selected"':''}>待审批</option>
					<option value="1" ${param.approvalStatus==1?'selected="selected"':''}>同意</option>
					<option value="2" ${param.approvalStatus==2?'selected="selected"':''}>驳回</option>
				</select>
				</td>
  			</tr>
  			<tr>
  				<td><label>开始时间：</label></td>
  				<td>
  					<input class="small text" id="startTime" name="startTime" onFocus="WdatePicker({isShowClear:true,readOnly:true})" value="${param.startTime }" >
				</td>
  				<td><label>结束时间：</label></td>
  				<td>
  					<input class="small text" id="endTime" name="endTime" onFocus="WdatePicker({isShowClear:true,readOnly:true})" value="${param.endTime }">
  				</td>
  				<td><label>试驾开始：</label></td>
  				<td>
  					<input class="small text" id="tryCarStartTime" name="tryCarStartTime" onFocus="WdatePicker({isShowClear:true,readOnly:true})" value="${param.tryCarStartTime }" >
				</td>
  				<td><label>结束时间：</label></td>
  				<td>
  					<input class="small text" id="tryCarEndTime" name="tryCarEndTime" onFocus="WdatePicker({isShowClear:true,readOnly:true})" value="${param.tryCarEndTime }">
  				</td>
  			</tr>
  			<tr>
  					<td><label>来店开始：</label></td>
  				<td>
  					<input class="small text" id="comeShopStartTime" name="comeShopStartTime" onFocus="WdatePicker({isShowClear:true,readOnly:true})" value="${param.comeShopStartTime }" >
				</td>
  				<td><label>结束时间：</label></td>
  				<td>
  					<input class="small text" id="comeShopEndTime" name="comeShopEndTime" onFocus="WdatePicker({isShowClear:true,readOnly:true})" value="${param.comeShopEndTime }">
  				</td>
  				<td><label>审批时间开始：</label></td>
  				<td>
  					<input class="small text" id="approvalStartDate" name="approvalStartDate" onFocus="WdatePicker({isShowClear:true,readOnly:true})" value="${param.approvalStartDate }" >
				</td>
  				<td><label>审批结束时间：</label></td>
  				<td>
  					<input class="small text" id="approvalEndDate" name="approvalEndDate" onFocus="WdatePicker({isShowClear:true,readOnly:true})" value="${param.approvalEndDate }">
  				</td>
  				<td><div href="javascript:void(-1)" onclick="$('#searchPageForm')[0].submit()" class="searchIcon"></div></td>
  			</tr>
  			
   		</table>
   		</form>
   	</div>
   	<div class="clear" style="clear: both;"></div>
</div>

<c:if test="${empty(page.result)||page.result==null }" var="status">
	<div class="alert alert-info" style="margin-top: 20px;">
		<strong>提示!</strong> 当前未添加数据.
	</div>
</c:if>
<c:if test="${status==false }">
<table width="100%" border="0" class="mainTable" cellpadding="0" cellspacing="0">
	<thead>
		<tr>
			<td style="width: 100px;">姓名</td>
			<td style="width:120px;">车型</td>
			<td style="width:60px;">指导价格</td>
			<td style="width: 60px;">初次级别</td>
			<td style="width: 60px;">当前级别</td>
			<td style="width: 60px;">业务员</td>
			<td style="width: 60px;">类型</td>
			<td style="width: 80px;">成交结果</td>
			<td style="width: 60px">进店状态</td>
			<td style="width: 60px">试驾状态</td>
			<td style="width: 60px">互动次数</td>
			<c:if test="${systemInfo.dccInvationAndRecpStatus==2 }">
				<td style="width: 80px;">邀约/谈判人</td>
			</c:if>
			<td style="width: 80px;">创建时间</td>
		</tr>
	</thead>
	<tbody>
		<c:forEach items="${page.result }" var="customer">
		<tr>
			<td style="text-align: left;">
				<div class="dropDownContent" onmousemove="fn(this,event)" onmouseout="hiden(this)">
					${customer.name }
					${customer.mobilePhone}
					<div class="drop_down_menu hiden" onmousemove="show(this)" onmouseout="hi(this)" >
					    <ul>
					      <li class="drop_down_menu_active"><a href="javascript:void(-1)" class="aedit" onclick="window.location.href='${ctx}/custCustomer/customerFile?dbid=${customer.dbid}&type=1'">客户信息</a></li>
					      <li ><a href="javascript:void(-1)" class="aedit" onclick="window.location.href='${ctx }/factoryOrder/factoryOrderDetail?dbid=${factoryOrder.dbid}&type=4'">车辆日志</a></li>
					    </ul>
					  </div>
				</div>
			</td>
			<c:set value="${customer.customerBussi.brand.name}${customer.customerBussi.carSeriy.name} ${ customer.customerBussi.carModel.name }" var="carModel"></c:set>
			<td title="${carModel}  ${customer.carModelStr}">
					${carModel}  ${customer.carModelStr}
			</td>
			<td>
				${customer.customerBussi.carModel.navPrice }
			</td>
			<td>
				${customer.firstCustomerPhase.name}
			</td>
			<td>
				${customer.customerPhase.name}
			</td>
			<td>
				${customer.bussiStaff}<br>
				${customer.department.name }
			</td>
			<td>
				${customer.customerType.name }
				【${customer.customerInfrom.name }】
			</td>
			<td>
				<c:if test="${customer.lastResult==0 }">
					创建客户
				</c:if>
				<c:if test="${customer.lastResult==1 }">
					<span style="color: blue;">成交购车</span> 
				</c:if>
				<c:if test="${customer.lastResult==2 }">
					<span style="color: red;">流失购买其他品牌</span>
				</c:if>
				<c:if test="${customer.lastResult==3 }">
					<span style="color: red;">购车计划取消</span>
				</c:if>
				<br>
				<c:if test="${customer.customerLastBussi.approvalStatus==2 }">
					<span style="color: red;" title="">客户流失驳回,审批时间：<fmt:formatDate value="${customer.customerLastBussi.approvalDate}" pattern="yyyy-MM-dd HH:mm"/> ,原因：${customer.customerLastBussi.notReason },</span>
				</c:if>
			</td>
			<td>
				<c:if test="${customer.comeShopStatus==1||empty(customer.comeShopStatus)}">
					未到店				
				</c:if>
				<c:if test="${customer.comeShopStatus==2 }">
					<span style="color: red;">首次到店</span>	<br>			
					<fmt:formatDate value="${customer.comeShopDate }" pattern="yyyy-MM-dd"/>			
				</c:if>
				<c:if test="${customer.comeShopStatus==3 }">
					<span style="color: red;">二次到店</span>	<br>			
					<fmt:formatDate value="${customer.twoComeShopDate }" pattern="yyyy-MM-dd"/>			
				</c:if>
				<br>
			</td>
			<td>
				<c:if test="${customer.tryCarStatus==1||empty(customer.tryCarStatus)}">
					未试驾				
				</c:if>
				<c:if test="${customer.tryCarStatus==2 }">
					<span style="color: red;">已试驾</span><br>	
					<fmt:formatDate value="${customer.tryCarDate }" pattern="yyyy-MM-dd"/>			
				</c:if>
			</td>
			<td>
				${customer.trackNum }
			</td>
			<c:if test="${systemInfo.dccInvationAndRecpStatus==2 }">
				<td>
					${customer.invitationSalerName }/${customer.receptierSalerName }
				</td>
			</c:if>
			<td>
				<fmt:formatDate value="${customer.createFolderTime }"/>
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
function exportExcel(searchFrm){
	var params;
	if(null!=searchFrm&&searchFrm!=undefined&&searchFrm!=''){
		params=$("#"+searchFrm).serialize();
	}
	window.location.href='${ctx}/custCustomer/exportExcel?'+params;
}
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
