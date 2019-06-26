<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="../../commons/taglib.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html lang="en">
<head>
<title>已还款车辆</title>
<meta charset="UTF-8" />
<meta name="viewport" content="width=device-width, initial-scale=1.0" />
<link href="${ctx }/css/common.css" type="text/css" rel="stylesheet"/>
<script type="text/javascript" src="${ctx }/widgets/bootstrap3/jquery.min.js"></script>
<script type="text/javascript" src="${ctx }/widgets/utile/utile.js"></script>
<script type="text/javascript" src="${ctx }/widgets/artDialog/artDialog.js?skin=default"></script>
<script type="text/javascript" src="${ctx }/widgets/artDialog/plugins/iframeTools.source.js"></script>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<style type="text/css">
</style>
</head>
<body class="bodycolor">
<div class="location">
	<img src="${ctx}/images/homeIcon.png"/> &nbsp;
	<a href="javascript:void(-1);" onclick="window.parent.location.href='${ctx}/main/index'">首页</a>-
	<a href="javascript:void(-1);" onclick="">已还款车辆</a>
</div>
 <!--location end-->
<div class="line"></div>
<div class="alert alert-error">
		<strong>提示!</strong> 
		<p>1、如要撤销还款，请联系管理员.</p>
		<p>2、还款后车辆性质变更为“自有资金车辆".</p>
	</div>
<div class="listOperate">
	<div class="operate">
   	</div>
  	<div class="seracrhOperate">
  		<form name="searchPageForm" id="searchPageForm"  action="${ctx}/factoryOrder/repaymentedList" method="post" >
		<input type="hidden" id="currentPage" name="currentPage" value='${page.currentPageNo}'>
		<input type="hidden" id="paramPageSize" name="pageSize" value='${page.pageSize}'>
		<table cellpadding="0" cellspacing="0" class="searchTable" >
  			<tr>
  				<td><label>品牌：</label></td>
  				<td>
  					<select class="text midea" id="brandId" name="brandId"  onchange="$('#searchPageForm')[0].submit()">
						<option value="0" >请选择...</option>
						<c:forEach var="brand" items="${brands }">
							<option value="${brand.dbid }" ${param.brandId==brand.dbid?'selected="selected"':'' } >${brand.name }</option>
						</c:forEach>
					</select>
  				</td>
  				<td><label>车系：</label></td>
  				<td>
  					<select class="text midea" id="carSeriyId" name="carSeriyId"  onchange="$('#searchPageForm')[0].submit()">
						<option value="0" >请选择...</option>
						<c:forEach var="carSeriy" items="${carSeriys }">
							<option value="${carSeriy.dbid }" ${param.carSeriyId==carSeriy.dbid?'selected="selected"':'' } >${carSeriy.name }</option>
						</c:forEach>
					</select>
  				</td>
  				<td><label>车型：</label></td>
  				<td>
  					<select class="text midea" id="carModelId" name="carModelId"  onchange="$('#searchPageForm')[0].submit()">
						<option value="0" >请选择...</option>
						<c:forEach var="carModel" items="${carModels }">
							<option value="${carModel.dbid }" ${param.carModelId==carModel.dbid?'selected="selected"':'' } >${carModel.name }</option>
						</c:forEach>
					</select>
  				</td>
  				<td><label>VIN码：</label></td>
  				<td>
  					<input type="text" id="vinCode" name="vinCode" value="${param.vinCode }" class="text small">
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
			<td style="width: 20px;"><div class="checker" id="uniform-title-table-checkbox">
					<span><input type="checkbox" name="title-table-checkbox" id="title-table-checkbox" onclick="selectAll(this,'id')"></span>
				</div></td>
			<td style="width: 200px;">名称</td>
			<td style="width: 80px;">vin码</td>
			<td style="width: 50px;">执行价</td>
			<td style="width: 50px;">工厂价</td>
			<td style="width:70px;">工厂日期</td>
			<td style="width:60px;">订单性质</td>
			<td style="width:50px;">库龄</td>
			<td style="width:50px;">库存状态</td>
			<td style="width:50px;">出库日期</td>
			<td style="width:100px;">DMS上传日期</td>
			<td style="width:100px;">还款状态</td>
			<td style="width: 80px;">操作</td>
		</tr>
	</thead>
	<tbody>
		<c:forEach items="${page.result }" var="factoryOrder">
		<tr >
			<td style="text-align: center;">
					<input type="checkbox"   name="id" id="id1" value="${factoryOrder.dbid }">
			</td>
			<td>
				${factoryOrder.carSeriy.name }
				${factoryOrder.carModel.name }
				${factoryOrder.carColor.name }
			</td>
			<td>
				${factoryOrder.vinCode}
			</td>
			<td>
				${factoryOrder.marketPrice}
			</td>
			<td>
				${factoryOrder.factoryPrice}
			</td>
			<td>
				<fmt:formatDate value="${factoryOrder.factoryOrderDate}" pattern="yyyy-MM-dd"/> 
			</td>
			<td>
				${factoryOrder.orderAttr }
			</td>
			<td>
				${factoryOrder.storeAgeLevel.name }
			</td>
			<td>
				<c:if test="${factoryOrder.carStatus==2 }">
					<span style="color: red;">在库</span>
				</c:if>
				<c:if test="${factoryOrder.carStatus==3 }">
					<span style="color: blue;">已归档</span>
				</c:if>
				<c:if test="${factoryOrder.carStatus==4 }">
					<span style="color: green;">已交车</span>
				</c:if>
			</td>
			<td>
				${factoryOrder.outStockDate}
			</td>
			<td>
				<c:if test="${empty(factoryOrder.dmsFileUpdate) }">
					未上传
				</c:if>
				<c:if test="${!empty(factoryOrder.dmsFileUpdate) }">
					${factoryOrder.dmsFileUpdate }
				</c:if>
			</td>
			<td>
				<c:if test="${factoryOrder.repaymentStatus==2 }">
					<span style="color: red;">未还款</span>
				</c:if>
				<c:if test="${factoryOrder.repaymentStatus==3 }">
					<span style="color: green;">已还款</span>
					${ factoryOrder.repaymentInfo.repayDate}
				</c:if>
			</td>
			<td style="text-align: center;">
			<%-- <a href="${ctx}/factoryOrder/edit?dbid=${factoryOrder.dbid}" class="aedit">编辑</a> |  --%>
				<c:if test="${factoryOrder.repaymentStatus==3 }">
					<a href="javascript:void(-1)" class="aedit"  onclick="$.utile.openDialog('${ctx}/repaymentInfo/view?factoryOrderId=${factoryOrder.dbid }','还款',920,400)">查看还款</a>
					<c:if test="${sessionScope.user.userId=='admin' }">
						| <a href="javascript:void(-1)" class="aedit" onclick="$.utile.operatorDataByDbid('${ctx}/repaymentInfo/setRepaymentWaiting?factoryOrderId=${factoryOrder.dbid}','searchPageForm','确定要设置为未还款吗？')" title="标记未换货">标记未还款</a>
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
</html>
