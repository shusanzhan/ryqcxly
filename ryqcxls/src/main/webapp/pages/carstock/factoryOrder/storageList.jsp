<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="../../commons/taglib.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html lang="en">
<head>
<title>库存综合管理</title>
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
	<a href="javascript:void(-1);" onclick="">库存综合管理</a>
</div>
 <!--location end-->
<div class="line"></div>
<div class="listOperate">
	<div class="operate">
		<%-- <a class="but butSave" href="javascript:void();" onclick="operatorLocation('${ctx }/factoryOrder/factoryOrderDetail')">车辆日志</a> --%>
   	</div>
  	<div class="seracrhOperate">
  		<form name="searchPageForm" id="searchPageForm"  action="${ctx}/factoryOrder/storageList" method="post" >
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
  				<td><label>性质：</label></td>
  				<td>
  					<select class="text small" id="orderAttr" name="orderAttr"  onchange="$('#searchPageForm')[0].submit()">
						<option value="0" >请选择...</option>
						<option value="寄售订单" ${param.orderAttr=='寄售订单'?'selected="selected"':'' } >寄售订单</option>
						<option value="自有资金" ${param.orderAttr=='自有资金'?'selected="selected"':'' } >自有资金</option>
						<option value="金融贷款" ${param.orderAttr=='金融贷款'?'selected="selected"':'' } >金融贷款</option>
					</select>
  				</td>
  				<td><label>VIN码：</label></td>
  				<td>
  					<input type="text" id="vinCode" name="vinCode" value="${param.vinCode }" class="text small">
  				</td>
  				<td><label>原始进货商：</label></td>
  				<td>
  					<select class="text small" id="sourceCompanyId" name="sourceCompanyId"  onchange="$('#searchPageForm')[0].submit()">
						<option value="0" >请选择...</option>
						<c:forEach var="enterprise" items="${enterprises }">
							<option value="${enterprise.dbid }" ${param.sourceCompanyId==enterprise.dbid?'selected="selected"':'' } >${enterprise.name }</option>
						</c:forEach>
					</select>
  				</td>
  			</tr>
  			<tr>
  				<td><label>管理公司：</label></td>
  				<td>
  					<select class="text small" id="storeCompanyId" name="storeCompanyId"  onchange="$('#searchPageForm')[0].submit()">
						<option value="0" >请选择...</option>
						<c:forEach var="enterprise" items="${enterprises }">
							<option value="${enterprise.dbid }" ${param.storeCompanyId==enterprise.dbid?'selected="selected"':'' } >${enterprise.name }</option>
						</c:forEach>
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
  				<td><label>库存状态：</label></td>
  				<td>
  					<select class="text small" id="carStatus" name="carStatus"  onchange="$('#searchPageForm')[0].submit()">
						<option value="0" >请选择...</option>
						<option value="2" ${param.carStatus==2?'selected="selected"':'' } >在库</option>
						<option value="3" ${param.carStatus==3?'selected="selected"':'' } >已出库</option>
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
  				<td><label>区域：</label></td>
  				<td>
  					<select class="text small" id="storeAreaId" name="storeAreaId"  onchange="$('#searchPageForm')[0].submit()">
						<option value="0" >请选择...</option>
						<c:forEach var="storeArea" items="${storeAreas }">
							<option value="${storeArea.dbid }" ${param.storeAreaId==storeArea.dbid?'selected="selected"':'' } >${storeArea.name }</option>
						</c:forEach>
					</select>
  				</td>
  				<td><label>库房：</label></td>
  				<td>
  					<select class="text small" id="storeRoomId" name="storeRoomId"  onchange="$('#searchPageForm')[0].submit()">
						<option value="0" >请选择...</option>
						<c:forEach var="storeRoom" items="${storeRooms }">
							<option value="${storeRoom.dbid }" ${param.storeRoomId==storeRoom.dbid?'selected="selected"':'' } >${storeRoom.name }</option>
						</c:forEach>
					</select>
  				</td>
  				<%-- <td><label>库位：</label></td>
  				<td>
  					<select class="text small" id="storageId" name="storageId"  onchange="$('#searchPageForm')[0].submit()">
						<option value="0" >请选择...</option>
						<c:forEach var="storage" items="${storages }">
							<option value="${storage.dbid }" ${param.storageId==storage.dbid?'selected="selected"':'' } >${storage.name }</option>
						</c:forEach>
					</select>
  				</td> --%>
  				<td><div href="javascript:void(-1)" onclick="$('#searchPageForm')[0].submit()" class="searchIcon"></div></td>
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
			<td style="width: 200px;">名称</td>
			<td style="width: 60px;">进货商</td>
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
			<td style="width:120px;">库房</td>
			<td style="width:60px;">库存状态</td>
			<td style="width:60px;">车辆状态</td>
			<td style="width:80px;">创建时间</td>
			<td style="width: 100px;">操作</td>
		</tr>
	</thead>
	<tbody>
		<c:forEach items="${page.result }" var="factoryOrder">
		<tr >
			<td style="text-align: center;">
					<input type="checkbox"   name="id" id="id1" value="${factoryOrder.dbid }">
			</td>
			<td align="left" style="text-align: left;">
				<c:set value="${factoryOrder.carSeriy.name }${factoryOrder.carModel.name }${factoryOrder.carColor.name }" var="name"></c:set>
				<div class="dropDownContent" onmousemove="fn(this,event)" onmouseout="hiden(this)">
					<c:if test="${fn:length(name)>28 }" var="status">
						${fn:substring(name,0,28) }...
					</c:if>
					<c:if test="${status==false}">
						${name }
					</c:if>
					${factoryOrder.vinCode}
					<div class="drop_down_menu hiden" onmousemove="show(this)" onmouseout="hi(this)" >
					    <ul>
					      <li class="drop_down_menu_active"><a href="javascript:void(-1)" class="aedit" onclick="window.location.href='${ctx }/factoryOrder/factoryOrderDetail?dbid=${factoryOrder.dbid}&type=1'">车辆档案</a></li>
					      <li ><a href="javascript:void(-1)" class="aedit" onclick="window.location.href='${ctx }/factoryOrder/factoryOrderDetail?dbid=${factoryOrder.dbid}&type=4'">车辆日志</a></li>
					      <c:if test="${factoryOrder.enterprise.dbid==enterprise.dbid }">
					     	 <li><a href="javascript:void(-1)" class="aedit" onclick="$.utile.openDialog('${ctx}}/factoryOrder/reward?dbid=${factoryOrder.dbid }','添加特殊奖',800,300)">添加特殊奖</a> </li>
						      <c:if test="${factoryOrder.carStatus<3 }">
						     	 <li><a href="javascript:void(-1)" class="aedit" onclick="$.utile.openDialog('${ctx}}/refundCar/add?dbid=${factoryOrder.dbid }','填写退库记录',800,340)">退库记录</a> </li>
						      </c:if>
					      </c:if>
					    </ul>
					  </div>
				</div>
			</td>
			<td>
				${factoryOrder.sourceCompany.name}
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
			
			<td class="tip" >
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
				<c:if test="${empty(factoryOrder.storeCompany) }">
					在途
				</c:if>
				<c:if test="${!empty(factoryOrder.storeCompany) }">
					${factoryOrder.storeCompany.name }
				</c:if>
				<c:if test="${factoryOrder.enterprise.dbid==enterprise.dbid }" var="status">
					<span style="color: green;">（自有）</span>
				</c:if>
				<c:if test="${status==false }">
					<span style="color: red;">（分公司）</span>
				</c:if>
			</td>
			 <td>
				<c:set value="${factoryOrder.carReceiving }" var="carReceiving"></c:set>
				<span style="color: green;">
					<a href="${ctx }/factoryOrder/factoryOrderDetail?dbid=${factoryOrder.dbid}&type=3" class="" style="color: #46A0DE;">
						${carReceiving.storeArea.name }&nbsp;
						${carReceiving.storeRoom.name }&nbsp;
						${carReceiving.storage.name }</a>
				</span>
			</td>
			<td>
				<c:if test="${factoryOrder.carStatus==2 }">
					<span style="color: red;">在库</span>
					<br>
					<c:if test="${factoryOrder.reserveStatus==2 }">
						<a href="${ctx }/factoryOrder/factoryOrderDetail?dbid=${factoryOrder.dbid}&type=6" class="" style="color: #46A0DE;">已经绑定</a>
						<c:if test="${!empty(factoryOrder.saleApplyEnterPrise) }">
							(${factoryOrder.saleApplyEnterPrise.name })
						</c:if>
					</c:if>
					<c:if test="${factoryOrder.reserveStatus==3 }">
						<a href="${ctx }/factoryOrder/factoryOrderDetail?dbid=${factoryOrder.dbid}&type=6" class="" style="color: #46A0DE;">已预定</a>
					</c:if>
				</c:if>
				<c:if test="${factoryOrder.carStatus==3 }">
					<span style="color: red;">待移交</span>
				</c:if>
			</td>
			<td>
				<c:if test="${factoryOrder.abnormalStatus==1 }">
					<span style="color: green;">正常</span>
				</c:if>
				<c:if test="${factoryOrder.abnormalStatus==2 }">
					<span style="color: red;">异常</span>
				</c:if>
			</td>
			<td>
				<fmt:formatDate value="${factoryOrder.createDate}" pattern="yyyy-MM-dd"/> 
			</td>
			<td style="text-align: left;">
			<c:if test="${factoryOrder.carStatus==2 }">
				<c:if test="${factoryOrder.storeCompany.dbid==enterprise.dbid }">
					<c:if test="${!empty(carReceiving) }">
						<a href="javascript:void(-1)" class="aedit"  onclick="$.utile.openDialog('${ctx}/carReceiving/transfer?factoryOrderId=${factoryOrder.dbid }','车辆移库',920,500)">移库</a>
						|
					</c:if>
					<%-- <a href="${ctx}/installDecoration/add?factoryOrderId=${factoryOrder.dbid }" class="aedit" >加装装饰</a> --%>
					<br>
				</c:if>
				 <c:if test="${factoryOrder.enterprise.dbid==enterprise.dbid }">
					<a href="${ctx}/factoryOrder/edit?dbid=${factoryOrder.dbid}&directType=2" class="aedit">编辑</a>
				</c:if>
			</c:if>
			<c:if test="${factoryOrder.carStatus==3 }">
				<a href="javascript:void(-1)" class="aedit"  onclick="$.utile.openDialog('${ctx}/carReceiving/transfer?factoryOrderId=${factoryOrder.dbid }','车辆移库',920,500)">移库</a>
				|
				<a href="javascript:void(-1)" class="aedit"  onclick="$.utile.openDialog('${ctx}/carHandOver/handOver?factoryOrderId=${factoryOrder.dbid }','移交车辆',1024,600)">移交车辆</a>
				<br>
			</c:if>
			<!-- 当前管理公司绝版标记车辆异常权限 -->
			<c:if test="${factoryOrder.storeCompany.dbid==enterprise.dbid }">
				<a href="javascript:void(-1)" class="aedit"  onclick="$.utile.openDialog('${ctx}/factoryOrder/abnormal?factoryOrderId=${factoryOrder.dbid }','标记车辆',920,500)">标记车辆</a>
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
