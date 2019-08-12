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
<title>客户流失-申请</title>
</head>
<body class="bodycolor">
<div class="views content_title">
	 <a id="back" href="javascript:history.back()">
        <img src="${ctx }/images/jm/NavButtonBack.png" class="return">
    </a>
     <span id="page_title">客户流失-申请</span>
</div>
<br>
<div class="alert alert-error">
	<strong>提示：</strong>流失客户经领导审批同意后系统自动把客户级别更改为L级
</div>
<div style="margin: 0 auto;width: 92%;margin-top: 20px;">
	<form action="" name="frmId" id="frmId" style="margin-bottom: 40px;" target="_self">
		<input type="hidden" name="customerId" value="${customer.dbid }" id="customerId"></input>
		<input type="hidden" name="type" value="${param.type }" id="type"></input>
		<input type="hidden" name="customerLastBussi.dbid" id="dbid" value="${customerLastBussi.dbid }">
		<input type="hidden" name="lastResult" id="lastResult" value="2">
		<s:token></s:token>
		<div id="customerFlowReasonTr">
				<div class="form-group">
	 				<label class="control-label" for="name">流失原因:&nbsp;<span style="color: red">*</span></label>
					<select id="customerFlowReasonId" name="customerFlowReasonId" class="form-control"  >
						<option value="0">请选择...</option>
						<c:forEach var="customerFlowReason" items="${customerFlowReasons }">
							<option value="${customerFlowReason.dbid }" >${customerFlowReason.name }</option>
						</c:forEach>
					</select>
					
				</div>
		</div>
		<div class="form-group">
					<label class="control-label" for="name">备注:&nbsp;<span style="color: red">*</span></label>
				<textarea  name="customerLastBussi.note" id="note"	 class="form-control"  title="" checkType="string,2" tip="请填写一点备注吧">${customerLastBussi.note }</textarea>	
		</div>
	</form>
	<div class="formButton">
		<input id="approvalButton"  type="button" name="mobileCommit" value="提交经理审核" id="tele_register" class="addbutton" onclick="submitFrm('frmId','${ctx}/qywxCustomerLastBussi/save')">
	</div>

</div>
</body>
<script src="${ctx }/widgets/bootstrap3/jquery.min.js"></script>
<script src="${ctx }/widgets/bootstrap3/js/bootstrap.min.js"></script>
<script src="${ctx }/widgets/utile/wechat.js"></script>
<script type="text/javascript">
function submitFrm(frmId,url){
	try {
		if(validate1(frmId)){
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

	function validate1(){
		var note=$("#note").val();
		var customerFlowReasonId=$("#customerFlowReasonId option:selected")[0].value;
		if(null==customerFlowReasonId||customerFlowReasonId==""||customerFlowReasonId=="0"){
			alert("请选择流失原因");;
			$("#customerFlowReasonId").focus();
			return false;
		}
		if(null==note||note==''){
			alert("请填写客户流失备注信息");
			$("#note").focus();
			return false;
		}else{
			if(note.length<2){
				alert("客户流失备注信息必须大于2个字符");
				$("#note").focus();
				return false;
			}
			if(note.length>200){
				alert("客户流失备注信息小于200个字符");
				$("#note").focus();
				return false;
			}
		}
		
		return true;
	}
</script>
</html>