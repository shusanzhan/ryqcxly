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
<title>
<c:if test="${empty(customerRecord) }">
	添加
</c:if>
<c:if test="${!empty(customerRecord) }">
	编辑
</c:if>
线索</title>
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
    <span id="page_title">
    	<c:if test="${empty(customerRecord) }">
			添加
		</c:if>
		<c:if test="${!empty(customerRecord) }">
			编辑
		</c:if>
    线索</span>
    <a class="go_home" href="${ctx }/qywxCustomer/index">
    	<img src="${ctx }/images/jm/go_home.png" alt="">
    </a>
</div>
<div style="margin: 0 auto;width: 92%;margin-top: 20px;">
<form class="form-inline" action="" name="frmId" id="frmId" method="post" >
	<s:token></s:token>
   	<input type="hidden" name="red" id="red" value="1">
   	<input type="hidden" name="customerRecord.dbid" id="customerRecordDbid" value="${customerRecord.dbid }">
	<div class="form-group">
	  <label class="control-label" for="name">姓名</label>
	  <input type="text" class="form-control" id="name" name="customerRecord.name" value="${customerRecord.name }" checkType="string,2,10">
	</div>
	<div class="form-group" >
	  <label class="control-label" for="inputWarning1">称呼</label  >
	  	<select class="form-control" id="sex" name="customerRecord.sex" checkType="string,1" error="请选称呼">
	  		<option value="-1">请选择...</option>
	  		<option value="男" ${customerRecord.sex=='男'?'selected="selected"':''} >先生</option>
	  		<option value="女" ${customerRecord.sex=='女'?'selected="selected"':''}>女士</option>
		</select>
	</div>
	<div class="form-group" >
	  <label class="control-label" for="inputWarning1">电话</label  >
	  <input type="number" class="form-control" id="mobilePhone" name="customerRecord.mobilePhone" value="${customerRecord.mobilePhone }" checkType="mobilePhone" >
	</div>
	<div class="form-group" >
	  <label class="control-label" for="inputWarning1">线索类型</label  >
		 <select id="type" name="customerTypeId" class="form-control" checkType="integer,1" tip="请选择线索类型">
			<option value="-1">请选择...</option>
			<c:forEach var="customerType" items="${customerTypes }">
				<option value="${customerType.dbid }" ${customerRecord.customerType.dbid==customerType.dbid?'selected="selected"':'' } >${customerType.name }</option>
			</c:forEach>
		</select>
	</div>
	<div class="form-group" >
	  <label class="control-label" for="inputWarning1">信息来源</label  >
	  <select id="customerInfromId" name="customerInfromId" class="form-control" checkType="integer,1" tip="请选择信息来源">
			<option value="">请选择...</option>
				${customerInfromSelect }
		</select>
	</div>
	<div class="form-group" >
	  <label class="control-label" for="inputWarning1">登记时间</label  >
	  <c:if test="${empty(customerRecord) }">
			<input type="text" name="customerRecord.comeInTime" id="comeInTime" value='<fmt:formatDate value="${now }" pattern="HH:mm"/>' class="form-control" 	onfocus="WdatePicker({readOnly:true,dateFmt:'HH:mm'});" checkType="string,1" tip="请选择下次预约时间">
		</c:if>
		<c:if test="${!empty(customerRecord) }">
			<input type="text" name="customerRecord.comeInTime" id="comeInTime" value="${customerRecord.comeInTime }" class="form-control" 	onfocus="WdatePicker({readOnly:true,dateFmt:'HH:mm'});" checkType="string,1" tip="请选择下次预约时间">
		</c:if>
	</div>
	<div class="form-group" >
	  <label class="control-label" for="inputWarning1">进店次数</label  >
	  	<select id="comeinNum" name="customerRecord.comeinNum" class="form-control" checkType="integer,0" tip="请选择进店次数">
			<option value="">请选择...</option>
			<option value="0" selected="selected" >未到店</option>
			<option value="1" ${customerRecord.comeinNum==1?'selected="selected"':'' } >初次到店</option>
			<option value="2" ${customerRecord.comeinNum==2?'selected="selected"':'' }>2次到店</option>
		</select>
	</div>
		<!-- 多品牌 -->
	<c:if test="${enterprise.bussiType==3 }">
		<div class="form-group" >
		  <label class="control-label" for="inputWarning1">具体车型</label  >
		  <input type="text" class="form-control" id="carModelStr" onfocus="ajaxCarModel2('carModelStr')" name="customerRecord.carModelStr" value="${customerRecord.carModelStr }" checkType="string,1" >
		</div>
	</c:if>
	<c:if test="${empty(customerRecord) }">
		<div class="form-group" >
		  	<label class="control-label" for="inputWarning1">品牌</label>
		  	<select class="form-control"  onchange="ajaxCarSeriy(this.value)" id="brandId" name="brandId" checkType="integer,1" error='请选择品牌'>
		  		<option value="">请选择...</option>
		  		<c:forEach var="brand" items="${brands }">	  	
		  			<option value="${brand.dbid }">${brand.name }</option>
		  		</c:forEach>
			</select>
		</div>
		<div class="form-group" id="carSeriyDiv">
		  	<label class="control-label" for="inputWarning1">车系</label>
		  	<select class="form-control"  onchange="ajaxCarModel('carSeriyId')" id="carSeriyId" name="carSeriyId" checkType="integer,1" error='请选择车系'>
		  		<option value="">请选择...</option>
		  		<c:forEach var="carSeriy" items="${carSeriys }">	  	
		  			<option value="${carSeriy.dbid }" ${carSeriy.dbid==customerRecord.carSeriy.dbid?'selected="selected"':'' } >${carSeriy.name }</option>
		  		</c:forEach>
			</select>
		</div>
		<div class="form-group" id="carModelDiv">
		  	<label class="control-label" for="inputWarning1">车型</label>
		  	<select class="form-control"  id="carModelId" name="carModelId" checkType="integer,1" error='请选择车型'>
		  		<option value="">请选择...</option>
		  		<c:forEach var="carModel" items="${carModels }">	  	
		  			<option value="${carModel.dbid }" ${carModel.dbid==customerRecord.carModel.dbid?'selected="selected"':'' } >${carModel.name }</option>
		  		</c:forEach>
			</select>
		</div>
	</c:if>
	<c:if test="${!empty(customerRecord) }">
		<div class="form-group" >
		  	<label class="control-label" for="inputWarning1">品牌</label>
		  	<select class="form-control"  onchange="ajaxCarSeriy(this.value)" id="brandId" name="brandId" checkType="integer,1" error='请选择品牌'>
		  		<option value="">请选择...</option>
		  		<c:forEach var="brand" items="${brands }">	  	
		  			<option value="${brand.dbid }" ${brand.dbid==customerRecord.brand.dbid?'selected="selected"':'' } >${brand.name }</option>
		  		</c:forEach>
			</select>
		</div>
		<div class="form-group" id="carSeriyDiv">
		  	<label class="control-label" for="inputWarning1">车系</label>
		  	<select class="form-control"  onchange="ajaxCarModel('carSeriyId')" id="carSeriyId" name="carSeriyId" checkType="integer,1" error='请选择车系'>
		  		<option value="">请选择...</option>
		  		<c:forEach var="carSeriy" items="${carSeriys }">	  	
		  			<option value="${carSeriy.dbid }" ${carSeriy.dbid==customerRecord.carSeriy.dbid?'selected="selected"':'' } >${carSeriy.name }</option>
		  		</c:forEach>
			</select>
		</div>
		<div class="form-group" id="carModelDiv">
		  	<label class="control-label" for="inputWarning1">车型</label>
		  	<select class="form-control"  id="carModelId" name="carModelId" checkType="integer,1" error='请选择车型'>
		  		<option value="">请选择...</option>
		  		<c:forEach var="carModel" items="${carModels }">	  	
		  			<option value="${carModel.dbid }" ${carModel.dbid==customerRecord.carModel.dbid?'selected="selected"':'' } >${carModel.name }</option>
		  		</c:forEach>
			</select>
		</div>
	</c:if>
</form>
</div>
<div class="buttomBar">
    <input type="button" name="mobileCommit" value="保存" id="tele_register" class="addbutton" onclick="submitFrm('frmId','${ctx}/qywxCustomerRecord/saveSaler')">
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
		var op="<option>请选择车系...</option>";
		$("#carSeriyId").empty();
		$("#carModelId").empty();
		$("#carSeriyId").append(op);
		$("#carModelId").append(op);
		$.post("${ctx}/qywxCustomer/ajaxCarSeriy?brandId="+val+"&dateTime="+new Date()+"&type=2",{},function (data){
			if(data!="error"){
				$("#carSeriyId").empty();
				$("#carSeriyId").append(data);
			}
		});
	}
	function ajaxCarModel(sel){
		var options=$("#"+sel+" option:selected");
		var value=options[0].value;
		if(value==''||value<=0){
			return;
		}
		$.post("${ctx}/qywxCustomer/ajaxCarModelBySeriy?carSeriyId="+value+"&dateTime="+new Date()+"&type=2",{},function (data){
			if(data!="error"){
				$("#carModelId").empty();
				$("#carModelId").append(data);
			}
		});
	}
	function ajaxArea(sel){
		var value=$(sel).val();
		$("#areaId").val(value);
		var sle= $(sel).nextAll();
		$(sle).remove();
		$.post("${ctx}/area/ajaxArea?parentId="+value+"&dateTime="+new Date(),{},function (data){
			if(data!="error"){
				var data=data.replace(/midea text/g,'weui_select');
				$("#areaLabel").append(data);
			}
		});
	}
</script>
</html>