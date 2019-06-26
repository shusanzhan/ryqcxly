<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="../../commons/taglib.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html lang="en">
<head>
<title>物流库存查询</title>
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
	<a href="javascript:void(-1);" onclick="">库存综合管理</a>
</div>
 <!--location end-->
<div class="line"></div>
<div class="listOperate">
	<div class="operate">
		<!-- <a class="but button" href="javascript:void();" onclick="exportExcel('searchPageForm')">导出excel</a> -->
   	</div>
  	<div class="seracrhOperate">
  		<form name="searchPageForm" id="searchPageForm"  action="${ctx}/factoryOrder/queryCommStock" method="post" >
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
  				<td><label>加装：</label></td>
  				<td>
  					<select class="text small" id="isInstall" name="isInstall"  onchange="$('#searchPageForm')[0].submit()">
						<option value="0" >请选择...</option>
						<option value="1" ${param.isInstall==1?'selected="selected"':'' } >未加装</option>
						<option value="2" ${param.isInstall==2?'selected="selected"':'' } >加装</option>
					</select>
  				</td>
  				<td><label>VIN码：</label></td>
  				<td>
  					<input type="text" id="vinCode" name="vinCode" value="${param.vinCode }" class="text small">
  				</td>
  			</tr>
  			<tr>
  				<td><label>进货商：</label></td>
  				<td>
  					<select class="text small" id=sourceCompanyId name="sourceCompanyId"  onchange="$('#searchPageForm')[0].submit()">
						<option value="0" >请选择...</option>
						<c:forEach var="enterprise" items="${enterprises }">
							<option value="${enterprise.dbid }" ${param.sourceCompanyId==enterprise.dbid?'selected="selected"':'' } >${enterprise.name }</option>
						</c:forEach>
					</select>
  				</td>
  				<td><label>管理公司：</label></td>
  				<td>
  					<select class="text small" id="storeCompanyId" name="storeCompanyId"  onchange="$('#searchPageForm')[0].submit()">
						<option value="0" >请选择...</option>
						<c:forEach var="enterprise" items="${enterprises }">
							<option value="${enterprise.dbid }" ${param.storeCompanyId==enterprise.dbid?'selected="selected"':'' } >${enterprise.name }</option>
						</c:forEach>
					</select>
  				</td>
  				<td><label>库存状态：</label></td>
  				<td>
  					<select class="text small" id="carStatus" name="carStatus"  onchange="$('#searchPageForm')[0].submit()">
						<option value="0" >请选择...</option>
						<option value="1" ${param.carStatus==1?'selected="selected"':'' } >在途</option>
						<option value="2" ${param.carStatus==2?'selected="selected"':'' } >在库</option>
					</select>
  				</td>
  				<td><label>是否预定：</label></td>
  				<td>
  					<select class="text small" id="reserveStatus" name="reserveStatus"  onchange="$('#searchPageForm')[0].submit()">
						<option value="0" >请选择...</option>
						<option value="1" ${param.reserveStatus==1?'selected="selected"':'' } >未预定</option>
						<option value="2" ${param.reserveStatus==2?'selected="selected"':'' } >已绑定</option>
						<option value="3" ${param.reserveStatus==3?'selected="selected"':'' } >已预定</option>
					</select>
  				</td>
  				<td><label>车辆状态：</label></td>
  				<td>
  					<select class="text small" id="abnormalStatus" name="abnormalStatus"  onchange="$('#searchPageForm')[0].submit()">
						<option value="0" >请选择...</option>
						<option value="1" ${param.abnormalStatus==1?'selected="selected"':'' } >正常</option>
						<option value="2" ${param.abnormalStatus==2?'selected="selected"':'' } >异常</option>
					</select>
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
			<td style="width:60px;">进货商</td>
			<td style="width:50px;">
				<a href="javascript:void(-1)" onclick="order()" class="dropDownContent" style="font-weight: normal;" title="点击排序">
					奖励
					<c:if test="${empty(param.orderNum) }">
						<span style="color: red;font-size: 14px;">↓</span>		
					</c:if>
					<c:if test="${!empty(param.orderNum) }">
						<c:if test="${param.orderNum==1 }">
							<span style="color: red;font-size: 14px;">↓</span>
						</c:if>
						<c:if test="${param.orderNum==2 }">
						<span style="color: red;font-size: 14px;">↑</span>
						</c:if>
					</c:if>
				</a>
			</td>
			<td style="width:40px;">加装</td>
			<td style="width:40px;">库龄</td>
			<td style="width:60px;">预定状态</td>
			<td style="width:60px;">车辆状态</td>
			<td style="width:80px;">库存状态</td>
			<td style="width:80px;">管理公司</td>
			<td style="width:80px;">库房</td>
			<td style="width:80px;">创建时间</td>
			<td style="width:80px;">操作</td>
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
					    </ul>
					  </div>
				</div>
			</td>
			
			<td>
				${factoryOrder.sourceCompany.name }
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
				<c:if test="${factoryOrder.reserveStatus==2 }">
					<a href="${ctx }/factoryOrder/factoryOrderDetail?dbid=${factoryOrder.dbid}&vinCode=${factoryOrder.vinCode }&type=6" class="" style="color: blue;">已绑定(明细)</a>
				</c:if>
				<c:if test="${factoryOrder.reserveStatus==3 }">
					<a href="javascript:void(-1)" onclick="$.utile.openDialog('${ctx }/specialMotorPool/view?vinCode=${factoryOrder.vinCode}','占车仓库',920,450)"  class="aedit" style="color: green;">已预定(明细)</a>
				</c:if>
				<c:if test="${factoryOrder.reserveStatus==1 }">
					<span style="color: red;">未预定</span>
				</c:if>
			</td>
			<td>
				${factoryOrder.storeAgeLevel.name }
			</td>
			<td>
				<c:if test="${factoryOrder.abnormalStatus==2 }">
					<span style="color:red;">异常</span>
				</c:if>
				<c:if test="${factoryOrder.abnormalStatus==1 }">
					<span style="color: green;">正常</span>
				</c:if>
			</td>
			<td>
				<c:if test="${factoryOrder.carStatus==2 }">
					<span style="color: green;">在库</span>
				</c:if>
				<c:if test="${factoryOrder.carStatus==1 }">
					<span style="color: red;">在途</span>
				</c:if>
			</td>
			<c:set value="${factoryOrder.carReceiving }" var="carReceiving"></c:set>
			<td>
				<c:if test="${empty(factoryOrder.storeCompany) }">
					在途
				</c:if>
				<c:if test="${!empty(factoryOrder.storeCompany) }">
					${factoryOrder.storeCompany.name }
				</c:if>
			</td>
			<td>
				<c:if test="${empty(factoryOrder.storeCompany) }">
					在途
				</c:if>
				<c:if test="${!empty(factoryOrder.storeCompany) }">
					<span style="color: green;">
						<a href="${ctx }/factoryOrder/factoryOrderDetail?dbid=${factoryOrder.dbid}&type=3" class="" style="color: #46A0DE;">
						${carReceiving.storeArea.name }
						${carReceiving.storeRoom.name }
						${carReceiving.storage.name }
						</a>
					</span>
				</c:if>
			</td>
			<td>
				<fmt:formatDate value="${factoryOrder.createDate}" pattern="yyyy-MM-dd"/> 
			</td>
			<td>
				<c:if test="${factoryOrder.enterprise.dbid!=enterprise.dbid }" var="status">
					<c:if test="${factoryOrder.reserveStatus==2 }">
						<span>已绑定...</span>
					</c:if>
					<c:if test="${factoryOrder.reserveStatus==3 }">
						<span>已预定...</span>
					</c:if>
					<c:if test="${factoryOrder.reserveStatus==1 }">
						<c:if test="${factoryOrder.saleApplyStatus==1 }">
							<c:if test="${factoryOrder.reserveStatus==1 }">
								<a href="javascript:void(-1)" class="aedit" onclick="$.utile.openDialog('${ctx }/orderBuySaler/saleApplay?factoryOrderId=${factoryOrder.dbid}','绑车申请',920,500)" >绑车申请</a>
							</c:if>
						</c:if>
						<c:if test="${factoryOrder.saleApplyStatus==2 }">
							<span style="color: red;">等待绑车确认</span>
						</c:if>
						<c:if test="${factoryOrder.saleApplyStatus==3 }">
							<c:if test="${factoryOrder.saleApplyEnterPrise.dbid==enterprise.dbid }" var="status2">
								<c:if test="${factoryOrder.reserveStatus==2 }">
									<a href="javascript:void(-1)" class="aedit" onclick="$.utile.operatorDataByDbid('${ctx }/customerPidBookingRecord/cancelVinCode?vinCode=${factoryOrder.vinCode}','searchPageForm','确定释放【${factoryOrder.vinCode }】车架号码？释放后该订单将转为无车订单状态，如需分配车辆请重新绑定！')">释放车架号</a>
								</c:if>
								<c:if test="${factoryOrder.reserveStatus==3 }">
									<a href="javascript:void(-1)" class="aedit" onclick="$.utile.operatorDataByDbid('${ctx }/specialMotorPool/cancelVinCodeByFactory?vinCode=${factoryOrder.vinCode}','searchPageForm','确定释放【${factoryOrder.vinCode }】车架号码？释放后该订单将转为无车订单状态，如需分配车辆请重新绑定！')">释放车架号</a>
								</c:if>
								<c:if test="${factoryOrder.reserveStatus==1 }">
									<a href="javascript:void(-1)" class="aedit" onclick="window.location.href='${ctx}/customerPidBookingRecord/wlbEditStock?factoryOrderId=${factoryOrder.dbid }'">交车预约</a>
								</c:if>
							</c:if>
							<c:if test="${status2==false }">
								<span style="color: red;">经销商买卖中...</span>
							</c:if>
						</c:if>
					</c:if>
				</c:if>
				<c:if test="${status==false }">
					(自有)
					<c:if test="${factoryOrder.reserveStatus==2 }">
						<span>已绑定...</span>
					</c:if>
					<c:if test="${factoryOrder.reserveStatus==3 }">
						<span>已预定...</span>
					</c:if>
					<c:if test="${factoryOrder.reserveStatus==1 }">
						<span>未预定...</span>
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
<div style="clear: both;"></div>

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
	 function exportExcel(searchFrm){
		 	var params;
		 	if(null!=searchFrm&&searchFrm!=undefined&&searchFrm!=''){
		 		params=$("#"+searchFrm).serialize();
		 	}
		 	window.location.href='${ctx}/factoryOrder/exportExcel?'+params;
		 }
</script>
</body>
</html>
