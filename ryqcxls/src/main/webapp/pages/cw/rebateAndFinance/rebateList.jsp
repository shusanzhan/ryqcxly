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
<title></title>
</head>
<body class="bodycolor">
<div class="location">
	<img src="${ctx}/images/homeIcon.png"/> &nbsp;
	<a href="javascript:void(-1);" onclick="window.parent.location.href='${ctx}/main/index'">首页</a>-
	<a href="javascript:void(-1);" onclick="">工厂返利录入列表</a>
</div>
 <!--location end-->
<div class="line"></div>
<div class="listOperate">
	<a class="but button" href="${ctx}/advancePayment/add">添加返利</a> 
	<%-- <div class="operate">
		 <a class="but button" href="${ctx}/advancePayment/queryCustList">添加定金客户</a> 
		<!-- <a class="but button" href="javascript:void();" onclick="exportExcel('searchPageForm')">导出excel</a> -->
   </div> --%>
   	<!-- <tr  style="display:block" id="zf">
				<td colspan="4" >
				<table>
					<tr>
						<td ><div style="display:block" id="pt1">支付宝:&nbsp;<input type="text" name="alipay" id=""alipay class="small text" title="支付宝" checkType="double,0" tip="支付宝金额不能为空，且为数字类型"></div></td>
						<td ><div style="display:block" id="pt2" >微信:&nbsp;<input type="text" name="weChat" id="weChat" class="small text" title="微信" checkType="double,0" tip="微信支付金额不能为空，且为数字类型"></div></td>					
						<td ><div style="display:block" id="pt3">POS:&nbsp;<input type="text" name="POS" id="POS"  class="small text" title="POS" checkType="double,0" tip="POS支付金额不能为空，且为数字类型"></div></td>
						<td ><div style="display:block" id="pt4" >现金:&nbsp;<input type="text" name="cash" id="cash" class="small text" title="现金" checkType="double,0" tip="现金支付金额不能为空，且为数字类型"></div></td>
						<td ><div style="display:block" id="pt5" >支票:&nbsp;<input type="text" name="check" id="check" class="small text" title="支票" checkType="double,0" tip="支票支付金额不能为空，且为数字类型"></div></td>
					</tr>
					</table>
					</td>
			</tr>  -->
  	<div class="seracrhOperate">
  		<form name="searchPageForm" id="searchPageForm" action="${ctx}/advanceCashier/queryList" method="post">
		<input type="hidden" id="currentPage" name="currentPage" value='${page.currentPageNo}'>
		<input type="hidden" id="paramPageSize" name="pageSize" value='${page.pageSize}'>
		<table cellpadding="0" cellspacing="0" class="searchTable" >
  			<tr>
  				<td><label>vin：</label></td>
  				<td><input type="text" id="vinCode" name="vinCode" class="text small" value="${param.vinCode}"></input></td>
  				<td><label>创建日期：</label></td>
  				<td>
  					<input class="text small" id="startTime" name="startTime" onFocus="WdatePicker({isShowClear:true,readOnly:true})" value="${param.startTime }" >
  					~
  				</td>
  				<td>
  					<input class="text small" id="endTime" name="endTime" onFocus="WdatePicker({isShowClear:true,readOnly:true})" value="${param.endTime }">
				</td>
  				<td><div href="javascript:void(-1)" onclick="$('#searchPageForm')[0].submit()" class="searchIcon" ></div></td>
   			</tr>
   		</table>
   		</form>
   	</div>
   		<div style="clear: both;"></div>
</div>
<table width="100%"  cellpadding="0" cellspacing="0" class="mainTable" border="0">
	<thead  class="TableHeader">
		<tr>
			<td class="span3">名称</td>
			<td class="span2">vin码</td>
			<td class="span3">基本返利比例</td>
			<td class="span2">基本返利金额</td>
			<td class="span2">广告返利比例</td>
			<td class="span2">广告返利金额</td>
			<td class="span2">大客户返利比例</td>
			<td class="span2">大客户返利金额</td>
			<td class="span2">建店返利比例</td>
			<td class="span2">建店返利金额</td>
			<td class="span3">月度返利比例</td>
			<td class="span3">月度返利金额</td>
			<td class="span2">促销返利金额</td>
			<td class="span2">实销返利金额</td>
			<td class="span3">置换返利金额</td>
			<td class="span2">金融返利金额</td>
			<td class="span2">其他返利金额</td>
			<td class="span2">返利总额</td>
			<td class="span2">录入人</td>
			<td class="span2">操作</td>
		</tr>
	</thead>
	<c:forEach var="rebateAndFinance" items="${page.result }">
		<tr height="32" align="center">
			<td style="text-align:lcenter;">
				${rebateAndFinance.factoryOrder.carSeriy.name}
				${rebateAndFinance.factoryOrder.carModel.name }
				${rebateAndFinance.factoryOrder.carColor.name }
			</td>
			<td style="text-align:lcenter;">
				${rebateAndFinance.vinCode}
			</td>
			<td style="text-align:lcenter;">
				${rebateAndFinance.basicRebate}
			</td>
			<td style="text-align:lcenter;">
				${rebateAndFinance.basicRebateMoney}
			</td>
			<td style="text-align:lcenter;">
				${rebateAndFinance.advertisingRebate}
			</td>
			<td style="text-align:lcenter;">
				${rebateAndFinance.advertisingRebateMoney}
			</td>
			<td style="text-align:lcenter;">
				${rebateAndFinance.bigCustomerRebate}
			</td>
			<td style="text-align:lcenter;">
				${rebateAndFinance.bigCustomerRebateMoney}
			</td>
			<td style="text-align:lcenter;">
				${rebateAndFinance.buildAshopRebate}
			</td>
			<td style="text-align:lcenter;">
				${rebateAndFinance.buildAshopRebateMoney}
			</td>
			<td style="text-align:lcenter;">
				${rebateAndFinance.monthlyRebate}
			</td>
			<td style="text-align:lcenter;">
				${rebateAndFinance.monthlyRebateMoney}
			</td>
			<td style="text-align:lcenter;">
				${rebateAndFinance.promotionRebateMoney}
			</td>
			<td style="text-align:lcenter;">
				${rebateAndFinance.realSaleMoney}
			</td>
			<td style="text-align:lcenter;">
				${rebateAndFinance.substitutionRebateMoney}
			</td>
			<td style="text-align:lcenter;">
				${rebateAndFinance.financeRebateMoney}
			</td>
			<td style="text-align:lcenter;">
				${rebateAndFinance.otherRebateMoney}
			</td>
			<td style="text-align:lcenter;">
				${rebateAndFinance.totalRebate}
			</td>
			<td style="text-align:lcenter;">
				${rebateAndFinance.oparetor}
			</td>
			<td style="text-align:lcenter;">
				<a href="${ctx}/rebateAndFinance/edit?dbid=${rebateAndFinance.dbid}" class="aedit">编辑</a>
			</td>
		</tr>
	</c:forEach>
</table>
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
			window.location.href='${ctx}/settlementReceipts/exportExcel?'+params;
		}
</script>
</html>