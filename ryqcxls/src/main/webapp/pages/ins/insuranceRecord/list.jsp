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
<title>待买客户</title>
</head>
<body class="bodycolor">
<div class="location">
	<img src="${ctx}/images/homeIcon.png"/> &nbsp;
	<a href="javascript:void(-1);" onclick="window.parent.location.href='${ctx}/main/index'">首页</a>-
	<a href="javascript:void(-1);" onclick="">待买客户</a>
</div>
 <!--location end-->
<div class="line"></div>
<div class="listOperate">
	<div class="operate">
		<a class="but button" href="javascript:void();" onclick="window.location.href='${ctx}/insuranceRecord/addOutInsCustomer?type=2'">新增客户购买</a>
		<a class="but button" href="javascript:void();" onclick="exportExcel('searchPageForm')">导出excel</a>
   </div>
  	<div class="seracrhOperate">
  		<form name="searchPageForm" id="searchPageForm" action="${ctx}/insuranceRecord/queryList" method="post">
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
  				<td><label>出单公司：</label></td>
  				<td>
  					<select class="text small" id="insuranceCompanyId" name="insuranceCompanyId"  onchange="$('#searchPageForm')[0].submit()">
						<option value="0" >请选择...</option>
						<c:forEach var="insuranceCompany" items="${insuranceCompanies }">
							<option value="${insuranceCompany.dbid }" ${param.insuranceCompanyId==insuranceCompany.dbid?'selected="selected"':'' } >${insuranceCompany.name }</option>
						</c:forEach>
					</select>
  				</td>
  			</tr>
  			<tr>
  				<td><label>投保店：</label></td>
  				<td>
  					<select class="text small" id="enterpriseId" name="enterpriseId"  onchange="$('#searchPageForm')[0].submit()">
						<option value="0" >请选择...</option>
						<c:forEach var="enterprise" items="${enterprises }">
							<option value="${enterprise.dbid }" ${param.enterpriseId==enterprise.dbid?'selected="selected"':'' } >${enterprise.name }</option>
						</c:forEach>
					</select>
  				</td>
  				<td><label>客户类型：</label></td>
  				<td>
  					<select class="text small" id="customerType" name="customerType"  onchange="$('#searchPageForm')[0].submit()">
						<option value="0" >请选择...</option>
						<option value="1" ${param.customerType==1?'selected="selected"':'' } >保有客户</option>
						<option value="2" ${param.customerType==2?'selected="selected"':'' } >外来客户</option>
					</select>
  				</td>
  				<td><label>车牌号：</label></td>
  				<td><input type="text" id="carPlateNo" name="carPlateNo" class="text small" value="${param.carPlateNo}"></input></td>
  				<td><label>车架号：</label></td>
  				<td><input type="text" id="paramVinCode" name="paramVinCode" class="text small" value="${param.paramVinCode}"></input></td>
  			</tr>
  			<tr>
  				<td><label>客户名称：</label></td>
  				<td>
  					<input type="text" id="name" name="name" value="${param.name }" class="text small">
				</td>
  				<td><label>手机号码：</label></td>
  				<td>
  					<input type="text" id="mobilePhone" name="mobilePhone" value="${param.mobilePhone }" class="text small">
				</td>
				<td><label>创建日期：</label></td>
  				<td colspan="1">
  					<input class="text small" id="startTime" name="startTime" onFocus="WdatePicker({isShowClear:true,readOnly:true})" value="${param.startTime }" >
				</td>
				<td style="text-align: center;"><label>~</label></td>
  				<td colspan="1">
  					<input class="text small" id="endTime" name="endTime" onFocus="WdatePicker({isShowClear:true,readOnly:true})" value="${param.endTime }">
				</td>
   			</tr>
   			<tr>
   			<td><label>签订日期：</label></td>
  				<td colspan="1">
  					<input class="text small" id="startBuyTime" name="startBuyTime" onFocus="WdatePicker({isShowClear:true,readOnly:true})" value="${param.startBuyTime }" >
				</td>
				<td style="text-align: center;"><label>~</label></td>
  				<td colspan="1">
  					<input class="text small" id="endBuyTime" name="endBuyTime" onFocus="WdatePicker({isShowClear:true,readOnly:true})" value="${param.endBuyTime }">
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
		流待买客户
	</div>
</c:if>
<c:if test="${!empty(page.result) }">
<table width="100%"  cellpadding="0" cellspacing="0" class="mainTable" border="0">
	<thead  class="TableHeader">
		<tr>
			<td class="span1">名称</td>
			<td class="span3">车型</td>
			<td class="span4">险种</td>
			<td class="span1">保期</td>
			<td class="span3">保费</td>
			<td class="span1">返利</td>
			<td class="span1">客户权益</td>
			<td class="span1">提成基价</td>
			<td class="span1">签订日期</td>
			<td class="span1">操作日期</td>
			<td class="span1">购买次数</td>
			<td class="span2">操作</td>
		</tr>
	</thead>
	<c:forEach var="insuranceRecord" items="${page.result }">
		<c:set var="insCustomer" value="${insuranceRecord.insCustomer }"></c:set>
		<tr height="32" align="center">
			<td style="text-align: left;">
				<div class="dropDownContent" onmousemove="fn(this,event)" onmouseout="hiden(this)">
					${insCustomer.name }
					<c:if test="${insCustomer.customerType==1 }">
						（保有）
					</c:if>
					<c:if test="${insCustomer.customerType==2 }">
						（新增）
					</c:if>
					<br>
					${insCustomer.mobilePhone }
					<br>
					${insCustomer.carPlateNo }
					<div class="drop_down_menu hiden" onmousemove="show(this)" onmouseout="hi(this)" >
					    <ul>
					      <li class="drop_down_menu_active"><a href="javascript:void(-1)" class="aedit" onclick="window.location.href='${ctx}/insCustomer/insCustomerDetail?dbid=${insCustomer.dbid}'">客户资料</a></li>
					      <li><a href="${ctx }/insuranceRecord/insuranceRecordDetail?dbid=${insuranceRecord.dbid }" class="aedit" >投保明细</a> </li>
					    </ul>
					  </div>
				</div>			
			</td>
			<td style="text-align: left;">
				${insCustomer.brand.name }
				${insCustomer.carseriy.name }
				${insCustomer.carModel.name }
				${insCustomer.carName }
				<br>
				${insCustomer.vinCode }
			</td>
			<td style="text-align: left;">
				${insuranceRecord.strongRisk }
				${insuranceRecord.busiRisk }
			</td>
			<td style="text-align: center;">
				${insuranceRecord.beginDate }
				<br>
				${insuranceRecord.endDate }
			</td>
			<td style="text-align: center;">
				<span style="font-size: 14px;color: red;">
					<fmt:formatNumber value="${insuranceRecord.totalPrice }" pattern="#.00"></fmt:formatNumber>
				</span>
				=<span style="font-size: 14px;color: red;">
					<fmt:formatNumber value="${insuranceRecord.strongRiskPrice}" pattern="#.00"></fmt:formatNumber>
				</span> +  
				<span style="font-size: 14px;color: red;">
					<fmt:formatNumber value="${insuranceRecord.busiRiskPrice+insuranceRecord.nonDeductiblePrice }" pattern="#.00"></fmt:formatNumber>
				</span>
			</td>
			<td style="text-align: center;">
				<span style="font-size: 14px;color: red;">${insuranceRecord.rebateMoney }</span>
			</td>
			<td style="text-align: center;">
				<span style="font-size: 14px;color: red;">${insuranceRecord.incidentalInterestMoney }</span>
			</td>
			<td style="text-align: center;">
				<span style="font-size: 14px;color: red;">
				<c:if test="${insCustomer.customerType==1 }">
						${insuranceRecord.salerBasePrice }
					</c:if>
					<c:if test="${insCustomer.customerType==2 }">
						多品牌
					</c:if>
				</span>
			</td>
			<td>
				<fmt:formatDate value="${insuranceRecord.buyDate }" pattern="yyyy-MM-dd"/>
			</td>
			<td>
				<fmt:formatDate value="${insuranceRecord.createDate }" pattern="yyyy-MM-dd HH:mm"/>
			</td>
			<td style="text-align: center;">
				${insCustomer.historyBuyNum }
			</td>
			<td>
				<c:if test="${insCustomer.customerType==1 }">
					<a href="#" class="aedit" onclick="window.location.href='${ctx }/insuranceRecord/add?dbid=${insCustomer.dbid}&type=2&insType=2'">续保</a>
				</c:if>
				<c:if test="${insCustomer.customerType==2 }">
					<a href="#" class="aedit" onclick="window.location.href='${ctx }/insuranceRecord/add?dbid=${insCustomer.dbid}&type=2&insType=4'">续保</a>
				</c:if>
				|
				<a href="${ctx}/insuranceRecord/edit?dbid=${insuranceRecord.dbid }&type=2&insType=${insuranceRecord.insType}" class="aedit" >编辑</a>
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
	 
	 
</script>
<script type="text/javascript">
function exportExcel(searchFrm){
 	var params;
 	if(null!=searchFrm&&searchFrm!=undefined&&searchFrm!=''){
 		params=$("#"+searchFrm).serialize();
 	}
 	window.location.href='${ctx}/insuranceRecord/downExcel?'+params;
 }
</script>
</html>