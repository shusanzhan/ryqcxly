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
<title>交车预约</title>
<style type="text/css">
	.largeX{
		width: 100%;
		height: 32px;
	}
</style>
</head>
<body class="bodycolor">
<div class="views content_title">
	 <a id="back" href="javascript:history.back()">
        <img src="${ctx }/images/jm/NavButtonBack.png" class="return">
    </a>
    <span id="page_title">客户归档</span>
</div>
<div class="orderContrac">
	<div class="title" align="left">
 			客户：${customer.name }<br/>
 			电话：<a href="tel:${customer.mobilePhone }">${customer.mobilePhone }</a>
			</div>
			<div class="line"></div>
		<div style="margin: 0 auto;margin: 5px;" onclick="window.location.href='${ctx}/qywxCustomer/customerDetail?customerId=${customer.dbid }&type=1'">
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
				颜色:${customerLastBussi.carColor.name}
				<br>
				顾问：${customer.bussiStaff}（${customer.department.name}）<br>
				意向级别：${customer.customerPhase.name}<br>
				订单日期:<fmt:formatDate value="${customer.orderContract.createTime }" pattern="yyyy-MM-dd HH:mm"/> <br/>
				定金:<span style="color: red;"><fmt:formatNumber value="${customer.orderContract.orderMoney }" pattern="#0.00"/> </span><br/>
				合同金额:<span style="color: red;"><fmt:formatNumber value="${customer.orderContract.totalPrice }" pattern="#0.00"/> </span><br/>
				</div>
		</div>
</div>
<div style="margin: 0 auto;width: 92%;margin-top: 20px;">
	<form action="" name="frmId" id="frmId" style="margin-bottom: 40px;" >
		<input type="hidden" name="customerId" value="${customer.dbid }" id="customerId"></input>
		<input type="hidden" name="customerPidBookingRecord.createTime" id="createTime" value="${customerPidBookingRecord.createTime}">
		<input type="hidden" name="customerPidBookingRecord.dbid" id="dbid" value="${customerPidBookingRecord.dbid }">
		<input type="hidden" id="brandId" name="brandId" value="${customer.customerLastBussi.brand.dbid }" />
		<input type="hidden" id="carModelId" name="carModelId" value="${customer.customerLastBussi.carModel.dbid }" />
		<input type="hidden" id="carSeriyId" name="carSeriyId" value="${customer.customerLastBussi.carSeriy.dbid }" />
		<input type="hidden" id="carColorId" name="carColorId" value="${customerLastBussi.carColor.dbid}" />
		<input type="hidden" readonly="readonly" name="customerPidBookingRecord.orderDate" id="orderDate" class="largeX text"  value='<fmt:formatDate value="${customer.orderContract.createTime }" pattern="yyyy-MM-dd HH:mm"/>' >
		<s:token></s:token>
		<div class="form-group">
	 		 <label class="control-label" for="name">归档日期:&nbsp;	<span style="color: red;">*</span></label>				
				<input type="date" name="customerPidBookingRecord.modifyTime" id="modifyTime" class="form-control"   checkType="string,10" style="width: 100%;">
		</div>
		<div class="form-group">
	 		 <label class="control-label" for="name">车架号:&nbsp;	<span style="color: red;">*</span></label>				
				<input type="text" name="customerPidBookingRecord.vinCode" id="vinCode" class="form-control"   checkType="string,10" style="width: 100%;" ="${customerPidBookingRecord.vinCode }" checkType="string,17,17">
		</div>
		<div class="form-group">
	 		 <label class="control-label" for="name">备注:&nbsp</label>
			<textarea   name="customerPidBookingRecord.note" id="note"	 class="form-control" title="备注" placeholder="请填写需要告知调配出库人员信息">${customerPidBookingRecord.note }</textarea>
		</div>
	</form>
	<div class="buttomBar">
	    <input type="button" name="mobileCommit" value="保&nbsp;&nbsp;存" id="tele_register" class="addbutton" onclick="submitFrm('frmId','${ctx}/qywxCustomerPidRecord/save')">
	</div>	
</div>
</body>
<script src="${ctx }/widgets/bootstrap3/jquery.min.js"></script>
<script src="${ctx }/widgets/easyvalidator/js/easy_validator.pack3.js?n=${now}"></script>
<script src="${ctx }/widgets/bootstrap3/js/bootstrap.min.js"></script>
<script src="${ctx }/widgets/utile/wechat.js"></script>
<script type="text/javascript">
	function submitFrm(frmId,url){
		try {
			if(validateForm(frmId)){
			if (undefined != frmId && frmId != "") {
				var params = $("#" + frmId).serialize();
					var url2="";
					$.ajax({	
						url : url, 
						data : params, 
						async : false, 
						timeout : 20000, 
						dataType : "json",
						type:"post",
						success : function(data, textStatus, jqXHR){
							//alert(data.message);
							var obj;
							if(data.message!=undefined){
								obj=$.parseJSON(data.message);
							}else{
								obj=data;
							}
							if(obj[0].mark==1){
								//错误
								showMo(data[0].message,false);
								$(".addbutton").attr("onclick",url2);
								return ;
							}else if(obj[0].mark==0){
								showMo(data[0].message,true);
								setTimeout(
										function() {
											window.location.href = obj[0].url
										}, 1000);
							}
						},
						complete : function(jqXHR, textStatus){
							$(".addbutton").attr("onclick",url2);
							var jqXHR=jqXHR;
							var textStatus=textStatus;
						}, 
						beforeSend : function(jqXHR, configs){
							url2=$(".addbutton").attr("onclick");
							$(".addbutton").attr("onclick","");
							var jqXHR=jqXHR;
							var configs=configs;
						}, 
						error : function(jqXHR, textStatus, errorThrown){
									showMo(data[0].message);
								$(".addbutton").attr("onclick",url2);
						}
					});
				} else {
					return;
				}
			}
		} catch (e) {
			showMo(e,false);
			return;
		}
	}
</script>
</html>