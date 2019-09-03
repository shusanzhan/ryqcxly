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
<c:if test="${recommendCustomer.approvalStatus!=3 }">
<div id="detail_nav">
    <div class="detail_nav_inner" style="margin: 0;padding: 0;box-sizing: border-box;width: 100%;overflow: hidden;">
        <ul class="clearfix padding10">
		         <li class="detail_tap2 detail_tap pull_left select" id="imgs_tap" onclick="window.location.href='${ctx}/agentWechat/recommendCustomerDetial?recommendCustomerDbid=${recommendCustomer.dbid }'">推荐客户</li>
	          	 <li class="detail_tap2 detail_tap pull_left " id="pingjia_tap" onclick="window.location.href='${ctx}/agentWechat/customerDetial?recommendCustomerDbid=${recommendCustomer.dbid }'">客户记录</li>
     	</ul>
    </div>
</div>
</c:if>
 <div class="center_mian" style="width:96%;margin: 0px auto;margin-top:14px;;text-align: center;">
 <c:if test="${empty(recommendCustomers) }">
		<div class="titles" align="center">
			<c:if test="${param.type==0||param.type==1  }">
				无交易中客户
			</c:if>
			<c:if test="${param.type==2  }">
				无交易成功客户
			</c:if>
			<c:if test="${param.type==3  }">
				无交易失败客户
			</c:if>
		</div>
 </c:if>
	<div class="orderItem" id="spxx" style="overflow: auto;padding-bottom: 12px;">
 			<div class="titles" align="left">
  			客户姓名：${recommendCustomer.name}<br/>
  			电话：<a href="tel:${recommendCustomer.mobilePhone }" style="display:inline;">${recommendCustomer.mobilePhone }</a><br>
  			推荐时间：<fmt:formatDate value="${recommendCustomer.createDate}" pattern="yyyy-MM-dd"/><br>
  			车型：${recommendCustomer.carSeriy.brand.name}${recommendCustomer.carSeriy.name}
 			</div>
 			<div class="line"></div>
 			<c:set var="sum" value="0"/>
			<div class="content" >
		    		<div class="titleOrPrice">
		    			<h1 class="productTitle" style=""></h1>
		    			<div class="det" align="left">
		  					指价格:<span class="price">${recommendCustomer.carSeriy.priceFrom }万元</span><br/>
		  					审核状态:
		  						<c:if test="${recommendCustomer.approvalStatus==1 }">
		  						<span class="price">	待审批...</span>
		  						</c:if>
		  						<c:if test="${recommendCustomer.approvalStatus==2 }">
		  							<span class="price" style="color: green">已审批</span>
		  						</c:if>
		  						<c:if test="${recommendCustomer.approvalStatus==3 }">
		  							<span class="price" style="color: red">客户无效</span>
		  						</c:if>
		  					<br/>
		  					分配状态：
							<c:if test="${recommendCustomer.distStatus==1}">
								<span class="price">待分配</span>
							</c:if>
							<c:if test="${recommendCustomer.distStatus==2}">
								<span class="price" style="color:green;">已分配</span>
							</c:if>
							<br>
		  						交易状态:<span class="price">
		  						<c:if test="${recommendCustomer.tradeStatus==1 }">
		  							交易中...
		  						</c:if>
		  						<c:if test="${recommendCustomer.tradeStatus==3 }">
		  							交易失败
		  						</c:if>
		  						<c:if test="${recommendCustomer.tradeStatus==2 }">
		  							交易成功
		  						</c:if>
		  						</span>
		  					
			  			</div>
		    		</div>
		    		<div style="clear: both;"></div>
		    </div>
 	</div>
 	<c:if test="${recommendCustomer.approvalStatus==3 }">
	 <div class="orderItem" id="spxx" style="overflow: auto;padding-bottom: 12px;">
		<div class="titles" align="left">
			无效原因
		</div>
		<div class="line"></div>
		<div class="content" >
		   		<div class="titleOrPrice">
		   			<h1 class="productTitle" style=""></h1>
		   			<div class="det" align="left">
		 				<table>
						<tr>
							<td colspan="2">原因：
									${recommendCustomer.flowReason.name }
									&#12288;</td>
						</tr>
						<tr>
							<td colspan="2">
								备注：${recommendCustomer.flowNote }
							</td>
						</tr>
					</table>
				</div>
			</div>
		</div>
	</div>
	</c:if>
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
					<td colspan="2">地址：
							${recommendCustomer.province }
							${recommendCustomer.city }
							${recommendCustomer.areaStr }&#12288;</td>
				</tr>
				<tr >
					<td colspan="2">推荐人：${recommendCustomer.agentName }
					</td>
				</tr>
				<tr>
					<td colspan="2">荐人电话：${recommendCustomer.agentPhone }
					</td>				
				</tr>
				<tr>
					<td colspan="2">销售顾问：${recommendCustomer.saler.realName }
					</td>				
				</tr>
				<c:if test="${recommendCustomer.approvalStatus==2 }">
					<tr>
						<td class="formTableTdLeft" >审批人：
							${recommendCustomer.approvalUser}
						</td>
					</tr>
					<tr>
						<td>审批时间：
							${recommendCustomer.approvalDate}
						</td>
					</tr>
				</c:if>
				<c:if test="${recommendCustomer.distStatus==2}">
					<tr>
						<td class="formTableTdLeft" >分配操作人：
							${recommendCustomer.distUser}
						</td>
					</tr>
					<tr>
						<td>分配时间：
							${recommendCustomer.distDate}
						</td>
					</tr>
				</c:if>
			</table>
 				</div>
 			</div>
 	</div>
 </div>
 <div class="orderItem" id="spxx" style="overflow: auto;padding-bottom: 12px;">
	<div class="titles" align="left">
		推荐人信息
	</div>
	<div class="line"></div>
	<div class="content" >
   		<div class="titleOrPrice">
   			<h1 class="productTitle" style=""></h1>
   			<div class="det" align="left">
 				<table>
				<tr>
					<td>姓名：
						${member.name }
						(
							<c:if test="${member.sex=='男' }">
								<span style="color: #56a845">${member.sex }</span>
							</c:if>
							<c:if test="${member.sex=='女' }">
								<span style="color: #ff6700">${member.sex }</span>
							</c:if>
						)
					</td>
				</tr>
				<tr>
					<td> 联系电话：
						${member.mobilePhone }
					</td>
				</tr>
				<tr>
					<td>推荐客户：
						<span style="color: red;font-size: 16px;">${member.agentNum }</span>
					</td>
				</tr>
				<tr>
					<td >推荐成功客户：
						<span style="color: green;font-size: 16px;">${member.agentSuccessNum }</span>
					</td>
				</tr>
				<tr>
						<td >所在区域：
							${agent.province }
							${agent.city }
							${agent.areaStr }
						</td>
				</tr>
					<tr>
						<td >支付类型：
						<c:if test="${member.payType==1 }">
							微信支付
						</c:if>
						<c:if test="${member.payType==2 }">
							支付宝
						</c:if>
						</td>
					</tr>
					<tr>
						<td >账号：
								${member.accountNo }
						</td>
					</tr>
					<tr>
						<td >申请时间：
							${agent.applyDate }
						</td>
					</tr>
			</table>
 				</div>
 			</div>
 	</div>
 </div>
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