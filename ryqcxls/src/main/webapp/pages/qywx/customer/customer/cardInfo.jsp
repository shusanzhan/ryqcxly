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
	<input type="hidden" value="${param.type }" id="type" name="type">
	<div class="form-group">
	  <label class="control-label" for="name">姓名</label>
	  <input type="text" class="form-control" name="customerName" id="name"  value="${customer.name }" checkType="string,1,20" placeholder="请输入客户姓名" >
	</div>
	<div class="form-group" >
	  <label class="control-label" for="inputWarning1">电话</label  >
	  <input type="text" class="form-control" name="mobilePhone" id="mobilePhone"  value="${customer.mobilePhone }" checkType="mobilePhone">
	</div>
	<div class="form-group" >
	  <label class="control-label" for="inputWarning1">证件信息</label  >
	  	<c:if test="${customer.orderContract.status>=1}" var="status">
				<input type="hidden" id="paperworkId" name="paperworkId" value="${customer.paperwork.dbid }">						
				<input type="text" class="form-control" class="largeX text" id="" name="" value="${customer.paperwork.name }" readonly="readonly">		
		</c:if>
		<c:if test="${status==false }">
		  	<select class="form-control" id="paperworkId" name="paperworkId" class="midea text" checkType="integer,1">
				<option value="">请选择...</option>
				<c:forEach var="paperwork" items="${paperworks }">
					<option value="${paperwork.dbid }" ${customer.paperwork.dbid==paperwork.dbid?'selected="selected"':'' } >${paperwork.name }</option>
				</c:forEach>
			</select>
		</c:if>			
	</div>
	<div class="form-group" >
	  <label class="control-label" for="inputWarning1">证件号码</label  >
	 	 <c:if test="${customer.orderContract.status>=1}" var="status">
			<input type="text" class="form-control"   readonly="readonly" class="midea text" name="icard" id="icard"  value="${customer.icard }" />	
		</c:if>
		<c:if test="${status==false }">
				<input type="text" class="form-control"  class="mideaX text" name="icard" id="icard"  value="${customer.icard }" checkType="string,6"  />	
		</c:if>
	</div>
	<div class="form-group" id="areaLabel">
	  <label class="control-label" for="inputWarning1">地域</label  >
	 	 <c:if test="${customer.orderContract.status>=1}" var="status">
			<input type="hidden" name="areaId" value="${customer.area.dbid }" id="areaId">
			<input type="text" class="form-control" class="midea text" readonly="readonly" value="${customer.area.fullName }" >
		</c:if>
		<c:if test="${status==false }">
			<input type="hidden" name="areaId" value="${customer.area.dbid }" id="areaId">
			<c:if test="${empty(areaSelect) }">
				<select class="form-control" id="areoD" name="areoD" class="midea text" onchange="ajaxArea(this)">
					<option>请选择...</option>
					<c:forEach items="${areas }" var="area">
						<option  value="${area.dbid }">${area.name }</option>
					</c:forEach>
				</select>
			</c:if>
			<c:if test="${!empty(areaSelect) }">
				${fn:replace(areaSelect,"midea text","form-control")  }
			</c:if>
		</c:if>
	</div>
	<div class="form-group" >
	  <label class="control-label" for="inputWarning1">地址</label  >
	 	 <c:if test="${customer.orderContract.status>=1}" var="status">
			<input readonly="readonly" class="form-control"   name="address" class="midea text" id=address title="" value="${customer.address }" placeholder="请填写街道地址"></input>	
		</c:if>
		<c:if test="${status==false }">
			<input class="form-control" name="address"  class="largeX text" id=address title="" value="${customer.address }" placeholder="请填写街道地址" checkType="string,1" tip="请填写街道地址"></input>
		</c:if>
	</div>
</form>
</div>
<div class="buttomBar">
    <input type="button" name="mobileCommit" value="保存" id="tele_register" class="addbutton" onclick="submitFrm('frmId','${ctx}/qywxCustomerFile/saveCardInfo')">
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