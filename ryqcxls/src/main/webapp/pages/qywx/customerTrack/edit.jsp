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
<style type="text/css">
	.form-controlSe{
		margin-top: 5px;
	}
	.form-group{
		margin-bottom: 10px;
	}
</style>
<title>添加追踪记录</title>
</head>
<body class="bodycolor">
<div class="views content_title">
	 <a id="back" href="javascript:history.back()">
        <img src="${ctx }/images/jm/NavButtonBack.png" class="return">
    </a>
     <span id="page_title">添加追踪记录</span>
</div>
<div style="margin: 0 auto;width: 92%;margin-top: 20px;">
	<form class="form-inline" action="" name="frmId" id="frmId" method="post" >
		<c:if test="${not empty(customerTrack) }">
			<input type="hidden" name="customerId" value="${customerTrack.customer.dbid }" id="customerId"></input>
		</c:if>
		<c:if test="${empty(customerTrack) }">
			<input type="hidden" name="customerId" value="${param.customerId }" id="customerId"></input>
		</c:if>
		<input type="hidden" name="customerTrack.createTime" id="createTime" value="${customerTrack.createTime}">
		<input type="hidden" name="customerTrack.dbid" id="dbid" value="${customerTrack.dbid }">
		<input type="hidden" name="currentPage" id="currentPage" value="${param.currentPage}">
		<input type="hidden" name="pageSize" id="pageSize" value="${param.pageSize }">
		<input type="hidden" name="typeRedirect" id="typeRedirect" value="${param.typeRedirect }">
		<input type="hidden" name="redirect" id="redirect" value="${param.redirect }">
		<input type="hidden" name="customerRecordId" id="customerRecordId" value="${param.customerRecordId }">
		<input type="hidden" name="maxDay" id="maxDay" value="">
		<s:token></s:token>
		<input readonly="readonly"  type="hidden" class="form-control" name="customerTrack.trackDate" id="trackDate"	value='<fmt:formatDate value="${now }" pattern="yyyy-MM-dd HH:mm" />' class="large text" >
		<div class="form-group">
	 		<label class="control-label" for="name">跟进类型:&nbsp;<span style="color: red;">*</span></label>
	 		<c:if test="${empty(param.customerRecordId) }">
		 		<select id="trackType" name="customerTrack.trackType" class="form-control" checkType="integer,1" tip="请选择跟进类型" onchange="marketingAct(this.value);tryDriverOper()">
					<option value="">请选择...</option>
					<option value="1" ${customerTrack.trackType==1?'selected="selected"':'' }>日常关系维护</option>
					<option value="2" ${customerTrack.trackType==2?'selected="selected"':'' }>普通邀约到店</option>
					<option value="3" ${customerTrack.trackType==3?'selected="selected"':'' }>活动邀约到店 </option>
				</select>
	 		</c:if>
	 		<c:if test="${!empty(param.customerRecordId) }">
		 		<select id="trackType" name="customerTrack.trackType" class="form-control" checkType="integer,1" tip="请选择跟进类型" onchange="marketingAct(this.value);tryDriverOper()">
					<option value="">请选择...</option>
					<option value="1" ${customerTrack.trackType==1?'selected="selected"':'' }>日常关系维护</option>
					<option value="2" selected="selected">普通邀约到店</option>
					<option value="3" ${customerTrack.trackType==3?'selected="selected"':'' }>活动邀约到店 </option>
				</select>
	 		</c:if>
		</div>
		<div class="form-group">
	 		<label class="control-label" for="name">跟进方法:&nbsp;<span style="color: red;">*</span></label>
	 		<c:if test="${empty(param.customerRecordId) }">
				<select id="trackMethod" name="customerTrack.trackMethod" class="form-control" checkType="integer,1" tip="请选跟进方法" onchange="tryDriverOper()">
					<option value="0f">请选择...</option>
					<option value="1" ${customerTrack.trackMethod==1?'selected="selected"':'' }>电话</option>
					<option value="3" ${customerTrack.trackMethod==3?'selected="selected"':'' }>短信 </option>
					<option value="4" ${customerTrack.trackMethod==4?'selected="selected"':'' }>上户</option>
					<option value="5" ${customerTrack.trackMethod==5?'selected="selected"':'' }>微信</option>
					<option value="6" ${customerTrack.trackMethod==6?'selected="selected"':'' }>QQ</option>
				</select>
			</c:if>
	 		<c:if test="${!empty(param.customerRecordId) }">
				<select id="trackMethod" name="customerTrack.trackMethod" class="form-control" checkType="integer,1" tip="请选跟进方法">
					<option value="0f">请选择...</option>
					<option value="1" ${customerTrack.trackMethod==1?'selected="selected"':'' }>电话</option>
					<option value="3" ${customerTrack.trackMethod==3?'selected="selected"':'' }>短信 </option>
					<option value="4" ${customerTrack.trackMethod==4?'selected="selected"':'' }>回访</option>
				</select>
			</c:if>
		</div>	
		<div id="marketing" style="display: none;">
			<div class="form-group">
		 		<label class="control-label" for="name">邀约活动:&nbsp;<span style="color: red;">*</span></label>
				<select id="custMarketingActId" name="custMarketingActId" class="form-control" >
					<option value="">请选择...</option>
					<c:forEach var="custMarketingAct" items="${custMarketingActs }">
						<option value="${custMarketingAct.dbid }">${custMarketingAct.name }</option>
					</c:forEach>
				</select>
			</div>	
			<div class="form-group">
		 		<label class="control-label" for="name">邀约结果:&nbsp;<span style="color: red;">*</span></label>
				<select id="turnBackResult" name="customerTrack.turnBackResult" class="form-control" >
					<option value="">请选择...</option>
					<option value="1" ${customerTrack.turnBackResult==1?'selected="selected"':'' }>接受</option>
					<option value="2" ${customerTrack.turnBackResult==2?'selected="selected"':'' }>待定</option>
					<option value="3" ${customerTrack.turnBackResult==3?'selected="selected"':'' }>拒绝 </option>
				</select>
			</div>	
		</div>
			<c:if test="${customer.lastResult==0 }" var="status">
				<div class="form-group" >
	 			 <label class="control-label" for="inputWarning1">更新级别:&nbsp;</label>
						<select id="customerPhaseId" name="customerPhaseId" class="form-control" checkType="integer,1" tip="请选更新级别" onchange="addDate(this.value)">
							<option value="0">请选择...</option>
							<c:forEach var="customerPhase" items="${customerPhases }">
								<c:if test="${customerPhase.name!='O' }">
									<option value="${customerPhase.dbid }"  >${customerPhase.name }</option>
								</c:if>
							</c:forEach>
						</select>
				</div>
				<div class="form-group" >
	 			 	<label class="control-label" for="inputWarning1">下次预约时间:<span style="color: red;">*</span></label>
					<input type="text" name="customerTrack.nextReservationTime" id="nextReservationTime" value="" class="form-control" onfocus="WdatePicker({readOnly:true,dateFmt:'yyyy-MM-dd HH:mm',minDate:'#F{$dp.$D(\'trackDate\')}',maxDate:'#F{$dp.$D(\'maxDay\')}'});"  	checkType="string,1" tip="请选择下次预约时间">
				</div>
			</c:if>
			<c:if test="${status==false}">
				<div class="form-group" >
	 			 <label class="control-label" for="inputWarning1">更新级别:&nbsp;</label>
						<input type="hidden" readonly="readonly" class="form-control"  name="customerPhaseId" id="customerPhaseId"  value="${customer.customerPhase.dbid }">
						<input type="text" readonly="readonly" class="form-control"    value="${customerTrack.beforeCustomerPhase.name }">
				</div>
				<div class="form-group" >
	 			 	<label class="control-label" for="inputWarning1">下次预约时间:</label>
						<input type="date" name="customerTrack.nextReservationTime" id="nextReservationTime" value="" class="form-control" 	checkType="string,1" tip="请选择下次预约时间">
				</div>
			</c:if>
			<div class="form-group" >
	 			 <label class="control-label" for="inputWarning1">跟进内容:&nbsp;</label>
				<input type="text" name="customerTrack.trackContent" id="trackContent"	value="${customerTrack.trackContent }" class="form-control"  checkType="string,1,2000"	tip="请输入跟进内容,必须小于2000个字符"></td>
			</div>
			<div class="form-group" >
	 			 <label class="control-label" for="inputWarning1">沟通结果:&nbsp;</label>
					<input type="text" name="customerTrack.result" id="result"
					value="${customerTrack.result }" class="form-control" 	>
			</div>
			<div class="form-group" >
	 			 <label class="control-label" for="inputWarning1">客户反馈问题:&nbsp;</label>
				<input type="text" name="customerTrack.feedBackResult" id="feedBackResult"
					value="${customerTrack.feedBackResult }" class="form-control" 	>
			</div>
			<div class="form-group" >
	 			<label class="control-label" for="inputWarning1">对应措施:&nbsp;</label>
				<input type="text" name="customerTrack.dealMethod" id="dealMethod"
				value="${customerTrack.dealMethod }" class="form-control" 	>
			</div>
	</form>
	<div class="formButton">
		<c:if test="${param.type==1 }" var="status">
		</c:if>
		<c:if test="${status==false }">
			<input type="button" name="mobileCommit" value="保存" id="tele_register" class="addbutton" onclick="submitFrm('frmId','${ctx}/qywxCustomerTrack/save')"> 
		</c:if>
	</div>
</div>
</body>
<script type="text/javascript" src="${ctx }/widgets/My97DatePicker/WdatePicker.js"></script>
<script src="${ctx }/widgets/bootstrap3/jquery.min.js"></script>
<script src="${ctx }/widgets/easyvalidator/js/easy_validator.pack3.js?n=${now}"></script>
<script src="${ctx }/widgets/bootstrap3/js/bootstrap.min.js"></script>
<script src="${ctx }/widgets/utile/wechat.js"></script>
<script type="text/javascript">
function addDate(value){
    var d=new Date(); 
    var mm="";
    var dd="";
    $.post("${ctx}/customerPhase/ajax?dbid="+value+"&date="+new Date(),{},function(data){
    	if(0==data||data=='0'){
    		data=30;
    	}
    	data=parseInt(data)
    	d.setDate(d.getDate()+data); 
        var m=d.getMonth()+1; 
        if(m<10){
        	mm="0"+m;
        }else{
        	mm=m;
        }
        if(d.getDate()<10){
        	dd="0"+d.getDate();
        }else{
        	dd=d.getDate();
        }
        $("#maxDay").val(d.getFullYear()+'-'+mm+'-'+dd+' '+d.getHours()+':'+d.getMinutes());
    })
  } 
function marketingAct(trackType){
	  if(trackType==3){
		  $("#marketing").show();
		  $("#custMarketingActId").attr("checkType","integer,1").attr("tip","请选择邀约活动");
		  $("#turnBackResult").attr("checkType","integer,1").attr("tip","请选择邀约结果");
	  }else{
		  $("#marketing").hide();
		  $("#custMarketingActId").removeAttr("checkType").removeAttr("tip");
		  $("#turnBackResult").removeAttr("checkType").removeAttr("tip");
	  }
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