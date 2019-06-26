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
function order(){
	var orderNum=$("#orderNum").val();
	if(orderNum==1){
		$("#orderNum").val(2);
	}
	if(orderNum==2){
		$("#orderNum").val(1);
	}
	$('#searchPageForm')[0].submit();
}
</script>
</head>
<body class="bodycolor">
<div class="location">
	<img src="${ctx}/images/homeIcon.png"/> &nbsp;
	<a href="javascript:void(-1);" onclick="window.parent.location.href='${ctx}/main/index'">首页</a>-
	<a href="javascript:void(-1);" onclick="">经销商买车</a>
</div>
 <!--location end-->
<div class="line"></div>
<div class="listOperate">
	<div class="operate">
		<%-- <a class="but butSave" href="javascript:void();" onclick="operatorLocation('${ctx }/factoryOrder/factoryOrderDetail')">车辆日志</a> --%>
   	</div>
  	<div class="seracrhOperate">
  		<form name="searchPageForm" id="searchPageForm"  action="${ctx}/orderBuySaler/queryBuyList" method="post" >
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
  					<td><label>申请方：</label></td>
	  				<td>
	  					<select class="text small" id="enterpriseId" name="enterpriseId"  onchange="$('#searchPageForm')[0].submit()">
							<option value="0" >请选择...</option>
							<c:forEach var="enterprise" items="${enterprises }">
								<option value="${enterprise.dbid }" ${param.enterpriseId==enterprise.dbid?'selected="selected"':'' } >${enterprise.name }</option>
							</c:forEach>
						</select>
	  				</td>
  				</tr>
  				<tr>
  					
  					<td><label>确认状态：</label></td>
	  				<td>
	  					<select class="text small" id="confireStatus" name="confireStatus"  onchange="$('#searchPageForm')[0].submit()">
							<option value="0" >请选择...</option>
							<option value="1" ${param.confireStatus==1?'selected="selected"':'' } >待确认</option>
							<option value="2" ${param.confireStatus==2?'selected="selected"':'' } >同意申请</option>
							<option value="3" ${param.confireStatus==3?'selected="selected"':'' } >驳回申请</option>
						</select>
	  				</td>
  					<td><label>发车状态：</label></td>
	  				<td>
	  					<select class="text small" id="sendCarStatus" name="sendCarStatus"  onchange="$('#searchPageForm')[0].submit()">
							<option value="0" >请选择...</option>
							<option value="1" ${param.sendCarStatus==1?'selected="selected"':'' } >待发车</option>
							<option value="2" ${param.sendCarStatus==2?'selected="selected"':'' } >已发车</option>
						</select>
	  				</td>
  					<td><label>收车状态：</label></td>
	  				<td>
	  					<select class="text small" id="acceptStatus" name="acceptStatus"  onchange="$('#searchPageForm')[0].submit()">
							<option value="0" >请选择...</option>
							<option value="1" ${param.acceptStatus==1?'selected="selected"':'' } >待收车</option>
							<option value="2" ${param.acceptStatus==2?'selected="selected"':'' } >已收车</option>
						</select>
	  				</td>
	  				<td><label>结算状态：</label></td>
	  				<td>
	  					<select class="text small" id="statementStatus" name="statementStatus"  onchange="$('#searchPageForm')[0].submit()">
							<option value="0" >请选择...</option>
							<option value="1" ${param.statementStatus==1?'selected="selected"':'' } >待核单</option>
							<option value="2" ${param.statementStatus==2?'selected="selected"':'' } >待结算</option>
							<option value="3" ${param.statementStatus==3?'selected="selected"':'' } >已结算</option>
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
			<td style="width: 120px;">名称</td>
			<td style="width: 60px;">进货商</td>
			<td style="width: 50px;">执行价</td>
			<td style="width: 50px;">工厂价</td>
			<td style="width:70px;">工厂日期</td>
			<td style="width:60px;">申请日期</td>
			<td style="width:80px;">结算状态</td>
			<td style="width:60px;">确认方</td>
			<td style="width:60px;">确认状态</td>
			<td style="width:60px;">发车状态</td>
			<td style="width:60px;">收车状态</td>
			<td style="width:60px;">退车状态</td>
			<td style="width: 80px;">操作</td>
		</tr>
	</thead>
	<tbody>
		<c:forEach items="${page.result }" var="orderBuySaler">
		<c:set value="${orderBuySaler.factoryOrder }" var="factoryOrder"></c:set>
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
					      <li><a href="javascript:void(-1)" class="aedit" onclick="$.utile.openDialog('${ctx}}/factoryOrder/reward?dbid=${factoryOrder.dbid }','添加特殊奖',800,300)">添加特殊奖</a> </li>
					      <c:if test="${factoryOrder.carStatus<3 }">
					     	 <li><a href="javascript:void(-1)" class="aedit" onclick="$.utile.openDialog('${ctx}}/refundCar/add?dbid=${factoryOrder.dbid }','填写退库记录',800,340)">退库记录</a> </li>
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
				${orderBuySaler.applayDate }
			</td>
			<td>
				${orderBuySaler.saleCompnay.name }
			</td>
			<td style="text-align: left;">
				<c:if test="${orderBuySaler.statementStatus==1 }">
					<span style="color: red;">待核单</span><br>
				</c:if>
				<c:if test="${orderBuySaler.statementStatus==2 }">
					<span style="color: red;">待结算</span>
				</c:if>
				<c:if test="${orderBuySaler.statementStatus==3 }">
					<span style="color: green;">已结算</span>
				</c:if>
			</td>
			 <td>
				<c:if test="${orderBuySaler.confireStatus==1 }">
					<span style="color: red;">待确认</span>
				</c:if>
				<c:if test="${orderBuySaler.confireStatus==2 }">
					<span style="color: green;">同意绑车</span>
				</c:if>
				<c:if test="${orderBuySaler.confireStatus==3 }">
					<span style="color: red;">驳回绑车</span>
				</c:if>
				<c:if test="${orderBuySaler.confireStatus==4 }">
					<span style="color: red;">申请取消</span>
				</c:if>
			</td>
			<td>
				<c:if test="${orderBuySaler.sendCarStatus==1 }">
					<span style="color: red;">待发车</span>
				</c:if>
				<c:if test="${orderBuySaler.sendCarStatus==2 }">
					<span style="color: green;">已经发车</span>
				</c:if>
			</td>
			 <td>
				<c:if test="${orderBuySaler.acceptStatus==1 }">
					<span style="color: red;">待收车</span>
				</c:if>
				<c:if test="${orderBuySaler.acceptStatus==2 }">
					<span style="color: green;">已收车</span>
				</c:if>
			</td>
			 <td>
				<c:if test="${orderBuySaler.applayTurnBackStatus==1 }">
					<span style="color: green;">正常</span>
				</c:if>
				<c:if test="${orderBuySaler.applayTurnBackStatus==2 }">
					<span style="color: red;">申请退车</span>
				</c:if>
				<c:if test="${orderBuySaler.applayTurnBackStatus==3 }">
					<span style="color: green;">同意退车</span>
				</c:if>
				<c:if test="${orderBuySaler.applayTurnBackStatus==4 }">
					<span style="color: red;">驳回</span>
				</c:if>
			</td>
			<td style="text-align: center;">
				
				<c:if test="${orderBuySaler.sendCarStatus!=2&& orderBuySaler.confireStatus<3}">
					<a href="javascript:void(-1)" class="aedit" onclick="$.utile.operatorDataByDbid('${ctx }/orderBuySaler/cancel?dbid=${orderBuySaler.dbid}','searchPageForm','确定取消绑定车辆申请吗？取消申请将释放绑定车架号，重置已经绑车量车状态。')" >取消</a>
					|
				</c:if>
				<c:if test="${orderBuySaler.sendCarStatus==2 }">
					<c:if test="${orderBuySaler.acceptStatus==1||orderBuySaler.acceptStatus==3 }">
						<a href="javascript:void(-1)" class="aedit"  onclick="$.utile.openDialog('${ctx}/orderBuySaler/acceptCar?dbid=${orderBuySaler.dbid }','确认入库',920,500)">确认入库</a>
						|
					</c:if>
				 </c:if>
				  <c:if test="${orderBuySaler.confireStatus==4||orderBuySaler.confireStatus==3 }">
					<a href="javascript:void(-1)" class="aedit" onclick="$.utile.operatorDataByDbid('${ctx }/orderBuySaler/delete?dbids=${orderBuySaler.dbid}','searchPageForm','确定删除申请记录吗？')" >删除</a>
					|
				</c:if>
				<a href="${ctx }/orderBuySaler/view?dbid=${orderBuySaler.dbid}" class="aedit" >查看</a>
				<c:if test="${orderBuySaler.acceptStatus==2 }">
					<c:if test="${orderBuySaler.applayTurnBackStatus==1||orderBuySaler.applayTurnBackStatus==4 }">
						|<a href="javascript:void(-1)" class="aedit"  onclick="$.utile.openDialog('${ctx}/orderBuySaler/apply?dbid=${orderBuySaler.dbid }','申请退车',920,500)">申请退车</a>
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
