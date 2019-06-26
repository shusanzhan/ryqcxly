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
<title>快捷创建客户</title>
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
    <span id="page_title">添加客户资料</span>
    <a class="go_home" href="${ctx }/qywxCustomer/index">
    	<img src="${ctx }/images/jm/go_home.png" alt="">
    </a>
</div>
<div style="margin: 0 auto;width: 92%;margin-top: 20px;">
<form class="form-inline" action="" name="frmId" id="frmId" method="post" >
	<input type="hidden" id="customerShoppingRecordId" name="customerShoppingRecord.dbid" value="">
	<input type="hidden" id="customerBussiId" name="customerBussi.dbid" value="">
	<input type="hidden" id="customerId" name="customer.dbid" value="">
	<input type="hidden" id="type" name="type" value="1">
	<input type="hidden" name="customerRecordId" id="customerRecordId" value="${customerRecord.dbid }">
	<div class="form-group">
	  <label class="control-label" for="name">姓名</label>
	  <input type="text" class="form-control" id="name" name="customer.name" value="${customerRecord.name }" checkType="string,2,5">
	</div>
	<div class="form-group" >
	  <label class="control-label" for="inputWarning1">电话</label  >
	  <c:if test="${empty(customerRecord.mobilePhone) }">
		  <input type="text" class="form-control" id="mobilePhone" name="customer.mobilePhone" checkType="mobilePhone" value="${param.mobilePhone }">
	  </c:if>
	  <c:if test="${!empty(customerRecord.mobilePhone) }">
		  <input type="text" class="form-control" id="mobilePhone" name="customer.mobilePhone" checkType="mobilePhone" value="${customerRecord.mobilePhone }">
	  </c:if>
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
	  <label class="control-label" for="inputWarning1">交叉客户</label  >
	  	<select class="form-control" id="cityCrossCustomerId" name="cityCrossCustomerId" checkType="integer,1" error="请选择交叉客户">
	  		<option value="">请选择...</option>
			<c:forEach var="cityCrossCustomer" items="${cityCrossCustomers }">
				  <option value="${cityCrossCustomer.dbid }">${cityCrossCustomer.name }</option>
			</c:forEach>
		</select>
	</div>
	<div class="form-group" >
	  <label class="control-label" for="inputWarning1">意向级别</label  >
	  	<select class="form-control" id="customerPhaseId" name="customerPhaseId" checkType="integer,1" error="请选择意向级别">
	  		<option value="">请选择...</option>
			<c:forEach var="customerPhase" items="${customerPhases }">
					<c:if test="${customerPhase.name!='O' }">
					<option value="${customerPhase.dbid }" >${customerPhase.name }</option>
				</c:if>
			</c:forEach>
		</select>
	</div>
	<div class="form-group" >
	  <label class="control-label" for="inputWarning1">是否试驾</label  >
	  	<select class="form-control" id="isTryDriver" name="customerShoppingRecord.isTryDriver" checkType="integer,1" error="是否试驾">
	  		<option value="-1">请选择...</option>
	  		<option value="1" ${customerShoppingRecord.isTryDriver=='1'?'selected="selected"':''} >已试驾</option>
	  		<option value="2" ${customerShoppingRecord.isTryDriver=='2'?'selected="selected"':''}>未试驾</option>
		</select>
	</div>
	<div class="form-group" >
	  <label class="control-label" for="inputWarning1">试驾专员</label  >
		  <input type="text" class="form-control" id="tryDriver" name="customerShoppingRecord.tryDriver"  value="${customerShoppingRecord.tryDriver }">
	</div>
	<c:if test="${enterprise.bussiType==3 }">
		<div class="form-group" >
		  <label class="control-label" for="inputWarning1">具体车型</label  >
		  <input type="text" class="form-control" id="carModelStr" onfocus="ajaxCarModel2('carModelStr')" name="customer.carModelStr" value="${customerRecord.carModelStr }" checkType="string,1" >
		</div>
		<div class="form-group" >
		  <label class="control-label" for="inputWarning1">指导价</label  >
		  <input type="text" class="form-control" id="navPrice"  name="customer.navPrice" value="${customer.navPrice }" checkType="float" >
		</div>
	</c:if>
	<div class="form-group" >
	  <label class="control-label" for="inputWarning1">信息来源</label  >
	  <select id="customerInfromId" name="customerInfromId" class="form-control" checkType="integer,1" tip="请选择信息来源">
			<option value="">请选择...</option>
				${customerInfromSelect }
		</select>
	</div>
	<c:if test="${empty(customerRecord)||empty(customerRecord.brand) }">
		<div class="form-group" >
	  	<label class="control-label" for="inputWarning1">品牌</label>
	  	<select class="form-control"  onchange="ajaxCarSeriy(this.value)" id="brandId" name="brandId" checkType="integer,1" error='请选择品牌'>
	  		<option value="">请选择...</option>
	  		<c:forEach var="brand" items="${brands }">	  	
	  			<option value="${brand.dbid }">${brand.name }</option>
	  		</c:forEach>
		</select>
	</div>
	</c:if>
	<c:if test="${!empty(customerRecord)&&!empty(customerRecord.brand) }">
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
    <input type="button" name="mobileCommit" value="创建并返回线索列表" id="tele_register" class="addbutton" onclick="$('#type').val(1);submitFrm('frmId','${ctx}/qywxCustomer/save')" >
    <input type="button" name="mobileCommit" value="创建并返回客户列表" id="tele_register" class="addbutton" onclick="$('#type').val(2);submitFrm('frmId','${ctx}/qywxCustomer/save')">
    <div style="clear: both;"></div>
</div>	
	<c:if test="${empty(customerRecord.brand) }">
		<c:if test="${!empty(customerRecord.carModels)}">
			<div class="alert alert-error">
				<strong>提示:</strong>
				<p>网络线索备注车型,<span style="color: red;">${customerRecord.carModels }</span></p>
				<p>购车城市,<span style="color: red;">${customerRecord.address }</span>
			</div>
		</c:if>
	</c:if>

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
		$.post("${ctx}/qywxCustomer/ajaxCarModelBySeriy?carSeriyId="+value+"&dateTime="+new Date(),{},function (data){
			if(data!="error"){
				$("#frmId").append(data);
			}
		});
	}
</script>
</html>