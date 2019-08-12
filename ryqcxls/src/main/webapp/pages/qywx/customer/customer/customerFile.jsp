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
<title>完善客户信息-证件信息</title>
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
    <span id="page_title">证件信息</span>
</div>
<div style="margin: 0 auto;width: 92%;margin-top: 20px;">
<form class="form-inline" action="" name="frmId" id="frmId" method="post" >
	<input type="hidden" value="${customer.dbid }" id="customerId" name="customerId">
	<div class="form-group">
	  <label class="control-label" for="name">单位信息</label>
	  <input type="text" class="form-control" name="customer.companyName1" id="companyName1"  value="${customer.companyName1 }"  >
	</div>
	<div class="form-group" >
	  <label class="control-label" for="inputWarning1">家庭情况</label  >
	  <input type="text" class="form-control" name="customer.family" id="family"  value="${customer.family }">
	</div>
	<div class="form-group" >
	  <label class="control-label" for="inputWarning1">QQ/MSN</label  >
	  <input type="text" class="form-control" name="customer.qq" id="qq"  value="${customer.qq }">
	</div>
	<div class="form-group" >
	  <label class="control-label" for="inputWarning1">EMAIL</label  >
	  <input type="text" class="form-control" name="customer.email" id="email"  value="${customer.email}">
	</div>
	<div class="form-group" >
	  <label class="control-label" for="inputWarning1">邮编</label  >
	  <input type="text" class="form-control" name="customer.zipCode" id="zipCode"  value="${customer.zipCode }">
	</div>
	<div class="form-group" >
	  <label class="control-label" for="inputWarning1">行业</label  >
	  	<select id="industryId" name="industryId" class="form-control">
			<option value="">请选择...</option>
			<c:forEach var="industry" items="${industries }">
				<option value="${industry.dbid }" ${customer.industry.dbid==industry.dbid?'selected="selected"':'' } >${industry.name }</option>
			</c:forEach>
		</select>
	</div>
	<div class="form-group" >
	  <label class="control-label" for="inputWarning1">职业</label  >
	 <select id="professionId" name="professionId" class="form-control">
		<option value="">请选择...</option>
		<c:forEach var="profession" items="${professions }">
			<option value="${profession.dbid }" ${customer.profession.dbid==profession.dbid?'selected="selected"':'' } >${profession.name }</option>
		</c:forEach>
	</select>
	</div>
	<div class="form-group" >
	  <label class="control-label" for="inputWarning1">学历</label  >
	  <select id="educationalId" name="educationalId" class="form-control">
			<option value="">请选择...</option>
			<c:forEach var="educational" items="${educationals }">
				<option value="${educational.dbid }" ${customer.educational.dbid==educational.dbid?'selected="selected"':'' } >${educational.name }</option>
			</c:forEach>
		</select>
	</div>
	<div class="form-group" >
	  <label class="control-label" for="inputWarning1">备注</label  >
	  <input type="text" class="form-control" name="customer.note" id="note"  value="${customer.note }">
	</div>
</form>
</div>
<div class="buttomBar">
    <input type="button" name="mobileCommit" value="保存" id="tele_register" class="addbutton" onclick="submitFrm('frmId','${ctx}/qywxCustomerFile/saveCustomerFile')">
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
	function ajaxArea(sel){
		var value=$(sel).val();
		$("#areaId").val(value);
		var sle= $(sel).nextAll();
		$(sle).remove();
		$.post("${ctx}/area/ajaxArea?parentId="+value+"&dateTime="+new Date(),{},function (data){
			if(data!="error"){
				var data=data.replace(/midea text/g,'form-control');
				$("#areaLabel").append(data);
			}
		});
	}
</script>
</html>