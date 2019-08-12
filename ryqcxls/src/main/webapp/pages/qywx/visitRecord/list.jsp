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
<title>回访客户</title>
</head>
<body>
<div class="views content_title navbar-fixed-top">
	 <a id="back" href="javascript:history.back()">
        <img src="${ctx }/images/jm/NavButtonBack.png" class="return">
    </a>
    <span id="page_title">回访客户</span>
      <a class="go_home" href="${ctx }/qywxCustomer/index">
    	<img src="${ctx }/images/jm/go_home.png" alt="">
    </a>
     <a id="search_action" class="go_search" onclick="showSearch()">
    	<img src="${ctx }/images/jm/search_list.png" class="search">
    </a>
</div>
<br>
<br>
<br>
<c:if test="${empty(visitRecords)||fn:length(visitRecords)<=0 }" var="status">
	无订单客户
</c:if>
<c:if test="${status==false }">
	<c:forEach items="${visitRecords }" var="visitRecord">
		<c:set value="${visitRecord.customer }" var="customer"></c:set>
		<c:set var="orderContract" value="${customer.orderContract}"></c:set>
		<div class="orderContrac" >
			<div class="title" align="left">
	  			客户：<a href="${ctx}/qywxCustomer/customerDetail?customerId=${customer.dbid }&type=2">${customer.name }</a><br/>
	  			电话：<a href="tel:${customer.mobilePhone }">${customer.mobilePhone }</a>
  			</div>
  			<div class="line"></div>
			<div style="margin: 0 auto;margin: 5px;" onclick="">
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
					vin码:
					<a href="${ctx }/qywxCustomer/factoryOrderDetail?vinCode=${customer.customerPidBookingRecord.vinCode}&type=1">${customer.customerPidBookingRecord.vinCode}</a>
					<br>
					顾问：${customer.bussiStaff}（${customer.department.name}）
				</div>
			</div>
			<div class="line"></div>
			<div class="title" align="left">
	  			回访信息
  			</div>
			<div class="line"></div>
			<div style="margin: 0 auto;margin: 5px;" onclick="window.location.href='${ctx}/qywxVisitRecord/viewVisitRecord?customerId=${customer.dbid }'">
				<div style="color:#8a8a8a;padding-left: 5px; ">
				回访状态：
				<c:if test="${visitRecord.ssiStatus==1 }">
					<span style="color: blue;">SSI调研成功</span>
					<br>
						合格：<c:if test="${visitRecord.coreQualified==1 }">
							<span style="color: green">合格</span>
						</c:if>
						<c:if test="${visitRecord.coreQualified==2 }">
							<span style="color: red;">不合格</span>
						</c:if>
						<br>
				</c:if>
				<c:if test="${visitRecord.ssiStatus>1 }">
					<c:if test="${visitRecord.ssiStatus==2 }">
						<span style="color: green;">SSI调研失败</span>
					</c:if>
					<c:if test="${visitRecord.ssiStatus==3 }">
						<span style="color: green;">SSI未调研</span>
					</c:if>
					<br>
					再访原因：${visitRecord.aginReason.name }<br>
				</c:if>
				任务状态：	
					<c:if test="${visitRecord.taskStatus==2 }">
						<span style="color: blue;">处理中</span><br>
					</c:if>
					<c:if test="${visitRecord.taskStatus==3 }">
						<span style="color: green;">回访完成</span><br>
					</c:if>
					<c:if test="${visitRecord.taskStatus==4 }">
						<span style="color: red;">不再回访</span><br>
					</c:if>
				回访结果：
				<c:if test="${visitRecord.visitResultStatus==1 }">
					<span style="color: red;">失败</span><br>
				</c:if>
				<c:if test="${visitRecord.visitResultStatus==2 }">
					<span style="color: blue;">成功</span><br>
				</c:if>
				<c:if test="${visitRecord.visitResultStatus==3 }">
					<span style="color: green;">跟踪</span><br>
				</c:if>
				<c:if test="${visitRecord.visitResultStatus==4 }">
					<span style="color: red;">未提车</span><br>
				</c:if>	
			</div>
					满意度：
					${visitRecord.comSat }
					<br>
					综合得分：${visitRecord.coreScore }
			</div>
		</div>
	</c:forEach>
</c:if>
<br>
<br>
<br>
<br>
<div class="modal fade" id="exampleModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
  <div class="modal-dialog">
    <div class="modal-content">
      <div class="modal-body">
      	<form class="form-inline" action="${ctx }/qywxVisitRecord/list" name="frmId" id="frmId" method="post">
      	 <table>
      	 	<tr>
      	 		<td width="60"><label for="exampleInputName2">回访状态</label></td>
      	 		<td width="240" id="carModelDiv">
	      	 		<select id="hfStatus" name="hfStatus"  class="form-control"  onchange="$('#searchPageForm')[0].submit()">
						<option value="">请选择...</option>
						<option value="2" ${param.hfStatus==2?'selected="selected"':'' } >需再次回访</option>
						<option value="3" ${param.hfStatus==3?'selected="selected"':'' } >回访成功</option>
					</select>
			    </td>
      	 	</tr>
      	 	<tr>
      	 		<td width="60"><label for="exampleInputName2">合格</label></td>
      	 		<td width="240" id="carModelDiv">
	      	 		<select id="coreQualified" name="coreQualified" class="form-control"    onchange="$('#searchPageForm')[0].submit()">
						<option value="">请选择...</option>
						<option value="1" ${param.coreQualified==1?'selected="selected"':'' } >合格</option>
						<option value="2" ${param.coreQualified==2?'selected="selected"':'' } >不合格</option>
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