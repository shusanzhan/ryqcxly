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
<title>装饰销售</title>
</head>
<body class="bodycolor">
<div class="location">
	<img src="${ctx}/images/homeIcon.png"/> &nbsp;
	<a href="javascript:void(-1);" onclick="window.parent.location.href='${ctx}/main/index'">首页</a>-
	<a href="javascript:void(-1);" onclick="">装饰销售作废单</a>
</div>
 <!--location end-->
<div class="line"></div>
<div class="listOperate">
	<div class="operate">
		<a class="but butCancle" href="javascript:void();" onclick="window.location.href='${ctx}/saleDecoreOut/queryList'">返回</a>
   </div>
  	<div class="seracrhOperate">
  		<form name="searchPageForm" id="searchPageForm" action="${ctx}/saleDecoreOut/queryCancelList" method="post">
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
		无装饰销售
	</div>
</c:if>
<c:if test="${!empty(page.result) }">
<table width="100%"  cellpadding="0" cellspacing="0" class="mainTable" border="0">
	<thead  class="TableHeader">
		<tr>
			<td class="sn"><input type='checkbox' id="selectAllCheck" onclick="selectAll(this,'id')" /></td>
			<td class="span2">销售单号</td>
			<td class="span2">销售日期</td>
			<td class="span2">客户</td>
			<td class="span2">实收金额</td>
			<td class="span2">销售金额</td>
			<td class="span1">折扣率</td>
			<td class="span2">说明</td>
			<td class="span2">操作</td>
		</tr>
	</thead>
	<c:forEach var="decoreOut" items="${page.result }">
		<c:set value="${decoreOut.customer }" var="customer"></c:set>
		<c:set value="${decoreOut.customer.customerPidBookingRecord }" var="customerPidBookingRecord"></c:set>
		<tr height="32" align="center">
			<td><input type='checkbox' name="id" id="id1" value="${decoreOut.dbid }"/></td>
			<td style="text-align: center;"> 
				${decoreOut.outNo }
			</td>			
			<td style="text-align: center;"> 
				${decoreOut.modifyDate }
			</td>			
			<td style="text-align: center;"> 
				<c:if test="${decoreOut.type==1 }">
					${customer.name }
				</c:if>
				<c:if test="${decoreOut.type==2 }">
					零售客户
				</c:if>
			</td>			
			<td style="text-align: center;"> 
				${decoreOut.acturePrice }
			</td>			
			<td style="text-align: center;"> 
				${decoreOut.decoreSaleTotalPrce }
			</td>			
			<td style="text-align: center;"> 
			${decoreOut.zkl}%
			</td>			
			<td style="text-align: center;">
				${decoreOut.note }
			</td>
			<td>
				<c:if test="${decoreOut.type==1 }">
					<a href="#" class="aedit" onclick="window.location.href='${ctx }/decoreOut/edit?dbid=${decoreOut.dbid}&type=1'">查看</a> |
				</c:if>
				<c:if test="${decoreOut.type==2 }">
					<a href="#" class="aedit" onclick="window.location.href='${ctx }/saleDecoreOut/viewSale?dbid=${decoreOut.dbid}&type=2'">查看</a> |
				</c:if>
				<a href="#" class="aedit" onclick="window.location.href='${ctx }/saleDecoreOut/printSale?dbid=${decoreOut.dbid}&type=1'">打印</a>
				|
				<a href="#" class="aedit" onclick="$.utile.operatorDataByDbid('${ctx}/saleDecoreOut/deleteCancel?dbid=${decoreOut.dbid }','searchPageForm','确定删除【${decoreOut.outNo }】单据吗？')">删除</a>
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