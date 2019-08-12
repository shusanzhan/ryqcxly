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
<title>成交客户</title>
</head>
<body>
<div class="views content_title navbar-fixed-top">
	 <a id="back" href="javascript:history.back()">
        <img src="${ctx }/images/jm/NavButtonBack.png" class="return">
    </a>
    <span id="page_title">成交客户</span>
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
	无订单信息！
</c:if>
<c:if test="${status==false }">
	<div class="orderContrac">
		<div class="title" align="left">
			查询总数数据   ${page.totalCount} 条
		</div>
	</div>
	<br>
	<c:forEach items="${page.result }" var="customer">
		<c:set var="orderContract" value="${customer.orderContract}"></c:set>
		<div class="orderContrac" >
			<div class="title" align="left">
	  			客户：${customer.name }<br/>
	  			电话：<a href="tel:${customer.mobilePhone }">${customer.mobilePhone }</a>
  			</div>
  			<div class="line"></div>
			<div style="margin: 0 auto;margin: 5px;" onclick="window.location.href='${ctx}/qywxCustomer/customerDetail?customerId=${customer.dbid }&type=2'">
				<div style="color:#8a8a8a;padding-left: 5px; ">
					车型：${customer.customerBussi.brand.name}&#12288;
					<c:set value="${customer.customerBussi.carSeriy.name}${ customer.customerBussi.carModel.name }" var="carModel"></c:set>
						${carModel} ${customer.carModelStr}
					<br>
					到店次数：
					<c:if test="${customer.comeShopStatus==1||empty(customer.comeShopStatus)}">
						未到店				
					</c:if>
					<c:if test="${customer.comeShopStatus==2 }">
						<span style="color: red;">首次到店</span>			
					</c:if>
					<c:if test="${customer.comeShopStatus==3 }">
						<span style="color: red;">二次到店</span>			
					</c:if>
					<br>
					试驾状态：
					<c:if test="${customer.tryCarStatus==1||empty(customer.tryCarStatus)}">
						未试驾				
					</c:if>
					<c:if test="${customer.tryCarStatus==2 }">
						<span style="color: red;">已试驾</span>			
					</c:if>
					<br>
					线索类型：${customer.customerType.name}<br>
					顾问：${customer.bussiStaff}（${customer.department.name}）<br>
					意向级别：${customer.customerPhase.name}<br>
					登记时间：<fmt:formatDate value="${customer.createFolderTime }"/> <br/>
					定金：<span style="color: red;">${orderContract.orderMoney }</span><br>
					订单日期：<fmt:formatDate value="${orderContract.createTime}" pattern="yyyy-MM-dd HH:mm:ss"/><br>
					总价：<span class="price" style="color: red;"><fmt:formatNumber value="${orderContract.totalPrice }" pattern="￥#,#00.00"></fmt:formatNumber></span>
				</div>
			</div>
			<div class="line"></div>
			<div class="title" align="left">
  			</div>
			<div class="line"></div>
				<div style="margin: 0 auto;margin: 5px;" onclick="window.location.href='${ctx}/qywxCustomer/customerDetail?customerId=${customer.dbid }&type=1'">
					归档日期:<fmt:formatDate value="${customer.customerPidBookingRecord.modifyTime}" pattern="yyyy-MM-dd"/><br>
					vin码:${customer.customerPidBookingRecord.vinCode}
				</div>
  					
			</div>
		</div>
	</c:forEach>
</c:if>
<div style="text-align: center;">
	<jsp:include page="${ctx }/pages/commons/wechatPage.jsp"></jsp:include>
</div>
<br>
<br>
<br>
<br>
<div class="modal fade" id="exampleModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
  <div class="modal-dialog">
    <div class="modal-content">
      <div class="modal-body">
      	<form class="form-inline" action="${ctx }/qywxCustomer/queryLeaderSuccessCustomer" name="searchPageForm" id="searchPageForm" method="post">
      	 <table>
      	 	<tr height="40">
  				<td><label>品牌：</label></td>
  				<td>
  					<select class="form-control" id="brandId" name="brandId"  onchange="$('#searchPageForm')[0].submit()">
						<option value="0" >请选择...</option>
						<c:forEach var="brand" items="${brands }">
							<option value="${brand.dbid }" ${param.brandId==brand.dbid?'selected="selected"':'' } >${brand.name }</option>
						</c:forEach>
					</select>
  				</td>
  			</tr>
  			<tr>
  				<td><label>车系：</label></td>
  				<td>
  					<select class="form-control" id="carSeriyId" name="carSeriyId"  onchange="$('#searchPageForm')[0].submit()">
						<option value="0" >请选择...</option>
						<c:forEach var="carSeriy" items="${carSeriys }">
							<option value="${carSeriy.dbid }" ${param.carSeriyId==carSeriy.dbid?'selected="selected"':'' } >${carSeriy.name }</option>
						</c:forEach>
					</select>
  				</td>
  			</tr>
  			<tr>
  				<td><label>车型：</label></td>
  				<td>
  					<select class="form-control" id="carModelId" name="carModelId"  onchange="$('#searchPageForm')[0].submit()">
						<option value="0" >请选择...</option>
						<c:forEach var="carModel" items="${carModels }">
							<option value="${carModel.dbid }" ${param.carModelId==carModel.dbid?'selected="selected"':'' } >${carModel.name }</option>
						</c:forEach>
					</select>
  				</td>
  			</tr>
  			<tr>
				<td><label>颜色：</label></td>
  				<td>
  					<select class="form-control" id="carColorId" name="carColorId"  onchange="$('#searchPageForm')[0].submit()">
						<option value="0" >请选择...</option>
						<c:forEach var="carColor" items="${carColors }">
							<option value="${carColor.dbid }" ${param.carColorId==carColor.dbid?'selected="selected"':'' } >${carColor.name }</option>
						</c:forEach>
					</select>
  				</td>
  			</tr>
  			<tr>
  				<td><label>销售顾问：</label></td>
  				<td>
  					<input class="form-control" id="userName" name="userName"  value="${param.userName }" >
  				</td>
				</tr>
				<tr>
  				<td><label>类型：</label></td>
  				<td>
  					<select class="form-control" id="customerTypeId" name="customerTypeId"  onchange="$('#searchPageForm')[0].submit()">
						<option value="0" >请选择...</option>
						<c:forEach var="customerType" items="${customerTypes }">
							<option value="${customerType.dbid }" ${param.customerTypeId==customerType.dbid?'selected="selected"':'' } >${customerType.name }</option>
						</c:forEach>
					</select>
  				</td>
  			</tr>
  			<tr>
  				<td><label>来源：</label></td>
  				<td>
  					<select class="form-control" id="customerInfromId" name="customerInfromId"  onchange="$('#searchPageForm')[0].submit()">
						<option value="0" >请选择...</option>
						${customerInfromSelect}
					</select>
  				</td>
  			</tr>
  			<tr>
  				<td><label>试乘试驾：</label></td>
  				<td>
  					<select class="form-control" id="tryCarStatus" name="tryCarStatus" onchange="$('#searchPageForm')[0].submit()" >
						<option value="">请选择...</option>
						<option value="1" ${param.tryCarStatus==1?'selected="selected"':''}>未试驾</option>
						<option value="2" ${param.tryCarStatus==2?'selected="selected"':''}>已试驾</option>
					</select>
  				</td>
  			</tr>
  			<tr>
  				<td><label>到店状态：</label></td>
  				<td>
  					<select class="form-control" id="comeShopStatus" name="comeShopStatus" onchange="$('#searchPageForm')[0].submit()" >
						<option value="-1">请选择...</option>
						<option value="1" ${param.comeShopStatus==1?'selected="selected"':''} >未到店</option>
						<option value="2" ${param.comeShopStatus==2?'selected="selected"':''}>首次到店</option>
						<option value="3" ${param.comeShopStatus==3?'selected="selected"':''}>二次到店</option>
					</select>
				</td>
			</tr>
  			<tr>
  				<td><label>客户名称：</label></td>
  				<td>
  					<input class="form-control" id="name" name="name"  value="${param.name }" >
  				</td>
				</tr>
				<tr>
  				
  				<td><label>电话：</label></td>
  				<td>
  					<input class="form-control" id="mobilePhone" name="mobilePhone"  value="${param.mobilePhone }" >
  				</td>
  			</tr>
  			<tr>
  				<td><label>开始时间：</label></td>
  				<td>
  					<input class="form-control" id="startTime" name="startTime" onFocus="WdatePicker({isShowClear:true,readOnly:true})" value="${param.startTime }" >
				</td>
			</tr>
  			<tr>
  				<td><label>结束时间：</label></td>
  				<td>
  					<input class="form-control" id="endTime" name="endTime" onFocus="WdatePicker({isShowClear:true,readOnly:true})" value="${param.endTime }">
  				</td>
  			</tr>
  			<tr>
  				<td><label>VIM码：</label></td>
  				<td>
  					<input class="form-control" id="vinCode" name="vinCode"  value="${param.vinCode }" >
  				</td>
  			</tr>
  			<tr>
  				<td><label>试驾开始：</label></td>
  				<td>
  					<input class="form-control" id="tryCarStartTime" name="tryCarStartTime" onFocus="WdatePicker({isShowClear:true,readOnly:true})" value="${param.tryCarStartTime }" >
				</td>
			</tr>
  			<tr>
  				<td><label>结束时间：</label></td>
  				<td>
  					<input class="form-control" id="tryCarEndTime" name="tryCarEndTime" onFocus="WdatePicker({isShowClear:true,readOnly:true})" value="${param.tryCarEndTime }">
  				</td>
  			</tr>
  			<tr>
  				<td><label>来店开始：</label></td>
  				<td>
  					<input class="form-control" id="comeShopStartTime" name="comeShopStartTime" onFocus="WdatePicker({isShowClear:true,readOnly:true})" value="${param.comeShopStartTime }" >
				</td>
			</tr>
  			<tr>
  				<td><label>结束时间：</label></td>
  				<td>
  					<input class="form-control" id="comeShopEndTime" name="comeShopEndTime" onFocus="WdatePicker({isShowClear:true,readOnly:true})" value="${param.comeShopEndTime }">
  				</td>
  			</tr>
  			<tr>
  				<td><label>订单开始：</label></td>
  				<td>
  					<input class="form-control" id="startOrderTime" name="startOrderTime" onFocus="WdatePicker({isShowClear:true,readOnly:true})" value="${param.startOrderTime }" >
				</td>
			</tr>
  			<tr>
  				<td><label>订单结束：</label></td>
  				<td>
  					<input class="form-control" id="endOrderTime" name="endOrderTime" onFocus="WdatePicker({isShowClear:true,readOnly:true})" value="${param.endOrderTime }">
  				</td>
  			</tr>
  			<tr>
  				<td><label>归档开始：</label></td>
  				<td>
  					<input class="form-control" id="startSuccessTime" name="startSuccessTime" onFocus="WdatePicker({isShowClear:true,readOnly:true})" value="${param.startSuccessTime }" >
				</td>
			</tr>
  			<tr>
  				<td><label>归档结束：</label></td>
  				<td>
  					<input class="form-control" id="endSuccessTime" name="endSuccessTime" onFocus="WdatePicker({isShowClear:true,readOnly:true})" value="${param.endSuccessTime }">
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