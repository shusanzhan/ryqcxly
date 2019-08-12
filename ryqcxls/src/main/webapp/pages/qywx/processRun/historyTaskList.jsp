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
<title>待我审批</title>
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
    <span id="page_title">经我审批</span>
     <a id="search_action" class="go_search" onclick="showSearch()">
    	<img src="${ctx }/images/jm/search_list.png" class="search">
    </a>
</div>
<br>
<br>
<br>
<c:if test="${empty(processFroms)||fn:length(processFroms)<=0 }" var="status">
	无经我审批任务
</c:if>
<c:if test="${status==false }">
	<c:forEach items="${processFroms }" var="processFrom">
		<c:set value="${processFrom.processRun }" var="processRun"></c:set>
		<c:set value="${processRun.customer }" var="customer"></c:set>
		<div class="orderContrac">
			<div class="title" align="left">
	  			客户：${customer.name }<br/>
	  			电话：<a href="tel:${customer.mobilePhone }">${customer.mobilePhone }</a>
  			</div>
  			<div class="line"></div>
			<div style="margin: 0 auto;margin: 5px;" onclick="window.location.href='${ctx}/qywxCustomer/customerDetail?customerId=${customer.dbid }&type=2'">
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
					顾问：${customer.bussiStaff}（${customer.department.name}）<br>
					登记时间：<fmt:formatDate value="${customer.createFolderTime }"/> <br/>
					申请类型:
					<c:if test="${processRun.type==1 }">
						<span style="color: green;">合同订单申请</span>
					</c:if>
					<c:if test="${processRun.type==2}">
						<span style="color: red;">合同流失申请</span>
					</c:if>
					<br>
					流程名称：${processRun.title }<br>
					申请时间：
						<fmt:formatDate value="${processRun.createDate}"/>
					<br>
					流程状态：
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
					任务状态：
					<c:if test="${processFrom.approvalStatus==2 }">
						<span style="color: red">驳回</span>
					</c:if>
					<c:if test="${processFrom.approvalStatus==3 }">
						<span style="color: red">同意</span>
					</c:if>
					<c:if test="${processFrom.approvalStatus==4 }">
						<span style="color: green;">提交上级审批</span>
					</c:if>
				</div>
			</div>
			<div class="line"></div>
			<div style="margin: 0 auto;margin: 5px;height: 30px;line-height: 30px;">
				<a href="${ctx }/qywxProcessRun/viewProcessFrom?processRunDbid=${processRun.dbid}">审批记录</a>
			</div>
		</div>
	</c:forEach>
</c:if>
<div class="modal fade" id="exampleModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
  <div class="modal-dialog">
    <div class="modal-content">
      <div class="modal-body">
      	<form class="form-inline" action="${ctx }/qywxProcessRun/queryHistoryTaskList" name="frmId" id="frmId" method="post">
      	 <table>
      	 	<tr height="">
      	 		<td width="60"><label for="exampleInputName2">申请类型</label></td>
      	 		<td width="240">
			    <select class="form-control" id="type" name="type"  onchange="$('#searchPageForm')[0].submit()">
					<option value="0" >请选择...</option>
					<option value="1" ${param.type==1?'selected="selected"':'' } >合同订单申请</option>
					<option value="2" ${param.type==2?'selected="selected"':'' } >合同流失申请</option>
				</select>
			    </td>
      	 	</tr>
      	 	
      	 	<tr>
      	 		<td width="60"><label for="exampleInputName2">任务状态</label></td>
      	 		<td width="240" id="carSeriyDiv">
	      	 		<select class="form-control" id="approvalStatus" name="approvalStatus" onchange="$('#searchPageForm')[0].submit()" >
						<option value="">请选择...</option>
						<option value="2" ${param.approvalStatus==2?'selected="selected"':'' } >驳回</option>
						<option value="3" ${param.approvalStatus==3?'selected="selected"':'' } >通过</option>
						<option value="4" ${param.approvalStatus==4?'selected="selected"':'' } >提交上级</option>
					</select>
			   	 
			    </td>
      	 	</tr>
      	 	<tr>
      	 		<td width="60"><label for="exampleInputName2">姓名</label></td>
      	 		<td width="240">
      	 			<input type="text" class="form-control" id="name" name="name" value="${param.name }">
			    </td>
      	 	</tr>
      	 	<tr>
      	 		<td width="60"><label for="exampleInputName2">电话</label></td>
      	 		<td width="240">
      	 			<input type="text" class="form-control" id="mobilePhone" name="mobilePhone" value="${param.mobilePhone }">
			    </td>
      	 	</tr>
      	 </table>
		</form>
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-default" data-dismiss="modal">取&nbsp;&nbsp;消</button>
        <button type="button" class="btn btn-primary" onclick="$('#frmId')[0].submit()">查询</button>
      </div>
    </div>
  </div>
</div>
<br>
<br>
<br>
</body>
<script src="${ctx }/widgets/bootstrap3/jquery.min.js"></script>
<script src="${ctx }/widgets/bootstrap3/js/bootstrap.min.js"></script>
<script src="${ctx }/widgets/utile/wechat.js"></script>
<script type="text/javascript">
function showSearch(){
	$('.modal-dialog').css({  
        'margin-top':'0','width':'100%','height':'100%'
    });  
	$('.modal-content').css({'border-radius':'0','box-shadow':'0 0 rgba(0, 0, 0, 0.5)'});
	$('#exampleModal').modal();
}
function sendWarmingMessage(processRunId,ad){
	$("#processRunId").val(processRunId);
	$("#adMes").text('');
	$("#adMes").text(ad);
	$('.modal-dialog').css({  
    });  
	$('.modal-content').css({'border-radius':'0','box-shadow':'0 0 rgba(0, 0, 0, 0.5)'});
	$('#exampleModal2').modal();
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
function sendMessage(){
	var processRunId=$("#processRunId").val();
	$.post('${ctx }/qywxProcessRun/sendWarmingMessage?processRunId='+processRunId+"&dateTime="+new Date(),{},function (data){
		$('#exampleModal2').remove();
		var obj;
		if(data.message!=undefined){
			obj=$.parseJSON(data.message);
		}else{
			obj=data;
		}
		if(obj[0].mark==1){
			//错误
			showMo(data[0].message,false);
			return ;
		}else if(obj[0].mark==0){
			showMo(data[0].message,true);
			setTimeout(
					function() {
						window.location.href = obj[0].url
					}, 1000);
		}
	})
}
</script>
</html>