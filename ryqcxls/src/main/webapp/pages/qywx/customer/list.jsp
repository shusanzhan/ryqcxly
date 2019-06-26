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
<title>登记客户列表</title>
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
    <span id="page_title">登记客户</span>
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
<c:if test="${empty(page.result)||fn:length(page.result)<=0 }" var="status">
	您还未添加客户！
</c:if>
<c:if test="${status==false }">
	<div style="line-height: 40px;width: 96%;margin: 0 auto;font-size: 16px;">
		<div class="title" align="left">
			查询总数数据   ${page.totalCount} 条
		</div>
	</div>
</c:if>
<c:if test="${status==false }">
	<c:forEach items="${page.result }" var="customer">
		<c:set value="${customer.orderContract }" var="orderContract"></c:set>
		<div class="orderContrac">
			<div class="title" align="left">
	  			客户：${customer.name }<br/>
	  			电话：<a href="tel:${customer.mobilePhone }">${customer.mobilePhone }</a>
  			</div>
  			<div class="line"></div>
			<div style="margin: 0 auto;margin: 5px;" onclick="window.location.href='${ctx}/qywxCustomer/customerDetail?customerId=${customer.dbid }&type=1'">
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
				<c:if test="${customer.customerLastBussi.approvalStatus==2 }">
					客户流失审批结果：<span style="color: red;" title="">驳回,审批时间：<fmt:formatDate value="${customer.customerLastBussi.approvalDate}" pattern="yyyy-MM-dd HH:mm:ss"/> ,原因：${customer.customerLastBussi.notReason },</span>
				</c:if>
				</div>
			</div>
			<div class="line"></div>
			<div style="margin: 0 auto;margin: 5px;height: 30px;line-height: 30px;">
				<a href="${ctx }/qywxCustomer/edit?dbid=${customer.dbid}">编辑档案</a>|
				<a href="${ctx }/qywxCustomerTrack/add?customerId=${customer.dbid}&typeRedirect=1">跟踪记录</a>|
				<c:if test="${customer.lastResult==0 }">
					<a href="${ctx }/qywxCustomerLastBussi/selectResult?customerId=${customer.dbid}" class="aedit" >成交结果</a>
				</c:if>
				<c:if test="${customer.lastResult==1 }">
					<c:if test="${customer.orderContractStatus==0 }">
						<a href="javascript:void(-1)" class="aedit" onclick="window.location.href='${ctx}/qywxOrderContract/addOrderContract?customerId=${customer.dbid }&editType=1'">提交订单</a>|
					</c:if>
					<c:if test="${customer.orderContractStatus==1 }">
						<span style="color: blue;cursor: pointer;" title="已生成订单,请到订单列表查看订单审批记录!">已生成订单...</span>
					</c:if> 
				</c:if>
				<c:if test="${customer.lastResult>1 }">
					<c:if test="${customer.customerLastBussi.approvalStatus==0 }">
						<span style="color: #DD9A4B;;">等待审批...</span>
					</c:if>
					<c:if test="${customer.customerLastBussi.approvalStatus==1 }">
						<span style="color: red;">客户流失</span>
					</c:if>
				</c:if>
			</div>
		</div>
	</c:forEach>
</c:if>
<div style="text-align: center;">
	<jsp:include page="${ctx }/pages/commons/wechatPage.jsp"></jsp:include>
</div>
<div class="modal fade" id="exampleModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
  <div class="modal-dialog">
    <div class="modal-content">
      <div class="modal-body">
      	<form class="form-inline" action="${ctx }/qywxCustomer/list" name="searchPageForm" id="searchPageForm" method="post">
      	  <input type="hidden" id="currentPage" name="currentPage" value='${page.currentPageNo}'>
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
				    		<c:if test="${customerPhase.dbid>1&&customerPhase.dbid<5 }">	  	
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
      	 </table>
		</form>
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-default" data-dismiss="modal">取&nbsp;&nbsp;消</button>
        <button type="button" class="btn btn-primary" onclick="$('#searchPageForm')[0].submit()">查询</button>
      </div>
    </div>
  </div>
</div>
<br>
<br>
<br>
<div class="oneMenu">
	<ul>
         <li>
             <a href="${ctx}/qywxCustomerRecord/salerEdit">
             	创建线索
             </a>
         </li>
      </ul>
</div>	
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