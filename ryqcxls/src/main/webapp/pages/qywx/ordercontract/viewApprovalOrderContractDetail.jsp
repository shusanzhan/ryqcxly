<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../../commons/taglib.jsp" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta content="width=device-width, initial-scale=1.0, minimum-scale=1.0, maximum-scale=1.0, user-scalable=no" name="viewport">
<!-- Mobile Devices Support @begin -->
<meta content="application/xhtml+xml;charset=UTF-8" http-equiv="Content-Type">
<meta content="no-cache,must-revalidate" http-equiv="Cache-Control">
<meta content="no-cache" http-equiv="pragma">
<meta content="0" http-equiv="expires">
<meta content="telephone=no, address=no" name="format-detection">
<meta name="apple-mobile-web-app-capable" content="yes" />
<!-- apple devices fullscreen -->
<meta name="apple-mobile-web-app-status-bar-style" content="black-translucent" />
<link href="${ctx }/css/qywx.css?da=${now}" type="text/css" rel="stylesheet"/>
<link href="${ctx }/widgets/bootstrap3/css/bootstrap.min.css?da=${now}" type="text/css" rel="stylesheet"/>
<link href="${ctx }/widgets/bootstrap3/css/bootstrap-theme.min.css" type="text/css" rel="stylesheet"/>
<title>${customer.name } 订单审批记录</title>
</head>
<body>
<div class="views content_title navbar-fixed-top">
	 <a id="back" href="javascript:history.back()">
        <img src="${ctx }/images/jm/NavButtonBack.png" class="return">
    </a>
    <span id="page_title">${customer.name }订单审批记录</span>
    <c:if test="${param.type==1 }">
      <a class="go_home" href="${ctx }/qywxCustomer/index">
	    	<img src="${ctx }/images/jm/go_home.png" alt="">
	    </a>
    </c:if>
</div>
<br>
<br>
<br>
<c:set var="customer" value="${orderContract.customer}"></c:set>
<div class="orderContrac detail">
	<div class="title" align="left">
 			客户：${customer.name }<br/>
 			电话：<a href="tel:${customer.mobilePhone }">${customer.mobilePhone }</a>
			</div>
			<div class="line"></div>
	<div style="margin: 0 auto;margin: 5px;">
		<div style="color:#8a8a8a;padding-left: 5px; ">
			车型：${customer.customerBussi.brand.name}&#12288;
			<c:set value="${customer.customerBussi.carSeriy.name}${ customer.customerBussi.carModel.name }" var="carModel"></c:set>
			<c:if test="${fn:length(carModel)>16 }" var="status">
				${fn:substring(carModel,0,16) }...
			</c:if>
			<c:if test="${ status==false}">
				${carModel} ${customer.carModelStr}
			</c:if>
			<br>
			总价：<span class="price"><fmt:formatNumber value="${orderContract.totalPrice }" pattern="￥#,#00.00"></fmt:formatNumber></span>
			<br>
			定金：<span class="price"><fmt:formatNumber value="${orderContract.orderMoney }" pattern="￥#,#00.00"></fmt:formatNumber></span>
			<br>
			顾问：${customer.bussiStaff}（${customer.department.name}）
		</div>
	</div>
	<c:if test="${customer.customerPidBookingRecord.wlStatus==2 }">
		<div class="line"></div>
		<div class="title" align="left">
	 			物流状态
		</div>
		<div class="line"></div>
		<div style="margin: 0 auto;margin: 5px;">
			<div style="color:#8a8a8a;padding-left: 5px; ">
			合同状态：<c:if test="${customer.customerPidBookingRecord.pidStatus==1 }">
				<span style="color: blue">已打印合同</span>
			</c:if>
			<c:if test="${customer.customerPidBookingRecord.pidStatus==2 }">
				<span style="color: blue">已经归档</span>
			</c:if>
			<c:if test="${customer.customerPidBookingRecord.pidStatus==3 }">
				<span style="color: #DD9A4B;">等待销售副总审批</span>
			</c:if>
			<c:if test="${customer.customerPidBookingRecord.pidStatus==4 }">
				<span style="color: #DD9A4B;">等待总经理审批</span>
			</c:if>
			<c:if test="${customer.customerPidBookingRecord.pidStatus==5 }">
				<span style="color: blue;">总经理同意流失</span>
			</c:if>
			<c:if test="${customer.customerPidBookingRecord.pidStatus==6 }">
				<span style="color: red;">总经理驳回申请</span>
			</c:if>
			<c:if test="${customer.customerPidBookingRecord.pidStatus==7 }">
				<span style="color: red;">销售副总驳回申请</span>
			</c:if>
			<br>
			交车状态：<c:if test="${customer.customerPidBookingRecord.wlStatus==0 }">
				<span class="dropDownContent">未提交</span>
			</c:if>
			<c:if test="${customer.customerPidBookingRecord.wlStatus==1 }">
				<span style="color: red;" class="dropDownContent">等待处理</span>
			</c:if>
			<c:if test="${customer.customerPidBookingRecord.wlStatus==2 }">
				<span class="dropDownContent" onclick="$.utile.openDialog('${ctx}/customerPidBookingRecord/viewWlbCustomerPidRecord?customerId=${customer.dbid }','查看处理记录',1024,380)">已经处理</span>
			</c:if>
			<br>
			车辆状态：
			<c:if test="${customer.customerPidBookingRecord.hasCarOrder==1 }">
				<span style="color: blue;">现车订单</span>
			</c:if>
			<c:if test="${customer.customerPidBookingRecord.hasCarOrder==2 }">
				<span style="color: green;">在途订单</span>
			</c:if>
			<c:if test="${customer.customerPidBookingRecord.hasCarOrder==3 }">
				<span style="color: red;">无车订单</span>
			</c:if>
			<br>
			vin码:
			<a href="${ctx }/qywxCustomer/factoryOrderDetail?vinCode=${customer.customerPidBookingRecord.vinCode}&type=1">${customer.customerPidBookingRecord.vinCode}</a>
		</div>
		</div>
	</c:if>
</div>
<div class="orderContrac detail">
	<div class="title" align="left">
	审批记录
	</div>
	<div class="line"></div>
	<div style="margin: 0 auto;margin: 5px;">
		<div style="color:#8a8a8a;padding-left: 5px; ">
			<c:if test="${empty(approvalRecords) }">
					<span style="color: red;padding-left: 12px;">无审批记录信息！</span>				
			</c:if>
			<c:if test="${!empty(approvalRecords) }">
				<c:forEach var="approvalRecord" items="${approvalRecords }">
					    	审批人：${approvalRecord.approvalName } &nbsp;&nbsp;&nbsp;&nbsp;<fmt:formatDate value="${approvalRecord.approvalTime }" pattern="yyyy年MM月dd日 HH:mm"/> &nbsp;&nbsp;&nbsp;&nbsp;
					    	<br>
					    	审批结果: 
					    	<c:if test="${approvalRecord.result==1 }">
								<span style="color: #DD9A4B;">提交售副总审批</span>
							</c:if>
							<c:if test="${approvalRecord.result==2 }">
								<span style="color: red;">销售副总审批驳回</span>
							</c:if>
							<c:if test="${approvalRecord.result==3 }">
								<span style="color: blue;">销售副总审批同意</span>
							</c:if>
							<c:if test="${approvalRecord.result==4 }">
								<span style="color: blue;">提交总经理审批</span>
							</c:if>
							<c:if test="${approvalRecord.result==5 }">
								<span style="color: red;">总经理审批驳回</span>
							</c:if>
							<c:if test="${approvalRecord.result==6 }">
								<span style="color: blue;">总经理审批同意</span>
							</c:if>
							<c:if test="${approvalRecord.result==8 }">
								<span style="color: blue;">待展厅经理审批</span>
							</c:if>
							<c:if test="${approvalRecord.result==10 }">
								<span style="color: red;">展厅经理审批驳回</span>
							</c:if>
							<c:if test="${approvalRecord.result==9 }">
								<span style="color: blue;">展厅经理审批同意</span>
							</c:if>
							<br>
					  		审批意见：${approvalRecord.sugg }
					  		<br>
					  		<div class="line"></div>
				</c:forEach>
			</c:if>
		</div>
	</div>
</div>
<div class="orderContrac detail">
	<div class="title" align="left">
		费用明细
	</div>
	<div class="line"></div>
	<div style="margin: 0 auto;margin: 5px;">
		<div style="color:#8a8a8a;padding-left: 5px; ">
			<table>
				<tr height="32">
				<td class="formTableTdLeft">经销商报价：&nbsp;</td>
				<td colspan="">
					${orderContractExpenses.salePrice }
				</td>
				<td class="formTableTdLeft" style="font-size: 11px;">车辆顾问结算价：</td>
				<td id="carColorId">
					${orderContractExpenses.carSalerPrice }
				</td>
			</tr>
			<tr height="32">
				<td class="formTableTdLeft">合同总金额：&nbsp;</td>
				<td colspan="">
					<span style="color: red;font-size: 14px;">${orderContractExpenses.totalPrice }</span>
				</td>
				<td class="formTableTdLeft" >购车定金：</td>
				<td >
					${orderContractExpenses.orderMoney } 
				</td>
			</tr>
			<tr height="32">
					<td class="formTableTdLeft">装饰款：&nbsp;</td>
					<td >
						${orderContractExpenses.decoreMoney }
					</td>
					<td class="formTableTdLeft" style="font-size: 11px;">装饰顾问结算价：&nbsp;</td>
					<td >
						${orderContractDecore.salerTotalPrice }
					</td>
			</tr>
			<tr>
					<td class="formTableTdLeft">咨询服务费：&nbsp;</td>
					<td >
						${orderContractExpenses.ajsxf }
					</td>
					<td class="formTableTdLeft" style="font-size: 11px;">咨询服务费成本：&nbsp;</td>
					<td >
						0
					</td>
			</tr>
			<tr height="32">
				<td class="formTableTdLeft">预收款总额：&nbsp;</td>
				<td colspan="">
					<span style="font-size: 14px;">${orderContractExpenses.advanceTotalPrice }</span>
				</td>
				<td class="formTableTdLeft" >其他收费总额：</td>
				<td >
					${orderContractExpenses.otherFeePrice } 
				</td>
			</tr>
			<tr height="32">
				<td class="formTableTdLeft">整车营收：&nbsp;</td>
				<td colspan="">
					<span style="font-size: 14px;">${orderContractExpenses.revenuePrice }</span>
				</td>
				<td class="formTableTdLeft" >预估整车毛利：</td>
				<td >
					<c:set value="${orderContractExpenses.revenuePrice-orderContractExpenses.carSalerPrice-orderContractDecore.salerTotalPrice }" var="carGrofitPrice"></c:set>
					<c:if test="${carGrofitPrice>0 }">
						<span style="color: red;font-size: 20px;">${carGrofitPrice }</span>
					</c:if>
					<c:if test="${carGrofitPrice<=0 }">
						<span style="color: green;font-size: 20px;">${carGrofitPrice }</span>
					</c:if>
				</td>
			</tr>
			<tr height="32">
				<td class="formTableTdLeft">裸车销售价：&nbsp;</td>
				<td colspan="">
					<span style="font-size: 14px;">${orderContractExpenses.carActurePrice }</span>
				</td>
				<td class="formTableTdLeft" >预估裸车毛利：</td>
				<td >
					<c:set value="${orderContractExpenses.carActurePrice-orderContractExpenses.carSalerPrice }" var="carPrice"></c:set>
					<c:if test="${carPrice>0 }">
						<span style="color: red;font-size: 20px;">${carPrice }</span>
					</c:if>
					<c:if test="${carPrice<=0 }">
						<span style="color: green;font-size: 20px;">${carPrice }</span>
					</c:if> 
				</td>
			</tr>
			<tr height="32">
				<td class="formTableTdLeft">购车方式：&nbsp;</td>
				<td >
					<c:if test="${orderContractExpenses.buyCarType==1 }">
						<span style="color: green;">现款</span>
					</c:if>
					<c:if test="${orderContractExpenses.buyCarType==2 }">
						<span style="color: red;">分付</span>
					</c:if>
				</td>
				<td class="formTableTdLeft">付款方式：&nbsp;</td>
				<td >
					<c:if test="${orderContractExpenses.payWay==1 }">
						<span style="color: green;">现金</span>
					</c:if>
					<c:if test="${orderContractExpenses.payWay==2 }">
						<span style="color: red;">转账</span>
					</c:if>
				</td>
			</tr>
			<c:if test="${orderContractExpenses.buyCarType==2 }">
				<tr height="32">
					<td class="formTableTdLeft">首付款：&nbsp;</td>
					<td colspan="">
						<span style="font-size: 14px;">
						<c:if test="${empty(orderContractExpenses.sfk) }">
							0.0
						</c:if>
						<c:if test="${!empty(orderContractExpenses.sfk) }">
							${orderContractExpenses.sfk }
						</c:if>
						</span>
					</td>
					<td class="formTableTdLeft" >贷款：</td>
					<td >
						<c:if test="${empty(orderContractExpenses.daikuan) }">
							0.0
						</c:if>
						<c:if test="${!empty(orderContractExpenses.daikuan) }">
							${orderContractExpenses.daikuan}
						</c:if>
					</td>
				</tr>
			</c:if>
			<tr height="32">
					<td class="formTableTdLeft">未折让权限：&nbsp;</td>
					<td colspan="3">
						<span style="font-size: 14px;">
						<c:if test="${empty(orderContractExpenses.noWllowancePrice) }">
							0.0
						</c:if>
						<c:if test="${!empty(orderContractExpenses.noWllowancePrice) }">
							${orderContractExpenses.noWllowancePrice }
						</c:if>
						</span>
					</td>
					<td class="formTableTdLeft">颜色溢价：&nbsp;</td>
					<td colspan="0">
						<span style="font-size: 14px;">
						<c:if test="${empty(orderContractExpenses.colorPrice) }">
							0.0
						</c:if>
						<c:if test="${!empty(orderContractExpenses.colorPrice) }">
							${orderContractExpenses.colorPrice }
						</c:if>
						</span>
					</td>
				</tr>
			</table>
		</div>
	</div>
	<div class="line"></div>
	<div class="title" align="left">
		收费明细
	</div>
	<div class="line"></div>
	<table cellpadding="0" cellspacing="0" width="100%" border="0" style="color:#8a8a8a">
		<c:if test="${empty(orderContractExpensesPreferenceItems) }" var="status">
			<span style="color: red;padding-left: 12px;">无收费明细</span>
		</c:if>
		<c:if test="${status==false }">
			<c:forEach var="orderContractExpensesPreferenceItem" items="${orderContractExpensesPreferenceItems }" varStatus="inde">
				<tr class="tabletr">
					<td width="140" align="left">${inde.index+1 }、${orderContractExpensesPreferenceItem.preferenceItemName }</td>
					<td width="80" align="left">
					<fmt:formatNumber value="${orderContractExpensesPreferenceItem.price }" pattern="￥#,#00.00"></fmt:formatNumber>
					</td>
					<td width="80"  align="left">${orderContractExpensesPreferenceItem.note }&#12288;</td>
				</tr>
			</c:forEach>
		</c:if>
	</table>
	<div class="line"></div>
	<div class="title" align="left">
		优惠明细
	</div>
	<div class="line"></div>
	<table cellpadding="0" cellspacing="0" width="100%" border="0" style="color:#8a8a8a">
		<c:if test="${empty(orderContractExpensesChargeItems) }" var="status">
			<span style="color: red;padding-left: 12px;">无优惠明细</span>
		</c:if>
		<c:if test="${status==false }">
			<c:forEach var="orderContractExpensesChargeItem" items="${orderContractExpensesChargeItems }" >
				<tr class="tabletr">
					<td width="140" align="left">${itemB.index+1 }、${orderContractExpensesChargeItem.chargeItemName }</td>
					<td width="80" align="left">
						<fmt:formatNumber value="${orderContractExpensesChargeItem.price }" pattern="￥#,#00.00"></fmt:formatNumber>
					</td>
					<td width="80" align="left">${orderContractExpensesChargeItem.note }&#12288;</td>
				</tr>
			</c:forEach>
		</c:if>
	</table>
</div>
<div class="orderContrac detail">
	<div class="title" align="left">
		装饰明细
	</div>
	<div class="line"></div>
	<div style="margin: 0 auto;margin: 5px;">
		<div style="color:#8a8a8a;padding-left: 5px; ">
			<table>
				<tr>
					<td>销售合计：
					<fmt:formatNumber value="${orderContractDecore.decoreSaleTotalPrce }" pattern="￥#,#00.00"></fmt:formatNumber>
					&#12288;</td>
					<td>赠送合计：
					<fmt:formatNumber value="${orderContractDecore.giveTotalPrice }" pattern="￥#,#00.00"></fmt:formatNumber>
					&#12288;</td>
				</tr>
				<tr>
					<td>
						装饰款：<fmt:formatNumber value="${orderContractExpenses.decoreMoney}" pattern="￥#,#00.00"></fmt:formatNumber>
					</td>
					<td class="formTableTdLeft">
						折扣率：${orderContractDecore.zkl }
					</td>
				</tr>
				<tr>
					<td >装饰顾问结算价:
						${orderContractDecore.salerTotalPrice }
					</td>
					<td >装饰毛利:
						${orderContractDecore.salerGrofitPrice }
					</td>
				</tr>
			</table>
		</div>
	</div>
	<div class="line"></div>
	<div class="title" align="left">
		销售装饰
	</div>
	<div class="line"></div>
	<table cellpadding="0" cellspacing="0" width="100%" border="0" style="color:#8a8a8a">
			<c:set value="0" var="saleCount"></c:set>
			<c:forEach  var="decoreNoticeItem" items="${orderContractDecore.orderContractDecoreItem }"  varStatus="i">
				<c:if test="${decoreNoticeItem.type==1 }">
					<c:set value="${saleCount+1 }" var="saleCount"></c:set>
					<tr> 
						<td width="140" align="left">
							${saleCount }、${decoreNoticeItem.itemName }
						</td>
						<td width="80" align="left">
							<fmt:formatNumber value="${decoreNoticeItem.price }" pattern="￥#,#00.00"></fmt:formatNumber>
						</td>
						<td width="80" align="center">
							${decoreNoticeItem.quality }
						</td>
					</tr>
					
				</c:if>
			</c:forEach>
			<c:if test="${saleCount<=0 }" var="status">
				<span style="color: red;padding-left: 12px;">无销售装饰</span>
			</c:if>
	</table>
	<div class="line"></div>
	<div class="title" align="left">
		赠送装饰
	</div>
	<div class="line"></div>
	<table cellpadding="0" cellspacing="0" width="100%" border="0" style="color:#8a8a8a">
		<c:set value="0" var="zsCount"></c:set>
		<c:forEach  var="decoreNoticeItem" items="${orderContractDecore.orderContractDecoreItem }"  varStatus="i">
			<c:if test="${decoreNoticeItem.type==2 }">
				<c:set value="${zsCount+1 }" var="zsCount"></c:set>
				<tr> 
					<td width="140" align="left">
						${zsCount }、${decoreNoticeItem.itemName }
					</td>
					<td width="80" align="left">
						<fmt:formatNumber value="${decoreNoticeItem.price }" pattern="￥#,#00.00"></fmt:formatNumber>
					</td>
					<td width="80" align="center">
						${decoreNoticeItem.quality }
					</td>
				</tr>
				<tr>
					<td >装饰顾问结算价:
						${orderContractDecore.salerTotalPrice }
					</td>
					<td >装饰毛利:
						${orderContractDecore.salerGrofitPrice }
					</td>
				</tr>
			</c:if>
		</c:forEach>
		<c:if test="${zsCount<=0 }" var="status">
				<span style="color: red;padding-left: 12px;">无赠送装饰</span>
	    </c:if>
	</table>
</div>
<div class="modal fade" id="exampleModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
  <div class="modal-dialog">
    <div class="modal-content">
      <div class="modal-header">
        <h4 class="modal-title" id="exampleModalLabel">审批</h4>
      </div>
      <div class="modal-body">
        <form id="frmId" name="frmId" method="post" >
	    	<input type="hidden" id="orderContractId" name="orderContractId" value="${orderContract.dbid}"/>
	    	<input type="hidden" id="type" name="type" value="1"/>
			<input type="hidden" id="status" name="status" value=""/>
	          <div class="form-group">
	            <label for="message-text" class="control-label">意见:</label>
	            <textarea class="form-control" name="sugg" id="sugg" style="height: 120px;"></textarea>
	          </div>
        </form>
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-default" data-dismiss="modal">取&nbsp;&nbsp;消</button>
        <button type="button" class="btn btn-primary" onclick="submitAjaxForm('frmId','${ctx}/qywxOrderContract/saveApproval')">提&nbsp;&nbsp;交</button>
      </div>
    </div>
  </div>
</div>
<br>
<br>
<br>
<br>
</body>
<script src="${ctx }/widgets/bootstrap3/jquery.min.js"></script>
<script src="${ctx }/widgets/bootstrap3/js/bootstrap.min.js"></script>
<script src="${ctx }/widgets/utile/wechat.js"></script>
</html>