<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
      <%@ include file="../../commons/taglib.jsp" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
 <meta charset="UTF-8">
    <meta content="width=device-width, initial-scale=1.0, minimum-scale=1.0, maximum-scale=1.0, user-scalable=no" name="viewport">
    <!-- Mobile Devices Support @begin -->
    <meta content="application/xhtml+xml;charset=UTF-8" http-equiv="Content-Type">
    <meta content="no-cache,must-revalidate" http-equiv="Cache-Control">
    <meta content="no-cache" http-equiv="pragma">
    <meta content="0" http-equiv="expires">
    <meta content="telephone=no, address=no" name="format-detection">
    <meta name="apple-mobile-web-app-capable" content="yes" />
    <!-- apple devices fullscreen -->
    <link rel="stylesheet" href="${ctx }/css/wechat/comm.css" type="text/css" />
    <meta name="apple-mobile-web-app-status-bar-style" content="black-translucent" />
    <link rel="stylesheet" href="${ctx }/pages/wechat/WeUI/style/weui.css?${now}" type="text/css" />
	<script src="${ctx }/pages/wechat/WeUI/example/zepto.min.js"></script>
    <script src="${ctx }/pages/wechat/WeUI/example/router.min.js"></script>
    <style type="text/css">
    </style>
<title>${recommendCustomer.name }客户记录</title>
</head>
<body>
<div class="title">
    <a class="btn-back" onclick="window.history.go(-1)" href="javascript:void(0)"><i class="icon icon-2-1"></i></a>
    <h3>${recommendCustomer.name }客户记录</h3>
</div>
<br>
<br>
<br>
<div id="detail_nav">
    <div class="detail_nav_inner" style="margin: 0;padding: 0;box-sizing: border-box;width: 100%;overflow: hidden;">
        <ul class="clearfix padding10">
	         <li class="detail_tap2 detail_tap pull_left " id="imgs_tap" onclick="window.location.href='${ctx}/agentWechat/recommendCustomerDetial?recommendCustomerDbid=${recommendCustomer.dbid }'">推荐客户</li>
          	 <li class="detail_tap2 detail_tap pull_left select" id="pingjia_tap" onclick="window.location.href='${ctx}/agentWechat/customerDetial?recommendCustomerDbid=${recommendCustomer.dbid }'">客户记录</li>
     	</ul>
    </div>
</div>
 <div class="center_mian" style="width:96%;margin: 0px auto;margin-top:14px;;text-align: center;">
 <c:if test="${empty(customer) }">
		<div class="titles" align="center" style="color: red">
				客户待登记中....请稍后
		</div>
 </c:if>
 <c:if test="${!empty(customer) }">
	<div class="orderItem" id="spxx" style="overflow: auto;padding-bottom: 12px;">
 			<div class="titles" align="left">
  			客户：${customer.name }&nbsp;&nbsp;${customer.sex }<br/>
	  		电话：<a href="tel:${customer.mobilePhone }" style="display:inline;">${customer.mobilePhone }</a><br>
	  		车型：${customer.customerBussi.brand.name}&#12288;
			<c:set value="${customer.customerBussi.carSeriy.name}${ customer.customerBussi.carModel.name }" var="carModel"></c:set>
			<c:if test="${fn:length(carModel)>16 }" var="status">
				${fn:substring(carModel,0,16) }...
			</c:if>
			<c:if test="${ status==false}">
				${carModel} ${customer.carModelStr}
			</c:if>
			<br>
 			</div>
 			<div class="line"></div>
 			<c:set var="sum" value="0"/>
			<div class="content" >
		    		<div class="titleOrPrice">
		    			<h1 class="productTitle" style=""></h1>
		    			<div class="det" align="left">
		  					意向级别：${customer.customerPhase.name}<br>
							登记时间：<fmt:formatDate value="${customer.createFolderTime }"/> <br/>
							顾问：${customer.user.realName}（${customer.department.name}）<br>
		  					
			  			</div>
		    		</div>
		    		<div style="clear: both;"></div>
		    </div>
 	</div>
 <div class="orderItem" id="spxx" style="overflow: auto;padding-bottom: 12px;">
	<div class="titles" align="left">
		客户基础资料
	</div>
	<div class="line"></div>
	<div class="content" >
   		<div class="titleOrPrice">
   			<h1 class="productTitle" style=""></h1>
   			<div class="det" align="left">
 					<table>
						<tr>
							<td colspan="2">证件信息：${ customer.paperwork.name}&#12288;</td>
						</tr>
						<tr>
							<td colspan="2">
								证件号码：
								${fn:substring(customer.icard,0,6) }*****
								${fn:substring(customer.icard,13,18) }
							</td>
						</tr>
						<tr >
							<td colspan="2">地址：${customer.area.fullName }${customer.address }
							</td>
						</tr>
					</table>
 				</div>
 			</div>
 	</div>
 </div>
 <div class="orderItem" id="spxx" style="overflow: auto;padding-bottom: 12px;">
	<div class="titles" align="left">
		跟踪记录
	</div>
	<div class="line"></div>
	<div class="content" >
 		<div class="det" align="left" style="width: 100%">
			<table cellpadding="0" cellspacing="0" width="100%" border="0" style="color:#8a8a8a">
			<c:if test="${empty(customertracks) }" var="status">
				<span style="color: red;padding-left: 12px;">无跟踪记录</span>
			</c:if>
			<c:if test="${status==false }">
					<table width="100%"  cellpadding="0" cellspacing="0" class="mainTable" border="0">
						<c:forEach var="customerTrack" items="${customertracks }" varStatus="i">
								<tr>
									<td id="" width="100%" >
										${i.index+1 }、<fmt:formatDate value="${customerTrack.trackDate}" pattern="yyyy-MM-dd"/> ,
										<c:if test="${customerTrack.trackMethod==1 }">
											电话
										</c:if>
										<c:if test="${customerTrack.trackMethod==2 }">
											到店
										</c:if>
										<c:if test="${customerTrack.trackMethod==3 }">
											短信
										</c:if>
										<c:if test="${customerTrack.trackMethod==4 }">
											回访
										</c:if>
										进行回访，回访后更新客户级别为【${customerTrack.beforeCustomerPhase.name}】
										<br>跟进内容为:${customerTrack.trackContent }
										<br>沟通结果:${customerTrack.result }
										<br>反馈问题:${customerTrack.feedBackResult }
									<td>
								</tr>
						</c:forEach>
					</table>
			</c:if>
		</table>
			</div>
 	</div>
 </div>
 <div class="orderItem" id="spxx" style="overflow: auto;padding-bottom: 12px;">
	<div class="titles" align="left">
		成交结果
	</div>
	<div class="line"></div>
	<div class="content" >
   		<div class="titleOrPrice">
   			<h1 class="productTitle" style=""></h1>
   			<div class="det" align="left">
 				<table cellpadding="0" cellspacing="0" width="100%" border="0" style="color:#8a8a8a">
					<tr>
						<td id="" >客户状态：
							<c:if test="${customer.lastResult==0 }">
								<span style="color:maroon;">创建</span>
							</c:if>
							<c:if test="${customer.lastResult==1 }">
								<span style="color: green;">提报订单</span>
							</c:if>
							<c:if test="${customer.lastResult==2 }">
								<span style="color: red;">流失</span>
							</c:if>
					    </td>
					</tr>
					<tr>
						<td id="" >订单状态：
						<c:if test="${empty(orderContract) }">
								<span style="color: red;">未提报订单</span>
							</c:if>
							<c:if test="${customer.orderContractStatus==1 }">
								<span style="color: green;">已创建订单</span>
							</c:if>
					    </td>
					</tr>
					<tr>
						<td id="" >档案状态：
							<c:if test="${empty(customerPidBookingRecord) }">
								<span style="color: red;">未提报档案</span>
							</c:if>
							<c:if test="${customerPidBookingRecord.pidStatus==1 }">
								<span style="color: red;">待提报档案</span>
							</c:if>
							<c:if test="${customerPidBookingRecord.pidStatus==2 }">
								<span style="color: green;">已提报档案(客户成交)</span>
							</c:if>
					</tr>
					<c:if test="${customer.lastResult==1 }">
						<tr>
							<td id="" >成交车型：
								${customer.customerBussi.brand.name}&#12288;
								<c:set value="${customer.customerBussi.carSeriy.name}${ customer.customerBussi.carModel.name }" var="carModel"></c:set>
								<c:if test="${fn:length(carModel)>16 }" var="status">
									${fn:substring(carModel,0,16) }...
								</c:if>
								<c:if test="${ status==false}">
									${carModel} ${customer.carModelStr}
								</c:if>
						    </td>
						</tr>	
					</c:if>		
					<c:if test="${customer.lastResult>1 }">
						<tr>
							<td id="" >
								客户流失审批状态：
								<c:if test="${customer.lastResult>1 }">
									<c:if test="${customer.customerLastBussi.approvalStatus==0 }">
										<span style="color: #DD9A4B;;">等待审批...</span>
									</c:if>
									<c:if test="${customer.customerLastBussi.approvalStatus==1 }">
										<span style="color: red;">客户流失</span>
									</c:if>
								</c:if>
						    </td>
						</tr>
						<tr>
							<td id="" >
								流失原因：
									${customer.customerLastBussi.customerFlowReason.name }
						    </td>
						</tr>
					</c:if>
			</table>
 				</div>
 			</div>
 	</div>
 </div>
</c:if>
</div>
</body>
<script type="text/javascript">
function deleteBy(url){
	var cs=confirm("确定删除推荐客户吗？");
	if(cs==true){
		$.post(url,{},function(data){
			data=$.parseJSON(data);
			if(data[0].mark==1){
				//错误
				alert("删除推荐客户失败!");
				return ;
			}else if(data[0].mark==0){
				$('#toast').show();
	            setTimeout(function () {
	                $('#toast').hide();
	            	window.location.href = data[0].url;
	            }, 2000);
			}
		})
	}
	
}
</script>
</html>