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
<style type="text/css">
	.form-controlSe{
		margin-top: 5px;
	}
	.form-group{
		margin-bottom: 10px;
	}
	select{
		margin-bottom: 5px;
		display: block;
	    width: 100%;
	    height: 34px;
	    padding: 6px 12px;
	    font-size: 14px;
	    line-height: 1.42857143;
	    color: #555;
	    background-color: #fff;
	    background-image: none;
	    border: 1px solid #ccc;
	    border-radius: 4px;
	    -webkit-box-shadow: inset 0 1px 1px rgba(0,0,0,0.075);
	    box-shadow: inset 0 1px 1px rgba(0,0,0,0.075);
	    -webkit-transition: border-color ease-in-out .15s, box-shadow ease-in-out .15s;
	    -o-transition: border-color ease-in-out .15s, box-shadow ease-in-out .15s;
	    transition: border-color ease-in-out .15s, box-shadow ease-in-out .15s;
	}
</style>
<title>成交结果</title>
</head>
<body class="bodycolor">
<div class="views content_title">
	 <a id="back" href="javascript:history.back()">
        <img src="${ctx }/images/jm/NavButtonBack.png" class="return">
    </a>
     <span id="page_title">成交结果</span>
</div>
<div class="alert alert-error">
	<strong>提示!</strong>成交客户系统将会把客户级别更改为O级，流失客户系统将会把客户级别更改为L级
</div>
<div style="margin: 0 auto;width: 92%;margin-top: 20px;">
	<form action="" name="frmId" id="frmId" style="margin-bottom: 40px;" target="_self">
		<c:if test="${not empty(customerLastBussi) }">
			<input type="hidden" name="customerId" value="${customerLastBussi.customer.dbid }" id="customerId"></input>
		</c:if>
		<c:if test="${empty(customerLastBussi) }">
			<input type="hidden" name="customerId" value="${param.customerId }" id="customerId"></input>
		</c:if>
		<input type="hidden" name="customerLastBussi.dbid" id="dbid" value="${customerLastBussi.dbid }">
		<s:token></s:token>
		<div class="form-group">
	 		<label class="control-label" for="name">结案情形:&nbsp;</label>&nbsp;<span style="color: red">*</span>
					<select id="lastResult" name="lastResult" class="form-control" onchange="showHiden()" checkType="integer,1">
						<option value="0">请选择...</option>
						<option value="1" ${customer.lastResult==1?'selected="selected"':'' }>成交——购车</option>
						<option value="2" ${customer.lastResult==2?'selected="selected"':'' }>流失——购买其它品牌产品等</option>
						<option value="3" ${customer.lastResult==3?'selected="selected"':'' }>购车计划取消 </option>
					</select>
		</div>
			<div id="contentTr" style="display: none;">
				<div class="form-group">
	 				<label class="control-label" for="name">购买车型:&nbsp;<span style="color: red">*</span></label>
	 					<div id="carModelLabel">
						<select id="brandId" name="brandId" class="form-control" onchange="ajaxCarSeriy(this.value)" checkType="integer,1" tip="请选择品牌">
							<option value="">请选择...</option>
							<c:forEach var="brand" items="${brands }">
								<option value="${brand.dbid }" ${customerBussi.brand.dbid==brand.dbid?'selected="selected"':'' } >${brand.name }</option>
							</c:forEach>
						</select>
						<select id="carSeriyId" name="carSeriyId" class="form-control" onchange="ajaxCarModel('carSeriyId')" checkType="integer,1" tip="请选择意向车型！">
							<option value="">请选择...</option>
							<c:forEach var="carSeriy" items="${carSeriys }">
								<option value="${carSeriy.dbid }" ${customerBussi.carSeriy.dbid==carSeriy.dbid?'selected="selected"':'' } >${carSeriy.name }</option>
							</c:forEach>
						</select>
						<select id="carModelId" name="carModelId" class="form-control" checkType="integer,1" tip="请选择意向车型！">
							<option value="">请选择...</option>
							<c:forEach var="carModel" items="${carModels }">
								<option value="${carModel.dbid }" ${customerBussi.carModel.dbid==carModel.dbid?'selected="selected"':'' } >${carModel.name }&nbsp;&nbsp;价格：${carModel.navPrice }</option>
							</c:forEach>
						</select>
						</div>
				</div>
				<div class="form-group">
	 				<label class="control-label" for="name">购车颜色:&nbsp;<span style="color: red">*</span></label>
	 					<div id="carColorLable">
							<select id="carColor" name="carColor" class="form-control"  checkType="integer,1">
								<option value="0">请选择...</option>
								<c:forEach var="carColor" items="${carColors }">
									<option value="${carColor.dbid }" >${carColor.name }</option>
								</c:forEach>
							</select>
	 					</div>
				</div>
				<div class="form-group">
						<label><input type="checkbox" id="isCarPlate" name="customerLastBussi.isCarPlate" value="true" ${customerLastBussi.isCarPlate==true?'checked="checked"':'' } >&nbsp;&nbsp;是否上牌</label>&nbsp;&nbsp;&nbsp;&nbsp;
						<label><input type="checkbox" id="isBuySafe" name="customerLastBussi.isBuySafe" ${customerLastBussi.isBuySafe==true?'checked="checked"':'' }  value="true">&nbsp;&nbsp;是否购买保险</label>&nbsp;&nbsp;&nbsp;&nbsp;
						<label><input type="checkbox" id="isBoutique" name="customerLastBussi.isBoutique" ${customerLastBussi.isBoutique==true?'checked="checked"':'' }  value="true">&nbsp;&nbsp;是否加装精品</label>
				</div>
			</div>
			<div class="form-group">
	 				<label class="control-label" for="name">备注:&nbsp;<span style="color: red">*</span></label>
					<textarea  name="customerLastBussi.note" id="note"	 class="form-control"  title="" checkType="string,2" tip="请填写一点备注吧">${customerLastBussi.note }</textarea>	
			</div>
	</form>
	<div class="formButton">
		<input id="saveButton"  type="button" name="mobileCommit" value="保存" id="tele_register" class="addbutton" onclick="if(validate1()){submitFrm('frmId','${ctx}/qywxCustomerLastBussi/save')}">
		<input id="approvalButton" style="display: none;"  type="button" name="mobileCommit" value="提交经理审核" id="tele_register" class="addbutton" onclick="iif(validate2()){submitFrm('frmId','${ctx}/qywxCustomerLastBussi/save')}">
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
$(document).ready(function(){
})
	function validate1(){
		var carseriyId=$("#carSeriyId").val();
		$("#carColor").attr("checkType","integer,1");
		if(null==carseriyId||carseriyId==""){
			alert("请选择意向车型！");
			$("#carSeriyId").focus();
			return false;
		}
		var carModelId=$("#carModelId").val();
		if(null==carModelId||carModelId==""){
			alert("请选择意向车型！");
			$("#carModelId").focus();
			return false;
		}
		return true;
	}
	function validate2(){
		var note=$("#note").val();
		$("#carColor").removeAttr("checkType");
		if(null==note||note==""){
			alert("请输入备注信息！");
			$("#note").focus();
			return false;
		}
		return true;
	}
	function showHiden(){
		var options=$("#lastResult option:selected");
		var value=options[0].value;
		if(value==1){
			$("#contentTr").show();
			$("#saveButton").show();
			$("#approvalButton").hide();
			
		}else{
			$("#contentTr").hide();
			$("#saveButton").hide();
			$("#carColor").val("    ")
			$("#approvalButton").show();
		}
	}
	
	function ajaxCarSeriy(val){
		if(null==val||val==''){
			alert("请选择品牌");
			return false;
		}
		$("#carModelId").remove();
		$("#carSeriyId").remove();
		$.post("${ctx}/carSeriy/ajaxCarSeriyByStatus?brandId="+val+"&dateTime="+new Date(),{},function (data){
			if(data!="error"){
				$("#carModelLabel").append(data);
			}
		});
	}
	function ajaxCarModel(sel){
		var options=$("#"+sel+" option:selected");
		var value=options[0].value;
		$("#carModelId").remove();
		$("#carColorLable").children().remove();
		if(value==''||value<=0){
			return;
		}
		$.post("${ctx}/carModel/ajaxCarModelBySeriyStatus?carSeriyId="+value+"&dateTime="+new Date(),{},function (data){
			if(data!="error"){
				$("#carModelLabel").append(data);
			}
		});
		$.post("${ctx}/carColor/ajaxCarColorStatus?carSeriyId="+value+"&dateTime="+new Date(),{},function (data){
			if(data!="error"){
				$("#carColorLable").append(data);
			}
		});
	}
</script>
</html>