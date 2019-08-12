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
<title>审批记录</title>
<style type="text/css">
	.form-controlSe{
		margin-top: 5px;
	}
	.form-group{
		margin-bottom: 10px;
	}
	.list-group-item {
    background-color: #fff;
    border: 1px solid #ddd;
    display: block;
    margin-bottom: -1px;
    padding: 15px 10px;
    position: relative;
}
.form-inline tr{
	height: 45px;
}
</style>
</head>
<body>
<div class="views content_title navbar-fixed-top">
	 <a id="back" href="javascript:history.back()">
        <img src="${ctx }/images/jm/NavButtonBack.png" class="return">
    </a>
    <span id="page_title">审批记录</span>
</div>
<br>
<br>
<br>
<div class="orderContrac">
	<div class="title" align="left">
		客户：${customer.name }<br/>
		电话：<a href="tel:${customer.mobilePhone }">${customer.mobilePhone }</a>
	</div>
	<div class="line"></div>
	<div style="margin: 0 auto;margin: 5px;" >
		<div style="color:#8a8a8a;padding-left: 5px; ">
			车型：${customer.customerBussi.brand.name}&#12288;
			<c:set value="${customer.customerBussi.carSeriy.name}${ customer.customerBussi.carModel.name }" var="carModel"></c:set>
			<c:if test="${fn:length(carModel)>16 }" var="status">
				${fn:substring(carModel,0,16) }...
			</c:if>
			<c:if test="${ status==false}">
				${carModel }${customer.carModelStr}
			</c:if>
			<br>
			顾问：${customer.bussiStaff}<a href="tel:${customer.user.mobilePhone }">${customer.user.mobilePhone }</a>（${customer.department.name}）<br>
			意向级别：${customer.customerPhase.name}<br>
			登记时间：<fmt:formatDate value="${customer.createFolderTime }"/> <br/>
			申请类型:
			<c:if test="${processRun.type==1 }">
				合同订单申请
			</c:if>
			<c:if test="${processRun.type==2}">
				合同流失申请
			</c:if>
			<br>
			申请时间：
			<fmt:formatDate value="${processRun.createDate}"/>
			<br>
			审批时间:
			<c:if test="${empty(processRun.finishDate) }">
				<span style="color: red">审批中...</span>
			</c:if>
			<c:if test="${!empty(processRun.finishDate) }">
				<fmt:formatDate value="${processRun.finishDate}"/>
			</c:if><br>
			
			审批状态：
			<c:if test="${processRun.runStatus==1 }">
				<span style="color: red">审批中...</span>
			</c:if>
			<c:if test="${processRun.runStatus==2 }">
				<span style="color: red">驳回</span>
			</c:if>
			<c:if test="${processRun.runStatus==3 }">
				<span style="color: green;">通过</span>
			</c:if>
			<br>
			审批用时:${processRun.duringLong }(小时)
		</div>
	</div>
	<div class="line"></div>
</div>
<c:forEach var="processFrom" items="${processFroms }" varStatus="i">
	<div class="orderContrac">
	<div class="title" align="left">
		审批记录${i.index+1 }
	</div>
	<div class="line"></div>
		<div style="margin: 0 auto;margin: 5px;" >
		<div style="color:#8a8a8a;padding-left: 5px; ">
				任务名称：${processFrom.taskName }
				<br>
				创建时间：<fmt:formatDate value="${processFrom.createTime }" pattern="yyyy-MM-dd HHH:mm"/><br>
				上个任务：${processFrom.fromTaskName }<br>
				审批人：${processFrom.taskUserName } <br/>
				审批状态:
				<c:if test="${processFrom.status==1 }">
					<span style="color: red">待审批</span>
				</c:if>
				<c:if test="${processFrom.status==2 }">
					<span style="color: green">已审批</span>
				</c:if>
				<br>
				审批结果：
				<c:if test="${processFrom.approvalStatus==1 }">
						<span style="color: red">待审批</span>
					</c:if>
					<c:if test="${processFrom.approvalStatus==2 }">
						<span style="color: red">审批驳回</span>
					</c:if>
					<c:if test="${processFrom.approvalStatus==3 }">
						<span style="color: green;">通过</span>
					</c:if>
					<c:if test="${processFrom.approvalStatus==4 }">
						<span style="color: green;">提交上级审批</span>
					</c:if>
				<br>
				处理时间:
					<fmt:formatDate value="${processFrom.finishTime }"/><br>
				审批意见：
				${processFrom.comments }
				<br>
				用时(小时):${processFrom.duringLong }小时)
			</div>
			</div>
	</div>
</c:forEach>

</body>
<script src="${ctx }/widgets/bootstrap3/jquery.min.js"></script>
<script src="${ctx }/widgets/bootstrap3/js/bootstrap.min.js"></script>
<script type="text/javascript">
function showSearch(){
	$('.modal-dialog').css({  
        'margin-top':'0','width':'100%','height':'100%'
    });  
	$('.modal-content').css({'border-radius':'0','box-shadow':'0 0 rgba(0, 0, 0, 0.5)'});
	$('#exampleModal').modal();
}
$(function () {
	var window_w=window.innerWidth|| document.documentElement.clientWidth|| document.body.clientWidth;
	var window_h=window.innerHeight|| document.documentElement.clientHeight|| document.body.clientHeight;
	if($('.go_top').length==0){
	    $('body').append('<a href="#" class="go_top"><img src="${ctx}/images/jm/icon_top.png" data-original=${ctx}/images/jm/icon_top.png" alt=""></a>');
	}
	$(window).scroll(function(e){
	    if(document.body.scrollTop+document.documentElement.scrollTop>window_h){
	        $('.go_top').show();
	    }
	    else{
	        $('.go_top').hide();
	    }
	});
	$('.go_top').click(function(){
	    document.body.scrollTop = 0;
	    document.documentElement.scrollTop = 0;
	    return false;
	})
})
function ajaxCarSeriy(val){
		if(val==''||val==undefined){
			$("#carModelId").attr("disabled",true);
			$("#carModelId option").remove(); 
			$("#carModelId").append("<option value=''>请选择...</option>");  
			$("#carSeriyId").attr("disabled",true);
			$("#carSeriyId option").remove(); 
			$("#carSeriyId").append("<option value=''>请选择...</option>"); 
		}else{
			$("#carSeriyId").remove();
			$("#carModelId").attr("disabled",true);
			$("#carModelId option").remove(); 
			$("#carModelId").append("<option value=''>请选择...</option>"); 
			$.post("${ctx}/qywxCustomer/ajaxCarSeriyContent?brandId="+val+"&dateTime="+new Date(),{},function (data){
				if(data!="error"){
					$("#carSeriyDiv").append(data);
				}
			});
		}
	}

function ajaxCarModel(sel){
	var options=$("#"+sel+" option:selected");
	var value=options[0].value;
	$("#carModelId").remove();
	if(value==''||value<=0){
		return;
	}
	$.post("${ctx}/qywxCustomer/ajaxCarModelBySeriyContent?carSeriyId="+value+"&dateTime="+new Date(),{},function (data){
		if(data!="error"){
			$("#carModelDiv").append(data);
		}
	});
}
</script>
</html>