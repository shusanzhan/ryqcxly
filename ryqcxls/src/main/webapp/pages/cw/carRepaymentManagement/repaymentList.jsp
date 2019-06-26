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
<script type="text/javascript" src="${ctx }/widgets/My97DatePicker/WdatePicker.js"></script>
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
<div class="listOperate">
	<div class="operate">
   	</div>
  	<div class="seracrhOperate">
  		<form name="searchPageForm" id="searchPageForm"  action="${ctx}/carRepaymentManagement/queryRepaymentList	" method="post" >
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
  				<td>
  				<td><label>车辆性质：</label></td>
  				<td>
  					<select id="orderAttr" name="orderAttr"  class="text midea" onchange="$('#searchPageForm')[0].submit()">
						<option value="">请选择...</option>
						<option value="金融贷款" ${param.orderAttr=='金融贷款'?'selected="selected"':'' } >金融贷款</option>
						<option value="自有资金" ${param.orderAttr=='自有资金'?'selected="selected"':'' } >自有资金</option>
					</select>
				</td>
   			</tr>
   			<tr>
   				<td><label>VIN码：</label></td>
  				<td>
  					<input type="text" id="vinCode" name="vinCode" value="${param.vinCode }" class="text middle">
  				</td>
  				<td><label>还款人：</label></td>
  				<td>
  					<input type="text" id="payee" name="payee" value="${param.payee }" class="text small">
  				</td>
  				<td><label>还款日期：</label></td>
  				<td>
  					<input class="text small" id="startTime" name="startTime" onFocus="WdatePicker({isShowClear:true,readOnly:true})" value="${param.startTime }" >
  					~
  				</td>
  				<td>
  					<input class="text small" id="endTime" name="endTime" onFocus="WdatePicker({isShowClear:true,readOnly:true})" value="${param.endTime }">
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
			<td style="width: 200px;">名称</td>
			<td style="width: 80px;">vin码</td>
			<td style="width: 50px;">工厂价</td>
			<td style="width: 50px;">还款金额</td>
			<td style="width:70px;">工厂日期</td>
			<td style="width:60px;">订单性质</td>
			<td style="width:50px;">库龄</td>
			<td style="width:50px;">库存状态</td>
			<td style="width:100px;">出库日期</td>
			<td style="width:100px;">还款日期</td>
			<td style="width:50px;">还款人</td>
			<td style="width:100px;">还款状态</td>
			<td style="width: 80px;">操作</td>
		</tr>
	</thead>
	<tbody>
		<c:forEach items="${page.result }" var="factoryOrder">
		<tr>
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
				${factoryOrder.factoryPrice}
			</td>
			<td>
				<span style="color:red">${factoryOrder.presaleRebate}</span>
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
				<fmt:formatDate value="${factoryOrder.repaymentDate }"/>
			</td>
			<td>
				${factoryOrder.repaymentPerson }
			</td>
			<td>
				<c:if test="${factoryOrder.costPayment==2 }">
					<span style="color: red;">未还款</span>
				</c:if>
				<c:if test="${factoryOrder.costPayment==3 }">
					<span style="color: green;">已还款</span>
				</c:if>
			</td>
			<td style="text-align: center;">
			<%-- <a href="${ctx}/factoryOrder/edit?dbid=${factoryOrder.dbid}" class="aedit">编辑</a> |  --%>
				<%-- <c:if test="${factoryOrder.repaymentStatus==3 }">
					<a href="javascript:void(-1)" class="aedit"  onclick="$.utile.openDialog('${ctx}/repaymentInfo/view?factoryOrderId=${factoryOrder.dbid }','还款',920,400)">查看还款</a>
					<c:if test="${sessionScope.user.userId=='admin' }">
						| <a href="javascript:void(-1)" class="aedit" onclick="$.utile.operatorDataByDbid('${ctx}/repaymentInfo/setRepaymentWaiting?factoryOrderId=${factoryOrder.dbid}','searchPageForm','确定要设置为未还款吗？')" title="标记未换货">标记未还款</a>
					</c:if> 
				</c:if> --%>
				<a href="javascript:void(-1)" class="aedit"  onclick="$.utile.openDialog('${ctx}/carRepaymentManagement/repaymentDetial?factoryOrderId=${factoryOrder.dbid }','还款明细',920,400)">查看还款</a>
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
