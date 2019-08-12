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
<title>回访记录</title>
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
    <span id="page_title">回访客户记录</span>
        <a class="go_home" href="${ctx }/qywxCustomerTrack/index">
    	<img src="${ctx }/images/jm/go_home.png" alt="">
    </a>
     <a id="search_action" class="go_search" onclick="showSearch()">
    	<img src="${ctx }/images/jm/search_list.png" class="search">
    </a>
</div>
<br>
<br>
<br>
<c:if test="${empty(page.result)||fn:length(page.result)<=0 }" var="status">
	今日还未回访！
</c:if>

<c:if test="${status==false }">
	<c:forEach items="${page.result }" var="customerTrack" varStatus="i">
		<c:set value="${customerTrack.customer }" var="customer"></c:set>
		<div class="orderContrac">
			<div class="title" align="left">
	  			序号：${i.index+1 }<br/>
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
					意向级别：${customer.customerPhase.name}<br>
					回访日期：<fmt:formatDate value="${customerTrack.finishDate}"/><br>
					到期回访日：<fmt:formatDate value="${customerTrack.nextReservationTime}"/><br>
					超时状态：
						<c:if test="${customerTrack.taskOverTimeStatus==1 }">
							<span style="color: green">未超时</span>
						</c:if>
						<c:if test="${customerTrack.taskOverTimeStatus==2 }">
							<span style="color: red">已超时</span>
						</c:if>
					<br>
					超时天数：${customerTrack.taskOverTimeNum }
					<br>
					登记时间：<fmt:formatDate value="${customer.createFolderTime }"/> <br/>
					<c:if test="${customer.lastResult>1 }">
						<c:if test="${customer.lastResult==1 }">
							<span style="color: blue;">成交购车</span> 
						</c:if>
						<c:if test="${customer.lastResult==2 }">
							<span style="color: red;">客户流失</span>
						</c:if>
						<c:if test="${customer.customerLastBussi.approvalStatus==0 }">
							<span style="color: #DD9A4B;;">等待审批...</span>
						</c:if>
						<c:if test="${customer.customerLastBussi.approvalStatus==1 }">
							<span style="color: red;">客户流失</span>
						</c:if>
					</c:if>
					<c:if test="${customer.customerLastBussi.approvalStatus==0 }">
						<br>
						流失发起时间:<fmt:formatDate value="${customer.customerLastBussi.createTime }" pattern="yyyy-MM-dd HH:mm"/>
					</c:if>
					<c:if test="${customer.customerLastBussi.approvalStatus==1 }">
					<br>
						流失发起时间:<fmt:formatDate value="${customer.customerLastBussi.createTime }" pattern="yyyy-MM-dd HH:mm"/>
					<br>
						流失审批时间:<fmt:formatDate value="${customer.customerLastBussi.approvalDate }" pattern="yyyy-MM-dd HH:mm"/>
					</c:if>
				</div>
			</div>
			<div class="line"></div>
		</div>
	</c:forEach>
</c:if>
<div style="text-align: center;">
	<jsp:include page="${ctx }/pages/commons/wechatPage.jsp"></jsp:include>
</div>
<br>
<br>
<br>
<div class="modal fade" id="exampleModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
  <div class="modal-dialog">
    <div class="modal-content">
      <div class="modal-body">
      	<form class="form-inline" action="${ctx }/qywxCustomerTrack/queryCompList" name="searchPageForm" id="searchPageForm" method="post">
      	<input type="hidden" id="currentPage" name="currentPage" value='${page.currentPageNo+1}'>
		<input type="hidden" id="paramPageSize" name="pageSize" value='${page.pageSize}'>
      	 <table>
      	 	<tr height="">
      	 		<td width="60"><label for="exampleInputName2">品牌</label></td>
      	 		<td width="240">
	      	 		<select class="form-control" id="brandId" name="brandId" onchange="ajaxCarSeriy(this.value)">
			    	<option value="">请选择...</option>
			    	<c:forEach var="brand" items="${brands }">
				    	<option value="${brand.dbid }" ${param.brandId==brand.dbid?'selected="selected"':'' } >${brand.name }</option>
			    	</c:forEach>
			    </select>
			    </td>
      	 	</tr>
      	 	
      	 	<tr>
      	 		<td width="60"><label for="exampleInputName2">车系</label></td>
      	 		<td width="240" id="carSeriyDiv">
	      	 		<select class="form-control " id="carSeriyId" name="carSeriyId" ${empty(param.brandId)==true?'disabled="disabled"':'' }>
			    		<option value="">请选择...</option>
				    	<c:forEach var="carSeriy" items="${carSeriys }">
					    	<option value="${carSeriy.dbid }" ${param.carSeriyId==carSeriy.dbid?'selected="selected"':'' } >${carSeriy.name }</option>
				    	</c:forEach>
			   	 </select>
			    </td>
      	 	</tr>
      	 	<tr>
      	 		<td width="60"><label for="exampleInputName2">车型</label></td>
      	 		<td width="240" id="carModelDiv">
	      	 		<select class="form-control" id="carModelId" name="carModelId" ${empty(param.carSeriyId)==true?'disabled="disabled"':'' }>
				    	<option value="">请选择...</option>
				    	<c:forEach var="carModel" items="${carModels }">
					    	<option value="${carModel.dbid }" ${param.carModelId==carModel.dbid?'selected="selected"':'' } >${carModel.name }</option>
				    	</c:forEach>
			    </select>
			    </td>
      	 	</tr>
      	 	<tr>
      	 		<td width="60"><label for="exampleInputName2">客户等级</label></td>
      	 		<td width="240">
	      	 		<select class="form-control" id="customerPhaseId" name="customerPhaseId">
				    	<option value="">请选择...</option>
				    	<c:forEach var="customerPhase" items="${customerPhases }">
				    		<c:if test="${customerPhase.dbid>1&&customerPhase.dbid<6 }">	  	
					    		<option value="${customerPhase.dbid }" ${param.customerPhaseId==customerPhase.dbid?'selected="selected"':'' } >${customerPhase.name }</option>
					    	</c:if>
				    	</c:forEach>
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
      	 	      	 	<tr>
      	 		<td width="60"><label for="exampleInputName2">业务员</label></td>
      	 		<td width="240">
      	 			<input type="text" class="form-control" id="userName" name="userName" value="${param.userName }">
			    </td>
      	 	</tr>
      	 	<tr>
      	 		<td width="60"><label for="exampleInputName2">回访开始日期</label></td>
      	 		<td width="240">
      	 			<input type="date" class="form-control" id="startFinishDate" name="startFinishDate" value="${param.startFinishDate }">
			    </td>
      	 	</tr>
      	 	<tr>
      	 		<td width="60"><label for="exampleInputName2">回访开始结束</label></td>
      	 		<td width="240">
      	 			<input type="date" class="form-control" id="endFinishDate" name="endFinishDate" value="${param.endFinishDate }">
			    </td>
      	 	</tr>
      	 	<tr>
      	 		<td>
					任务状态
				</td>
				<td>
					<select id="taskDealStatus" name="taskDealStatus"  class="form-control" onchange="$('#searchPageForm')[0].submit()">
						<option value="">请选择...</option>
						<option value="1" ${param.taskDealStatus==1?'selected="selected"':'' } >待回访</option>
						<option value="2" ${param.taskDealStatus==2?'selected="selected"':'' } >已回访</option>
						<option value="3" ${param.taskDealStatus==3?'selected="selected"':'' } >任务关闭</option>
					</select>
				</td>
			</tr>
			<tr>
				<td>
					超时状态
				</td>
				<td>
					<select id="taskOverTimeStatus" name="taskOverTimeStatus"  class="form-control" onchange="$('#searchPageForm')[0].submit()">
						<option value="">请选择...</option>
						<option value="1" ${param.taskOverTimeStatus==1?'selected="selected"':'' } >未超时</option>
						<option value="2" ${param.taskOverTimeStatus==2?'selected="selected"':'' } >已超时</option>
					</select>
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