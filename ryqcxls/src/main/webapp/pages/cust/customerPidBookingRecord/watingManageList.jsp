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
<script type="text/javascript" src="${ctx }/widgets/My97DatePicker/WdatePicker.js"></script>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
</head>
<body class="bodycolor">
<div class="location">
	<img src="${ctx}/images/homeIcon.png"/> &nbsp;
	<a href="javascript:void(-1);" onclick="window.parent.location.href='${ctx}/main/index'">首页</a>-
	<a href="javascript:void(-1);" onclick="">代交车管理</a>
</div>
<!--location end-->
<div class="line"></div>
<div class="listOperate">
	<%-- <div class="operate">
		<a class="but button" href="javascript:void();" onclick="operator('${ctx }/customer/handerOverCar')">交车确认单</a>
		<a class="but button" href="javascript:void();" onclick="operator('${ctx }/customer/customerFolder')">客户综合信息</a>
		<a href="javascript:void(-1)" class="but button" onclick="operator('${ctx }/customer/trakingCard')">意向跟踪卡</a> 
   </div> --%>
  	<div class="seracrhOperate">
  		<form name="searchPageForm" id="searchPageForm"  action="${ctx}/customerPidBookingRecord/queryManageWatingList" method="post" >
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
  					<input type="text" id="userName" name="userName" class="text small" value="${param.userName}"></input>
				</td>
  				<td><label>物流部处理状态：</label></td>
  				<td>
  					<select class="small text" id="wlStatus" name="wlStatus" onchange="$('#searchPageForm')[0].submit()" >
					<option value="-1">请选择...</option>
						<option value="0" ${param.wlStatus==0?'selected="selected"':'' } >未提交物流部处理</option>
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
					<td><label>审批状态：</label></td>
  				<td>
  					<select id="pidStatus" name="pidStatus"  class="text small" onchange="$('#searchPageForm')[0].submit()">
						<option value="">请选择...</option>
						<option value="1" ${param.pidStatus==1?'selected="selected"':''  }>打印合同</option>
						<option value="3" ${param.pidStatus==3?'selected="selected"':''  }>等待展厅经理审批</option>
						<option value="4" ${param.pidStatus==4?'selected="selected"':''  }>展厅经理同意合同流失</option>
						<option value="5" ${param.pidStatus==5?'selected="selected"':''  }>总/副总经理同意合同流失</option>
						<option value="6" ${param.pidStatus==6?'selected="selected"':''  }>总/副总经理驳回合同流失</option>
						<option value="7" ${param.pidStatus==7?'selected="selected"':''  }>展厅经理驳回合同流失</option>
					</select>
  				</td>
  				<td><label>创建日期开始：</label></td>
  				<td>
  					<input class="small text" id="startTime" name="startTime" onFocus="WdatePicker({isShowClear:true,readOnly:true})" value="${param.startTime }" >
				</td>
  				<td><label>结束：</label></td>
  				<td>
  					<input class="small text" id="endTime" name="endTime" onFocus="WdatePicker({isShowClear:true,readOnly:true})" value="${param.endTime }">
  				</td>
  				
  				<td><label>常用手机号：</label></td>
  				<td><input type="text" id="mobilePhone" name="mobilePhone" class="text small" value="${param.mobilePhone}"></input></td>
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
			<!-- <td style="width: 20px;"><div class="checker" id="uniform-title-table-checkbox">
					<span><input type="checkbox" name="title-table-checkbox" id="title-table-checkbox" onclick="selectAll(this,'id')"></span>
				</div></td> -->
			<td style="width: 60px;">编号</td>
			<td style="width: 60px;">姓名</td>
			<td style="width: 80px;">电话</td>
			<td style="width:160px;">车型</td>
			<td style="width: 80px;">部门</td>
			<td style="width: 60px;">业务员</td>
			<td style="width: 60px;">车源状态</td>
			<td style="width: 80px;">合同流失状态</td>
			<td style="width: 80px;">物流部处理状态</td>
			<td style="width: 80px;">创建时间</td>
			<td style="width: 100px;">操作</td>
		</tr>
	</thead>
	<tbody>
		<c:forEach items="${page.result }" var="customer">
		<tr>
			<%-- <td style="text-align: center;">
					<input type="checkbox"   name="id" id="id1" value="${customer.dbid }">
			</td> --%>
			<td>
				<a href="javascript:void(-1)" class="aedit" onclick="window.location.href='${ctx}/customer/customerFile?dbid=${customer.dbid}&type=1'" title="点击查看客户档案明细">${customer.sn }</a>
			</td>
			<td>
				<a href="javascript:void(-1)" class="aedit" onclick="window.location.href='${ctx}/customer/customerFile?dbid=${customer.dbid}&type=1'" title="点击查看客户档案明细">
					<c:if test="${fn:length(customer.name)>12 }" var="status">
						${fn:substring(customer.name,0,12) }...
					</c:if>
					<c:if test="${status==false }">
						${customer.name }
					</c:if>
				</a>
			</td>
			<td>
				${customer.mobilePhone}
			</td>
			<c:set value="${customer.customerBussi.carSeriy.name}${ customer.customerBussi.carModel.name }" var="carModel"></c:set>
			<td title="${carModel }${customer.carModelStr}">
				<%-- <c:if test="${fn:length(carModel)>8 }" var="status">
					${fn:substring(carModel,0,8) }...
				</c:if>
				<c:if test="${ status==false}"> --%>
					${carModel }${customer.carModelStr}
				<%-- </c:if> --%>
			</td>
			<td>${customer.department.name }</td>
			<td>
				${customer.bussiStaff}
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
				<c:if test="${customer.customerPidBookingRecord.pidStatus==1 }">
					<span style="color: blue">已打印合同</span>
				</c:if>
				<c:if test="${customer.customerPidBookingRecord.pidStatus==3 }">
					<span style="color: #DD9A4B;">等待展厅经理审批</span>
				</c:if>
				<c:if test="${customer.customerPidBookingRecord.pidStatus==4 }">
					<span style="color: #DD9A4B;">展厅经理同意合同流失</span>
				</c:if>
				<c:if test="${customer.customerPidBookingRecord.pidStatus==5 }">
					<span style="color: blue;">总/副总经理同意合同流失</span>
				</c:if>
				<c:if test="${customer.customerPidBookingRecord.pidStatus==6 }">
					<span style="color: red;">总/副总经理驳回合同流失</span>
				</c:if>
				<c:if test="${customer.customerPidBookingRecord.pidStatus==7 }">
					<span style="color: red;">展厅经理驳回合同流失</span>
				</c:if>
			</td>
			<td>
				<c:if test="${customer.customerPidBookingRecord.wlStatus==0 }">
					<span>未提交物流信息</span>
				</c:if>
				<c:if test="${customer.customerPidBookingRecord.wlStatus==1 }">
					<span style="color: red;">等待处理</span>
				</c:if>
				<c:if test="${customer.customerPidBookingRecord.wlStatus==2 }">
					<span style="color:blue;">已经处理</span>
				</c:if>
			</td>
			<td>
				<fmt:formatDate value="${customer.customerPidBookingRecord.createTime }" pattern="yyyy-MM-dd HH:mm"/>
			</td>
			<td style="text-align: center;">
				<c:if test="${customer.customerPidBookingRecord.pidStatus==4 }">
					<a href="javascript:void(-1)" class="aedit" onclick="window.location.href='${ctx}/customerPidBookingRecord/approvalManageOrderContractCancel?customerId=${customer.dbid }&type=1'">合同流失审批</a>
				</c:if>
				<c:if test="${customer.customerPidBookingRecord.pidStatus>3 }">
					<a href="javascript:void(-1)" class="aedit" onclick="window.location.href='${ctx}/customerPidBookingRecord/approvalDetail?customerId=${customer.dbid }'" title="查看审批记录">查看审批记录</a>
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
