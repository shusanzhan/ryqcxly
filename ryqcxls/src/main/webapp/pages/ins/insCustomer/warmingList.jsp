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
<title>续保预警客户</title>
</head>
<body class="bodycolor">
<div class="location">
	<img src="${ctx}/images/homeIcon.png"/> &nbsp;
	<a href="javascript:void(-1);" onclick="window.parent.location.href='${ctx}/main/index'">首页</a>-
	<a href="javascript:void(-1);" onclick="">续保预警客户</a>
</div>
 <!--location end-->
<div class="line"></div>
<div class="listOperate">
	<div class="operate">
		<%-- <a class="but button" href="javascript:void();" onclick="window.location.href='${ctx}/insCustomer/add'">购买</a> --%>
   </div>
  	<div class="seracrhOperate">
  		<form name="searchPageForm" id="searchPageForm" action="${ctx}/insCustomer/warmingList" method="post">
		<input type="hidden" id="currentPage" name="currentPage" value='${page.currentPageNo}'>
		<input type="hidden" id="paramPageSize" name="pageSize" value='${page.pageSize}'>
		<table cellpadding="0" cellspacing="0" class="searchTable" >
  			<tr>
  				<td><label>预警时间：</label></td>
  				<td>
  					<select id="warmingState" name="warmingState" class="text midea" onchange="$('#searchPageForm')[0].submit()">
  						<option value="1" ${param.warmingState==1?'selected="selected"':'' } >今日到期</option>
  						<option value="2" ${param.warmingState==2?'selected="selected"':'' } >未来3天到期</option>
  						<option value="3" ${param.warmingState==3?'selected="selected"':'' } >未来7天到期</option>
  						<option value="4" ${param.warmingState==4?'selected="selected"':'' } >未来15天到期</option>
  						<option value="5" ${param.warmingState==5?'selected="selected"':'' } >未来1个月到期</option>
  						<option value="6" ${param.warmingState==6?'selected="selected"':'' } >未来3个月到期</option>
  					</select>
				</td>
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
		无续保预警客户
	</div>
</c:if>
<c:if test="${!empty(page.result) }">
<table width="100%"  cellpadding="0" cellspacing="0" class="mainTable" border="0">
	<thead  class="TableHeader">
		<tr>
			<td class="sn"><input type='checkbox' id="selectAllCheck" onclick="selectAll(this,'id')" /></td>
			<td class="span2">名称</td>
			<td class="span3">车型</td>
			<td class="span2">客户类型</td>
			<td class="span2">销售顾问</td>
			<td class="span3">最近保期</td>
			<td class="span2">登记日期</td>
			<td class="span2">购买次数</td>
			<td class="span2">购买历史</td>
			<td class="span2">操作</td>
		</tr>
	</thead>
	<c:forEach var="insCustomer" items="${page.result }">
		<tr height="32" align="center">
			<td><input type='checkbox' name="id" id="id1" value="${insCustomer.dbid }"/></td>
			<td style="text-align: center;">
				<div class="dropDownContent" onmousemove="fn(this,event)" onmouseout="hiden(this)">
					${insCustomer.name }
					<br>
					${insCustomer.mobilePhone }
					<div class="drop_down_menu hiden" onmousemove="show(this)" onmouseout="hi(this)" >
					    <ul>
					      <li class="drop_down_menu_active"><a href="javascript:void(-1)" class="aedit" onclick="window.location.href='${ctx}/insCustomer/insCustomerDetail?dbid=${insCustomer.dbid}'">客户资料</a></li>
					      <li><a href="${ctx }/insuranceRecord/historyDetail?customerId=${insCustomer.dbid}" class="aedit" style="color:#2b7dbc">购买记录</a> </li>
					    </ul>
					  </div>
				</div>			
			</td>
			<td style="text-align: left;">
				${insCustomer.brand.name }
				${insCustomer.carseriy.name }
				${insCustomer.carModel.name }
				<br>
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
				${insCustomer.beginDate }~
				${insCustomer.endDate }
			</td>
			<td style="text-align: center;">
				<fmt:formatDate value="${insCustomer.recordDate }"/> 
			</td>
			<td style="text-align: center;"> 
				<a href="${ctx }/insuranceRecord/historyDetail?customerId=${insCustomer.dbid}" class="dropDownContent" style="color:#2b7dbc">${insCustomer.historyBuyNum }</a>
			</td>
			<td style="text-align: center;">
				${insCustomer.historyBuyMoney }
			</td>
			
			<td><a href="#" class="aedit"
				onclick="window.location.href='${ctx }/insuranceRecord/add?dbid=${insCustomer.dbid}'">续保</a>
				|
				<a href="javascript:void(-1)" class="aedit" onclick="window.location.href='${ctx}/insCustomer/insCustomerDetail?dbid=${insCustomer.dbid}'">客户资料</a>
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