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
<title>装饰客户</title>
</head>
<body class="bodycolor">
<div class="location">
	<img src="${ctx}/images/homeIcon.png"/> &nbsp;
	<a href="javascript:void(-1);" onclick="window.parent.location.href='${ctx}/main/index'">首页</a>-
	<a href="javascript:void(-1);" onclick="">装饰客户</a>
</div>
 <!--location end-->
<div class="line"></div>
<div class="listOperate">
	<div class="operate">
		<a class="but button" href="javascript:void();" onclick="window.location.href='${ctx}/insuranceRecord/addOutdecoreOut?type=1'">批量提报</a>
   </div>
  	<div class="seracrhOperate">
  		<form name="searchPageForm" id="searchPageForm" action="${ctx}/decoreOut/queryCwList" method="post">
		<input type="hidden" id="currentPage" name="currentPage" value='${page.currentPageNo}'>
		<input type="hidden" id="paramPageSize" name="pageSize" value='${page.pageSize}'>
		<table cellpadding="0" cellspacing="0" class="searchTable" >
  			<tr>
  				<td><label>客户名称：</label></td>
  				<td>
  					<input type="text" id="name" name="name" value="${param.name }" class="text midea">
				</td>
  				<td><label>手机号码：</label></td>
  				<td>
  					<input type="text" id="mobilePhone" name="mobilePhone" value="${param.mobilePhone }" class="text midea">
				</td>
  				<td><label>VIN码：</label></td>
  				<td>
  					<input type="text" id="vinCode" name="vinCode" value="${param.vinCode }" class="text midea">
				</td>
  				<td><div href="javascript:void(-1)" onclick="$('#searchPageForm')[0].submit()" class="searchIcon"></div></td>
   			</tr>
   		</table>
   		</form>
   	</div>
   	<div style="clear: both;"></div>
</div>
<c:if test="${empty(page.result) }">
	<div class="alert alert-error">
		无装饰客户
	</div>
</c:if>
<c:if test="${!empty(page.result) }">
<table width="100%"  cellpadding="0" cellspacing="0" class="mainTable" border="0">
	<thead  class="TableHeader">
		<tr>
			<td class="sn"><input type='checkbox' id="selectAllCheck" onclick="selectAll(this,'id')" /></td>
			<td class="span2">名称</td>
			<td class="span3">车型</td>
			<td class="span1">销售价</td>
			<td class="span2">实收</td>
			<td class="span1">赠送</td>
			<td class="span2">装饰</td>
			<td class="span2">是否处理</td>
			<td class="span1">销售顾问</td>
			<td class="span2">登记日期</td>
			<td class="span2">提交财务</td>
			<td class="span2">操作</td>
		</tr>
	</thead>
	<c:forEach var="decoreOut" items="${page.result }">
		<c:set value="${decoreOut.customer }" var="customer"></c:set>
		<c:set value="${decoreOut.customer.customerPidBookingRecord }" var="customerPidBookingRecord"></c:set>
		<tr height="32" align="center">
			<td><input type='checkbox' name="id" id="id1" value="${decoreOut.dbid }"/></td>
			<td style="text-align: left;">
				<div class="dropDownContent" onmousemove="fn(this,event)" onmouseout="hiden(this)">
					${decoreOut.customerName }
					<br>
					${customer.mobilePhone }
					<div class="drop_down_menu hiden" onmousemove="show(this)" onmouseout="hi(this)" >
					     <ul>
					      <li>	<a href="javascript:void(-1)" class="aedit" onclick="window.location.href='${ctx}/orderContract/viewOrderContract?dbid=${customer.orderContract.dbid }'">查看订单</a> </li>
					      <li><a href="javascript:void(-1)" class="aedit" onclick="window.location.href='${ctx}/outboundOrder/viewIndex?customerId=${customer.dbid}'">查看出库</a> </li>
					       <li><a href="javascript:void(-1)" class="aedit" onclick="window.location.href='${ctx}/customer/customerFile?dbid=${customer.dbid}&type=1'">客户综合信息</a> </li>
					    </ul>
					  </div>
				</div>			
			</td>
			<td style="text-align: left;">
				${customerPidBookingRecord.brand.name }
				${customerPidBookingRecord.carSeriy.name }
				${customerPidBookingRecord.carModel.name }<br>
				${customerPidBookingRecord.vinCode }
			</td>
			<td style="text-align: center;"> 
				${decoreOut.decoreSaleTotalPrce }
			</td>			
			<td style="text-align: center;"> 
				${decoreOut.acturePrice }（${decoreOut.zkl}%）
			</td>			
			<td style="text-align: center;"> 
				${decoreOut.giveTotalPrice }
			</td>			
			<td style="text-align: center;"> 
				<c:if test="${decoreOut.decoreStatus==1 }">
					<span style="color: green;">包含装饰</span>
				</c:if>
				<c:if test="${decoreOut.decoreStatus==2 }">
					<span style="color: red;">无装饰单</span>
				</c:if>
				<c:if test="${decoreOut.copyStatus==2 }">
					<span style="color: green">（副本）</span>
				</c:if>
			</td>
			<td style="text-align: center;"> 
				<c:if test="${decoreOut.status==1 }">
					<span style="color: red;">未处理</span>
				</c:if>
				<c:if test="${decoreOut.status==2 }">
					<span style="color: green;">已经处理</span>
				</c:if>
			</td>
			<td style="text-align: center;">
				${customer.bussiStaff }
			</td>
			<td style="text-align: center;">
				<fmt:formatDate value="${decoreOut.createDate }"/> 
			</td>
			<td style="text-align: center;">
				<c:if test="${decoreOut.cwStatus==1 }">
					<span style="color:red">待提交</span>
				</c:if>
				<c:if test="${decoreOut.cwStatus==2 }">
					<span style="color:green;">已提交</span>
						<c:if test="${decoreOut.cwAppStatus==3 }">
							<a href="javascript:void(-1)" onclick="$.utile.openDialog('${ctx}/cwAppmodifydata/viewApproval?dbid=${decoreOut.dbid }&type=4&querytType=1','审批记录',960,400)"><span style="color: red;">申请驳回</span></a>
						</c:if>
						<c:if test="${decoreOut.cwAppStatus==4 }">
							<a href="javascript:void(-1)" onclick="$.utile.openDialog('${ctx}/cwAppmodifydata/viewApproval?dbid=${decoreOut.dbid }&type=4&querytType=1','审批记录',960,400)"><span style="color: green;">申请通过</span></a>
						</c:if>
					<br>
					<fmt:formatDate value="${decoreOut.cwDate }" pattern="yyyy-MM-dd"/>
				</c:if>
			</td>
			<td>
				<c:if test="${decoreOut.cwStatus==1 }">
					<a href="javascript:void(-1)" class="aedit" onclick="$.utile.operatorDataByDbid('${ctx }/decoreOut/subCwDecoreOut?dbid=${decoreOut.dbid }','searchPageForm','您确定将【${decoreOut.customerName }】提报财务吗？')">提报财务</a>
				</c:if>
				<c:if test="${decoreOut.cwStatus==2 }">
					<c:if test="${decoreOut.cwAppStatus==1 }">
						<a href="javascript:void(-1)" class="aedit" onclick="$.utile.openDialog('${ctx}/cwAppmodifydata/decoreApply?decoreOutId=${decoreOut.dbid }','发起撤销提报申请',720,400)">提报撤销</a>
					</c:if>
					<c:if test="${decoreOut.cwAppStatus==2 }">
						<span style="color: red;">发起修改申请</span>
					</c:if>
					<c:if test="${decoreOut.cwAppStatus==3 }">
						<a href="javascript:void(-1)" onclick="$.utile.openDialog('${ctx}/cwAppmodifydata/viewApproval?dbid=${decoreOut.dbid }&type=4&querytType=1','审批记录',960,400)"><span style="color: red;">申请驳回</span></a>
						<a href="javascript:void(-1)" class="aedit" onclick="$.utile.openDialog('${ctx}/cwAppmodifydata/decoreApply?decoreOutId=${decoreOut.dbid }','发起撤销提报申请',720,400)">提报撤销</a>
					</c:if>
					<c:if test="${decoreOut.cwAppStatus==4 }">
						<a href="javascript:void(-1)" class="aedit" onclick="$.utile.operatorDataByDbid('${ctx }/decoreOut/subCwDecoreOut?dbid=${decoreOut.dbid }','searchPageForm','您确定将【${decoreOut.customerName }】提报财务吗？')">提报财务</a>
					</c:if>
				</c:if>
			</td>
		</tr>
	</c:forEach>
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
	 
	 function sendMms(){
		window.location.href="${ctx}/sms/add";
	 }
</script>
</html>