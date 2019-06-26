<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="../../commons/taglib.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html lang="en">
<head>
<title>车料调配管理</title>
<meta charset="UTF-8" />
<meta name="viewport" content="width=device-width, initial-scale=1.0" />
<link href="${ctx }/css/common.css" type="text/css" rel="stylesheet"/>
<script type="text/javascript" src="${ctx }/widgets/bootstrap3/jquery.min.js"></script>
<script type="text/javascript" src="${ctx }/widgets/utile/utile.js"></script>
<script type="text/javascript" src="${ctx }/widgets/easyvalidator/js/easy_validator.pack.js"></script>
<script type="text/javascript" src="${ctx }/widgets/artDialog/artDialog.js?skin=default"></script>
<script type="text/javascript" src="${ctx }/widgets/artDialog/plugins/iframeTools.source.js"></script>
<script type="text/javascript" src="${ctx }/widgets/My97DatePicker/WdatePicker.js"></script>
<style type="text/css">
	.seal{
	background-image: url("${ctx}/images/xwqr/seal40.png");
	height: 17px;
	width: 40px;
	position: relative;
}
</style>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<script type="text/javascript">
function order(val){
	$("#appOrder").val("");
	$("#orderNum").val(val);
	$('#searchPageForm')[0].submit();
}
function appOrder(val){
	$("#appOrder").val(val);
	$("#orderNum").val("");
	$('#searchPageForm')[0].submit();
}
document.onkeydown=function(event){ 
	 e = event ? event :(window.event ? window.event : null); 
	 if(e.keyCode==13){ 
		 if(e.keyCode==13){
			 $('#searchPageForm')[0].submit(); //处理事件
		 }
	 } 
}  
</script>
</head>
<body class="bodycolor">
<div class="location">
	<img src="${ctx}/images/homeIcon.png"/> &nbsp;
	<a href="javascript:void(-1);" onclick="window.parent.location.href='${ctx}/main/index'">首页</a>-
	<a href="javascript:void(-1);" onclick="">车辆调配管理</a>
</div>
<!--location end-->
<div class="line"></div>
<div class="listOperate">
	<div class="operate">
		<%-- <a class="but button" href="javascript:void();" onclick="operatorLocation('${ctx }/customerFile/printKhb')">客户档案</a> 
		<a class="but button" href="javascript:void();" onclick="operatorLocation('${ctx }/customerFile/printKhb')">打印出库单</a>
	   <a href="javascript:void(-1)" class="but button" onclick="operator('${ctx }/paymentConfirmation/printPaymentConfirmation')">打印交款确认单</a>
	   <a href="javascript:void(-1)" class="but button" onclick="operator('${ctx }/paymentConfirmation/printDecoreNotice')">打印附加通知单</a>--%>
	     <a href="javascript:void(-1)" class="but button" onclick="exportExcel('searchPageForm')">导出excel</a>
   </div>
  	<div class="seracrhOperate" style="margin-top: 12px;">
  		<form name="searchPageForm" id="searchPageForm"  action="${ctx}/customerPidBookingRecord/queryWlbWatingList" method="post" >
		<input type="hidden" id="currentPage" name="currentPage" value='${page.currentPageNo}'>
		<input type="hidden" id="paramPageSize" name="pageSize" value='${page.pageSize}'>
		<c:if test="${empty(param.orderNum) }">
			<input type="hidden" id="orderNum" name="orderNum" value=''>
		</c:if>
		<c:if test="${!empty(param.orderNum) }">
			<input type="hidden" id="orderNum" name="orderNum" value='${param.orderNum }'>
		</c:if>
		<c:if test="${empty(param.appOrder) }">
			<input type="hidden" id="appOrder" name="appOrder" value=''>
		</c:if>
		<c:if test="${!empty(param.appOrder) }">
			<input type="hidden" id="appOrder" name="appOrder" value='${param.appOrder }'>
		</c:if>
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
  				<td><label>部门：</label></td>
  				<td>
  					<select class="text small" id="departmentId" name="departmentId"  onchange="$('#searchPageForm')[0].submit()">
						<option value="0" >请选择...</option>
							${departmentSelect }
					</select>
  				</td>
  				<td><label>审批状态：</label></td>
  				<td>
  					<select id="pidStatus" name="pidStatus"  class="text small" onchange="$('#searchPageForm')[0].submit()">
						<option value="">请选择...</option>
						<option value="1" ${param.pidStatus==1?'selected="selected"':''  }>发起交车</option>
						<option value="3" ${param.pidStatus==3?'selected="selected"':''  }>合同流失申请</option>
						<option value="5" ${param.pidStatus==4?'selected="selected"':''  }>合同流驳回</option>
					</select>
  				</td>
  			</tr>
  			<tr>
  				<td><label>销售顾问：</label></td>
  				<td><input type="text" id="userName" name="userName" class="text small" value="${param.userName}"></input></td>
  				<td><label>处理状态：</label></td>
  				<td>
  					<select id="wlStatus" name="wlStatus"  class="text small" onchange="$('#searchPageForm')[0].submit()">
						<option value="">请选择...</option>
						<option value="1" ${param.wlStatus==1?'selected="selected"':''  }>等待物流部处理</option>
						<option value="2" ${param.wlStatus==2?'selected="selected"':''  }>物流部已处理</option>
					</select>
  				</td>
  				<td><label>车源状态：</label></td>
  				<td>
  					<select id="hasCarOrder" name="hasCarOrder"  class="text small" onchange="$('#searchPageForm')[0].submit()">
						<option value="">请选择...</option>
						<option value="1" ${param.hasCarOrder==1?'selected="selected"':''  }>现车订单</option>
						<option value="2" ${param.hasCarOrder==2?'selected="selected"':''  }>在途订单</option>
						<option value="3" ${param.hasCarOrder==3?'selected="selected"':''  }>无车订单</option>
					</select>
  				</td>
  				<td><label>名称：</label></td>
  				<td><input type="text" id="name" name="name" class="text small" value="${param.name}"></input></td>
  				<td><label>车架号：</label></td>
  				<td><input type="text" id="paramVinCode" name="paramVinCode" class="text small" value="${param.paramVinCode}"></input></td>
  				<td><label>创建日期：</label></td>
  				<td colspan="1">
  					<input class="text small" id="startTime" name="startTime" onFocus="WdatePicker({isShowClear:true,readOnly:true})" value="${param.startTime }" >~
  					<input class="text small" id="endTime" name="endTime" onFocus="WdatePicker({isShowClear:true,readOnly:true})" value="${param.endTime }">
				</td>
  				<td><div href="javascript:void(-1)" onclick="$('#searchPageForm')[0].submit()" class="searchIcon"></div></td>
   			</tr>
   		</table>
   		</form>
   	</div>
   	<div style="clear: both;"></div>
</div>

<c:if test="${empty(page.result)||page.result==null }" var="status">
	<div class="alert alert-info" style="margin-top: 50px;">
		<strong>提示!</strong> 当前未添加数据.
	</div>
</c:if>
<c:if test="${status==false }">
<table width="100%" border="0" class="mainTable" cellpadding="0" cellspacing="0" style="margin-top: 20px;">
	<thead>
		<tr>
			<td style="width: 20px;"><div class="checker" id="uniform-title-table-checkbox">
					<span><input type="checkbox" name="title-table-checkbox" id="title-table-checkbox" onclick="selectAll(this,'id')"></span>
				</div></td>
			<td style="width: 60px;">姓名</td>
			<td style="width:160px;">车型</td>
			<td style="width:60px;">指导价</td>
			<td style="width: 60px;">部门</td>
			<td style="width: 60px;">经销商类型</td>
			<td style="width: 60px;">业务员</td>
			<td style="width: 80px;">合同状态</td>
			<td style="width: 100px;">创建日期</td> 
			<c:if test="${empty(param.orderNum) }">
				<td style="width: 70px;">
				<a href="javascript:void(-1)" onclick="order(1)" class="dropDownContent" style="font-weight: normal;">
					预约时间
					<span style="color: red;font-size: 14px;">↓</span>
				</a>
				</td>	
			</c:if>
			<c:if test="${!empty(param.orderNum) }">
				<c:if test="${param.orderNum==2 }">
					<td style="width: 70px;">
						<a href="javascript:void(-1)" onclick="order(1)" class="dropDownContent" style="font-weight: normal;">
							预约时间
							<span style="color: red;font-size: 14px;">↓</span>	
						</a>
					</td>	
				</c:if>
				<c:if test="${param.orderNum==1 }">
					<td style="width: 70px;">
						<a href="javascript:void(-1)" onclick="order(2)" class="dropDownContent" style="font-weight: normal;">
							预约时间
							<span style="color: red;font-size: 14px;">↑</span>	
						</a>
					</td>	
				</c:if>
			</c:if>
			<td style="width: 80px;">处理状态</td>
			<td style="width: 60px;">车源状态</td>
			<td style="width:80px;">车架号</td>
			<c:if test="${empty(param.appOrder) }">
				<td style="width: 70px;">
				<a href="javascript:void(-1)" onclick="appOrder(1)" class="dropDownContent" style="font-weight: normal;">
					处理时间
					<span style="color: red;font-size: 14px;">↓</span>	
				</a>
				</td>	
			</c:if>
			<c:if test="${!empty(param.appOrder) }">
				<c:if test="${param.appOrder==2 }">
					<td style="width: 70px;">
						<a href="javascript:void(-1)" onclick="appOrder(1)" class="dropDownContent" style="font-weight: normal;">
							处理时间
							<span style="color: red;font-size: 14px;">↓</span>	
						</a>
					</td>	
				</c:if>
				<c:if test="${param.appOrder==1 }">
					<td style="width: 70px;">
						<a href="javascript:void(-1)" onclick="appOrder(2)" class="dropDownContent" style="font-weight: normal;">
							处理时间
							<span style="color: red;font-size: 14px;">↑</span>	
						</a>
					</td>	
				</c:if>
			</c:if>
			<td style="width: 80px;">操作</td>
		</tr>
	</thead>
	<tbody>
		<c:forEach items="${page.result }" var="customer">
		<tr>
			<td style="text-align: center;">
					<input type="checkbox"   name="id" id="id1" value="${customer.dbid }">
			</td>
			<td align="left" style="text-align: left;">
				<div class="dropDownContent" onmousemove="fn(this,event)" onmouseout="hiden(this)">
					<c:if test="${fn:length(customer.name)>12 }" var="status">
						${fn:substring(customer.name,0,12) }...
						<br>
						${customer.mobilePhone }
					</c:if>
					<c:if test="${status==false }">
						${customer.name }<br>
						${customer.mobilePhone }
					</c:if>
					<div class="drop_down_menu hiden" onmousemove="show(this)" onmouseout="hi(this)" >
					     <ul>
					      <li><a class="drop_down_menu_active" href="javascript:void(-1)" class="aedit" onclick="window.open('${ctx}/orderContract/printContract?dbid=${customer.orderContract.dbid }&type=1')">查看合同</a> </li>
										<c:if test="${customer.customerPidBookingRecord.hasCarOrder==1&&customer.customerPidBookingRecord.outStockCheckStatus==2}">
											<%--  <li><a href="javascript:void(-1)" class="aedit" onclick="$.utile.operatorDataByDbid('${ctx}/customerPidBookingRecord/customerFile?customerId=${customer.dbid }','searchPageForm','提示：确定将选择客户设置为归档客户吗？')">归档客户</a> </li> --%>
											<li><a href="javascript:void(-1)" class="aedit"
												onclick="$.utile.openDialog('${ctx}/customerPidBookingRecord/toCutomerFile?customerId=${customer.dbid }','归档客户',960,500)">归档客户</a>
											</li>
										</c:if>
										<li>	<a href="javascript:void(-1)" class="aedit" onclick="window.location.href='${ctx}/orderContract/viewOrderContract?dbid=${customer.orderContract.dbid }'">查看订单</a> </li>
					       <li><a href="javascript:void(-1)" class="aedit" onclick="window.location.href='${ctx}/customer/customerFile?dbid=${customer.dbid}&type=1'">客户综合信息</a> </li>
					    </ul>
					  </div>
				</div>
			</td>
			<c:set value="${customer.customerBussi.carSeriy.name}${ customer.customerBussi.carModel.name }" var="carModel"></c:set>
			<td title="${carModel}  ${customer.carModelStr}" style="text-align: left;">
				${customer.customerBussi.brand.name } ${carModel}  ${customer.carModelStr}
				<c:if test="${!empty(customer.customerPidBookingRecord.carColor) }">
					${customer.customerPidBookingRecord.carColor.name }	
				</c:if>
				${customer.carColorStr}
			</td>
			<td>
				${customer.customerBussi.carModel.navPrice }
			</td>
			<td>
				${customer.department.name }
			</td>
			<td>
				<c:if test="${customer.customerType==1 }">
					自有店
				</c:if>
				<c:if test="${customer.customerType==2 }">
					<br>
					${customer.distributor.shortName }
					<c:if test="${customer.distributor.type==1 }">
						(合作)
					</c:if>
					<c:if test="${customer.distributor.type==2 }">
						(非合作)
					</c:if>
				</c:if>
			</td>
			<td>
				${customer.user.realName}
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
			<td style="text-align: left;">
				<fmt:formatDate value="${customer.customerPidBookingRecord.createTime }" pattern="yyyy-MM-dd"/>
			</td>
			<td style="text-align: left;">
				<fmt:formatDate value="${customer.customerPidBookingRecord.bookingDate }" pattern="yyyy-MM-dd"/>
			</td>
			<td>
				<c:if test="${customer.customerPidBookingRecord.wlStatus==1 }">
					<span style="color: red;">等待处理</span>
				</c:if>
				<c:if test="${customer.customerPidBookingRecord.wlStatus==2 }">
					<span style="color:blue;">已经处理</span>
				</c:if>
			</td>
			<td>
				<c:if test="${customer.customerPidBookingRecord.hasCarOrder==1 }">
					<span style="color: blue;">现车订单</span>
				</c:if>
				<c:if test="${customer.customerPidBookingRecord.hasCarOrder==2 }">
					<span style="color:green;">在途订单</span>
				</c:if>
				<c:if test="${customer.customerPidBookingRecord.hasCarOrder==3 }">
					<span style="color: red;">无车订单</span>
				</c:if>
			</td>
			<td>
				<a class="aedit" style="color: #2b7dbc" href="${ctx }/factoryOrder/factoryOrderDetail?vinCode=${customer.customerPidBookingRecord.vinCode}&type=1">${customer.customerPidBookingRecord.vinCode }</a>
				<br>
				<c:if test="${customer.customerPidBookingRecord.kdStatus==2 }">
					<span style="color: blue;">等待卖家确认</span>
				</c:if>
				<c:if test="${customer.customerPidBookingRecord.kdStatus==3 }">
					<span style="color:green;">卖家同意</span>
				</c:if>
			</td>
			<td style="text-align: left;">
				<fmt:formatDate value="${customer.customerPidBookingRecord.wlCreateTime }" pattern="yyyy-MM-dd HH:mm"/>
				<c:if test="${customer.customerPidBookingRecord.outStockCheckStatus==2 }">
					<div class="seal"></div>
				</c:if>
				<c:if test="${customer.customerPidBookingRecord.outStockCheckStatus==1 }">
					<span style="color: red;">未核查</span>
				</c:if>
			</td>
			<td style="text-align: center;">
					<!-- 交车预约处于未处理状态 -->
					<c:if test="${customer.customerPidBookingRecord.wlStatus==1 }">
						<a href="javascript:void(-1)" class="aedit" onclick="window.location.href='${ctx}/customerPidBookingRecord/wlbEdit?customerId=${customer.dbid }'">交车预约</a>
					</c:if>
					<c:if test="${customer.customerPidBookingRecord.wlStatus==2 }">
						<c:if test="${empty(customer.customerPidBookingRecord.vinCode)&&fn:length(customer.customerPidBookingRecord.vinCode)<=0 }" var="status">
							<a href="javascript:void(-1)" class="aedit" onclick="window.location.href='${ctx}/customerPidBookingRecord/wlbEdit?customerId=${customer.dbid }'">绑车架号</a>
							<br>
						</c:if>
						<c:if test="${status==false }">
							<c:set value="" var="message"></c:set>
							<c:if test="${customer.customerPidBookingRecord.kdStatus==2 }">
								<c:set value="由于车辆是跨店绑车，释放车架号将删除跨店绑车申请记录，重置已经绑车量车状态。" var="message"></c:set>
							</c:if>
							<c:if test="${customer.customerPidBookingRecord.kdStatus==3 }">
								<c:set value="由于车辆是跨店绑车，释放车架号将删除跨店绑车申请记录，重置已经绑车量状态。" var="message"></c:set>
							</c:if>
							
							<a href="javascript:void(-1)" class="aedit" onclick="$.utile.operatorDataByDbid('${ctx }/customerPidBookingRecord/cancelVinCode?pidDbid=${customer.customerPidBookingRecord.dbid}','searchPageForm','确定释放【${customer.customerPidBookingRecord.vinCode }】车架号码？释放后该订单将转为无车订单状态，如需分配车辆请重新绑定！${message }')">释放车架号</a>
						</c:if>
					</c:if>
					<br>
					<c:if test="${!empty(customer.customerPidBookingRecord.vinCode) }">
						<c:if test="${customer.customerPidBookingRecord.kdStatus!=2 }">
							<a href="javascript:void(-1)" class="aedit" onclick="window.location.href='${ctx}/outboundOrder/index?customerId=${customer.dbid }&modifyType=1'">核查出库单</a>
						</c:if>
						<br>
						<a href="javascript:void(-1)" class="aedit" onclick="window.location.href='${ctx}/customerPidBookingRecord/wlbEdit?customerId=${customer.dbid }'">编辑预约</a>
					</c:if>
			</td>
		</tr>
		</c:forEach>
	</tbody>
</table>
</c:if>
<div id="fanye">
	<%@ include file="../../commons/commonPagination.jsp" %>
</div>
<br>
<br>
<br>
<br>
<br>
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
	 function exportExcel(searchFrm){
		 	var params;
		 	if(null!=searchFrm&&searchFrm!=undefined&&searchFrm!=''){
		 		params=$("#"+searchFrm).serialize();
		 	}
		 	window.location.href='${ctx}/customerPidBookingRecord/exportCustomerPidExcel?'+params;
		 }
	
</script>
</html>
