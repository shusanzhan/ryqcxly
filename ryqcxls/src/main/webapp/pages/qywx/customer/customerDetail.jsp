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
<title>${customer.name }档案信息</title>
</head>
<body>
<div id="hearder_nav" class="views content_title navbar-fixed-top">
    <a id="back" href="javascript:history.back()">
        <img src="${ctx }/images/jm/NavButtonBack.png" class="return">
    </a>
    <span id="page_title">${customer.name }档案信息</span>
    <c:if test="${param.type==1 }">
	    <a class="go_home" href="${ctx }/qywxCustomer/index">
	    	<img src="${ctx }/images/jm/go_home.png" alt="">
	    </a>
    </c:if>
    <c:if test="${param.type==2 }">
	    <a class="go_home" href="${ctx }/qywxCustomerTrack/index">
	    	<img src="${ctx }/images/jm/go_home.png" alt="">
	    </a>
    </c:if>
</div>
<br>
<br>
<br>

<div class="orderContrac detail">
	<div class="title" align="left">
 			客户：${customer.name }&nbsp;&nbsp;${customer.sex }<br/>
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
				${carModel }${customer.carModelStr}
			</c:if>
			<br>
			意向级别：${customer.customerPhase.name}<br>
			登记时间：<fmt:formatDate value="${customer.createFolderTime }"/> <br/>
			顾问：${customer.bussiStaff}（${customer.department.name}）<br>
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
					<span style="color: #DD9A4B;">合同流失待审批</span>
				</c:if>
				<c:if test="${customer.customerPidBookingRecord.pidStatus==4 }">
					<span style="color: #DD9A4B;">合同流失</span>
				</c:if>
				<c:if test="${customer.customerPidBookingRecord.pidStatus==5 }">
					<span style="color: red;">审批驳回</span>
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
			定金：<span style="color: red;">${orderContract.orderMoney }</span><br>
			合同金额：<span style="color: red;">${orderContract.totalPrice}</span><br>
			订单日期：<fmt:formatDate value="${orderContract.createTime }"/> <br/>
			VIM码：${customer.customerPidBookingRecord.vinCode}<br/>
			归档日期：<fmt:formatDate value="${customer.customerPidBookingRecord.modifyTime }"/> <br/>
		</div>
		</div>
	</c:if>
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
					<td colspan="2">证件信息：${ customer.paperwork.name}&#12288;</td>
				</tr>
				<tr>
					<td colspan="2">
						证件号码：${customer.icard }
					</td>
				</tr>
				<tr >
					<td colspan="2">地址：${customer.area.fullName }${customer.address }
					</td>
				</tr>
				<tr>
					<td colspan="2" class="formTableTdLeft">类型：
						${customer.customerType.name }
					</td>
				</tr>
				<tr>
					<td colspan="2" class="formTableTdLeft" >购车预算：${customerBussi.buyCarBudget.name}
						</td>
				</tr>
				<tr>
						<td colspan="2" class="formTableTdLeft">使用者：
							${customerBussi.buyCarMainUse.name}
						</td>
					</tr>
			</table>
		</div>
	</div>
</div>

<div class="orderContrac detail">
	<div class="title" align="left">
		跟踪记录
	</div>
	<div class="line"></div>
	<div style="margin: 0 auto;margin: 5px;">
	<div style="color:#8a8a8a;padding-left: 5px; ">
		<table cellpadding="0" cellspacing="0" width="100%" border="0" style="color:#8a8a8a">
			<c:if test="${empty(customertracks) }" var="status">
				<span style="color: red;padding-left: 12px;">无跟踪记录</span>
			</c:if>
			<c:if test="${status==false }">
					<table width="100%"  cellpadding="0" cellspacing="0" class="mainTable" border="0">
						<c:forEach var="customerTrack" items="${customertracks }" varStatus="i">
								<tr>
									<td id="" width="200">
										${i.index+1 }、<a href='javascript:;' onclick="showDecore('${ctx}/qywxCustomer/viewCustomerTrack?customerTrackId=${customerTrack.dbid }','','','跟踪明细')" ><fmt:formatDate value="${customerTrack.trackDate}" pattern="yyyy-MM-dd"/> </a>
								    </td>
								    <td style="text-align: center;" width="80">
										<c:if test="${customer.lastResult==1 }">
											电话
										</c:if>
										<c:if test="${customer.lastResult==2 }">
											到店
										</c:if>
										<c:if test="${customer.lastResult==3 }">
											短信
										</c:if>
										<c:if test="${customer.lastResult==4 }">
											上门
										</c:if>
										<c:if test="${customer.lastResult==5 }">
											微信
										</c:if>
										<c:if test="${customer.lastResult==6 }">
											QQ
										</c:if>
									</td>
								    <td style="text-align: center;" width="40">
										${customerTrack.beforeCustomerPhase.name}
									</td>
								</tr>
						</c:forEach>
					</table>
			</c:if>
		</table>
		</div>
	</div>
</div>
<!-- 成交结果  -->
<c:if test="${customer.lastResult>0 }">
<div class="orderContrac detail">
	<div class="title" align="left">
		成交结果
	</div>
	<div class="line"></div>
	<div style="margin: 0 auto;margin: 5px;">
	<div style="color:#8a8a8a;padding-left: 5px; ">
		<table cellpadding="0" cellspacing="0" width="100%" border="0" style="color:#8a8a8a">
					<tr>
						<td id="" >成交结果：
							<c:if test="${customer.lastResult==0 }">
								创建客户
							</c:if>
							<c:if test="${customer.lastResult==1 }">
								<span style="color: blue;">成交购车</span> 
							</c:if>
							<c:if test="${customer.lastResult==2 }">
								<span style="color: red;">流失购买其他品牌</span>
							</c:if>
							<c:if test="${customer.lastResult==3 }">
								<span style="color: red;">购车计划取消</span>
							</c:if>
					    </td>
					</tr>
					<c:if test="${customer.lastResult==1 }">
						<tr>
							<td id="" >成交车型：
								${customer.customerBussi.brand.name}&#12288;
								<c:set value="${customer.customerBussi.carSeriy.name}${ customer.customerBussi.carModel.name }" var="carModel"></c:set>
								<c:if test="${fn:length(carModel)>16 }" var="status">
									${fn:substring(carModel,0,16) }...
								</c:if>
								<c:if test="${ status==false}">
									${carModel }${customer.carModelStr}
								</c:if>
						    </td>
						</tr>	
					</c:if>		
					<c:if test="${customer.lastResult>1 }">
					<tr>
						<td id="" >
							审批状态：
							<c:if test="${customer.lastResult>1 }">
								<c:if test="${customer.customerLastBussi.approvalStatus==0 }">
									<span style="color: #DD9A4B;;">等待审批...</span>
								</c:if>
								<c:if test="${customer.customerLastBussi.approvalStatus==1 }">
									<span style="color: red;">客户流失</span>
								</c:if>
							</c:if>
					    </td>
					</tr>
					</c:if>
					<tr>
						<td id="" >
							备注：${customerLastBussi.note }
					    </td>
					</tr>
			</table>
		</div>
	</div>
</div>
</c:if>
<!-- 成交结果结束 -->

<div class="modal fade" id="exampleModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
  <div class="modal-dialog">
    <div class="modal-content">
      <div class="modal-header">
        <h4 class="modal-title" id="exampleModalLabel">跟踪明细</h4>
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
<br>
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