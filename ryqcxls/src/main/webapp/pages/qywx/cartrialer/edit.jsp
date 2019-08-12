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
<title>维护挂车信息</title>
</head>
	<form action="" name="frmId" id="frmId" style="margin-bottom: 40px;" target="_parent">
		<input type="hidden" name="custCartrialer.dbid" id="dbid" value="${custCartrialer.dbid }">
		<input type="hidden" name="customerId" id="customerId" value="${param.customerId }">
		<input type="hidden" name="editType" id="editType" value="${param.editType }">
		<div style="margin: 0 auto;width: 92%;margin-top: 20px;">
			<div class="form-group">
				<label class="control-label" for="name">品牌:&nbsp;<span style="color: red">*</span></label>
				<select id="brandId" name="brandId" class="form-control" onchange="ajaxCarSeriy(this.value)" checkType="integer,1" tip="请选择品牌">
					<option value="">请选择...</option>
					<c:forEach var="brand" items="${brands }">
						<option value="${brand.dbid }" ${custCartrialer.brand.dbid==brand.dbid?'selected="selected"':'' } >${brand.name }</option>
					</c:forEach>
				</select>
			</div>
			<div class="form-group">
					<label class="control-label" for="name">车系:&nbsp;<span style="color: red">*</span></label>
				<select id="carSeriyId" name="carSeriyId" class="form-control" onchange="ajaxCarModel('carSeriyId')" checkType="integer,1" tip="请选择意向车型！">
					<option value="">请选择...</option>
					<c:forEach var="carSeriy" items="${carSeriys }">
						<option value="${carSeriy.dbid }" ${custCartrialer.carSeriy.dbid==carSeriy.dbid?'selected="selected"':'' } >${carSeriy.name }</option>
					</c:forEach>
				</select>
			</div>
			<div class="form-group">
					<label class="control-label" for="name">车型:&nbsp;<span style="color: red">*</span></label>
				<select id="carModelId" name="carModelId" class="form-control" checkType="integer,1" tip="请选择意向车型！">
					<option value="">请选择...</option>
					<c:forEach var="carModel" items="${carModels }">
						<option value="${carModel.dbid }" ${custCartrialer.carModel.dbid==carModel.dbid?'selected="selected"':'' } >${carModel.name }&nbsp;&nbsp;价格：${carModel.navPrice }</option>
					</c:forEach>
				</select>
			</div>
			<div class="form-group">
 				<label class="control-label" for="name">购车颜色:&nbsp;<span style="color: red">*</span></label>
				<select id="carColor" name="carColor" class="form-control"  checkType="integer,1">
					<option value="0">请选择...</option>
					<c:forEach var="carColor" items="${carColors }">
						<option value="${carColor.dbid }"  ${custCartrialer.carColor.dbid==carColor.dbid?'selected="selected"':'' }>${carColor.name }</option>
					</c:forEach>
				</select>
			</div>
			<div class="form-group">
					<label class="control-label" for="name">备注：</label>
					<textarea  class="form-control" style="height: 50px;"  name="custCartrialer.note"  id="note" placeholder="">${custCartrialer.note }</textarea>
			</div>
			<div class="formButton"  onclick="submitFrm('frmId','${ctx}/qywxCustCartrialer/save')">
			   		<input type="button" name="mobileCommit" value="保存" id="tele_register" class="addbutton">
			   		<br>
			</div>
		</div>
</form>
</body>
<script src="${ctx }/widgets/bootstrap3/jquery.min.js"></script>
<script src="${ctx }/widgets/easyvalidator/js/easy_validator.pack3.js?n=${now}"></script>
<script src="${ctx }/widgets/bootstrap3/js/bootstrap.min.js"></script>
<script src="${ctx }/widgets/utile/wechat.js"></script>
<script type="text/javascript">
function ajaxCarSeriy(val){
	if(null==val||val==''){
		alert("请选择品牌");
		return false;
	}
	$("#carSeriyId").empty();
	$("#carSeriyId").append('<option value="-1">请选择...</option>');
	$("#carModelId").empty();
	$("#carModelId").append('<option value="-1">请选择...</option>');
	$("#carColor").empty();
	$("#carColor").append('<option value="-1">请选择...</option>');
	$.post("${ctx}/qywxCustomer/ajaxCarSeriyOrder?brandId="+val+"&dateTime="+new Date(),{},function (data){
		if(data!="error"){
			$("#carSeriyId").append(data);
		}
	});
}
function ajaxCarModel(sel){
	var options=$("#"+sel+" option:selected");
	var value=options[0].value;
	$("#carModelId").empty();
	$("#carModelId").append('<option value="-1">请选择...</option>');
	$("#carColor").empty();
	$("#carColor").append('<option value="-1">请选择...</option>');
	if(value==''||value<=0){
		return;
	}
	$.post("${ctx}/qywxCustomer/ajaxCarModelBySeriyOrder?carSeriyId="+value+"&dateTime="+new Date(),{},function (data){
		if(data!="error"){
			$("#carModelId").append(data);
		}
	});
	$.post("${ctx}/qywxCustomer/ajaxCarColorStatus?carSeriyId="+value+"&dateTime="+new Date(),{},function (data){
		if(data!="error"){
			$("#carColor").append(data);
		}
	});
}
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