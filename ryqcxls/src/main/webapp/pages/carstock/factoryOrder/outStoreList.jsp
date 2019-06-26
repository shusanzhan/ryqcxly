<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="../../commons/taglib.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html lang="en">
<head>
<title>车辆出库管理</title>
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
<script type="text/javascript">
//客户管理文档相关
function operatorLocation(url){
	// 删除数据前验证选择数据
	var checkeds = $("input[type='checkbox'][name='id']");
	var length = 0;
	$.each(checkeds, function(i, checkbox) {
		if (checkbox.checked) {
			length++;
		}
	})
	if(length >1){
		warm("一次只能选择一条数据！");
		return ;
	}
	if(length<=0){
		warm("请先选择操作数据！");
		return ;
	}
	if(length<=1) {
		var dbid=getCheckBox();
		url=url+"?dbid="+dbid+"&type=4";
		window.location.href=url;
	}
}
function order(value){
	if(value==1){
		$("#orderNum").val(2);
	}
	if(value==2){
		$("#orderNum").val(1);
	}
	if(value==3){
		$("#orderNum").val(4);
	}
	if(value==4){
		$("#orderNum").val(3);
	}
	$('#searchPageForm')[0].submit();
}
</script>
</head>
<body class="bodycolor">
<div class="location">
	<img src="${ctx}/images/homeIcon.png"/> &nbsp;
	<a href="javascript:void(-1);" onclick="window.parent.location.href='${ctx}/main/index'">首页</a>-
	<a href="javascript:void(-1);" onclick="">车辆出库管理</a>
</div>
 <!--location end-->
<div class="line"></div>
<div class="listOperate">
	<div class="operate">
		<%--  <a class="but butSave" href="javascript:void();" onclick="operatorLocation('${ctx }/factoryOrder/factoryOrderDetail')">车辆日志</a>  --%>
   	</div>
  	<div class="seracrhOperate">
  		<form name="searchPageForm" id="searchPageForm"  action="${ctx}/factoryOrder/outStoreList" method="post" >
		<input type="hidden" id="currentPage" name="currentPage" value='${page.currentPageNo}'>
		<input type="hidden" id="paramPageSize" name="pageSize" value='${page.pageSize}'>
		<c:if test="${empty(param.orderNum) }">
			<input type="hidden" id="orderNum" name="orderNum" value='1'>
		</c:if>
		<c:if test="${!empty(param.orderNum) }">
			<input type="hidden" id="orderNum" name="orderNum" value='${param.orderNum }'>
		</c:if>
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
  				<td><label>颜色：</label></td>
  				<td>
  					<select class="text small" id="carColorId" name="carColorId"  onchange="$('#searchPageForm')[0].submit()">
						<option value="0" >请选择...</option>
						<c:forEach var="carColor" items="${carColors }">
							<option value="${carColor.dbid }" ${param.carColorId==carColor.dbid?'selected="selected"':'' } >${carColor.name }</option>
						</c:forEach>
					</select>
  				</td>
  				<td><label>VIN码：</label></td>
  				<td>
  					<input type="text" id="vinCode" name="vinCode" value="${param.vinCode }" class="text small">
  				</td>
  				<td><label>惠民：</label></td>
  				<td>
  					<select class="text small" id="huimin" name="huimin"  onchange="$('#searchPageForm')[0].submit()">
						<option value="" >请选择...</option>
						<option value="惠民" ${param.huimin=='惠民'?'selected="selected"':'' } >惠民</option>
						<option value="非惠民" ${param.huimin=='非惠民'?'selected="selected"':'' } >非惠民</option>
					</select>
  				</td>
  				<td><div href="javascript:void(-1)" onclick="$('#searchPageForm')[0].submit()" class="searchIcon"></div></td>
  			</tr>
  			<tr>
  				
  				<td><label>性质：</label></td>
  				<td>
  					<select class="text small" id="orderAttr" name="orderAttr"  onchange="$('#searchPageForm')[0].submit()">
						<option value="0" >请选择...</option>
						<option value="寄售订单" ${param.orderAttr=='寄售订单'?'selected="selected"':'' } >寄售订单</option>
						<option value="自有资金" ${param.orderAttr=='自有资金'?'selected="selected"':'' } >自有资金</option>
						<option value="金融贷款" ${param.orderAttr=='金融贷款'?'selected="selected"':'' } >金融贷款</option>
					</select>
  				</td>
  				<td><label>加装：</label></td>
  				<td>
  					<select class="text small" id="isInstall" name="isInstall"  onchange="$('#searchPageForm')[0].submit()">
						<option value="0" >请选择...</option>
						<option value="1" ${param.isInstall==1?'selected="selected"':'' } >未加装</option>
						<option value="2" ${param.isInstall==2?'selected="selected"':'' } >加装</option>
					</select>
  				</td>
  				<td><label>库存等级：</label></td>
  				<td>
  					<select class="text small" id="storeAgeLevelId" name="storeAgeLevelId"  onchange="$('#searchPageForm')[0].submit()">
						<option value="0" >请选择...</option>
						<c:forEach var="storeAgeLevel" items="${storeAgeLevels }">
							<option value="${storeAgeLevel.dbid }" ${param.storeAgeLevelId==storeAgeLevel.dbid?'selected="selected"':'' } >${storeAgeLevel.name }</option>
						</c:forEach>
					</select>
  				</td>
  				<td><label>进货商：</label></td>
  				<td>
  					<select class="text small" id="sourceCompanyId" name="sourceCompanyId"  onchange="$('#searchPageForm')[0].submit()">
						<option value="0" >请选择...</option>
						<c:forEach var="storeCompany" items="${enterprises }">
							<option value="${storeCompany.dbid }" ${param.sourceCompanyId==storeCompany.dbid?'selected="selected"':'' } >${storeCompany.name }</option>
						</c:forEach>
					</select>
  				</td>
  				<td><label>管理公司：</label></td>
  				<td>
  					<select class="text small" id="storeCompanyId" name="storeCompanyId"  onchange="$('#searchPageForm')[0].submit()">
						<option value="0" >请选择...</option>
						<c:forEach var="storeCompany" items="${enterprises }">
							<option value="${storeCompany.dbid }" ${param.storeCompanyId==storeCompany.dbid?'selected="selected"':'' } >${storeCompany.name }</option>
						</c:forEach>
					</select>
  				</td>
  			</tr>
   		</table>
   		</form>
   	</div>
   	<div class="clear" style="clear: both;"></div>
</div>

<c:if test="${empty(page.result)||page.result==null }" var="status">
	<div class="alert alert-info" style="margin-top: 24px;">
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
			<td style="width: 180px;">名称</td>
			<td style="width: 50px;">执行价</td>
			<td style="width: 50px;">工厂价</td>
			<td style="width:70px;">工厂日期</td>
			<td style="width:60px;">种类</td>
			<td style="width:60px;">性质</td>
			<td style="width:50px;">
				<c:if test="${empty(param.orderNum) }">
						<a href="javascript:void(-1)" onclick="order(3)" class="dropDownContent" style="font-weight: normal;" title="点击排序">
							库龄
							<span style="color: red;font-size: 14px;">↓</span>
						</a>
				</c:if>
				<c:if test="${param.orderNum<3 }">
						<a href="javascript:void(-1)" onclick="order(3)" class="dropDownContent" style="font-weight: normal;" title="点击排序">
							库龄
						</a>
				</c:if>
				<c:if test="${param.orderNum==3 }">
					<a href="javascript:void(-1)" onclick="order(3)" class="dropDownContent" style="font-weight: normal;" title="点击排序">
						库龄
						<span style="color: red;font-size: 14px;">↓</span>
					</a>
				</c:if>
				<c:if test="${param.orderNum==4 }">
					<a href="javascript:void(-1)" onclick="order(4)" class="dropDownContent" style="font-weight: normal;" title="点击排序">
						库龄<span style="color: red;font-size: 14px;">↑</span>
					</a>
				</c:if>
			</td>
			<td style="width:50px;">
					<c:if test="${empty(param.orderNum)||param.orderNum>2 }">
						<a href="javascript:void(-1)" onclick="order(1)" class="dropDownContent" style="font-weight: normal;" title="点击排序">
								奖励<span style="color: red;font-size: 14px;"></span>
							</a>
					</c:if>
					<c:if test="${param.orderNum==1 }">
						<a href="javascript:void(-1)" onclick="order(1)" class="dropDownContent" style="font-weight: normal;" title="点击排序">
							奖励<span style="color: red;font-size: 14px;">↓</span>
						</a>
					</c:if>
					<c:if test="${param.orderNum==2 }">
						<a href="javascript:void(-1)" onclick="order(2)" class="dropDownContent" style="font-weight: normal;" title="点击排序">
							奖励<span style="color: red;font-size: 14px;">↑</span>
						</a>
					</c:if>
			</td>
			<td style="width:40px;">加装</td>
			<td style="width:60px;">管理公司</td>
			<td style="width:80px;">库房</td>
			<td style="width:80px;">创建时间</td>
			<td style="width: 80px;">操作</td>
		</tr>
	</thead>
	<tbody>
		<c:forEach items="${page.result }" var="factoryOrder">
		<tr >
			<td style="text-align: center;">
					<input type="checkbox"   name="id" id="id1" value="${factoryOrder.dbid }">
			</td>
			<td style="text-align: left;">
				<c:set value="${factoryOrder.carSeriy.name }${factoryOrder.carModel.name }${factoryOrder.carColor.name }" var="name"></c:set>
				<div class="dropDownContent" onmousemove="fn(this,event)" onmouseout="hiden(this)">
						${name }<br>
						${factoryOrder.vinCode}
					<div class="drop_down_menu hiden" onmousemove="show(this)" onmouseout="hi(this)" >
					    <ul>
					     <c:if test="${factoryOrder.copyStatus==1 }">
						      <li class="drop_down_menu_active"><a href="javascript:void(-1)" class="aedit" onclick="window.location.href='${ctx }/factoryOrder/factoryOrderDetail?dbid=${factoryOrder.dbid}&type=1'">车辆档案</a></li>
						      <li ><a href="javascript:void(-1)" class="aedit" onclick="window.location.href='${ctx }/factoryOrder/factoryOrderDetail?dbid=${factoryOrder.dbid}&type=4'">车辆日志</a></li>
					     </c:if>
					     <c:if test="${factoryOrder.copyStatus==2 }">
						      <li class="drop_down_menu_active"><a href="javascript:void(-1)" class="aedit" onclick="window.location.href='${ctx }/factoryOrder/factoryOrderDetail?dbid=${factoryOrder.copyFactoryOrderId}&type=1'">车辆档案</a></li>
						      <li ><a href="javascript:void(-1)" class="aedit" onclick="window.location.href='${ctx }/factoryOrder/factoryOrderDetail?dbid=${factoryOrder.copyFactoryOrderId}&type=4'">车辆日志</a></li>
					     </c:if>
					    </ul>
					  </div>
				</div>
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
				${factoryOrder.orderType }
			</td>
			<td>
				${factoryOrder.orderAttr }
			</td>
			<td>
				${factoryOrder.storeAgeLevel.name }
			</td>
			<td class="tip" 
				tip="特殊奖励：${factoryOrder.rewardMoney}<br>
				${factoryOrder.storeAgeLevel.name}&nbsp;&nbsp;&nbsp;:
				${factoryOrder.storeAgeLevel.rewardMoney }<br>
				<c:if test="${factoryOrder.orderAttr=='自有资金' }">
					自有资金:${factoryOrderSet.ownCar } 
				</c:if>
				<c:if test="${factoryOrder.orderAttr=='金融贷款' }">
					金融贷款:${factoryOrderSet.loanMoney }元
				</c:if>
			">
				<a href="${ctx }/factoryOrder/factoryOrderDetail?dbid=${factoryOrder.dbid}&type=5" class="" style="color: #46A0DE;">${factoryOrder.totalRewardMoney }</a>
				
			</td>
			 <td>
				<c:if test="${factoryOrder.isInstall==1 }">
					<span style="color: red;">未加装</span>
				</c:if>
				<c:if test="${factoryOrder.isInstall==2 }">
					<a href="${ctx }/factoryOrder/factoryOrderDetail?dbid=${factoryOrder.dbid}&type=2" class="" style="color: #46A0DE;"><span style="color: green;">加装</span></a>
				</c:if>
			</td>
			<td>
				${factoryOrder.storeCompany.name }
			</td>
			 <td>
				<c:set value="${factoryOrder.carReceiving }" var="carReceiving"></c:set>
				<span style="color: green;">
					<a href="${ctx }/factoryOrder/factoryOrderDetail?dbid=${factoryOrder.dbid}&type=3" class="" style="color: #46A0DE;">&nbsp;&nbsp;${carReceiving.storeRoom.name }&nbsp;&nbsp;${carReceiving.storage.name }</a>
				</span>
			</td>
			<td>
				<fmt:formatDate value="${factoryOrder.createDate}" pattern="yyyy-MM-dd"/> 
			</td>
			<td style="text-align: center;">
				<a href="javascript:void(-1)" class="aedit"  onclick="$.utile.operatorDataByDbid('${ctx }/carHandOver/cancelHandOver?factoryOrderId=${factoryOrder.dbid}','searchPageForm','您确定撤销出库吗？')">撤销出库</a>
			</td>
		</tr>
		</c:forEach>
	</tbody>
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
</script>
</body>
</html>
