<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../../commons/taglib.jsp" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<meta content="IE=edge" http-equiv="X-UA-Compatible">
<meta name="Keywords" content="text/html; charset=UTF-8" http-equiv="Content-Type">
<meta content="IE=edge" http-equiv="X-UA-Compatible">
<!-- 最新 Bootstrap 核心 CSS 文件 -->
<link rel="stylesheet" href="${ctx }/css/bootstrap/bootstrap.min.css">
<link  type="text/css" href="${ctx }/css/common.css" rel="stylesheet">
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<style type="text/css">
.tableContent{
	width: 100%;
}
.tableContent tr{
	height: 32px;
}
.table-c{
}
.table-c table{border: 0}
.table-c table td{border-left:1px solid #767474;border-bottom: 1px solid #767474;}
.table-c table td:FIRST-CHILD{border-left:0;}
.table-c table td:nth-last-child(0){border-right:0;border-left:0;}
.table-c table tr:nth-last-child(0) td{border-right:0;border-left:0;border: 0;}
.tabletr{
	border: 0;
}
.tabletr td{
	
}
</style>
<title>车辆档案信息</title>
</head>
<body class="bodycolor">
<c:if test="${empty(param.from) }">
<div class="location">
	<img src="${ctx}/images/homeIcon.png"/> &nbsp;
	<a href="javascript:void(-1);" onclick="window.parent.location.href='${ctx}/main/index'">首页</a>-
	<a href="javascript:void(-1);" onclick="">车辆档案信息</a>
</div>
 <!--location end-->
<div class="line"></div>
<div class="listOperate">
	<div class="operate">
		<a class="but butCancle" href="javascript:void(-1);" onclick="window.history.go(-1)">返回</a>
   </div>
   <div style="clear: both;"></div>
</div>
</c:if>
<c:if test="${!empty(param.from) }">
<div class="listOperate">
	<div class="operate">
		<a class="but butCancle" href="javascript:void(-1);" onclick="window.close()">关闭</a>
   </div>
</div>
</c:if>
<table class="tableContent" border="0" align="center" cellpadding="0" cellspacing="0" style="background-color:#e5e5e5 ;">
	<tr>
		<td class="formTableTdLeft" align="right" width="12%">车型：</td>
		<td width="38%" align="left">
			${factoryOrder.carSeriy.name }
			${factoryOrder.carModel.name }
			${factoryOrder.carColor.name }
		</td>
		<td class="formTableTdLeft" width="12%" align="right">vin码：</td>
		<td width="38%" align="left">
			${factoryOrder.vinCode }
		</td>
	</tr>
	<tr>
		<td class="formTableTdLeft" align="right" width="12%">管理公司：</td>
		<c:set value="${factoryOrder.carReceiving }" var="carReceiving"></c:set>
		<td width="38%" align="left">
			${factoryOrder.storeCompany.name }
			
		</td>
		<td class="formTableTdLeft" width="12%" align="right">库房：</td>
		<td width="38%" align="left">
			${carReceiving.storeCompany.name }${carReceiving.storeArea.name }&nbsp;&nbsp;${carReceiving.storeRoom.name }&nbsp;&nbsp;${carReceiving.storage.name }
		</td>
	</tr>
	<tr>
		<td class="formTableTdLeft" align="right" width="12%">入库时间：</td>
		<td width="38%" align="left">
			<fmt:formatDate value="${carReceiving.stockInDate }"/> 
		</td>
		<td class="formTableTdLeft" width="12%" align="right">移库时间：</td>
		<td width="38%" align="left">
			${carReceiving.transferDate }
		</td>
	</tr>
	<tr>
		<td class="formTableTdLeft" align="right" width="12%">库龄等级：</td>
		<td width="38%" align="left">
			  ${factoryOrder.storeAgeLevel.name }
		</td>
	</tr>
	<tr>
		<td class="formTableTdLeft" align="right" width="12%">原始进货商：</td>
		<td width="38%" align="left">
			${factoryOrder.sourceCompany.name}
		</td>
		<td class="formTableTdLeft" align="right" width="12%">车辆来源：</td>
		<td width="38%" align="left">
			${factoryOrder.carFrom.name}
		</td>
	</tr>
</table>
<div class="containerLeft" style="width: 100%">
	<div style="margin: 5px 12px;border-buttom:1px solid rgb( 222, 222, 222 ); margin-top: 30px;">
		<ul class="nav nav-tabs" role="tablist">
		  	<c:if test="${param.type==1 }" var="sta">
				  <li class="active">
				  	<a href="#factoryOrder" role="tab" data-toggle="tab">基本资料</a>
				  </li>
		  	</c:if>
		  	<c:if test="${sta==false }">
				  <li>
				  	<a href="#factoryOrder" role="tab" data-toggle="tab">基本资料</a>
				  </li>
		  	</c:if>
		  <c:if test="${param.type==2 }" var="sta">
		  	<li class="active">
		  		<a href="#installItem" role="tab" data-toggle="tab">加装明细</a>
		  	</li>
		  </c:if>
		  <c:if test="${sta==false }">
		  	<li><a href="#installItem" role="tab" data-toggle="tab">加装明细</a></li>
		  </c:if>
		   <c:if test="${param.type==3 }" var="sta">
		  	<li class="active"><a href="#carTransfer" role="tab" data-toggle="tab">移库记录</a></li>
		  </c:if>
		  <c:if test="${sta==false }">
		  	<li><a href="#carTransfer" role="tab" data-toggle="tab">移库记录</a></li>
		  </c:if>
		   <c:if test="${param.type==4 }" var="sta">
		  	<li  class="active"><a href="#carOperateLog" role="tab" data-toggle="tab">车辆日志</a></li>
		  </c:if>
		  <c:if test="${sta==false }">
		  	<li><a href="#carOperateLog" role="tab" data-toggle="tab">车辆日志</a></li>
		  </c:if>
		   <c:if test="${param.type==5 }" var="sta">
		  	<li  class="active"><a href="#carLain" role="tab" data-toggle="tab">车辆奖励</a></li>
		  </c:if>
		  <c:if test="${sta==false }">
		  	<li><a href="#carLain" role="tab" data-toggle="tab">车辆奖励</a></li>
		  </c:if>
		   <c:if test="${param.type==6 }" var="sta">
		  	<li  class="active"><a href="#orderDetail" role="tab" data-toggle="tab">订单信息</a></li>
		  </c:if>
		  <c:if test="${sta==false }">
		  	<li><a href="#orderDetail" role="tab" data-toggle="tab">订单信息</a></li>
		  </c:if>
		   <c:if test="${param.type==7 }" var="sta">
		  	<li  class="active"><a href="#specialCar" role="tab" data-toggle="tab">占车信息</a></li>
		  </c:if>
		  <c:if test="${sta==false }">
		  	<li><a href="#specialCar" role="tab" data-toggle="tab">占车信息</a></li>
		  </c:if>
		  <c:if test="${param.type==8 }" var="sta">
		  	<li  class="active"><a href="#preRebate" role="tab" data-toggle="tab">售前返利</a></li>
		  </c:if>
		  <c:if test="${sta==false }">
		  	<li><a href="#preRebate" role="tab" data-toggle="tab">售前返利</a></li>
		  </c:if>
		  <c:if test="${param.type==9 }" var="sta">
		  	<li  class="active"><a href="#afterRebate" role="tab" data-toggle="tab">售后返利</a></li>
		  </c:if>
		  <c:if test="${sta==false }">
		  	<li><a href="#afterRebate" role="tab" data-toggle="tab">售后返利</a></li>
		  </c:if>
		</ul>
		<!-- Tab panes -->
		<div class="tab-content" >
			<c:if test="${param.type==1 }" var="sta">
			  <div class="tab-pane active" id="factoryOrder" >
			</c:if>
			<c:if test="${sta==false }">
			  <div class="tab-pane" id="factoryOrder" >
			</c:if>
		  		<table class="tableContent" border="0" align="center" cellpadding="0" cellspacing="0" style="width: 92%;padding: 12px">
					<tr>
						<td class="formTableTdLeft">物料号：</td>
						<td colspan="3">
							${factoryOrder.materialNumber}&nbsp;&nbsp;&nbsp;
						</td>
					</tr>
					<tr>
						<td class="formTableTdLeft">物料描述：</td>
						<td colspan="3">
							${factoryOrder.materialDes }
						</td>
					</tr>
					<tr>
						<td class="formTableTdLeft">工厂价：</td>
						<td>
							${factoryOrder.factoryPrice }
						</td>
						<td class="formTableTdLeft">执行价：</td>
						<td>
							${factoryOrder.marketPrice }
						</td>
					</tr>
					<tr>
						<td class="formTableTdLeft">工厂订单日期：</td>
						<td>
							${factoryOrder.factoryOrderDate }
						</td>
						<td class="formTableTdLeft">惠民：</td>
						<td>
							${factoryOrder.huimin }
						</td>
					</tr>
					<tr>
						<td class="formTableTdLeft">订单性质：</td>
						<td>
							${factoryOrder.orderAttr }
						</td>
						<td class="formTableTdLeft">订单种类：</td>
						<td>
							${factoryOrder.orderType }
						</td>
					</tr>
					<tr>
						<td class="formTableTdLeft" >加装状态：</td>
						<td>
							<c:if test="${factoryOrder.isInstall==1 }">
								<span style="color: red;">未加装</span>
							</c:if> 
							<c:if test="${factoryOrder.isInstall==2 }">
								<span style="color: green;">已经装</span>
							</c:if> 
						</td>
						 <td class="formTableTdLeft"  >车辆状态：</td>
						<td>
							<c:if test="${factoryOrder.carStatus==1 }">
								<span style="color: red;">在途订单</span>
							</c:if>
							<c:if test="${factoryOrder.carStatus==2 }">
								<span style="color: green;">车辆在库</span>
							</c:if>
							<c:if test="${factoryOrder.carStatus==4 }">
								<span style="color: pink;">车辆出库</span>
							</c:if>
						</td>
					</tr>
					<tr>
						<td class="formTableTdLeft" >还款状态：</td>
						<td>
							<c:if test="${factoryOrder.repaymentStatus==1}">
								<span style="color: blue;">无需还款</span>
							</c:if> 
							<c:if test="${factoryOrder.repaymentStatus==2}">
								<span style="color: red;">待还款</span>
							</c:if> 
							<c:if test="${factoryOrder.repaymentStatus==3}">
								<span style="color: green;">已还款</span>
							</c:if> 
						</td>
						<td class="formTableTdLeft">在库周期：</td>
						<td>
							${factoryOrder.stockCyle}
							${factoryOrder.stockAgeDate }
						</td>
					</tr>
					<tr>
						<td class="formTableTdLeft">创建日期：</td>
						<td>
							${factoryOrder.createDate}
						</td>
					</tr>
				</table>
		  </div>
		  	<c:if test="${param.type==2 }" var="sta">
			   <div class="tab-pane active" id="installItem" >
			</c:if>
			<c:if test="${sta==false }">
			  <div class="tab-pane" id="installItem">
			</c:if>
				<c:if test="${empty(installDecoration) }" var="status">
					<div class="alert alert-error">
						<strong>提示!</strong> 车辆无加装记录！
					</div>
				</c:if>
				<c:if test="${status==false }">
				<table class="tableContent" border="0" align="center" cellpadding="0" cellspacing="0" style="width: 92%;padding: 12px">
					<tr>
						<td class="formTableTdLeft">加装名称：</td>
						<td>
							${installDecoration.installName }
						</td>
					</tr>
					<tr>
						<td class="formTableTdLeft">加装时间：</td>
						<td>
							${installDecoration.installDate }
						</td>
					</tr>
					<tr>
						<td class="formTableTdLeft">加装内容：</td>
						<td>
							${installDecoration.installContent }
						</td>
					</tr>
					<tr>
						<td class="formTableTdLeft">备注：</td>
						<td>
							${installDecoration.note }
						</td>
					</tr>
				</table>
				<table width="100%"  cellpadding="0" cellspacing="0" class="mainTable" border="0">
					<thead  class="TableHeader">
						<tr>
							<td class="span1">序号</td>
							<td class="span1">项目名称</td>
							<td class="span1">编码</td>
							<td class="span3">品牌</td>
							<td class="span1">销售价格</td>
							<td class="span1">数量</td>
						</tr>
					</thead>
					<c:forEach var="installItem" items="${installitems }" varStatus="i">
							<tr>
								<td id="">
									${i.index+1 }
							    </td>
								<td style="text-align: center;">
									<a href='javascript:;' onclick="$.utile.openDialog('${ctx}/product/viewProduct?productId=${installItem.product.dbid }','商品明细',760,320)">${installItem.itemName }</a>
								</td>
								<td style="text-align: center;">
									${installItem.serNo }
								</td>
								<td>
									${installItem.product.brand.name }
								</td>
							    <td style="text-align: center;">
									${installItem.price }
								</td>
							    <td style="text-align: center;">
									${installItem.quality }
								</td>
							</tr>
					</c:forEach>
				</table>
				</c:if>
		  </div>
		  	<c:if test="${param.type==3 }" var="sta">
			   <div class="tab-pane active" id="carTransfer" >
			</c:if>
			<c:if test="${sta==false }">
			  <div class="tab-pane" id="carTransfer">
			</c:if>
				<c:if test="${empty(carTransfers)||carTransfers==null }" var="status">
					<div class="alert alert-error">
						<strong>提示!</strong> 车辆无移库记录
					</div>
				</c:if>
				<c:if test="${status==false }">
				<table width="100%" border="0" class="mainTable" cellpadding="0" cellspacing="0">
					<thead>
						<tr>
							<td style="width: 40px;">
								序号		
							</td>
							<td style="width: 80px;">转库日期</td>
							<td style="width: 120px;">原库房</td>
							<td style="width: 120px;">新库房</td> 
							<td style="width: 400px;">备注</td>
							<td style="width:80px;">创建时间</td>
							<td style="width:80px;"></td>
						</tr>
					</thead>
					<tbody>
						<c:forEach items="${carTransfers}" var="carTransfer" varStatus="i">
						<tr >
							<td style="text-align: center;">
								${i.index+1 }
							</td>
							<td>
								${carTransfer.tranferDate }
							</td>
							<td>
								${carTransfer.oldStorageRoom}
							</td>
							<td>
								${carTransfer.newStorageRoom}
							</td>
							<td style="text-align: left;">
								${carTransfer.note}
							</td>
							<td>
								<fmt:formatDate value="${carTransfer.operateDate}" pattern="yyyy-MM-dd"/> 
							</td>
							<td>
								<a href="${ctx }/carReceiving/print?dbid=${carTransfer.dbid}">打印</a>
							</td>
						</tr>
						</c:forEach>
					</tbody>
				</table>
				</c:if>
				
				
		  </div>
		  <c:if test="${param.type==4 }" var="sta">
			   <div class="tab-pane active" id="carOperateLog" >
			</c:if>
			<c:if test="${sta==false }">
			  <div class="tab-pane" id="carOperateLog">
			</c:if>
		  		<c:if test="${fn:length(carOperateLogs)<=0}" var="status">
					<div class="alert alert-error" align="left">
							<strong>提示：</strong>车辆操作日志
					</div>
				</c:if>
				<c:if test="${status==false}">
					<table width="100%" border="0" class="mainTable" cellpadding="0" cellspacing="0">
						<thead>
							<tr>
								<td style="width: 40px;">
									序号		
								</td>
								<td style="width: 120px;">操作类型</td>
								<td style="width: 80px;">操作时间</td>
								<td style="width: 80px;">操作人</td> 
								<td style="width: 120px;">备注</td>
							</tr>
						</thead>
						<tbody>
							<c:forEach items="${carOperateLogs}" var="carOperateLog" varStatus="i">
							<tr >
								<td style="text-align: center;">
									${i.index+1 }
								</td>
								<td>
									${carOperateLog.type }
								</td>
								<td>
									<fmt:formatDate value="${carOperateLog.operateDate}" pattern="yyyy-MM-dd HH:mm:ss"/>	 
								</td>
								<td>
									${carOperateLog.operator}
								</td>
								<td style="text-align: left;">
									${carOperateLog.note}
								</td>
							</tr>
							</c:forEach>
						</tbody>
					</table>
				</c:if>
		  </div>
		  <c:if test="${param.type==5 }" var="sta">
			  <div class="tab-pane active" id="carLain" >
			</c:if>
			<c:if test="${sta==false }">
			  <div class="tab-pane" id="carLain" >
			</c:if>
		  		<table class="tableContent" border="0" align="center" cellpadding="0" cellspacing="0" style="width: 92%;padding: 12px">
					<tr>
						<td class="formTableTdLeft">车辆备注：</td>
						<td colspan="3">
							${factoryOrder.rewardNote}&nbsp;&nbsp;&nbsp;
						</td>
					</tr>
					<tr>
						<td class="formTableTdLeft">奖励总金额：</td>
						<td>
								<span style="color: red;font-size: 14px;"><fmt:formatNumber value="${factoryOrder.totalRewardMoney }" pattern="#.##"></fmt:formatNumber> </span>元
						</td>
					</tr>
			</table>
			</div>
			<c:if test="${param.type==6 }" var="sta">
			  <div class="tab-pane active" id="orderDetail" >
			</c:if>
			<c:if test="${sta==false }">
			  <div class="tab-pane" id="orderDetail" >
			</c:if>
				<c:if test="${empty(customer) }">
					<div class="alert alert-error" align="left">
						<strong>提示：</strong>车辆还未绑定客户！
					</div>
				</c:if>
				<c:if test="${!empty(customer) }">
					<div class="frmTitle" onclick="showOrHiden('contactTable')">基本信息</div>
						<table border="0" align="center" cellpadding="0" cellspacing="0" style="width: 92%;">
							<tr height="42">
								<td class="formTableTdLeft" >客户名称：</td>
								<td>
									<c:set value="${fn:length(customer.name) }" var="len"></c:set> 
									**${fn:substring(customer.name,len-1,len)}&nbsp;&nbsp;&nbsp;&nbsp; ${fn:substring(customer.mobilePhone,0,3) }******${fn:substring(customer.mobilePhone,9,11) }
								</td>
							</tr>
							<tr height="42">
								<td>销售顾问：</td>
								<td>
									${customer.bussiStaff}
									&nbsp;&nbsp;&nbsp;&nbsp;
									${customer.user.mobilePhone }
								</td>
							</tr>
							<tr height="42">
								<td>车辆信息：</td>
								<td>
									${customerPidBookingRecord.brand.name }
									${customerPidBookingRecord.carSeriy.name }
									${customerPidBookingRecord.carModel.name }
									${customerPidBookingRecord.carColor.name }
								</td>
							</tr>
							<tr height="42">
								<td>预约时间：</td>
								<td>
									${customerPidBookingRecord.bookingDate }
								</td>
							</tr>
							<tr height="42">
								<td>交车备注：</td>
								<td>
									${customerPidBookingRecord.note }
								</td>
							</tr>
						</table>
					<div class="frmTitle" onclick="showOrHiden('contactTable')">附加通知单</div>		
						<c:if test="${empty(orderContractDecore) }">
							<div class="alert alert-error">
								<strong>提示：</strong> 
								该客户无附加通知单！				
						</div>
					</c:if>
					<c:if test="${!empty(orderContractDecore) }">
					<table id="orderDecore" cellpadding="0" cellspacing="0" border="1" style="margin:0 auto;width: 92%;" class="table-c">
							<tr>
								<td align="center" colspan="4">&#12288;销售装饰项目</td>
								<td  align="center" colspan="4">&#12288;赠送装饰项目</td>	
							</tr>
							<tr style="border-bottom: 0;">
								<td colspan="4" style="border-bottom: 0;" width="50%">
									<table cellpadding="0" cellspacing="0" width="100%" border="0" >
										<tr class="tabletr">
											<td align="center" style="0">序号</td>
											<td align="center">编号</td>
											<td align="center">项目</td>
											<td align="center">金额</td>
										</tr>
										<c:set value="0" var="zs"></c:set>	
										<c:set value="0" var="xs"></c:set>	
										<c:set value="0" var="total"></c:set>	
										<c:forEach  var="decoreNoticeItem" items="${orderContractDecore.orderContractDecoreItem }"  varStatus="i">
											<c:if test="${decoreNoticeItem.type==1 }">
												<c:set value="${xs+1 }" var="xs"></c:set>
											</c:if>
											<c:if test="${decoreNoticeItem.type==2 }">
												<c:set value="${zs+1 }" var="zs"></c:set>
											</c:if>
										</c:forEach>
										<c:if test="${xs>zs }" var="status">
											<c:set value="${xs }" var="total"></c:set>
										</c:if>
										<c:if test="${status==false }">
											<c:set value="${zs }" var="total"></c:set>
										</c:if>
										<c:set value="1" var="indexVar"></c:set>
										<c:forEach  var="decoreNoticeItem" items="${orderContractDecore.orderContractDecoreItem }"  varStatus="i">
											<c:if test="${decoreNoticeItem.type==1 }">
												<tr> 
													<td align="center">${indexVar } </td>
													<td align="center">
														${decoreNoticeItem.serNo }
													</td>
													<td align="center">
														${decoreNoticeItem.itemName }
													</td>
													<td align="left">
														${decoreNoticeItem.price }
													</td>
												</tr>
												<c:set value="${indexVar+1 }" var="indexVar"></c:set>
											</c:if>
										</c:forEach>
										<c:if test="${xs<zs }" var="status">
											<c:forEach var="ind" begin="${xs+1 }" end="${zs }">
												<tr> 
														<td align="center">${ind } </td>
														<td align="center">
														</td>
														<td align="center">
														</td>
														<td align="left">
														</td>
													</tr> 
											</c:forEach>
										</c:if>
									</table>
								</td>
								<td colspan="4" style="border-bottom: 0;" width="50%">
									<table cellpadding="0" cellspacing="0" width="100%" border="0" >
										<tr class="tabletr">
											<td align="center" style="0">序号</td>
											<td align="center">编号</td>
											<td align="center">项目</td>
											<td align="center">金额</td>
										</tr>	
										<c:set value="1" var="indexVar"></c:set>
										<c:forEach  var="decoreNoticeItem" items="${orderContractDecore.orderContractDecoreItem }"  varStatus="i">
											<c:if test="${decoreNoticeItem.type==2 }">
												<tr> 
													<td align="center">${indexVar } </td>
													<td align="center">
														${decoreNoticeItem.serNo }
													</td>
													<td align="center">
														${decoreNoticeItem.itemName }
													</td>
													<td align="left">
														${decoreNoticeItem.price }
													</td>
												</tr>
												<c:set value="${indexVar+1 }" var="indexVar"></c:set>
											</c:if> 
											<c:set value="${i.index+1 }" var="size"></c:set>
										</c:forEach>
										<c:forEach var="ind" begin="${zs+1 }" end="${xs }">
											<tr> 
													<td align="center">${ind }</td>
													<td align="center">
													</td>
													<td align="center">
													</td>
													<td align="left">
													</td>
												</tr> 
										</c:forEach>
									</table>
								</td>
							</tr>
							<tr>
						<td align="center">销售装饰合计</td>
						<td colspan="3">
							${orderContractDecore.decoreSaleTotalPrce }
						</td>
						<td align="center">赠送装饰合计</td>
						<td  colspan="3">
							${orderContractDecore.giveTotalPrice }
						</td>
					</tr>
					<tr>
						<td align="center">装饰实收合计</td>
						<td colspan="3">
							${orderContractDecore.acturePrice }
						</td>
						<td align="center">折扣率</td>
						<td  colspan="3">
							${orderContractDecore.zkl }
						</td>
					</tr>
					<tr>
						<td align="center">装饰顾问结算价</td>
						<td colspan="3">
							${orderContractDecore.salerTotalPrice }
						</td>
						<td align="center">装饰毛利</td>
						<td  colspan="3">
							${orderContractDecore.salerGrofitPrice }
						</td>
					</tr>
						</table>
					</c:if>
				</c:if>
			</div>
			<c:if test="${param.type==7 }" var="sta">
			  <div class="tab-pane active" id="specialCar" >
			</c:if>
			<c:if test="${sta==false }">
			  <div class="tab-pane" id="specialCar" >
			</c:if>
			<c:if test="${empty(specialMotorPool) }">
				<div class="alert alert-error" align="left">
					<strong>提示：</strong>无占车信息！
				</div>
			</c:if>
			<c:if test="${!empty(specialMotorPool) }">
				<table border="0" align="center" cellpadding="0" cellspacing="0" style="width: 92%;">
						<tr height="42">
							<td class="formTableTdLeft" >占车人：</td>
							<td>
								${specialMotorPool.reserveDep }
							</td>
						</tr>
						<tr height="42">
							<td>提车时间：</td>
							<td>
								${specialMotorPool.reserveDate}
							</td>
						</tr>
						<tr height="42">
							<td>备注：</td>
							<td>
								${specialMotorPool.note }
							</td>
						</tr>
					</table>
			</c:if>
			</div>
			<c:if test="${param.type==8 }" var="sta">
			  <div class="tab-pane active" id="preRebate" >
			</c:if>
			<c:if test="${sta==false }">
			  <div class="tab-pane" id="preRebate" >
			</c:if>
			<c:if test="${empty(preRebates) }">
				<div class="alert alert-error" align="left">
					<strong>提示：</strong>售前返利信息！
				</div>
			</c:if>
			<c:if test="${!empty(preRebates) }">
				<table border="0" align="center" cellpadding="0" cellspacing="0" style="width: 92%;">
					<c:forEach var="rebate" items="${preRebates}">
						<tr height="42">
							<td class="formTableTdLeft" >${rebate.name }比例：&nbsp;</td>
							<td>
								${rebate.rebateRatio }%
							</td>
							<td class="formTableTdLeft" >${rebate.name }金额：&nbsp;</td>
							<td>
								${rebate.rebateMoney }元
							</td>
						</tr>
						<tr height="42">
							<td class="formTableTdLeft">付款期限:&nbsp;</td>
							<td>
								${rebate. rebateTerm}
							</td>
						</tr>
					</c:forEach>
				</table>
			</c:if>
			</div>
			<c:if test="${param.type==9 }" var="sta">
			  <div class="tab-pane active" id="afterRebate" >
			</c:if>
			<c:if test="${sta==false }">
			  <div class="tab-pane" id="afterRebate" >
			</c:if>
			<c:if test="${empty(afterRebates) }">
				<div class="alert alert-error" align="left">
					<strong>提示：</strong>售后返利信息！
				</div>
			</c:if>
			<c:if test="${!empty(afterRebates) }">
				<table border="0" align="center" cellpadding="0" cellspacing="0" style="width: 92%;">
					<c:forEach var="rebate" items="${afterRebates}">
						<tr height="42">
							<td>
								<c:if test="${rebate.rebateState eq 1}">
									<span style="color:red">未到帐</span>
								</c:if>
								<c:if test="${rebate.rebateState eq 3}">
									<span style="color:green;font-size: 20px">到帐</span>
								</c:if>
							</td>
						</tr>
						<tr height="42">
							<td class="formTableTdLeft" >${rebate.name }比例：&nbsp;</td>
							<td>
								${rebate.rebateRatio }%
							</td>
							<td class="formTableTdLeft" >${rebate.name }金额：&nbsp;</td>
							<td>
								${rebate.rebateMoney }元
							</td>
						</tr>
						<tr height="42">
							<td class="formTableTdLeft">付款期限:&nbsp;</td>
							<td>
								${rebate. rebateTerm}
							</td>
						</tr>
					</c:forEach>
				</table>
			</c:if>
		</div>
	</div>
</div>
</body>
<script type='text/javascript'  src="${ctx}/widgets/bootstrap3/jquery.min.js"></script>
<script type='text/javascript'  src="${ctx }/widgets/bootstrap3/js/bootstrap.min.js"></script>
<script type="text/javascript" src="${ctx }/widgets/utile/utile.js"></script>
<script type="text/javascript" src="${ctx }/widgets/easyvalidator/js/easy_validator.pack.js"></script>
<script type="text/javascript" src="${ctx }/widgets/artDialog/artDialog.js?skin=default"></script>
<script type="text/javascript" src="${ctx }/widgets/artDialog/plugins/iframeTools.source.js"></script>
</html>
