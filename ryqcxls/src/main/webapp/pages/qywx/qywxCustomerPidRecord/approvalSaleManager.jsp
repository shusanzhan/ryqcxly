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
<title>${customer.name }合同流失审批</title>
</head>
<body>
<div class="views content_title navbar-fixed-top">
	 <a id="back" href="javascript:history.back()">
        <img src="${ctx }/images/jm/NavButtonBack.png" class="return">
    </a>
    <span id="page_title">${customer.name }合同流失审批</span>
    <a class="go_home" href="${ctx }/qywxCustomerPidRecord/saleManagerList">
    	<img src="${ctx }/images/jm/go_home.png" alt="">
    </a>
</div>
<br>
<br>
<br>
<c:set value="${customer.orderContract }" var="orderContract"></c:set>
<div class="orderContrac detail">
	<div class="title" align="left">
 			客户：${customer.name }<br/>
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
			总价：<span class="price"><fmt:formatNumber value="${orderContract.totalPrice }" pattern="￥#,#00.00"></fmt:formatNumber></span>
			<br>
			定金：<span class="price"><fmt:formatNumber value="${orderContract.orderMoney }" pattern="￥#,#00.00"></fmt:formatNumber></span>
			<br>
			顾问：${customer.bussiStaff}（${customer.department.name}）
		</div>
	</div>
</div>
<div class="orderContrac detail">
	<div class="title" align="left">
		流失原因
	</div>
	<div class="line"></div>
	<div style="margin: 0 auto;margin: 5px;">
		<div style="color:#8a8a8a;padding-left: 5px; ">
			申请时间：<fmt:formatDate value="${customerPidCancel.createDate}" pattern="yyyy-MM-dd HH:mm"/> 
			<br>
			流失原因：${customerPidCancel.note }
		</div>
	</div>
</div>
<div class="modal fade" id="exampleModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
  <div class="modal-dialog">
    <div class="modal-content">
      <div class="modal-header">
        <h4 class="modal-title" id="exampleModalLabel">预审意见</h4>
      </div>
      <div class="modal-body">
        <form id="frmId" name="frmId" method="post" >
            <input type="hidden" id="status" name="status" value="">
            <input type="hidden" name="customerPidCancelId" id="customerPidCancelId" value="${customerPidCancel.dbid }">
			<input type="hidden" name="customerId" value="${customer.dbid }" id="customerId"></input>
			<input type="hidden" name="customerPidBookingRecordDbid" id="dbid" value="${customerPidBookingRecord.dbid }">
			<input type="hidden" name="pidStatus" id="pidStatus" >
	          <div class="form-group">
	            <label for="message-text" class="control-label">意见:</label>
	            <textarea class="form-control" name="sugg" id="sugg" style="height: 120px;"></textarea>
	          </div>
        </form>
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-default" data-dismiss="modal">取&nbsp;&nbsp;消</button>
        <button type="button" class="btn btn-primary" onclick="submitAjaxForm('frmId','${ctx}/qywxCustomerPidRecord/saveApprovalOrderContractCancel')">提&nbsp;&nbsp;交</button>
      </div>
    </div>
  </div>
</div>
<br>
<br>
<br>
<br>
<div class="orderMenu">
	<ul>
         <li>
             <a href="javascript:void(-1)"  data-toggle="modal" data-target="#exampleModal" onclick="setVal(7)">
             	驳回
             </a>
         </li>
         <li>
             <a href="javascript:void(-1)" id="agreeActive" data-toggle="modal" data-target="#exampleModal" onclick="setVal(4)">
             	同意
             </a>
         </li>
      </ul>
</div>	


</body>
<script src="${ctx }/widgets/bootstrap3/jquery.min.js"></script>
<script src="${ctx }/widgets/bootstrap3/js/bootstrap.min.js"></script>
<script src="${ctx }/widgets/utile/wechat.js"></script>
<script type="text/javascript">
	function setVal(va){
		$("#pidStatus").val(va);
		if(va==4){
			$('#exampleModal').find('.modal-title').text('预审（同意） ');
		}
		if(va==7){
			$('#exampleModal').find('.modal-title').text('预审（驳回） ');
		}
	}
</script>
</html>