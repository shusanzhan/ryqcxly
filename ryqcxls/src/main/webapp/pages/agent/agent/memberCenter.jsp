<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../../commons/taglib.jsp" %>
<!doctype html>
<html  lang="en">
<head>
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
<!-- Mobile Devices Support @end -->
<link rel="stylesheet" href="${ctx }/css/wechat/comm.css?${now}" type="text/css" />
<script src="${ctx }/widgets/bootstrap3/jquery.min.js?${now}"></script>
<title>会员中心</title>
</head>
<body class="blue">
<div class="order">
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
			      		<img alt="" src="${member.memberShipLevel.headerImage }" width="30"> 
			      		<c:forEach var="item" items="${hasMap }">
			      			<c:set value="${item.value }" var="cardOrder"></c:set>
			      			<img alt="" src="${cardOrder.courseCard.headerImage }" width="30"> 
			      		</c:forEach>
			      	</div>
		    	</div>
		</div>
	</div>
	<div class="nav">
		<div class="menu">
			 <a href="javascript:void(-1)" onclick="window.location.href='${ctx}/memberPayment/member?menu=5'" class="center_head_menu_p">等待付款<span style="margin-left: 4px;color: red;">${waitingCount } </span></a>
		</div>
		<div class="menu">
	      <a href="javascript:void(-1)" onclick="window.location.href='${ctx}/memberPayment/waitReceipt?menu=5'" class="center_head_menu_p">待&nbsp;收&nbsp;货<span style="margin-left: 4px;color: red;">${waitReceiptCount } </span></a>
		</div>
		<div class="menu">
	      <a href="javascript:void(-1)" onclick="window.location.href='${ctx}/memberPayment/endOrder?menu=5'" class="center_head_menu_p">已&nbsp;收&nbsp;货<span style="margin-left: 4px;color: red;">${endCount } </span></a> 
		</div>
	</div>
</div>
<div class="mycenterMian" style="">
	  	 <article>
                <div class="mycenter">
                    <ul>
                        <li>
                            <a href="${ctx }/wechatMember/memberInfo?wechat_id=${param.wechat_id}">
                                <img src="${ctx }/img/weixin/myInfo.png">
                                <p>我的资料</p>
                            </a>
                        </li>
                        <li>
                            <a href="${ctx }/wechatMember/myPoint?wechat_id=${param.wechat_id}">
                                <img src="${ctx }/img/weixin/myPoint.png">
                                <p>我的积分</p>
                            </a>
                        </li>
                        <li>
                            <a href="${ctx }/memberPayment/member?menu=5">
                                <img src="${ctx }/img/weixin/myOrder.png">
                                <p>我的订单</p>
                            </a>
                        </li>
                        <li>
                            <a href="${ctx}/courseApplicationRecordWeixin/myCourseCard?wechat_id=${param.wechat_id}">
                                <img src="${ctx }/img/weixin/kecheng.png">
                                <p>预约报名</p>
                            </a>
                        </li>
                        <li>
                            <a href="${ctx }/receiver/queryList?wechat_id=${param.wechat_id}&menu=5">
                                <img src="${ctx }/img/weixin/memberAddress.png">
                                <p>收货地址</p>
                            </a>
                        </li>
                        <li>
                            <a href="${ctx}/wechatMember/memberExplain">
                                <img src="${ctx }/img/weixin/memberDis.png">
                                <p>会员说明</p>
                            </a>
                        </li>
                        <li>
                            <a href="${ctx}/wechatMember/aboutUs">
                                <img src="${ctx }/img/weixin/lianxi.png">
                                <p>关于我们</p>
                            </a>
                        </li>
                        <li>
                            <a href="${ctx}/wechatFanli/index?wechat_id=${param.wechat_id}&menu=5">
                                <img src="${ctx }/img/weixin/fanli.png">
                                <p>我的收益</p>
                            </a>
                        </li>
                        <li>
                            <a href="${ctx }/wechatCourse/courseIndex?wechat_id=${param.wechat_id}&menu=5">
                                <img src="${ctx }/images/weixin/djc.jpg">
                                <p>学员状态</p>
                            </a>
                        </li>
                        <li>
                            <a href="${ctx }/wechatRechargePoint/rechargePoint?wechat_id=${param.wechat_id}&menu=5">
                                <img src="${ctx }/img/weixin/point.png">
                                <p>积分充值</p>
                            </a>
                        </li>
                        <li>
                            <a href="${ctx }/wechatSpreadDetail/spreadDetail?sceneStr=${spreadDetail.sceneStr}&menu=5">
                                <img src="${ctx }/img/weixin/gco.png">
                                <p>推广二维码</p>
                            </a>
                        </li>
                        <li>
                            <a href="${ctx }/wechatCourseStudent/courseStudentList?wechat_id=${param.wechat_id}&menu=5">
                                <img src="${ctx }/img/weixin/student.png">
                                <p>学员管理</p>
                            </a>
                        </li>
                    </ul>
                </div>
            </article>
	</div>
<jsp:include page="${ctx }/pages/wechat/home/bottom.jsp"></jsp:include>
</body>
</html>