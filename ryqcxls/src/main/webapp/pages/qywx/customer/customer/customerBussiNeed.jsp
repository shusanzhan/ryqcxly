<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../../../commons/taglib.jsp" %>
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
<title>完善客户信息-接待结果</title>
<style type="text/css">
	.form-controlSe{
		margin-top: 5px;
	}
	.form-group{
		margin-bottom: 10px;
	}
</style>
</head>
<body>
<div class="views content_title">
	 <a id="back" href="javascript:history.back()">
        <img src="${ctx }/images/jm/NavButtonBack.png" class="return">
    </a>
    <span id="page_title">接待结果</span>
</div>
<div style="margin: 0 auto;width: 92%;margin-top: 20px;">
<form class="form-inline" action="" name="frmId" id="frmId" method="post" >
	<c:set value="${customer.customerShoppingRecord }" var="customerShoppingRecord"></c:set>
	<c:set value="${customer.customerBussi }" var="customerBussi"></c:set>
	<input type="hidden" id="customerShoppingRecordId" name="customerShoppingRecord.dbid" value="${customerShoppingRecord.dbid }">
	<input type="hidden" id="customerBussiId" name="customerBussi.dbid" value="${customerBussi.dbid }">
	<input type="hidden" id="customerId" name="customer.dbid" value="${customer.dbid }">
	<div class="form-group" >
	  <label  class="control-label" for="inputWarning1">客户来源</label  >
	  	<select class="form-control" id="infoFromId" name="infoFromId" class="largeX text" checkType="integer,1" error='请选择客户来源'>
			<option value="">请选择...</option>
			<c:forEach var="infoFrom" items="${infoFroms }">
				<c:if test="${ infoFrom.dbid>58}">
					<option value="${infoFrom.dbid }" ${customerBussi.infoFrom.dbid==infoFrom.dbid?'selected="selected"':'' } >${infoFrom.name }</option>
				</c:if>
			</c:forEach>
		</select>
	</div>
	<div class="form-group" >
	  <label  class="control-label" for="inputWarning1">购车关注点</label  >
	  	<select class="form-control" id="buyCarCareId" name="buyCarCareId" class="largeX text">
			<option value="">请选择...</option>
			<c:forEach var="buyCarCare" items="${buyCarCares }">
				<option value="${buyCarCare.dbid }" ${customerBussi.buyCarCare.dbid==buyCarCare.dbid?'selected="selected"':'' } >${buyCarCare.name }</option>
			</c:forEach>
		</select>
	</div>
	<div class="form-group" >
	  <label class="control-label" for="inputWarning1">购车主要目的</label  >
	  	<select class="form-control" id="buyCarTargetId" name="buyCarTargetId" class="largeX text">
			<option value="">请选择...</option>
			<c:forEach var="buyCarTarget" items="${buyCarTargets }">
				<option value="${buyCarTarget.dbid }" ${customerBussi.buyCarTarget.dbid==buyCarTarget.dbid?'selected="selected"':'' } >${buyCarTarget.name }</option>
			</c:forEach>
		</select>
	</div>
	<div class="form-group" >
	  <label class="control-label" for="inputWarning1">购车类型</label  >
	  	<select class="form-control" id="buyCarTypeId" name="buyCarTypeId" class="largeX text">
			<option value="">请选择...</option>
			<c:forEach var="buyCarType" items="${buyCarTypes }">
				<option value="${buyCarType.dbid }" ${customerBussi.buyCarType.dbid==buyCarType.dbid?'selected="selected"':'' } >${buyCarType.name }</option>
			</c:forEach>
		</select>
	</div>
	<div class="form-group" >
	  <label class="control-label" for="inputWarning1">购车预算</label  >
		  <select class="form-control" id="buyCarBudgetId" name="buyCarBudgetId" class="largeX text">
			<option value="">请选择...</option>
			<c:forEach var="buyCarBudget" items="${buyCarBudgets }">
				<option value="${buyCarBudget.dbid }" ${customerBussi.buyCarBudget.dbid==buyCarBudget.dbid?'selected="selected"':'' } >${buyCarBudget.name }</option>
			</c:forEach>
		</select>
	</div>
	<div class="form-group" >
	  <label class="control-label" for="inputWarning1">主要使用者</label  >
	  	<select class="form-control" id="buyCarMainUseId" name="buyCarMainUseId" class="largeX text">
			<option value="">请选择...</option>
			<c:forEach var="buyCarMainUse" items="${buyCarMainUses }">
				<option value="${buyCarMainUse.dbid }" ${customerBussi.buyCarMainUse.dbid==buyCarMainUse.dbid?'selected="selected"':'' } >${buyCarMainUse.name }</option>
			</c:forEach>
		</select>
	</div>
	<div class="form-group" >
	  <label class="control-label" for="inputWarning1">购车时间</label  >
	  	<select class="form-control" id="trackingPhaseId" name="trackingPhaseId" class="largeX text">
			<option value="">请选择...</option>
			<c:forEach var="trackingPhase" items="${trackingPhases }">
				<option value="${trackingPhase.dbid }" ${customerBussi.trackingPhase.dbid==trackingPhase.dbid?'selected="selected"':'' } >${trackingPhase.name }</option>
			</c:forEach>
		</select>
	</div>
	<div class="form-group" >
	  <label class="control-label" for="inputWarning1">备注</label  >
	  <input type="text" class="form-control" id="cutNote" name="customerBussi.note"  value="${customerBussi.note }">
	</div>
</form>
</div>
<div class="buttomBar">
    <input type="button" name="mobileCommit" value="保存" id="tele_register" class="addbutton" onclick="submitFrm('frmId','${ctx}/qywxCustomerFile/saveCustomerBussiNeed')">
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
	function ajaxCarSeriy(val){
		$("#carModelDiv").remove();
		$("#carSeriyDiv").remove();
		$.post("${ctx}/qywxCustomer/ajaxCarSeriy?brandId="+val+"&dateTime="+new Date(),{},function (data){
			if(data!="error"){
				$("#frmId").append(data);
			}
		});
	}

	function ajaxCarModel(sel){
		var options=$("#"+sel+" option:selected");
		var value=options[0].value;
		$("#carModelDiv").remove();
		if(value==''||value<=0){
			return;
		}
		$.post("${ctx}/qywxCustomer/ajaxCarModelBySeriyStatus?carSeriyId="+value+"&dateTime="+new Date(),{},function (data){
			if(data!="error"){
				$("#frmId").append(data);
			}
		});
	}
</script>
</html>