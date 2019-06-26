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
<title>车辆档案信息</title>
</head>
<body>
<div id="hearder_nav" class="views content_title navbar-fixed-top">
    <a id="back" href="javascript:history.back()">
        <img src="${ctx }/images/jm/NavButtonBack.png" class="return">
    </a>
    <span id="page_title">车辆档案信息</span>
    <a class="go_home" href="${ctx }/qywxWlbFacotoryOrder/index">
    	<img src="${ctx }/images/jm/go_home.png" alt="">
    </a>
</div>
<br>
<br>
<br>
<div class="orderContrac detail">
	<div class="title" align="left">
 			车型：
 			${factoryOrder.carSeriy.name }
			${factoryOrder.carModel.name }
			${factoryOrder.carColor.name }<br/>
 			工厂日期：<fmt:formatDate value="${factoryOrder.factoryOrderDate}" pattern="yyyy-MM-dd"/>
	</div>
	<div class="line"></div>
	<div style="margin: 0 auto;margin: 5px;">
		<div style="color:#8a8a8a;padding-left: 5px; ">
			<table>
				<c:set value="${factoryOrder.carReceiving }" var="carReceiving"></c:set>
				<tr>
					<td colspan="2">VIN码：${factoryOrder.vinCode}&#12288;</td>
				</tr>
				<tr>
					<td>奖励：${factoryOrder.totalRewardMoney }</td>
					<td class="formTableTdLeft">
						惠民：${factoryOrder.huimin }
					</td>
				</tr>
				<tr >
					<td >加装：
						<c:if test="${factoryOrder.isInstall==1 }">
							<span style="color: red;">未加装</span>
						</c:if>
						<c:if test="${factoryOrder.isInstall==2 }">
							<span style="color: green;">加装</span>
						</c:if>
					</td>
					<td >
						预定：
						<c:if test="${factoryOrder.reserveStatus==2 }">
							<span style="color: blue;">已绑定</span>
						</c:if>
						<c:if test="${factoryOrder.reserveStatus==3 }">
							<span style="color: green;">已预定</span>
						</c:if>
						<c:if test="${factoryOrder.reserveStatus==1 }">
							<span style="color: red;">未预定</span>
						</c:if>
					</td>				
				</tr>
				<tr >
					<td class="formTableTdLeft">异常：
						<c:if test="${factoryOrder.abnormalStatus==2 }">
							<span style="color:red;">异常</span>
						</c:if>
						<c:if test="${factoryOrder.abnormalStatus==1 }">
							<span style="color: green;">正常</span>
						</c:if>
					</td>
					<td class="formTableTdLeft">库存：
						<c:if test="${factoryOrder.carStatus==2 }">
							<span style="color: green;">在库</span>
						</c:if>
						<c:if test="${factoryOrder.carStatus==1 }">
							<span style="color: red;">在途</span>
						</c:if>
					</td>
				</tr>
				<tr>
					<td colspan="2">所属公司：${carReceiving.storeCompany.name }&#12288;</td>
				</tr>
				<tr>
					<td colspan="2">
						入库日期：&#12288;
						${carReceiving.transferDate }
					</td>
				</tr>
				<tr>
					<td colspan="2">
						库房：&#12288;
						${carReceiving.storeArea.name }
						${carReceiving.storeRoom.name }
						${carReceiving.storage.name }
					</td>
				</tr>
			</table>
		</div>
	</div>
</div>
<div class="orderContrac detail">
	<div class="title" align="left">
		基础信息
	</div>
	<div class="line"></div>
	<div style="margin: 0 auto;margin: 5px;">
		<div style="color:#8a8a8a;padding-left: 5px; ">
			<table>
				<tr>
					<td colspan="2">物料号：${factoryOrder.materialNumber}&#12288;</td>
				</tr>
				<tr>
					<td colspan="2">
						物料描述：${factoryOrder.materialDes }
					</td>
				</tr>
				<tr >
					<td colspan="2">工厂价：${factoryOrder.factoryPrice }
					</td>
				</tr>
				<tr>
					<td colspan="2">指导价：${factoryOrder.marketPrice }
					</td>				
				</tr>
				<tr>
					<td colspan="2" class="formTableTdLeft">订单性质：
						${factoryOrder.orderAttr }
					</td>
				</tr>
				<tr>
					<td colspan="2" class="formTableTdLeft">订单种类：
						${factoryOrder.orderType }
					</td>
				</tr>
				<tr>
					<td colspan="2" class="formTableTdLeft" >还款状态：
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
				</tr>
				<tr>
						<td colspan="2" class="formTableTdLeft">在库周期：
							${factoryOrder.stockCyle}
						</td>
					</tr>
					<tr>
						<td colspan="2" class="formTableTdLeft">创建日期：
							${factoryOrder.createDate}
						</td>
					</tr>
			</table>
		</div>
	</div>
</div>
<div class="orderContrac detail">
	<div class="title" align="left">
		车辆奖励
	</div>
	<div class="line"></div>
	<div style="margin: 0 auto;margin: 5px;">
		<div style="color:#8a8a8a;padding-left: 5px; ">
			<table>
				<tr>
					<td colspan="2">库龄奖：${factoryOrder.storeAgeLevel.name}&nbsp;&nbsp;&nbsp;<span style="color: red;font-size: 14px;">${factoryOrder.storeAgeLevel.rewardMoney } </span>元</td>
				</tr>
				<tr>
					<td colspan="2">
						订单类型：
						<c:if test="${factoryOrder.orderAttr=='自有资金' }">
								自有资金<span style="color: red;font-size: 14px;">&nbsp;&nbsp;&nbsp;${factoryOrderSet.ownCar } </span>元
							</c:if>
							<c:if test="${factoryOrder.orderAttr=='展期金融' }">
								展期金融<span style="color: red;font-size: 14px;">&nbsp;&nbsp;&nbsp;${factoryOrderSet.loanMoneyDelay } </span>元
							</c:if>
							<c:if test="${factoryOrder.orderAttr=='金融贷款' }">
								金融贷款<span style="color: red;font-size: 14px;">&nbsp;&nbsp;&nbsp;${factoryOrderSet.loanMoneyNormal } </span>元
							</c:if>
					</td>
				</tr>
				<c:if test="${!empty(factoryOrder.rewardMoney)}">
					<tr>
						<td class="formTableTdLeft" colspan="2">车辆特殊奖：
							<span style="color: red;font-size: 14px;">${factoryOrder.rewardMoney } </span>元
						</td>
					</tr>
				</c:if>
				<c:if test="${!empty(factoryOrder.rewardNote) }">
					<tr>
						<td class="formTableTdLeft">车辆备注：</td>
						<td colspan="2">
							${factoryOrder.rewardNote}&nbsp;&nbsp;&nbsp;
						</td>
					</tr>
				</c:if>
				<tr >
					<td colspan="2">奖励总金额：
						<span style="color: red;font-size: 14px;"><fmt:formatNumber value="${factoryOrder.totalRewardMoney }" pattern="#.##"></fmt:formatNumber> </span>元
					</td>
				</tr>
				
			</table>
		</div>
	</div>
</div>
<div class="orderContrac detail">
	<div class="title" align="left">
		加装记录
	</div>
	<div class="line"></div>
	<div style="margin: 0 auto;margin: 5px;">
	<div style="color:#8a8a8a;padding-left: 5px; ">
		<table cellpadding="0" cellspacing="0" width="100%" border="0" style="color:#8a8a8a">
			<c:if test="${empty(installDecoration) }" var="status">
				<span style="color: red;padding-left: 12px;">无加装记录</span>
			</c:if>
			<c:if test="${status==false }">
				<table class="tableContent" border="0" align="center" cellpadding="0" cellspacing="0" style="width: 92%;padding: 12px">
						<tr>
							<td class="formTableTdLeft">加装名称：
								${installDecoration.installName }
							</td>
						</tr>
						<tr>
							<td class="formTableTdLeft">加装时间：
								${installDecoration.installDate }
							</td>
						</tr>
						<tr>
							<td class="formTableTdLeft">加装内容：
								${installDecoration.installContent }
							</td>
						</tr>
						<tr>
							<td class="formTableTdLeft">备注：
								${installDecoration.note }
							</td>
						</tr>
					</table>
					<div class="line"></div>
					<div class="title" align="left">
						装饰项目
					</div>
					<div class="line"></div>
					<table width="100%"  cellpadding="0" cellspacing="0" class="mainTable" border="0">
						<c:forEach var="installItem" items="${installitems }" varStatus="i">
								<tr>
									<td id="" width="200">
										<c:if test="${installItem.product.type==1 }">
											${i.index+1 }、<a href='javascript:;' onclick="showDecore('${ctx}/qywxWlbFacotoryOrder/viewProduct?productId=${installItem.product.dbid }','','','商品明细')" >${installItem.itemName }</a>
										</c:if>
										<c:if test="${installItem.product.type==2 }">
											${i.index+1 }、<a href='javascript:;' onclick="showDecore('${ctx}/qywxWlbFacotoryOrder/viewProduct?productId=${installItem.product.dbid }','','','套餐明细')" >${installItem.itemName }</a>
										</c:if>
								    </td>
								    <td style="text-align: center;" width="80">
										￥${installItem.price }
									</td>
								    <td style="text-align: center;" width="40">
										${installItem.quality }
									</td>
								</tr>
						</c:forEach>
					</table>
			</c:if>
		</table>
		</div>
	</div>
</div>
<div class="orderContrac detail">
	<div class="title" align="left">
		移库记录
	</div>
	<div class="line"></div>
	<div style="margin: 0 auto;margin: 5px;">
		<div style="color:#8a8a8a;padding-left: 5px; ">
				<c:if test="${empty(carTransfers)||carTransfers==null }" var="status">
						<span style="color: red;padding-left: 12px;">无移库记录</span>
				</c:if>
				<c:if test="${status==false }">
				<table width="100%" border="0" class="mainTable" cellpadding="0" cellspacing="0">
					<tbody>
						<c:forEach items="${carTransfers}" var="carTransfer" varStatus="i">
						<tr >
							<td style="text-align: left;">
								${i.index+1 }、${carTransfer.tranferDate }&#12288;${carTransfer.newStorageRoom}
								&#12288;
								${carTransfer.note}
							</td>
						</tr>
						</c:forEach>
					</tbody>
				</table>
				</c:if>
		</div>
	</div>
</div>
<div class="orderContrac detail">
	<div class="title" align="left">
		操作日志
	</div>
	<div class="line"></div>
	<div style="margin: 0 auto;margin: 5px;">
		<div style="color:#8a8a8a;padding-left: 5px; ">
				<c:if test="${fn:length(carOperateLogs)<=0}" var="status">
						<span style="color: red;padding-left: 12px;">操作日志</span>
				</c:if>
				<c:if test="${status==false }">
				<table width="100%" border="0" class="mainTable" cellpadding="0" cellspacing="0">
					<tbody>
						<c:forEach items="${carOperateLogs}" var="carOperateLog" varStatus="i">
							<tr >
								<td style="text-align:left;">
									${i.index+1 }、${carOperateLog.type } &#12288;
									<fmt:formatDate value="${carOperateLog.operateDate}" pattern="yyyy-MM-dd"/>
									&#12288; ${carOperateLog.operator}&#12288;${carOperateLog.note}
								</td>
							</tr>
						</c:forEach>
					</tbody>
				</table>
				</c:if>
		</div>
	</div>
</div>
<div class="orderContrac detail">
	<div class="title" align="left">
		订单信息
	</div>
	<div class="line"></div>
	<div style="margin: 0 auto;margin: 5px;">
		<div style="color:#8a8a8a;padding-left: 5px; ">
				<c:if test="${empty(customer) }" var="status">
						<span style="color: red;padding-left: 12px;">未绑定客户</span>
				</c:if>
				<c:if test="${!empty(customer) }">
					客户：${customer.name }&nbsp;&nbsp;&nbsp;&nbsp; ${customer.mobilePhone}<br/>
					<c:set value="${customer.orderContract }" var="orderContract"></c:set>
					总价：<span class="price"><fmt:formatNumber value="${orderContract.totalPrice }" pattern="￥#,#00.00"></fmt:formatNumber></span>
					<br>
					定金：<span class="price"><fmt:formatNumber value="${orderContract.orderMoney }" pattern="￥#,#00.00"></fmt:formatNumber></span>
					<br>
					顾问：${customer.bussiStaff}（${customer.department.name}）
					<br>
					预约时间：${customerPidBookingRecord.bookingDate }
				</c:if>
		</div>
	</div>
</div>
<div class="modal fade" id="exampleModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
  <div class="modal-dialog">
    <div class="modal-content">
      <div class="modal-header">
        <h4 class="modal-title" id="exampleModalLabel">装饰明细</h4>
      </div>
      <div class="modal-body">
      	 <iframe id="NoPermissioniframe" width="100%" height="100%" frameborder="0" ></iframe>
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-default" data-dismiss="modal">取&nbsp;&nbsp;消</button>
      </div>
    </div>
  </div>
</div>

<br>
<br>
<br>
<c:if test="${factoryOrder.reserveStatus==1 }">
<div class="oneMenu">
	<ul>
         <li>
             <a href="${ctx}/qywxWlbFacotoryOrder/addSpecialMotorPool?vinCode=${factoryOrder.vinCode}">
             	快速占车
             </a>
         </li>
      </ul>
</div>	
</c:if>
</body>
<script src="${ctx }/widgets/bootstrap3/jquery.min.js"></script>
<script src="${ctx }/widgets/bootstrap3/js/bootstrap.min.js"></script>
<script src="${ctx }/widgets/utile/wechat.js"></script>
<script type="text/javascript">
function showDecore(frameSrc,cssobj,cssifm,otitle){
	$("#NoPermissioniframe").attr("src", frameSrc);
	$("#exampleModal").modal();
	 var _scrollHeight = $(document).scrollTop();
     var wHeight = $(window).height();
     var this_height;
     if(cssobj&&cssobj["height"])
       this_height=cssobj["height"];
     else
       this_height="350";
     var this_top=(wHeight-this_height)/2+_scrollHeight+"px";
     var this_top=(wHeight-this_height)/2+"px";

     var myifmcss=cssifm||{};//iframe样式
     $('#exampleModal .modal-dialog').find('.modal-content').css({height: '100%',width: '100%'}).find('h4').html(otitle||"").end().find('.modal-body').css({height: '65%'}).find("#NoPermissioniframe").css(myifmcss);;
}
$(function () {
	var window_w=window.innerWidth|| document.documentElement.clientWidth|| document.body.clientWidth;
	var window_h=window.innerHeight|| document.documentElement.clientHeight|| document.body.clientHeight;
	if($('.go_top').length==0){
	    $('body').append('<a href="#" class="go_top"><img src="${ctx}/images/jm/icon_top.png" data-original=${ctx}/images/jm/icon_top.png" alt=""></a>');
	}
	$(window).scroll(function(e){
	    if(document.body.scrollTop+document.documentElement.scrollTop>window_h){
	        $('.go_top').show();
	    }
	    else{
	        $('.go_top').hide();
	    }
	});
	$('.go_top').click(function(){
	    document.body.scrollTop = 0;
	    document.documentElement.scrollTop = 0;
	    return false;
	})
})
</script>
</html>