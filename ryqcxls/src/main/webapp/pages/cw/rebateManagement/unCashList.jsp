<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="../../commons/taglib.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html lang="en">
<head>
<title>工厂返利收银</title>
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
	<a href="javascript:void(-1);" onclick="">工厂返利录入收银</a>
</div>
 <!--location end-->
<div class="line"></div>
<div class="listOperate">
		<div class="operate">
		 <a  href="javascript:void(-1)" class="but button"  onclick="batchCash()">批量收银</a> 
   </div>
  	<div class="seracrhOperate">
  		<form name="searchPageForm" id="searchPageForm"  action="${ctx}/rebateManagement/queryUnCashList" method="post" >
		<input type="hidden" id="currentPage" name="currentPage" value='${page.currentPageNo}'>
		<input type="hidden" id="paramPageSize" name="pageSize" value='${page.pageSize}'>
		<table cellpadding="0" cellspacing="0" class="searchTable" >
  			<tr>
  				<td><label>VIN码：</label></td>
  				<td>
  					<input type="text" id="vinCode" name="vinCode" value="${param.vinCode }" class="text large">
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
			<td style="width: 20px;">
				<div class="checker" id="uniform-title-table-checkbox">
					<span><input type="checkbox" name="title-table-checkbox" id="title-table-checkbox" onclick="selectAll(this,'id')"></span>
				</div>
			</td>
			<td style="width: 200px;">名称</td>
			<td style="width: 80px;">vin码</td>
			<td style="width: 80px;">进货商</td>
			<td style="width: 80px;">物料号</td>
			<td style="width: 50px;">执行价</td>
			<td style="width: 50px;">工厂价</td>
			<td style="width:70px;">工厂日期</td>
			<td style="width:70px;">返利总额</td>
			<td style="width:70px;">返利未收金额</td>
			<td style="width: 100px;">操作</td>
		</tr>
	</thead>
	<tbody>
		<c:forEach items="${page.result }" var="factoryOrder">
		<tr >
			<td style="text-align: center;">
					<input type="checkbox"   name="id" value="${factoryOrder.dbid }" onchange="sum()" />
			</td>
			<td>
				<span style="color:#2b7dbc">
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
				<fmt:formatDate value="${factoryOrder.factoryOrderDate}" pattern="yyyy-MM-dd"/> 
			</td>
			<td>
				<ystech:factoryRebateMoney factoryOrderId="${factoryOrder.dbid }" />
			</td>
			<td>
				<ystech:factoryRebateUnCashMoney factoryOrderId="${factoryOrder.dbid}" />
			</td>
			<td style="text-align: center;">
				<a href="${ctx}/rebateManagement/cashRebate?factoryOrderId=${factoryOrder.dbid}" class="aedit"><span style="color:#2b7dbc">工厂返利收银</span></a>
			</td>
		</tr>
		</c:forEach>
	</tbody>
</table>
</c:if>
<div id="fanye">
	<%@ include file="../../commons/commonPagination.jsp" %>
</div>
<p id="total" style="display:none;font-size:20px;color:red;cursor:hand">总额:<span id="totals"></span></p>
</body>
<script type="text/javascript">
function batchCash(){
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
			content : '请选择批量收银数据！',
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
		content : '确定对【'+length+'】客户,总金额<span style="color:red;">【￥'+sum()+'】</span>进行批量收银吗?',
		icon : 'question',
		width:"250px",
		height:"80px",
		lock : true,
		ok : function() {
			window.location.href="${ctx }/rebateManagement/batchCash?dbids="+dbids;
		},
		cancel : true
	});
}
function sum(){
	var len = $("input[name='id']:checked");
	var sum = 0;
	for(var i=0;i<len.size();i++){
		var check = len.eq(i);
		var tds = check.parent().siblings();
		if(tds.eq(8).text()!=null && tds.eq(8).text()!=''){
			sum = sum + parseFloat(tds.eq(8).text());
		}
	}
	$("#total").css("display","");
	$("#totals").text(sum);
	return sum;
}
</script>
</html>
