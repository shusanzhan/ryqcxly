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
<title>我的提成</title>
</head>
<body>
<div class="order" style="">
	<div class="head">
		<div class="headImage">
				<div class="centerImg">
					<c:if test="${empty(weixinGzuserinfo) }" >
						<img src="${ctx }/img/weixin/head_05.png" width="57" height="57"/>
					</c:if>
					<c:if test="${!empty(weixinGzuserinfo) }" >
						<img src="${weixinGzuserinfo.headimgurl }" width="57" height="57"/>
					</c:if>
				</div>
		      	<div class="centerInfo">
			      	<div class="customName">${member.name}</div>
			      	<div class="receiverManage">
			      		账号：${member.mobilePhone }
			      	</div>
		    	</div>
		</div>
	</div>
	<div class="nav">
		<ul>
              <li style="width: 50%">
                  <a href="javascript:void(-1)">
                       <p >本月收益</p>
                      <p style="font-size: 14px;font-weight: bold;">
                      	<c:if test="${empty(totalMoney) }">
                      		0.0
                      	</c:if>
                      	<c:if test="${!empty(totalMoney) }">
                      		${totalMoney }.0
                      	</c:if>
                      </p>
                  </a>
              </li>
              <li style="width: 50%">
                  <a href="javascript:void(-1)">
                      <p >总收益</p>
                      <p style="font-size: 14px;font-weight: bold;">
                      	<c:if test="${empty(agent.turnBackMoney) }">
                      		0.0
                      	</c:if>
                      	<c:if test="${!empty(agent.turnBackMoney) }">
                      		${agent.turnBackMoney }
                      	</c:if>
                      </p>
                  </a>
              </li>
         </ul>
	</div>
</div>
<div class="header" style="margin-bottom: 1px;">
 	<h1 class="h1">我的客户</h1>
 	<hr class="hr" style="border-color: -moz-use-text-color -moz-use-text-color #eb6877;">
 </div>
<ul class="list-group">
	  <li onclick="window.location.href='${ctx}/agentWechat/recommendCustomer?type=0'" class="list-group-item">
	  		<span style="float: right;">
	  			<img src="${ctx}/css/wechat/img/arrowLeft.png" alt="">
	  		</span>
	    		提供线索
	    	<span id="badgeSelf" class="badge" style="color: #f00;">
		    	${member.agentNum }
	    	</span>
	  </li>
	  <li onclick="window.location.href='${ctx}/agentWechat/recommendCustomer?type=3'"  class="list-group-item">
	  		<span style="float: right;">
	  			<img src="${ctx}/css/wechat/img/arrowLeft.png" alt="">
	  		</span>
	    		成交单数
	    	<span id="badgeSelf" class="badge" style="color: #f00;">
		    		${member.agentSuccessNum }
	    	</span>
	  </li>
	  <li onclick=""  class="list-group-item">
	  		<span style="float: right;">
	  			<img src="${ctx}/css/wechat/img/arrowLeft.png" alt="">
	  		</span>
	    		当前排名
	    	<span id="badgeSelf" class="badge" style="color: #f00;">
		    	${curentSn }
	    	</span>
	  </li>
	  <li onclick="" class="list-group-item">
	    		转化率
	    	<span id="badgeSelf" class="badge" style="color: #f00;">
	    		<c:if test="${agent.agentNum==0||empty(agent.agentNum) }" var="status">
	    			0.0
	    		</c:if>
	    		<c:if test="${status==false }">
		    		<fmt:parseNumber value="${agent.agentSuccessNum/agent.agentNum }" pattern="0.##"></fmt:parseNumber>
	    		</c:if>
	    	</span>
	  </li>
</ul>
<div class="header" style="margin-bottom: 1px;">
 	<h1 class="h1">收益明细</h1>
 	<hr class="hr" style="border-color: -moz-use-text-color -moz-use-text-color #eb6877;">
 </div>
 <c:if test="${empty(fanlis)||fn:length(fanlis)<=0 }" var="status">
 	无收益记录
 </c:if>
 <c:if test="${status==false }">
 	<table class="table_record" style="margin-top: 2px;" cellpadding="0" cellspacing="0">
		<thead>
		<tr>
			<td style="width:50%;text-align: center;">收益说明</td>
			<td style="width:30%;text-align: center;">日期 </td>
			<td style="width:20%;text-align: center;">金额 </td>
		</tr>
		</thead>
		<tbody>
			<c:forEach items="${fanlis}" var="fanli">
				<tr>
					<td>${fanli.rewardFrom }</td>
					<td align="center">
						<fmt:formatDate value="${fanli.createTime }" pattern="yyyy-MM-dd"/> 
					 </td>
					<td align="center">
						<span style="color: #f00;font-size: 14px;">${fanli.rewardMoney }</span>
					 </td>
				</tr>
			</c:forEach>
		</tbody>
	</table>
 </c:if>
<br>
<br>
<jsp:include page="tabbar.jsp"></jsp:include>
</body>
</html>