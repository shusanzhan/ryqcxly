<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../../commons/taglib.jsp" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link href="${ctx }/css/common.css" type="text/css" rel="stylesheet"/>
<script type="text/javascript" src="${ctx }/widgets/bootstrap3/jquery.min.js"></script>
<script type="text/javascript" src="${ctx }/widgets/utile/utile.js"></script>
<script type="text/javascript" src="${ctx }/widgets/easyvalidator/js/easy_validator.pack.js"></script>
<script type="text/javascript" src="${ctx }/widgets/artDialog/artDialog.js?skin=default"></script>
<script type="text/javascript" src="${ctx }/widgets/artDialog/plugins/iframeTools.source.js"></script>
<script type="text/javascript" src="${ctx }/widgets/My97DatePicker/WdatePicker.js"></script>
<title>我的申请</title>
</head>
<body class="bodycolor">
<div class="location">
	<img src="${ctx}/images/homeIcon.png"/> &nbsp;
	<a href="javascript:void(-1);" onclick="window.parent.location.href='${ctx}/main/index'">首页</a>-
	<a href="javascript:void(-1);" onclick="">我的申请</a>
</div>
 <!--location end-->
<div class="line"></div>
<div class="listOperate">
	<div class="operate">
		<%-- <a class="but button" href="javascript:void();" onclick="window.location.href='${ctx}/processRun/add'">添加</a>
		<a class="but butCancle" href="javascript:void();" onclick="$.utile.deleteIds('${ctx }/processRun/delete','searchPageForm')">删除</a> --%>
   </div>
  	<div class="seracrhOperate">
  		<form name="searchPageForm" id="searchPageForm" action="${ctx}/processRun/queryWaitingTaskList" method="post">
		<input type="hidden" id="currentPage" name="currentPage" value='${page.currentPageNo}'>
		<input type="hidden" id="paramPageSize" name="pageSize" value='${page.pageSize}'>
			<table cellpadding="0" cellspacing="0" class="searchTable" >
				<tr>
					<td><label>申请类型：</label></td>
	  				<td>
	  					<select class="text small" id="type" name="type"  onchange="$('#searchPageForm')[0].submit()">
							<option value="0" >请选择...</option>
							<option value="1" ${param.type==1?'selected="selected"':'' } >合同订单申请</option>
							<option value="2" ${param.type==2?'selected="selected"':'' } >合同流失申请</option>
						</select>
	  				</td>
	  				<td><label>申请时间：</label></td>
	  				<td>
	  					<input type="text" id="startDate" name="startDate" class="text small" value="${param.startDate}" onfocus="WdatePicker()"></input>
	  				</td>
	  				<td style="text-align:center; "><label>~</label></td>
	  				<td>
	  					<input type="text" id="endDate" name="endDate" class="text small" value="${param.endDate}" onfocus="WdatePicker()"></input>
					</td> 
					<td><label>客户：</label></td>
	  				<td>
	  					<input type="text" id="name" name="name" class="text small" value="${param.name}"></input></td>
	  				<td>
	  					<label>客户电话：</label></td>
	  				<td>
	  					<input type="text" id="mobilePhone" name="mobilePhone" class="text small" value="${param.mobilePhone}"></input></td>
					<td><div href="javascript:void(-1)" onclick="$('#searchPageForm')[0].submit()" class="searchIcon"></div></td>
				</tr>
				</table>
   		</form>
   	</div>
   	<div style="clear: both;"></div>
</div>
 <c:if test="${empty(page)||fn:length(page.result)<=0 }" var="status">
 	<div class="alert alert-error">无申请记录</div>
 </c:if>
 <c:if test="${status==false }">
<table width="100%"  cellpadding="0" cellspacing="0" class="mainTable" border="0">
	<thead  class="TableHeader">
		<tr>
			<td class="sn"><input type='checkbox' id="selectAllCheck" onclick="selectAll(this,'id')" /></td>
			<td class="span1">客户</td>
			<td class="span1">审批状态</td>
			<td class="span2">车型</td>
			<td class="span3">申请名称</td>
			<td class="span1">销售顾问</td>
			<td class="span1">申请时间</td>
			<td class="span2">类型</td>
			<td class="span2">操作</td>
		</tr>
	</thead>
	<c:forEach var="processFrom" items="${page.result }">
		<c:set value="${processFrom.processRun}" var="processRun"></c:set>
		<c:set value="${processRun.customer }" var="customer"></c:set>
		<tr height="32" align="center">
			<td><input type='checkbox' name="id" id="id1" value="${processRun.dbid }"/></td>
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
					      <li ><a href="#" class="aedit" onclick="window.location.href='${ctx }/processRun/viewProcessFrom?processRunDbid=${processRun.dbid}'">合同审批记录</a></li>
					    </ul>
					  </div>
				</div>
			</td>
			<td style="text-align: center;">
				<c:if test="${processRun.type==1 }">
					<span style="color: #63C058">合同订单申请</span>
				</c:if>
				<c:if test="${processRun.type==2}">
					<span style="color: #F49537;">合同流失申请</span>
				</c:if>
			</td>
			<c:set value="${customer.customerBussi.brand.name}${customer.customerBussi.carSeriy.name} ${ customer.customerBussi.carModel.name }" var="carModel"></c:set>
			<td  style="text-align: left;" title="${carModel} ${customer.carModelStr}">
					${carModel} ${customer.carModelStr}
			</td>
			<td style="text-align: left;">${processRun.title }</td>
			<td style="text-align: center;">${processRun.creator }</td>
			<td style="text-align: center;">
				<fmt:formatDate value="${processRun.createDate}"/>
			 </td>
			<td style="text-align: center;">
				<c:if test="${processRun.runStatus==1 }">
					<span style="color: red">审批中...</span>
				</c:if>
				<c:if test="${processRun.runStatus==2 }">
					<span style="color: red">驳回</span>
				</c:if>
				<c:if test="${processRun.runStatus==3 }">
					<span style="color: green;">通过</span>
				</c:if>
			</td>
			<td>
				<c:if test="${processRun.type==1}">
					<a href="#" class="aedit" onclick="window.location.href='${ctx }/processRun/dealTask?processFromId=${processFrom.dbid}&customerId=${customer.dbid }'">审批</a>
				</c:if>
				<c:if test="${processRun.type==2}">
					<a href="#" class="aedit" onclick="window.location.href='${ctx }/processRun/dealCpidTask?processFromId=${processFrom.dbid}&customerId=${customer.dbid }'">审批</a>
				</c:if>
			</td>
		</tr>
	</c:forEach>
</table>
<div id="fanye">
	<%@ include file="../../commons/commonPagination.jsp" %>
</div>
</c:if>
</body>
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
</html>