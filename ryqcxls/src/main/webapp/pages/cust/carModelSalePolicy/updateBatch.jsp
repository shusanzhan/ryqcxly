<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="../../commons/taglib.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<head>
<title>销售政策</title>
<meta charset="UTF-8" />
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<link href="${ctx }/css/common.css" type="text/css" rel="stylesheet"/>
</head>
<body>
<div class="location">
	<img src="${ctx}/images/homeIcon.png"/> &nbsp;
	<a href="javascript:void(-1);" onclick="window.parent.location.href='${ctx}/main/index'">首页</a>-
	<a href="javascript:void(-1);" onclick="">修改销售政策</a>
</div>
 <!--location end-->
<div class="line"></div>
<div class="listOperate">
  	<div class="seracrhOperate" style="float: left;">
  		<form name="searchPageForm" id="searchPageForm" action="${ctx}/carModelSalePolicy/updateBatch" method="post">
		<input type="hidden" id="currentPage" name="currentPage" value='${page.currentPageNo}'>
		<input type="hidden" id="paramPageSize" name="pageSize" value='${page.pageSize}'>
		<table  cellpadding="0" cellspacing="0" class="searchTable">
			<tr>
				<td><label>车系：</label></td>
  				<td>
  					<select id="carSeriesId" name="carSeriesId"  class="text midea" onchange="$('#searchPageForm')[0].submit()">
						<option value="">请选择...</option>
						<c:forEach var="carSeriy" items="${carSeriys }">
							<option value="${carSeriy.dbid }" ${param.carSeriesId==carSeriy.dbid?'selected="selected"':'' } >${carSeriy.name }</option>
						</c:forEach>
					</select>
				</td>
			</tr>
		 </table>
   		</form>
   	</div>
   	<div style="clear: both;"></div>
</div>
<div class="frmContent" >
	<form class="form-horizontal" method="post" action="" 	name="frmId" id="frmId">
		<c:if test="${empty(carModelSalePolicys)||carModelSalePolicys==null }" var="status">
			<div class="alert alert-info">
				<strong>提示:</strong>请先选择要修改的销售顾问结算价车系。 
			</div>
		</c:if>
		<c:if test="${status==false }">
		<table width="100%" border="0" class="mainTable" cellpadding="0" cellspacing="0">
			<thead class="TableHeader">
				<tr>
					<td class="span3">名称</td>
					<td class="span1">指导价</td>
					<td class="span1">经销商报价</td>
					<td class="span1">展厅结算价</td>
					<td class="span1">网销结算价</td>
					<td class="span1">区域结算价</td>
					<td class="span1">改展厅结算价</td>
					<td class="span1">改网销结算价</td>
					<td class="span1">改区域结算价</td>
				</tr>
			</thead>
			<tbody>
				<c:forEach items="${carModelSalePolicys }" var="carModelSalePolicy" varStatus="index">
					<tr height="60">
						<td align="left" style="text-align: left;">
							${carModelSalePolicy.brand.name }${carModelSalePolicy.carSeriy.name }${carModelSalePolicy.name }
						</td>
						<td>
							<span style="color: red;">${carModelSalePolicy.navPrice }</span>
						</td>
						<td>
							<c:if test="${empty(carModelSalePolicy.salePrice) }">
								0
							</c:if> 
							<c:if test="${!empty(carModelSalePolicy.salePrice) }">
								<span style="color: red;">${carModelSalePolicy.salePrice }</span>
							</c:if> 
						</td>
						<td>
							<c:if test="${empty(carModelSalePolicy.saleCsprice) }">
								0
							</c:if> 
							<c:if test="${!empty(carModelSalePolicy.saleCsprice) }">
								${carModelSalePolicy.saleCsprice }
							</c:if> 
						</td>
						<td>
							<c:if test="${empty(carModelSalePolicy.netSaleCsprice) }">
								0
							</c:if> 
							<c:if test="${!empty(carModelSalePolicy.netSaleCsprice) }">
								${carModelSalePolicy.netSaleCsprice }
							</c:if> 
						</td>
						<td>
							<c:if test="${empty(carModelSalePolicy.areaSaleCsprice) }">
								0
							</c:if> 
							<c:if test="${!empty(carModelSalePolicy.areaSaleCsprice) }">
								${carModelSalePolicy.areaSaleCsprice }
							</c:if> 
						</td>
						<td>
							<input type="text" class="text small" id="saleCSPrice${index.index+1 }" name="saleCSPrice" checkType="integer,1" value="${carModelSalePolicy.saleCsprice }">
							<input type="hidden" class="text small" id="dbid${index.index+1 }" name="dbid"  value="${carModelSalePolicy.dbid }">
						</td>
						<td>
							<input type="text" class="text small" id="netSaleCsprice${index.index+1 }" name="netSaleCsprice" checkType="integer,1" value="${carModelSalePolicy.netSaleCsprice }">
						</td>
						<td>
							<input type="text" class="text small" id="areaSaleCsprice${index.index+1 }" name="areaSaleCsprice" checkType="integer,1" value="${carModelSalePolicy.areaSaleCsprice }">
						</td>
					</tr>
				</c:forEach>
				</tbody>
			</table>
			<div class="formButton">
				<a href="javascript:void()"	onclick="$.utile.submitForm('frmId','${ctx}/carModelSalePolicy/saveUpdateBatch')"	class="but butSave">保&nbsp;&nbsp;存</a> 
		    	<a href="javascript:void(-1)"	onclick="goBack()" class="but butCancle">取&nbsp;&nbsp;消</a>
			</div>
		</c:if>
	</form>
</div>
<br>
<br>
<br>
</body>
<script type="text/javascript" src="${ctx }/widgets/bootstrap3/jquery.min.js"></script>
<script type="text/javascript" src="${ctx }/widgets/utile/utile.js"></script>
<script type="text/javascript" src="${ctx }/widgets/easyvalidator/js/easy_validator.pack.js"></script>
<script type="text/javascript" src="${ctx }/widgets/artDialog/artDialog.js?skin=default"></script>
<script type="text/javascript" src="${ctx }/widgets/artDialog/plugins/iframeTools.source.js"></script>
</html>
