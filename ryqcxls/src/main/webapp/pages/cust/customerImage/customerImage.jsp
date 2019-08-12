<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="../../commons/taglib.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html lang="en">
<head>
<title>成交客户管理-客户图片</title>
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
	<a href="javascript:void(-1);" onclick="">客户图片</a>
</div>
<!--location end-->
<div class="line"></div>
<div class="listOperate">
	<div class="operate">
		<%--<a class="but button" href="javascript:void(-1)" onclick="window.location.href='${ctx }/customerImage/downZip'">下载图片</a>
		<a class="but button" href="javascript:void();" onclick="operator('${ctx }/custCustomer/customerFolder')">客户综合信息</a>
		<a href="javascript:void(-1)" class="but button" onclick="operator('${ctx }/custCustomer/trakingCard')">意向跟踪卡</a> --%> 
   </div>
  	<div class="seracrhOperate">
  		<form name="searchPageForm" id="searchPageForm"  action="${ctx}/customerImage/customerImage" method="post" >
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
				<td><label>上传状态：</label></td>
  				<td>
  					<select id="status" name="status"  class="text small" onchange="$('#searchPageForm')[0].submit()">
						<option value="">请选择...</option>
						<option value="1" ${param.status==1?'selected="selected"':'' } >待上传</option>
						<option value="2" ${param.status==2?'selected="selected"':'' }>上传中</option>
					</select>
				</td>
				<td><label>交车照片状态：</label></td>
  				<td>
  					<select id="handCarStatus" name="handCarStatus"  class="text small" onchange="$('#searchPageForm')[0].submit()">
						<option value="">请选择...</option>
						<option value="1" ${param.handCarStatus==1?'selected="selected"':'' } >待上传</option>
						<option value="2" ${param.handCarStatus==2?'selected="selected"':'' }>待审批</option>
						<option value="3" ${param.handCarStatus==3?'selected="selected"':'' }>重新上传</option>
						<option value="4" ${param.handCarStatus==4?'selected="selected"':'' }>上传成功</option>
					</select>
				</td>
				</tr>
				<tr>
				<td><label>行驶证照片状态：</label></td>
  				<td>
  					<select id="drivingStatus" name="drivingStatus"  class="text small" onchange="$('#searchPageForm')[0].submit()">
						<option value="">请选择...</option>
						<option value="1" ${param.drivingStatus==1?'selected="selected"':'' } >待上传</option>
						<option value="2" ${param.drivingStatus==2?'selected="selected"':'' }>待审批</option>
						<option value="3" ${param.drivingStatus==3?'selected="selected"':'' }>重新上传</option>
						<option value="4" ${param.drivingStatus==4?'selected="selected"':'' }>上传成功</option>
					</select>
				</td>
  				<td><label>姓名：</label></td>
  				<td><input type="text" id="customerName" name="customerName" class="text small" value="${param.customerName}"></input></td>
  				<td><label>常用手机号：</label></td>
  				<td><input type="text" id="mobilePhone" name="mobilePhone" class="text small" value="${param.mobilePhone}"></input></td>
  				<td><label>归档日期开始：</label></td>
  				<td>
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
			<td style="width: 60px;">姓名</td>
			<td style="width: 80px;">电话</td>
			<td style="width:160px;">车型</td>
			<td style="width: 80px;">部门</td>
			<td style="width: 60px;">业务员</td>
			<td style="width: 60px;">上传状态</td>
			<td style="width: 60px;">交车照片</td>
			<td style="width: 60px;">行驶证照片</td>
			<td style="width: 80px;">创建时间</td>
			<td style="width: 80px;">成交时间</td>
			<td style="width: 80px;">操作</td>
		</tr>
	</thead>
	<tbody>
		<c:forEach items="${page.result }" var="customer">
		<tr>
			<%-- <td style="text-align: center;">
					<input type="checkbox"   name="id" id="id1" value="${customer.dbid }">
			</td> --%>
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
					      <li><a href="javascript:void(-1)" class="aedit" onclick="window.open('${ctx}/orderContract/printContract?dbid=${customer.orderContract.dbid }')">补打合同</a> </li>
					      <li>	<a href="javascript:void(-1)" class="aedit" onclick="window.location.href='${ctx}/orderContract/viewOrderContract?dbid=${customer.orderContract.dbid }'">查看订单</a> </li>
					      <li><a href="javascript:void(-1)" class="aedit" onclick="window.location.href='${ctx}/outboundOrder/viewIndex?customerId=${customer.dbid}'">查看出库</a> </li>
					       <li><a href="javascript:void(-1)" class="aedit" onclick="window.location.href='${ctx}/custCustomer/customerFile?dbid=${customer.dbid}&type=1'">客户综合信息</a> </li>
					    </ul>
					  </div>
				</div>
			</td>
			<td>
				${customer.mobilePhone}
			</td>
			<c:set value="${customer.customerBussi.carSeriy.name}${ customer.customerBussi.carModel.name }" var="carModel"></c:set>
			<td style="text-align: left;" title="${carModel}  ${customer.carModelStr}">
				${customer.customerBussi.carSeriy.name}${ customer.customerBussi.carModel.name }
			</td>
			<td>${customer.department.name }</td>
			<td>
				${customer.bussiStaff}
			</td>
			<td>
				<c:if test="${customer.customerImageApproval.status==1 }">
					<span style="color: red">待上传...</span>
				</c:if>
				<c:if test="${customer.customerImageApproval.status==2 }">
					<span style="color: red;">上传中</span>
				</c:if>
				<c:if test="${customer.customerImageApproval.status==3 }">
					<span style="color: green;">上传完成</span>
				</c:if>
			</td>
			<td>
				<c:if test="${customer.customerImageApproval.handCarStatus==1 }">
					<span style="color: red">待上传...</span>
				</c:if>
				<c:if test="${customer.customerImageApproval.handCarStatus==2 }">
					<span style="color: blue;">待审批</span>
					（<a href="javascript:void(-1)" class="aedit" onclick="window.location.href='${ctx}/customerImage/approvalImage?customerId=${customer.dbid }'">审批</a>）
				</c:if>
				<c:if test="${customer.customerImageApproval.handCarStatus==3 }">
					<span style="color: red;">重新上传</span>
				</c:if>
				<c:if test="${customer.customerImageApproval.handCarStatus==4 }">
					<span style="color: green;">审批通过</span>
				</c:if>
			</td>
			<td>
				<c:if test="${customer.customerImageApproval.drivingStatus==1 }">
					<span style="color: red">待上传...</span>
				</c:if>
				<c:if test="${customer.customerImageApproval.drivingStatus==2 }">
					<span style="color: blue;">待审批</span>
					（<a href="javascript:void(-1)" class="aedit" onclick="window.location.href='${ctx}/customerImage/approvalImage?customerId=${customer.dbid }'">审批</a>）
				</c:if>
				<c:if test="${customer.customerImageApproval.drivingStatus==3 }">
					<span style="color: red;">重新上传</span>
				</c:if>
				<c:if test="${customer.customerImageApproval.drivingStatus==4 }">
					<span style="color: green;">审批通过</span>
				</c:if>
			</td>
			<td>
				<fmt:formatDate value="${customer.createFolderTime }" pattern="yyyy-MM-dd HH:mm"/>
			</td>
			<td>
				<fmt:formatDate value="${customer.customerPidBookingRecord.modifyTime }" pattern="yyyy-MM-dd"/>
			</td>
			<td>
				<c:if test="${customer.customerImageApproval.status==1 }">
					<span style="color: red">待上传...</span>
				</c:if>
				<c:if test="${customer.customerImageApproval.status==2 }">
					<a href="javascript:void(-1)" class="aedit" onclick="window.location.href='${ctx}/customerImage/approvalImage?customerId=${customer.dbid }'">审批图片</a>
				</c:if>
				<c:if test="${customer.customerImageApproval.status>2 }">
					<a href="javascript:void(-1)" class="aedit" onclick="window.location.href='${ctx}/customerImage/viewImage?customerId=${customer.dbid }'">查看图片</a>
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
