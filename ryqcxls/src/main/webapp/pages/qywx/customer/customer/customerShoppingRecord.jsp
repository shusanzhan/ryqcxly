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
<script type="text/javascript" src="${ctx }/widgets/My97DatePicker/WdatePicker.js"></script>
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
	<s:token></s:token>
	<c:set value="${customer.customerShoppingRecord }" var="customerShoppingRecord"></c:set>
	<input type="hidden" id="customerShoppingRecordId" name="customerShoppingRecord.dbid" value="${customerShoppingRecord.dbid }">
	<input type="hidden" id="customerId" name="customer.dbid" value="${customer.dbid }">
	<div class="form-group">
	  <label class="control-label" for="name">进店时间</label>
		<input type="text" name="customerShoppingRecord.comeInTime" id="comeInTime" value="${customerRecord.comeInTime }" class="form-control" 	onfocus="WdatePicker({readOnly:true,dateFmt:'HH:mm'});" >
	</div>
	<div class="form-group" >
	  <label class="control-label" for="inputWarning1">离店时间</label  >
	  <input type="text" name="customerShoppingRecord.farwayTime" id="farwayTime" value="${customerRecord.comeInTime }" class="form-control" 	onfocus="WdatePicker({readOnly:true,dateFmt:'HH:mm'});"  >
	</div>
	<div class="form-group" >
	  <label class="control-label" for="inputWarning1">停留时间</label  >
	  <select class="form-control" id="waitingTime" name="customerShoppingRecord.waitingTime" class="largeX text">
			<option value="">请选择...</option>
			<option value="1" ${customerShoppingRecord.waitingTime==1?'selected="selected"':'' } >约10分钟</option>
			<option value="2" ${customerShoppingRecord.waitingTime==2?'selected="selected"':'' }>约20分钟</option>
			<option value="3" ${customerShoppingRecord.waitingTime==3?'selected="selected"':'' }>约30分钟</option>
			<option value="4" ${customerShoppingRecord.waitingTime==4?'selected="selected"':'' }>约1小时</option>
			<option value="5" ${customerShoppingRecord.waitingTime==5?'selected="selected"':'' }>约2小时</option>
			<option value="6" ${customerShoppingRecord.waitingTime==6?'selected="selected"':'' }>约3小时</option>
			<option value="7" ${customerShoppingRecord.waitingTime==7?'selected="selected"':'' }>约5小时</option>
			<option value="8" ${customerShoppingRecord.waitingTime==8?'selected="selected"':'' }>约8小时</option>
		</select>

	</div>
	<div class="form-group" >
	  <label class="control-label" for="inputWarning1">客户随性人数</label  >
	  <select class="form-control" id="customerNum" name="customerShoppingRecord.customerNum" class="largeX text">
			<option value="">请选择...</option>
			<option value="1" ${customerShoppingRecord.customerNum==1?'selected="selected"':'' } >1人</option>
			<option value="2" ${customerShoppingRecord.customerNum==2?'selected="selected"':'' }>2人</option>
			<option value="3" ${customerShoppingRecord.customerNum==3?'selected="selected"':'' }>3人</option>
			<option value="4" ${customerShoppingRecord.customerNum==4?'selected="selected"':'' }>4人</option>
			<option value="5" ${customerShoppingRecord.customerNum==5?'selected="selected"':'' }>5人</option>
			<option value="6" ${customerShoppingRecord.customerNum==6?'selected="selected"':'' }>6人</option>
			<option value="7" ${customerShoppingRecord.customerNum==7?'selected="selected"':'' }>7人</option>
			<option value="8" ${customerShoppingRecord.customerNum==8?'selected="selected"':'' }>8人</option>
			<option value="9" ${customerShoppingRecord.customerNum==9?'selected="selected"':'' }>9人</option>
			<option value="10" ${customerShoppingRecord.customerNum==10?'selected="selected"':'' }>10人以上</option>
		</select>
	</div>
	<div class="form-group" >
	  <label><input  type="checkbox"  id="isTryDriver" name="customerShoppingRecord.isTryDriver" ${customerShoppingRecord.isTryDriver==1?'checked="checked"':'' }   value="true"> 是否试驾</label>
		<label><input  type="checkbox"  id="isFirst" name="customerShoppingRecord.isFirst"  ${customerShoppingRecord.isFirst==true?'checked="checked"':'' }  value="true"> 是否首次来店</label>
		<label ><input  type="checkbox" id="isGetCar" name="customerShoppingRecord.isGetCar"  ${customerShoppingRecord.isGetCar==true?'checked="checked"':'' } value="true"> 客户是否有车</label>
	</div>
	<div class="form-group" >
	  <label class="control-label" for="inputWarning1">试驾专员</label  >
	  <input class="form-control" name="customerShoppingRecord.tryDriver"   id="tryDriver"  value="${customerShoppingRecord.tryDriver }" ></input>
	</div>
	<div class="form-group" >
	  <label class="control-label" for="inputWarning1">客户车型</label  >
	  <input  type="text" class="form-control" id="carModel" name="customerShoppingRecord.carModel"   value="${customerShoppingRecord.carModel }">
	</div>
	<div class="form-group" >
	  <label class="control-label" for="inputWarning1">接待经过</label  >
	  <input  type="text" class="form-control" name="customerShoppingRecord.receptionExperience" id="receptionExperience"  value="${customerShoppingRecord.receptionExperience }">
	</div>
</form>
</div>
<div class="buttomBar">
    <input type="button" name="mobileCommit" value="保存" id="tele_register" class="addbutton" onclick="submitFrm('frmId','${ctx}/qywxCustomerFile/saveCustomerShoppingRecord')">
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