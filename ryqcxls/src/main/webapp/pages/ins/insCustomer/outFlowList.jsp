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
<title>流失客户</title>
</head>
<body class="bodycolor">
<div class="location">
	<img src="${ctx}/images/homeIcon.png"/> &nbsp;
	<a href="javascript:void(-1);" onclick="window.parent.location.href='${ctx}/main/index'">首页</a>-
	<a href="javascript:void(-1);" onclick="">流失客户</a>
</div>
 <!--location end-->
<div class="line"></div>
<div class="listOperate">
	<div class="operate">
		<a class="but butCancle" href="javascript:void();" onclick="$.utile.deleteIds('${ctx }/insCustomer/delete','searchPageForm')">删除</a>
   </div>
  	<div class="seracrhOperate">
  		<form name="searchPageForm" id="searchPageForm" action="${ctx}/insCustomer/queryOutFlowList" method="post">
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
		无流失客户
	</div>
</c:if>
<c:if test="${!empty(page.result) }">
<table width="100%"  cellpadding="0" cellspacing="0" class="mainTable" border="0">
	<thead  class="TableHeader">
		<tr>
			<td class="sn"><input type='checkbox' id="selectAllCheck" onclick="selectAll(this,'id')" /></td>
			<td class="span2">名称</td>
			<td class="span1">电话</td>
			<td class="span3">车型</td>
			<td class="span2">vin码</td>
			<td class="span2">客户类型</td>
			<td class="span2">销售顾问</td>
			<td class="span2">登记日期</td>
			<td class="span2">操作</td>
		</tr>
	</thead>
	<c:forEach var="insCustomer" items="${page.result }">
		<tr height="32" align="center">
			<td><input type='checkbox' name="id" id="id1" value="${insCustomer.dbid }"/></td>
			<td style="text-align: center;">
				<div class="dropDownContent" onmousemove="fn(this,event)" onmouseout="hiden(this)">
					${insCustomer.name }
					<div class="drop_down_menu hiden" onmousemove="show(this)" onmouseout="hi(this)" >
					    <ul>
					      <li class="drop_down_menu_active"><a href="javascript:void(-1)" class="aedit" onclick="window.location.href='${ctx}/insCustomer/insCustomerDetail?dbid=${insCustomer.dbid}'">客户资料</a></li>
					      <li><a href="javascript:void(-1)" class="aedit" onclick="$.utile.operatorDataByDbid('${ctx}/insCustomer/resetCustomerOutFlowRecord?dbid=${insCustomer.dbid }','searchPageForm','您确定【${insCustomer.name}】客户撤销流失吗？')">撤销流失</a> </li>
					    </ul>
					  </div>
				</div>	
			</td>
			<td style="text-align: center;">
				${insCustomer.mobilePhone }
			</td>
			<td style="text-align: center;">
				${insCustomer.brand.name }
				${insCustomer.carseriy.name }
				${insCustomer.carModel.name }
			</td>
			<td style="text-align: center;">
				${insCustomer.vinCode }
			</td>
			<td style="text-align: center;">
				<c:if test="${insCustomer.customerType==1 }">
					保有客户
				</c:if>
				<c:if test="${insCustomer.customerType==2 }">
					续保客户
				</c:if>
			</td>
			<td style="text-align: center;">
				${insCustomer.salerName }
			</td>
			<td style="text-align: center;">
				${insCustomer.recordDate }
			</td>
			<td>
				<a href="javascript:void(-1)" class="aedit" onclick="$.utile.operatorDataByDbid('${ctx}/insCustomer/resetCustomerOutFlowRecord?dbid=${insCustomer.dbid }','searchPageForm','您确定【${insCustomer.name}】客户撤销流失吗？')">撤销流失</a>
				|
				<a href="javascript:void(-1)" class="aedit" onclick="$.utile.openDialog('${ctx}/insCustomer/outFlowDetail?dbid=${insCustomer.dbid }','流失原因',760,440)">查看流失</a>
		</tr>
	</c:forEach>
</table>
</c:if>
<div id="fanye">
	<%@ include file="../../commons/commonPagination.jsp" %>
</div>
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
</body>
</html>