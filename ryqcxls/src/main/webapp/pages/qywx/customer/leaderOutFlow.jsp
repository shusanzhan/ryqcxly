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
<title>流失客户列表</title>
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
    <span id="page_title">流失客户</span>
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
	您还未添加客户！
</c:if>
<c:if test="${status==false }">
	<div class="orderContrac">
		<div class="title" align="left">
			查询总数数据   ${page.totalCount} 条
		</div>
	</div>
	<br>
	<c:forEach items="${page.result }" var="customer">
		<c:set value="${customer.orderContract }" var="orderContract"></c:set>
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
					成交结果：
					<c:if test="${customer.lastResult==0 }">
						创建客户
					</c:if>
					<c:if test="${customer.lastResult==1 }">
						<span style="color: blue;">成交购车</span> 
					</c:if>
					<c:if test="${customer.lastResult==2 }">
						<span style="color: red;">流失购买其他品牌</span>
					</c:if>
					<c:if test="${customer.lastResult==3 }">
						<span style="color: red;">购车计划取消</span>
					</c:if>
					<br>
					流失发起时间：<fmt:formatDate value="${customer.customerLastBussi.createTime }"/> <br/>
				</div>
			</div>
			<div class="line"></div>
			<div style="margin: 5px;line-height: 20px;min-height: 30px;">
				<div class="status">
					<c:if test="${customer.lastResult>1 }">
					<c:if test="${customer.customerLastBussi.approvalStatus==0 }">
						<span style="color: #DD9A4B;;">等待审批...</span>
					</c:if>
					<c:if test="${customer.customerLastBussi.approvalStatus==1 }">
						<span style="color: red;">客户流失</span>
					</c:if>
				</c:if>
				</div>
  				<div style="clear: both;"></div>
			</div>
		</div>
	</c:forEach>
</c:if>
<div style="text-align: center;">
	<jsp:include page="${ctx }/pages/commons/wechatPage.jsp"></jsp:include>
</div>
<div class="modal fade" id="exampleModal2" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
  <div class="modal-dialog">
    <div class="modal-content">
      <div class="modal-header">
        <h4 class="modal-title" id="exampleModalLabel">提示信息</h4>
      </div>
	    <div class="modal-content">
	      <div class="modal-body">	
	      	您确定将【<span id="custName"></span>】转为登记客户吗？转为登记客户后系统将删除流失客户的审批记录和成交结果！
	      	<input type="hidden" id="custDbid" name="custDbid" value="">
        </div>
      </div>
     <div class="modal-footer">
        <button type="button" class="btn btn-default" data-dismiss="modal">取&nbsp;&nbsp;消</button>
        <button type="button" class="btn btn-primary" onclick="turnOutFlowerToCustomer()">确&nbsp;&nbsp;定</button>
      </div>
  </div>
</div>
</div>
<div class="modal fade" id="exampleModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
  <div class="modal-dialog">
    <div class="modal-content">
      <div class="modal-body">
      	<form class="form-inline" action="${ctx }/qywxCustomer/queryLeaderOutFlow" name="searchPageForm" id="searchPageForm" method="post">
      	  	<input type="hidden" id="currentPage" name="currentPage" value='${page.currentPageNo}'>
			<input type="hidden" id="paramPageSize" name="pageSize" value='${page.pageSize}'>
		<table cellpadding="0" cellspacing="0" class="searchTable" >
  			<tr>
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
  				<td><label>销售顾问：</label></td>
  				<td>
  					<input type="text" id="userName" name="userName" class="form-control" value="${param.userName}"></input>
				</td>
			</tr>
  			<tr>
  				<td><label>结案情形：</label></td>
  				<td>
  					<select id="customerFlowReasonId" name="customerFlowReasonId" class="form-control" onchange="$('#searchPageForm')[0].submit()">
						<option value="0">请选择...</option>
						<c:forEach var="customerFlowReason" items="${customerFlowReasons }">
							<option value="${customerFlowReason.dbid }" ${customerFlowReason.dbid ==param.customerFlowReasonId?'selected="selected"':'' }>${customerFlowReason.name }</option>
						</c:forEach>
					</select>
				</td>
			</tr>
  			<tr>
  				<td><label>客户姓名：</label></td>
  				<td><input type="text" id="name" name="name" class="form-control" value="${param.name}"></input></td>
  			</tr>
  			<tr>
  				<td><label>常用手机号：</label></td>
  				<td><input type="text" id="mobilePhone" name="mobilePhone" class="form-control" value="${param.mobilePhone}"></input></td>
  			</tr>
  			<tr>
				<td><label>创建日期开始：</label></td>
  				<td>
  					<input class="form-control" id="startFolderTime" name="startFolderTime" onFocus="WdatePicker({isShowClear:true,readOnly:true})" value="${param.startFolderTime }" >
				</td>
			</tr>
  			<tr>
  				<td><label>结束：</label></td>
  				<td>
  					<input class="form-control" id="endFolderTime" name="endFolderTime" onFocus="WdatePicker({isShowClear:true,readOnly:true})" value="${param.endFolderTime }">
  				</td>
		</tr>
		<tr>
				<td><label>审批状态：</label></td>
  				<td>
  					<select id="approvalStatus" name="approvalStatus" class="form-control" onchange="$('#searchPageForm')[0].submit()">
						<option value="-1">请选择...</option>
						<option value="0" ${param.approvalStatus==0?'selected="selected"':'' }>待审批</option>
						<option value="1" ${param.approvalStatus==1?'selected="selected"':'' }>已审批</option>
					</select>
				</td>
			</tr>
  			<tr>
				<td><label>流失日期开始：</label></td>
  				<td>
  					<input class="form-control" id="startTime" name="startTime" onFocus="WdatePicker({isShowClear:true,readOnly:true})" value="${param.startTime }" >
				</td>
			</tr>
  			<tr>
  				<td><label>结束：</label></td>
  				<td>
  					<input class="form-control" id="endTime" name="endTime" onFocus="WdatePicker({isShowClear:true,readOnly:true})" value="${param.endTime }">
  				</td>
  			</tr>
  			<tr>
  				<td><label>审批日期开始：</label></td>
  				<td>
  					<input class="form-control" id="startApprovalTime" name="startApprovalTime" onFocus="WdatePicker({isShowClear:true,readOnly:true})" value="${param.startApprovalTime }" >
				</td>
			</tr>
  			<tr>
  				<td><label>结束：</label></td>
  				<td>
  					<input class="form-control" id="endApprovalTime" name="endApprovalTime" onFocus="WdatePicker({isShowClear:true,readOnly:true})" value="${param.endApprovalTime }">
  				</td>
  				<td><div href="javascript:void(-1)" onclick="$('#searchPageForm')[0].submit()" class="searchIcon"></div></td>
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
function turnOutFlowerToCustomer(){
	var custDbid=$("#custDbid").val();
	$.post("${ctx}/qywxCustomerLastBussi/turnOutFlowerCustomerToCustomer?custDbid="+custDbid+"&dateTime="+new Date(),{},function (data){
		if (data[0].mark == 0) {// 返回标志为0表示添加数据成功
			alert("流失客户已经转换为登记客户，请到登记客户页面查看！")
			$("#orderContrac"+custDbid).remove();
			$('#exampleModal2').modal('hide');
		}
		if (data[0].mark == 1) {// /返回标志为1表示保存数据失败
			alert("转为登记客户失败！")
			// 保存失败时页面停留在数据编辑页面
		}
	});
}
function turnOutFlowerCustomerToCustomer(custDbid,custName){
	$("#custDbid").val(custDbid);
	$("#custName").text("");
	$("#custName").text(custName);
	$('.modal-dialog').css({  
    });  
	$('.modal-content').css({'border-radius':'0','box-shadow':'0 0 rgba(0, 0, 0, 0.5)'});
	$('#exampleModal2').modal();
}
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