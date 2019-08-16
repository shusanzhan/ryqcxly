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
<title>客户流失审批</title>
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
    <span id="page_title">客户流失审批</span>
</div>
<br>
<br>
<br>
<c:if test="${empty(customer)}" var="status">
	您还未填写登记回访明细！
</c:if>
<c:if test="${status==false }">
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
					顾问：${customer.bussiStaff}（${customer.department.name}）<br>
					意向级别：${customer.customerPhase.name}<br>
					登记时间：<fmt:formatDate value="${customer.createFolderTime }"/> <br/>
				</div>
			</div>
  			<div class="line"></div>
			<div class="title" align="left">
	  			跟踪信息
  			</div>
  			<div class="line"></div>
  			<div style="margin: 0 auto;margin: 5px;" >
				<div style="color:#8a8a8a;padding-left: 5px; ">
		  			<table width="100%">
						<tr height="42">
						<td style="text-align: left ;">结案情形:&nbsp;
							<c:if test="${customer.lastResult==1 }">
								成交——购车
							</c:if>
							<c:if test="${customer.lastResult==2 }">
								流失——购买其它品牌产品等
							</c:if>
							<c:if test="${customer.lastResult==3 }">
								购车计划取消
							</c:if>
						</td>
					</tr>
					<tr height="42">
						<td style="text-align: left">备注:&nbsp;
							${customerLastBussi.note }
						</td>
					</tr>
					</table>
				</div>
			</div>
		</div>
</c:if>
<form action="" id="frmId" name="frmId">
	<s:token></s:token>
	<input type="hidden" id="customerId" name="customerId" value="${customer.dbid }">
	<input type="hidden" id="lastResult" name="lastResult" value="">
</form>
<br>
<br>
<br>
<div class="orderMenu">
	<ul>
         <li>
             <a href="javascript:void(-1)"  data-toggle="modal" data-target="#exampleModal" onclick="smt('frmId','${ctx}/qywxCustomerOutFlow/saveOutFlow',2)">
             	不同意
             </a>
         </li>
         <li>
             <a href="javascript:void(-1)" id="agreeActive" data-toggle="modal" data-target="#exampleModal" onclick="smt('frmId','${ctx}/qywxCustomerOutFlow/saveOutFlow',1)">
             	同意
             </a>
         </li>
      </ul>
</div>	
</body>
<script src="${ctx }/widgets/bootstrap3/jquery.min.js"></script>
<script src="${ctx }/widgets/bootstrap3/js/bootstrap.min.js"></script>
<script src="${ctx }/widgets/utile/wechat.js"></script>
<script type="text/javascript">
function smt(frmId, url,type) {
	$("#lastResult").val(type);
	try {
		var state2=true;
		if(type==1){
			if(!confirm("确定【同意】客户流失吗？")){
				state2=false;
			}
		}
		if(type==2){
			if(!confirm("确定【不同意】客户流失吗？")){
				state2=false;
			}
		}
		if(state2==true){
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
								$(".butSave").attr("onclick",url2);
								$("#exampleModal").modal('show');
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
							$(".butSave").attr("onclick",url2);
							var jqXHR=jqXHR;
							var textStatus=textStatus;
						}, 
						beforeSend : function(jqXHR, configs){
							url2=$(".butSave").attr("onclick");
							$(".butSave").attr("onclick","");
							var jqXHR=jqXHR;
							var configs=configs;
						}, 
						error : function(jqXHR, textStatus, errorThrown){
									showMo(data[0].message);
								$(".butSave").attr("onclick",url2);
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