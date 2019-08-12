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
<script type="text/javascript">
document.onkeydown=function(event){ 
	 e = event ? event :(window.event ? window.event : null); 
	 if(e.keyCode==13){ 
		 if(e.keyCode==13){
			 $('#searchPageForm')[0].submit(); //处理事件
		 }
	 } 
}  
</script>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
</head>
<body class="bodycolor">
<div class="location">
	<img src="${ctx}/images/homeIcon.png"/> &nbsp;
	<a href="javascript:void(-1);" onclick="window.parent.location.href='${ctx}/main/index'">首页</a>-
	<a href="javascript:void(-1);" onclick="">客户回访</a>
</div>
<!--location end-->
<div class="line"></div>
<div class="listOperate">
	<div class="operate">
	   <%-- <a href="javascript:void(-1)" class="but button" onclick="operator('${ctx }/paymentConfirmation/printPaymentConfirmation')">打印交款确认单</a>
	   <a href="javascript:void(-1)" class="but button" onclick="operator('${ctx }/paymentConfirmation/printDecoreNotice')">打印附加通知单</a>
	  <a class="but button" href="javascript:void();" onclick="operatorLocation('${ctx }/customerFile/printKhb')">客户档案信息</a> --%>
   </div>
  	<div class="seracrhOperate">
  		<form name="searchPageForm" id="searchPageForm"  action="${ctx}/visitRecord/customerHf" method="post" >
		<input type="hidden" id="currentPage" name="currentPage" value='${page.currentPageNo}'>
		<input type="hidden" id="paramPageSize" name="pageSize" value='${page.pageSize}'>
		<table cellpadding="0" cellspacing="0" class="searchTable" >
  			<tr>
  				
  				<td><label>部门：</label></td>
  				<td>
  					<select id="departmentId" name="departmentId"  class="text small" onchange="$('#searchPageForm')[0].submit()">
						<option value="">请选择...</option>
						${departmentSelect }
					</select>
				</td>
  				<td><label>销售顾问：</label></td>
  				<td>
  					<input class="small text" id="userName" name="userName"  value="${param.userName }">
				</td>
  				<td><label>归档日期开始：</label></td>
  				<td colspan="1">
  					<input class="text small" id="startTime" name="startTime" onFocus="WdatePicker({isShowClear:true,readOnly:true})" value="${param.startTime }" >~
  					<input class="text small" id="endTime" name="endTime" onFocus="WdatePicker({isShowClear:true,readOnly:true})" value="${param.endTime }">
				</td>
  				</tr>
  				<tr>
  				<td><label>姓名：</label></td>
  				<td><input type="text" id="customerName" name="customerName" class="text small" value="${param.customerName}"></input></td>
  				<td><label>常用手机号：</label></td>
  				<td><input type="text" id="mobilePhone" name="mobilePhone" class="text small" value="${param.mobilePhone}"></input></td>
  				<td><label>vin码：</label></td>
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
			<td style="width: 60px;">vin码</td>
			<td style="width: 80px;">电话</td>
			<td style="width:160px;">车型</td>
			<td style="width: 80px;">所属公司</td>
			<td style="width: 80px;">部门</td>
			<td style="width: 60px;">业务员</td>
			<td style="width: 80px;">成交时间</td>
			<td style="width: 60px;">任务状态</td>
			<td style="width: 80px;">操作</td>
		</tr>
	</thead>
	<tbody>
		<c:forEach items="${page.result }" var="visitRecord">
		<c:set value="${visitRecord.customer }" var="customer"></c:set>
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
						${customer.name }（
						<c:if test="${customer.customerType==1}">
							一网
						</c:if>
						<c:if test="${customer.customerType==2}">
							二网
						</c:if>
						）
					</c:if>
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
				<a class="aedit" style="color: #2b7dbc" href="${ctx }/factoryOrder/factoryOrderDetail?vinCode=${customer.customerPidBookingRecord.vinCode}&type=1">
					${customer.customerPidBookingRecord.vinCode }
				</a>
			</td>
			<td>
				${customer.mobilePhone}
			</td>
			<c:set value="${customer.customerBussi.brand.name}${customer.customerBussi.carSeriy.name}${ customer.customerBussi.carModel.name }" var="carModel"></c:set>
			<td style="text-align: left;" title="${carModel} ${customer.carModelStr}">
				${carModel} ${customer.carModelStr}
			</td>
			<td>${customer.enterprise.name }</td>
			<td>${customer.department.name }</td>
			<td>
				${customer.bussiStaff}
			</td>
			<td>
				<fmt:formatDate value="${visitRecord.fileDate }" pattern="yyyy-MM-dd HH:mm"/>
			</td>
			<td>
				创建任务
			</td>
			<td>
				<a style="color: #2b7dbc" href="#" class="aedit" onclick="window.location.href='${ctx }/visitRecord/add?customerId=${customer.dbid}&directType=1'">回访</a>
				<a style="color: #2b7dbc" href="#" class="aedit" onclick="$.utile.openDialog('${ctx}/visitRecord/updateCustomer?customerId=${customer.dbid }&directType=1','修改客户信息',800,350)">修改客户信息</a>
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
