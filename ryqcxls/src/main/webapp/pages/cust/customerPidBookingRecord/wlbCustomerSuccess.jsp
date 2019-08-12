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
	<a href="javascript:void(-1);" onclick="">成交管理</a>
</div>
<!--location end-->
<div class="line"></div>
<div class="listOperate">
	<div class="operate">
	  <a href="javascript:void(-1)" class="but button" onclick="subCwCpidMoreCustomer()">批量提报财务</a>
	  <a class="but button" href="javascript:void();" onclick="operatorLocation('${ctx }/customerFile/index')">客户档案信息</a>
	  <a href="javascript:void(-1)" class="but button" onclick="exportExcel('searchPageForm')">导出excel</a>
   </div>
	<div class="operate">
		<%-- <a class="but button" href="javascript:void();" onclick="operator('${ctx }/customer/handerOverCar')">交车确认单</a>
		<a class="but button" href="javascript:void();" onclick="operator('${ctx }/customer/customerFolder')">客户综合信息</a>
		<a href="javascript:void(-1)" class="but button" onclick="operator('${ctx }/customer/trakingCard')">意向跟踪卡</a> --%> 
   </div>
  	<div class="seracrhOperate">
  		<form name="searchPageForm" id="searchPageForm"  action="${ctx}/customerPidBookingRecord/wlbCustomerManageSuccess" method="post" >
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
  				<td><label>归档日期开始：</label></td>
  				<td colspan="1">
  					<input class="text small" id="startTime" name="startTime" onFocus="WdatePicker({isShowClear:true,readOnly:true})" value="${param.startTime }" >~
  					<input class="text small" id="endTime" name="endTime" onFocus="WdatePicker({isShowClear:true,readOnly:true})" value="${param.endTime }">
				</td>
  			</tr>
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
			<td style="width: 60px;">姓名</td>
			<td style="width: 60px;">vin码</td>
			<td style="width:140px;">车型</td>
			<td style="width: 100px;">业务员</td>
			<td style="width: 60px;">奖励金额</td>
			<td style="width: 80px;">创建时间</td>
			<td style="width: 80px;">成交时间</td>
			<td class="span2">提交财务</td>
			<td style="width: 120px;">操作</td>
		</tr>
	</thead>
	<tbody>
		<c:forEach items="${page.result }" var="customer">
		<c:set value="${customer.recommendCustomer }" var="recommendCustomer"></c:set>
		<tr>
			<td style="text-align: center;">
					<input type="checkbox"   name="id" id="id1" value="${customer.dbid }">
			</td> 
			<td style="text-align: left;">
				<div class="dropDownContent" onmousemove="fn(this,event)" onmouseout="hiden(this)">
					${customer.name }
					<c:if test="${!empty(recommendCustomer) }">
						（经纪人）
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
			<td>
				<a class="aedit" style="color: #2b7dbc" href="${ctx }/factoryOrder/factoryOrderDetail?vinCode=${customer.customerPidBookingRecord.vinCode}&type=1">
					${customer.customerPidBookingRecord.vinCode }
				</a>
			</td>
			<c:set value="${customer.customerBussi.carSeriy.name}${ customer.customerBussi.carModel.name }" var="carModel"></c:set>
			<td style="text-align: left;" title="${carModel }${customer.carModelStr}">
				${customer.customerBussi.carSeriy.name}${ customer.customerBussi.carModel.name }${customer.customerPidBookingRecord.carColor.name }${customer.carColorStr}
			</td>
			<td>
				${customer.bussiStaff}(${customer.successDepartment.name })
			</td>
			<td>
				${customer.customerPidBookingRecord.rewardMoney}
			</td>
			<td>
				<fmt:formatDate value="${customer.createFolderTime }" pattern="yyyy-MM-dd HH:mm"/>
			</td>
			<td>
				<fmt:formatDate value="${customer.customerPidBookingRecord.modifyTime }" pattern="yyyy-MM-dd"/>
			</td>
			<c:set value="${customer.customerPidBookingRecord }" var="customerPidBookingRecord"></c:set>
			<td style="text-align: center;">
				<c:if test="${customerPidBookingRecord.cwStatus==1 }">
					<span style="color:red">待提交</span>
				</c:if>
				<c:if test="${customerPidBookingRecord.cwStatus==2 }">
					<span style="color:green;">已提交</span>
						<c:if test="${customerPidBookingRecord.cwAppStatus==3 }">
							<a href="javascript:void(-1)" onclick="$.utile.openDialog('${ctx}/cwAppmodifydata/viewApproval?dbid=${customerPidBookingRecord.dbid }&type=2&querytType=1','审批记录',960,400)"><span style="color: red;">申请驳回</span></a>
						</c:if>
						<c:if test="${customerPidBookingRecord.cwAppStatus==4 }">
							<a href="javascript:void(-1)" onclick="$.utile.openDialog('${ctx}/cwAppmodifydata/viewApproval?dbid=${customerPidBookingRecord.dbid }&type=2&querytType=1','审批记录',960,400)"><span style="color: green;">申请通过</span></a>
						</c:if>
					<br>
					<fmt:formatDate value="${customerPidBookingRecord.cwDate }" pattern="yyyy-MM-dd"/>
				</c:if>
			</td>
			<td>
				<c:if test="${customerPidBookingRecord.cwStatus==1 }">
					<a href="javascript:void(-1)" class="aedit" onclick="$.utile.operatorDataByDbid('${ctx }/customerPidBookingRecord/subCwCpidCustomer?dbid=${customerPidBookingRecord.dbid }','searchPageForm','您确定将【${customerPidBookingRecord.customer.name }】提报财务吗？')">提报财务</a>
					<br>
					<a style="color: #2b7dbc" href="#" class="aedit" onclick="$.utile.operatorDataByDbid('${ctx}/customerPidBookingRecord/cancelCustomerFile?customerId=${customer.dbid }','searchPageForm','提示：确定将选择客户为未归档客户吗？')">撤销归档</a>
					|
					<a style="color: #2b7dbc" class="aedit" onclick="window.location.href='${ctx}/outboundOrder/index?customerId=${customer.dbid }&modifyType=2'">修改出库单</a>
				</c:if>
				<c:if test="${customerPidBookingRecord.cwStatus==2 }">
					<c:if test="${customerPidBookingRecord.cwAppStatus==1 }">
						
					</c:if>
					<c:if test="${customerPidBookingRecord.cwAppStatus==2 }">
						<span style="color: red;">发起修改申请</span>
					</c:if>
					<c:if test="${customerPidBookingRecord.cwAppStatus==3 }">
						<a href="javascript:void(-1)" class="aedit" onclick="$.utile.openDialog('${ctx}/cwAppmodifydata/cpidApply?customerPidBookingRecordId=${customerPidBookingRecord.dbid }','发起撤销提报申请',720,400)">提报撤销</a>
					</c:if>
					<c:if test="${customerPidBookingRecord.cwAppStatus==4 }">
						<a href="javascript:void(-1)" class="aedit" onclick="$.utile.operatorDataByDbid('${ctx }/customerPidBookingRecord/subCwCpidCustomer?dbid=${customerPidBookingRecord.dbid }','searchPageForm','您确定将【${customerPidBookingRecord.customer.name }】提报财务吗？')">提报财务</a>
						<br>
						<a style="color: #2b7dbc" href="#" class="aedit" onclick="$.utile.operatorDataByDbid('${ctx}/customerPidBookingRecord/cancelCustomerFile?customerId=${customer.dbid }','searchPageForm','提示：确定将选择客户为未归档客户吗？')">撤销归档</a>
						|
						<a style="color: #2b7dbc" class="aedit" onclick="window.location.href='${ctx}/outboundOrder/index?customerId=${customer.dbid }&modifyType=2'">修改出库单</a>
					</c:if>
				</c:if>
				<c:set value="${customer.recommendCustomer }" var="recommendCustomer"></c:set>
				<c:if test="${!empty(recommendCustomer) }">
					<br>
					<c:if test="${recommendCustomer.rewardStatus==1 }">
						<a style="color: #2b7dbc" href="#" class="aedit" onclick="window.location.href='${ctx}/recommendCustomer/reward?customerId=${customer.dbid }&recommendCustomerId=${recommendCustomer.dbid }'">发送经纪人奖励</a>
					</c:if>
					<c:if test="${recommendCustomer.rewardStatus==2 }">
						<a>已发送奖励</a>
					</c:if>
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
	 function exportExcel(searchFrm){
		 	var params;
		 	if(null!=searchFrm&&searchFrm!=undefined&&searchFrm!=''){
		 		params=$("#"+searchFrm).serialize();
		 	}
		 	window.location.href='${ctx}/customerPidBookingRecord/exportExcel?'+params;
		 }
	 function subCwCpidMoreCustomer(){
		 var status=checkBefDel();
		 if(status==true){
			 var dbids=getCheckBox();
			 $.post("${ctx}/customerPidBookingRecord/subCwCpidMoreCustomer?dbids="+dbids+"&dateTime="+new Date(),{},function(data){
				 if (data[0].mark == 1) {// 删除数据失败时提示信息
						alert(data[0].message);
				 		return ;
					}
					if (data[0].mark == 0) {// 删除数据成功提示信息
						$.utile.tips(data[0].message);
					}
					window.location.reload();
			 })
		 }
	 }
</script>
</html>
