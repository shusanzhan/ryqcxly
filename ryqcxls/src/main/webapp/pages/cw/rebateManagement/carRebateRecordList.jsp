<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="../../commons/taglib.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html lang="en">
<head>
<title>车辆返利记录</title>
<meta charset="UTF-8" />
<meta name="viewport" content="width=device-width, initial-scale=1.0" />
<link href="${ctx }/css/common.css" type="text/css" rel="stylesheet"/>
<script type="text/javascript" src="${ctx }/widgets/bootstrap3/jquery.min.js"></script>
<script type="text/javascript" src="${ctx }/widgets/utile/utile.js"></script>
<script type="text/javascript" src="${ctx }/widgets/easyvalidator/js/easy_validator.pack.js"></script>
<script type="text/javascript" src="${ctx }/widgets/artDialog/artDialog.js?skin=default"></script>
<script type="text/javascript" src="${ctx }/widgets/artDialog/plugins/iframeTools.source.js"></script>
<script type="text/javascript" src="${ctx }/widgets/My97DatePicker/WdatePicker.js"></script>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<style type="text/css">
</style>
</head>
<body class="bodycolor">
<div class="location">
	<img src="${ctx}/images/homeIcon.png"/> &nbsp;
	<a href="javascript:void(-1);" onclick="window.parent.location.href='${ctx}/main/index'">首页</a>-
	<a href="javascript:void(-1);" onclick="">车辆返利记录</a>
</div>
 <!--location end-->
<div class="line"></div>
<div class="listOperate">
  	<div class="seracrhOperate">
  		<form name="searchPageForm" id="searchPageForm"  action="${ctx}/rebateManagement/queryCarRebateRecordList" method="post" >
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
  			</tr>
  			<tr>
  				<td><label>VIN码：</label></td>
  				<td>
  					<input type="text" id="vinCode" name="vinCode" value="${param.vinCode }" class="text midea">
  				</td>
  				<td><label>返利状态：</label></td>
  				<td>
  					<select class="text midea" id="factoryRebateState" name="factoryRebateState" onchange="$('#searchPageForm')[0].submit()">
  						<option value="0">请选择...</option>
  						<option value="1" ${param.factoryRebateState==1?'selected="selected"':'' }>未录入</option>
  						<option value="2" ${param.factoryRebateState==2?'selected="selected"':'' }>已录入</option>
  						<option value="3" ${param.factoryRebateState==3?'selected="selected"':'' }>返利到账</option>
  					</select>
  				</td>
  				<td><label>工厂日期：</label></td>
  				<td colspan="1">
  					<input class="text small" id="factoryOrderDateStart" name="factoryOrderDateStart" onFocus="WdatePicker({isShowClear:true,readOnly:true})" value="${param.factoryOrderDateStart }" >~
  				</td>
  				<td>
  					<input class="text small" id="factoryOrderDateEnd" name="factoryOrderDateEnd" onFocus="WdatePicker({isShowClear:true,readOnly:true})" value="${param.factoryOrderDateEnd }">
				</td>
   			</tr>
   			<tr>
   				<td><label>创建日期：</label></td>
  				<td colspan="1">
  					<input class="text small" id="createDateStart" name="createDateStart" onFocus="WdatePicker({isShowClear:true,readOnly:true})" value="${param.createDateStart }" >~
  				</td>
  				<td>
  					<input class="text small" id="createDateEnd" name="createDateEnd" onFocus="WdatePicker({isShowClear:true,readOnly:true})" value="${param.createDateEnd }">
				</td>
  				<td><div href="javascript:void(-1)" onclick="$('#searchPageForm')[0].submit()" class="searchIcon" ></div></td>
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
			<td style="width: 150px;">名称</td> 
			<td style="width: 80px;">vin码</td>
			<td style="width: 80px;">进货商</td>
			<td style="width: 80px;">物料号</td>
			<td style="width: 50px;">执行价</td>
			<td style="width: 50px;">工厂价</td>
			<td style="width:50px;">返利状态</td>
			<td style="width:70px;">工厂日期</td>
			<td style="width:80px;">创建时间</td>
			<td style="width:50px;">操作</td>
		</tr>
	</thead>
	<tbody>
		<c:forEach items="${page.result }" var="factoryOrder">
		<tr >
			<td style="text-align:left; ">
				<span style="text-align: left;">
				${factoryOrder.carSeriy.name }
				${factoryOrder.carModel.name }
				${factoryOrder.carColor.name }
				</span>
			</td>
			<td>
				${factoryOrder.vinCode}
			</td>
			<td>
				${factoryOrder.sourceCompany.name}
			</td>
			<td class="tip" tip="物料描述：${factoryOrder.materialDes}">
				<a href="javascript:void(-1)" class="" style="color: #46A0DE;">${factoryOrder.materialNumber}</a>
			</td>
			<td>
				${factoryOrder.marketPrice}
			</td>
			<td>
				${factoryOrder.factoryPrice}
			</td>
			<td>
				<c:if test="${factoryOrder.factoryRebateState eq 1}">
					<span style="color:red">未录入</span>
				</c:if>
				<c:if test="${factoryOrder.factoryRebateState eq 2}">
					<span style="color:green">已录入</span>
				</c:if>
				<c:if test="${factoryOrder.factoryRebateState eq 3}">
					到帐</span>
				</c:if>
			</td>
			<td>
				<fmt:formatDate value="${factoryOrder.factoryOrderDate}" pattern="yyyy-MM-dd"/> 
			</td>
			<td>
				<fmt:formatDate value="${factoryOrder.createDate}" pattern="yyyy-MM-dd"/> 
			</td>
			<td>
				<c:if test="${factoryOrder.factoryRebateState eq 1}">
					<a href="${ctx}/rebateManagement/editRebate1?dbid=${factoryOrder.dbid}&type=3" style="color:#2b7dbc" class="aedit">录入工厂返利</a>
				</c:if>
				<c:if test="${factoryOrder.factoryRebateState eq 2}">
					<a href="${ctx}/rebateManagement/editRebate1?dbid=${factoryOrder.dbid}&type=3" style="color:#2b7dbc" class="aedit">编辑工厂返利</a>
				</c:if>
				<c:if test="${factoryOrder.factoryRebateState eq 3}">
					<a href="${ctx}/rebateManagement/cashDetail?factoryOrderId=${factoryOrder.dbid}" style="color:#2b7dbc"  class="aedit">查看返利</a>
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
function batchEntry	(){
	var checkeds = $("input[type='checkbox'][name='id']");
	var length = 0;
	$.each(checkeds, function(i, checkbox) {
		if (checkbox.checked) {
			length++;
		}
	})
	if (length <= 0) {
		window.top.art.dialog({
			icon : 'warning',
			title : '警告',
			content : '请选择批量返利录入数据！',
			cancelVal : '关闭',
			lock : true,
			time : 3,
			width:"250px",
			height:"80px",
			cancel : true
		// 为true等价于function(){}
		});
		return false;
	}
	var dbids=getCheckBox();
	window.top.art.dialog({
		content : '确定对【'+length+'】车辆进行批量返利录入吗?',
		icon : 'question',
		width:"250px",
		height:"80px",
		lock : true,
		ok : function() {
			window.location.href="${ctx }/rebateManagement/optionRebateType?dbids="+dbids+"&type=1";
		},
		cancel : true
	});
}
</script>
</html>
