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
    <link rel="stylesheet" href="${ctx }/css/wechat/comm.css?" type="text/css" />
    <meta name="apple-mobile-web-app-status-bar-style" content="black-translucent" />
    <link rel="stylesheet" href="${ctx }/pages/wechat/WeUI/style/weui.css?${now}" type="text/css" />
	<script src="${ctx }/pages/wechat/WeUI/example/zepto.min.js"></script>
    <script src="${ctx }/pages/wechat/WeUI/example/router.min.js"></script>
    <style type="text/css">
    </style>
<title>${recommendCustomer.name }我的推荐</title>
</head>
<body>
<div class="title">
    <a class="btn-back" onclick="window.history.go(-1)" href="javascript:void(0)"><i class="icon icon-2-1"></i></a>
    <h3>${recommendCustomer.name }我的推荐</h3>
</div>
<br>
<br>
<br>
<div id="detail_nav">
    <div class="detail_nav_inner" style="margin: 0;padding: 0;box-sizing: border-box;width: 100%;overflow: hidden;">
        <ul class="clearfix padding10">
          <c:if test="${param.type==0 }" var="status">
	          <li class="detail_tap4 detail_tap pull_left select" id="imgs_tap" onclick="window.location.href='${ctx}/agentWechat/recommendCustomer?type=0'">全部</li>
          </c:if>
          <c:if test="${status==false }">
	          <li class="detail_tap4 detail_tap pull_left" id="imgs_tap" onclick="window.location.href='${ctx}/agentWechat/recommendCustomer?type=0'">全部</li>
          </c:if>
           <c:if test="${param.type==1 }" var="status">
          		<li class="detail_tap4 detail_tap pull_left select" id="pingjia_tap" onclick="window.location.href='${ctx}/agentWechat/recommendCustomer?type=1'">交易中...</li>
          </c:if>
           <c:if test="${status==false }">
	          	<li class="detail_tap4 detail_tap pull_left" id="pingjia_tap" onclick="window.location.href='${ctx}/agentWechat/recommendCustomer?type=1'">交易中...</li>
           </c:if>
           <c:if test="${param.type==2 }" var="status">
          	<li class="detail_tap4 detail_tap pull_left select" id="pingjia_tap" onclick="window.location.href='${ctx}/agentWechat/recommendCustomer?type=2'">交易成功</li>
          </c:if>
          <c:if test="${status==false }">
	          	<li class="detail_tap4 detail_tap pull_left" id="pingjia_tap" onclick="window.location.href='${ctx}/agentWechat/recommendCustomer?type=2'">交易成功</li>
           </c:if>
           <c:if test="${param.type==3 }" var="status">
          		<li class="detail_tap4 detail_tap pull_left select" id="pingjia_tap" onclick="window.location.href='${ctx}/agentWechat/recommendCustomer?type=3'">交易失败</li>
          </c:if>
           <c:if test="${status==false }">
          		<li class="detail_tap4 detail_tap pull_left" id="pingjia_tap" onclick="window.location.href='${ctx}/agentWechat/recommendCustomer?type=3'">交易失败</li>
           </c:if>
     	</ul>
    </div>
</div>
 <div class="center_mian" style="width:96%;margin: 0px auto;margin-top:14px;;text-align: center;">
 <c:if test="${empty(recommendCustomers) }">
		<div class="titles" align="center">
			<c:if test="${param.type==0||param.type==1  }">
				无交易中客户
			</c:if>
			<c:if test="${param.type==3  }">
				无交易失败客户
			</c:if>
			<c:if test="${param.type==2  }">
				无交易成功客户
			</c:if>
		</div>
 </c:if>
 <c:if test="${!empty(recommendCustomers) }">
	<c:if test="${param.type==0||param.type==1  }">
	 	<div class="alert alert-danger" style="height: 20px;line-height: 20px;">
			<i class="weui_icon_waiting_circle" style="float: left;"></i>
			<span style="margin-top: 5px;"><span style="float: left;">如果客户已分配，需要更改请拨打:</span><a href="tel:${enterprise.phone }" style="float: left;">${enterprise.phone }</a></span>
		</div>
	</c:if>
 </c:if>
 <c:forEach var="recommendCustomer" items="${recommendCustomers }">
	<div class="orderItem" id="spxx" style="overflow: auto;padding-bottom: 12px;">
 			<div class="titles" align="left">
  			客户姓名：${recommendCustomer.name}<br/>
  			推荐时间：<fmt:formatDate value="${recommendCustomer.createDate}" pattern="yyyy-MM-dd"/>
 			</div>
 			<div class="line"></div>
 			<c:set var="sum" value="0"/>
			<div class="content" onclick="window.location.href='${ctx}/agentWechat/recommendCustomerDetial?recommendCustomerDbid=${recommendCustomer.dbid }'">
		    		<div class="img" style="width: 120px;">
			    		<img alt="" src="${recommendCustomer.carSeriy.picture }" width="100%" height="100%" >
		    		</div>
		    		<div class="titleOrPrice">
		    			<h1 class="productTitle" style="">${recommendCustomer.carSeriy.brand.name}${recommendCustomer.carSeriy.name}</h1>
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
		    <c:if test="${recommendCustomer.approvalStatus==1 }">
		    <div class="line"></div> 
		    <div class="operateBut" style="">
					<div class="cannerOrder">
						<a href="javascript:void(-1)" onclick="deleteBy('${ctx}/recommendCustomerWechat/delete?dbid=${recommendCustomer.dbid }')">删除</a>
					</div>
					<div class="toPay">
							<a href="javascript:void(-1)" onclick="window.location.href='${ctx}/recommendCustomerWechat/editRecom?dbid=${recommendCustomer.dbid }'">修改</a>
					</div> 
					<div class="clear"></div>
				</div>
			</c:if>
			<c:if test="${ fn:length(order.orderProducts)>1 }" var="statu">
				<c:if test="${i.index<(fn:length(order.orderProducts)-1) }" var="productStatus">
					<div class="line"></div> 
				</c:if>
			</c:if>
 	</div>
 </c:forEach>
</div>
<br>
<br>
 <div id="toast" style="display: none;">
	    <div class="weui_mask_transparent"></div>
	    <div class="weui_toast">
	        <i class="weui_icon_toast"></i>
	        <p class="weui_toast_content">删除数据成功</p>
	    </div>
	</div>
<br>
<br>
<jsp:include page="tabbar.jsp"></jsp:include>
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