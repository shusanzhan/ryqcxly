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
<script type="text/javascript" src="${ctx }/widgets/My97DatePicker/WdatePicker.js"></script>
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
<div class="listOperate">
  	<div class="seracrhOperate">
  		<form name="searchPageForm" id="searchPageForm"  action="${ctx}/orderContract/queryManagerOrder" method="post" >
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
				<td><label>颜色：</label></td>
  				<td>
  					<select class="text small" id="carColorId" name="carColorId"  onchange="$('#searchPageForm')[0].submit()">
						<option value="0" >请选择...</option>
						<c:forEach var="carColor" items="${carColors }">
							<option value="${carColor.dbid }" ${param.carColorId==carColor.dbid?'selected="selected"':'' } >${carColor.name }</option>
						</c:forEach>
					</select>
  				</td>
	  			<td><label>销售顾问：</label></td>
  				<td>
  					<input class="small text" id="userName" name="userName"  value="${param.userName }" >
  				</td>
				</tr>
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
  				<td><label>试乘试驾：</label></td>
  				<td>
  					<select class="small text" id="tryCarStatus" name="tryCarStatus" onchange="$('#searchPageForm')[0].submit()" >
						<option value="">请选择...</option>
						<option value="1" ${param.tryCarStatus==1?'selected="selected"':''}>未试驾</option>
						<option value="2" ${param.tryCarStatus==2?'selected="selected"':''}>已试驾</option>
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
  				<td><label>客户名称：</label></td>
  				<td>
  					<input class="small text" id="name" name="name"  value="${param.name }" >
  				</td>
				</tr>
				<tr>
  				<td><label>电话：</label></td>
  				<td>
  					<input class="small text" id="mobilePhone" name="mobilePhone"  value="${param.mobilePhone }" >
  				</td>
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
  				<td><label>订单开始：</label></td>
  				<td>
  					<input class="small text" id="startOrderTime" name="startOrderTime" onFocus="WdatePicker({isShowClear:true,readOnly:true})" value="${param.startOrderTime }" >
				</td>
  				<td><label>订单结束：</label></td>
  				<td>
  					<input class="small text" id="endOrderTime" name="endOrderTime" onFocus="WdatePicker({isShowClear:true,readOnly:true})" value="${param.endOrderTime }">
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
			<td style="width: 60px;">名称</td>
			<td style="width: 40px;">类型</td>
			<td style="width:60px;">来源</td>
			<td style="width:160px;">车型</td>
			<td style="width:80px;">指导价格</td>
			<td style="width: 60px;">初/当级别</td>
			<td style="width: 100px;">部门</td>
			<td style="width: 60px">互动次数</td>
			<td style="width: 60px">进店状态</td>
			<td style="width: 60px">试驾状态</td>
			<td style="width: 80px;">创建时间</td>
			<td style="width: 80px;">订单时间</td>
		</tr>
	</thead>
	<tbody>
		<c:forEach items="${page.result }" var="orderContract">
		<c:set var="customer" value="${orderContract.customer }"></c:set>
		<tr>
			<%-- <td style="text-align: center;">
					<input type="checkbox"   name="id" id="id1" value="${orderContract.dbid }">
			</td> --%>
			<td style="text-align: left;">
				<div class="dropDownContent" onmousemove="fn(this,event)" onmouseout="hiden(this)">
					${customer.name }<br>
					${customer.mobilePhone}
					<div class="drop_down_menu hiden" onmousemove="show(this)" onmouseout="hi(this)" >
					    <ul>
					      <li class="drop_down_menu_active"><a href="javascript:void(-1)" class="aedit" onclick="window.location.href='${ctx}/customer/customerFile?dbid=${customer.dbid}&type=1'">客户信息</a></li>
					      <li ><a href="javascript:void(-1)" class="aedit" onclick="window.location.href='${ctx}/customer/customerFile?dbid=${customer.dbid}&type=4'">客户日志</a></li>
					      <li ><a href="javascript:void(-1)" class="aedit" onclick="window.location.href='${ctx}/customer/customerFile?dbid=${customer.dbid}&type=3'">跟踪记录</a></li>
					      <li ><a href="javascript:void(-1)" class="aedit" onclick="window.location.href='${ctx}/orderContract/viewApprovalRecord?dbid=${customer.orderContract.dbid }'">合同记录</a></li>
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
				${customer.customerBussi.carModel.navPrice }${customer.navPrice }
			</td>
			<td>
				${customer.firstCustomerPhase.name}/
				${customer.customerPhase.name}
			</td>
			<td>
				${customer.department.name }<br>
				${customer.bussiStaff}
			</td>
			<td>
				${customer.trackNum }
			</td>
			<td>
				<c:if test="${customer.comeShopStatus==1||empty(customer.comeShopStatus)}">
					未到店				
				</c:if>
				<c:if test="${customer.comeShopStatus==2 }">
					<span style="color: red;">首次到店</span><br>	
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
				<fmt:formatDate value="${customer.createFolderTime }"/>
			</td>
			<td>
				<fmt:formatDate value="${orderContract.createTime }" pattern="yyyy-MM-dd HH:mm"/>
			</td>
		</tr>
		</c:forEach>
	</tbody>
</table>
</c:if>
<div id="fanye">
	<%@ include file="../../commons/commonPagination.jsp" %>
</div>
<script type="text/javascript">
function exportExcel(searchFrm){
	var params;
	if(null!=searchFrm&&searchFrm!=undefined&&searchFrm!=''){
		params=$("#"+searchFrm).serialize();
	}
	window.location.href='${ctx}/customer/exportExcel?'+params;
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
</body>
</html>
