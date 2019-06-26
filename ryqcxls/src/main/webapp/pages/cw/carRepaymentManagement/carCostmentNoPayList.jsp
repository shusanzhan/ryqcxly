<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="../../commons/taglib.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html lang="en">
<head>
<title>还款管理</title>
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
	<a href="javascript:void(-1);" onclick="">成本登记</a>
</div>
 <!--location end-->
<div class="line"></div>
<div class="listOperate">
	<div class="operate">
		<a class="but button" href="javascript:void();" onclick="saveMore()">批量付款</a>
   	</div>
  	<div class="seracrhOperate">
  		<form name="searchPageForm" id="searchPageForm"  action="${ctx}/carRepaymentManagement/queryCarCostmentNoPayList" method="post" >
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
					<span><input type="checkbox" name="title-table-checkbox" id="title-table-checkbox" onclick="selectAll(this,'id')" onchange="sum()"></span>
				</div></td>
			<td style="width: 200px;">名称</td>
			<td style="width: 80px;">vin码</td>
			<td style="width: 50px;">执行价</td>
			<td style="width: 50px;">工厂价</td>
			<td style="width: 60px;">应付成本价</td>
			<td style="width:70px;">工厂日期</td>
			<td style="width:60px;">订单性质</td>
			<td style="width:50px;">库龄</td>
			<td style="width:50px;">库存状态</td>
			<td style="width:100px;">出库日期</td>
			<td style="width:70px;">车辆付款状态</td>
			<td style="width:100px;">DMS上传日期</td>
			<td style="width: 80px;">操作</td>
		</tr>
	</thead>
	<tbody>
		<c:forEach items="${page.result }" var="factoryOrder">
		<tr >
			<td style="text-align: center;">
					<input type="checkbox"   name="id" id="id1" value="${factoryOrder.dbid }" onchange="sum()">
			</td>
			<td>
				<c:set value="${factoryOrder.carSeriy.name }${factoryOrder.carModel.name }${factoryOrder.carColor.name }" var="name"></c:set>
				<div class="dropDownContent" onmousemove="fn(this,event)" onmouseout="hiden(this)">
						${name }
					<div class="drop_down_menu hiden" onmousemove="show(this)" onmouseout="hi(this)" >
					    <ul>
					     <c:if test="${factoryOrder.copyStatus==1 }">
						      <li class="drop_down_menu_active"><a href="javascript:void(-1)" class="aedit" onclick="window.location.href='${ctx }/carRepaymentManagement/factoryOrderDetail?dbid=${factoryOrder.dbid}&type=1'">车辆档案</a></li>
					     </c:if>
					     <c:if test="${factoryOrder.copyStatus==2 }">
						      <li class="drop_down_menu_active"><a href="javascript:void(-1)" class="aedit" onclick="window.location.href='${ctx }/carRepaymentManagement/factoryOrderDetail?dbid=${factoryOrder.copyFactoryOrderId}&type=1'">车辆档案</a></li>
					     </c:if>
					     <c:if test="${empty factoryOrder.copyStatus }">
						      <li class="drop_down_menu_active"><a href="javascript:void(-1)" class="aedit" onclick="window.location.href='${ctx }/carRepaymentManagement/factoryOrderDetail?dbid=${factoryOrder.dbid}&type=1'">车辆档案</a></li>
					     </c:if>
					    </ul>
					  </div>
				</div> 
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
				<span style="color:red">${factoryOrder.presaleRebate }</span>
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
				未登记
			</td>
			<td>
				<c:if test="${empty(factoryOrder.dmsFileUpdate) }">
					未上传
				</c:if>
				<c:if test="${!empty(factoryOrder.dmsFileUpdate) }">
					${factoryOrder.dmsFileUpdate }
				</c:if>
			</td>
			<td style="text-align: center;">
				<a href="javascript:void(-1)" class="aedit"  onclick="$.utile.openDialog('${ctx}/carRepaymentManagement/addSingleRegister?factoryOrderId=${factoryOrder.dbid }','登记',920,400)">登记</a>
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
<script type="text/javascript">
function exportExcel(){
	var dbids=getCheckBox();
	if(null==dbids||dbids==''){
		alert("请勾选导出数据！");
		return false;
	}
	window.location.href='${ctx}/factoryOrder/downVinCode?dbids='+dbids;
}
function saveMore(){
	/* var dbids=getCheckBox();
	if(null==dbids||dbids==''){
		alert("请勾选批量登记数据！");
		return false;
	}*/
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
			content : '请选择批量金融付款数据！',
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
		content : '确定对【'+length+'】客户,总金额<span style="color:red;">【￥'+sum()+'】</span>进行批量金融付款吗?',
		icon : 'question',
		width:"250px",
		height:"80px",
		lock : true,
		ok : function() {
			var url = '${ctx}/carRepaymentManagement/saveBatchRegister?dbids='+dbids;
			$.utile.submitAjaxForm12(url);
		},
		cancel : true
	});
	$.utile.submitAjaxForm12 = function(url) {
		try {
					$.ajax({	
						url : url, 
						async : false, 
						timeout : 20000, 
						dataType : "json",
						type:"post",
						success : function(data, textStatus, jqXHR){
							//alert(data.message);
							var obj;
							if(data.message!=undefined){
								obj=$.parseJSON(data.message);
							}else{
								obj=data;
							}
							if(obj[0].mark==1){
								//错误
								$.utile.tips(obj[0].message);
								$(".butSave").attr("onclick",url2);
								return ;
							}else if(obj[0].mark==0){
								window.location.href='${ctx}/carRepaymentManagement/queryCarCostmentNoPayList';
							}
						},
						complete : function(jqXHR, textStatus){
							$(".butSave").attr("onclick",url2);
							var jqXHR=jqXHR;
							var textStatus=textStatus;
						}, 
						beforeSend : function(jqXHR, configs){
							url2=$(".butSave").attr("onclick");
							$(".butSave").attr("onclick","");
							var jqXHR=jqXHR;
							var configs=configs;
						}, 
						error : function(jqXHR, textStatus, errorThrown){
								$.utile.tips("系统请求超时");
								$(".butSave").attr("onclick",url2);
						}
					});
		} catch (e) {
			$.utile.tips(e);
			return;
		}
	}
}
/** 获取checkBox的value* */
function getCheckBox() {
	var array = new Array();
	var checkeds = $("input[type='checkbox'][name='id']");
	$.each(checkeds, function(i, checkbox) {
		if (checkbox.checked) {
			array.push(checkbox.value);
		}
	});
	return array.toString();
}
function sum(){
	var len = $("input[name='id']:checked");
	var sum = 0;
	for(var i=0;i<len.size();i++){
		var check = len.eq(i);
		var tds = check.parent().siblings();
		if(tds.eq(4).text()!=null && tds.eq(4).text()!=''){
			sum = sum + parseFloat(tds.eq(4).text());
		}
	}
	$("#total").css("display","");
	$("#totals").text(sum);
	return sum;
}
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
</body>
</html>
