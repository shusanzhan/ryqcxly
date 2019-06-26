<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../../commons/taglib.jsp" %>
<!doctype html>
<html  lang="en">
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
    <meta name="apple-mobile-web-app-status-bar-style" content="black-translucent" />
    <link rel="stylesheet" href="${ctx }/css/wechat/comm.css?" type="text/css" />
    <link rel="stylesheet" href="${ctx }/pages/wechat/WeUI/style/weui.css?${now}" type="text/css" />
	<script src="${ctx }/pages/wechat/WeUI/example/zepto.min.js"></script>
    <script src="${ctx }/pages/wechat/WeUI/example/router.min.js"></script>
    <style type="text/css">
    	
   	</style>
<title>瑞一经纪人</title>
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
              <li>
                  <a href="${ctx }/agentWechat/recommendCustomer?type=0">
                       <p >推荐客户</p>
                      <p style="font-size: 14px;font-weight: bold;">${member.agentNum }</p>
                  </a>
              </li>
              <li>
                  <a href="${ctx }/agentWechat/myMoney">
                      <p >我的提成</p>
                      <p style="font-size: 14px;font-weight: bold;">
                      	<c:if test="${empty(member.agentMoney) }">
                      		0.0
                      	</c:if>
                      	<c:if test="${!empty(member.agentMoney) }">
                      		${member.agentMoney }
                      	</c:if>
                      </p>
                  </a>
              </li>
              <li>
                  <a href="${ctx }/agentWechat/myPoint">
                      <p>我的积分</p>
                      <p style="font-size: 14px;font-weight: bold;">
                      <c:if test="${empty(member.agentPointNum) }">
                      		0
                      	</c:if>
                      	<c:if test="${!empty(member.agentPointNum) }">
                      		${member.agentPointNum }
                      	</c:if>
                      
                      </p>
                  </a>
              </li>
         </ul>
	</div>
</div>
<br>
<div class="mycenterMian" >
	  	 <article>
               <div class="mycenter">
                    <ul>
                        <li>
                            <a href="${ctx }/agentWechat/info">
                                <img src="${ctx }/img/weixin/product_item27.png">
                                <p>我的资料</p>
                            </a>
                        </li>
                        <li>
                            <a href="${ctx }/agentWechat/myMoney">
                                 <img src="${ctx }/img/weixin/product_item17.png">
                                <p>我的提成</p>
                            </a>
                        </li>
                        <li>
                            <a href="${ctx }/agentWechat/recommendCustomer?type=0">
                                <img src="${ctx }/img/weixin/myagent.png">
                                <p>我的推荐</p>
                            </a>
                        </li>
                         <li>
                            <a href="${ctx}/agentWechat/myPoint">
                                <img src="${ctx }/img/weixin/mypoint.png">
                                <p>我的积分</p>
                            </a>
                        </li>
                        <%--  <li>
                            <a href="${ctx}/agentWechat/mySpreadDetail">
                                <img src="${ctx }/img/weixin/memberAddress.png">
                                <p>专属二维码</p>
                            </a>
                        </li> --%>
                         <li>
                            <a href="${ctx}/newsItemWechat/readNewsItem?dbid=17">
                                <img src="${ctx }/img/weixin/agentsc.png">
                                <p>推荐手册</p>
                            </a>
                        </li>
                        <c:if test="${!empty(member.spread) }">
	                         <li>
	                            <a href="${member.spread.policyStateMentUrl }">
	                                <img src="${ctx }/img/weixin/memberDis.png">
	                                <p>推荐政策</p>
	                            </a>
	                        </li>
                        </c:if>
                         <li>
                            <a href="${ctx}/newsItemWechat/readNewsItem?dbid=24">
                                <img src="${ctx }/img/weixin/contact.png">
                                <p>联系我们</p>
                            </a>
                        </li>
                        <li>
                            <a href="http://mp.weixin.qq.com/s/FSmUNvYDmLkeFr4vFHwuSg">
                                <img src="${ctx }/img/weixin/lianxi.png">
                                <p>关于我们</p>
                            </a>
                        </li>
                       
                      <!--     <li>
                            <a href="${ctx}/wechatMember/memberExplain">
                                <img src="${ctx }/img/weixin/memberDis.png">
                                <p>会员说明</p>
                            </a>
                        </li>
                        
                        <li>
                            <a href="${ctx}/wechatFanli/index?wechat_id=${param.wechat_id}&menu=5">
                                <img src="${ctx }/img/weixin/fanli.png">
                                <p>我的收益</p>
                            </a>
                        </li> -- -->
                    </ul>
                </div>
            </article>
	</div>
	<br>
	<br>
<br>
<br>
<jsp:include page="tabbar.jsp"></jsp:include>
	
</body>
</html>