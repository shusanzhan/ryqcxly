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
<title>客户中心</title>
</head>
<body>
<div class="views content_title">
    <span id="page_title">客户中心</span>
</div>
	<div class="mycenterMian" style="">
	  	 <article>
                <div class="mycenterTow">
                    <ul>
                    	<li>
                            <a href="${ctx }/qywxCustomerRecord/salerEdit">
                                <img src="${ctx }/images/weixin/djc.jpg">
                                <p>创建线索</p>
                            </a>
                        </li>
                    	<li>
                            <a href="${ctx }/qywxCustomerRecord/querySalerList">
                                <img src="${ctx }/images/memberDis.png">
                                <p>我的线索</p>
                            </a>
                        </li>
                    	<li>
                            <a href="${ctx }/qywxCustomer/list">
                                <img src="${ctx }/images/myInfo.png">
                                <p>登记客户</p>
                            </a>
                        </li>
                         <li>
                            <a href="${ctx}/qywxCustomer/queryOutFlow">
                                <img src="${ctx }/images/kecheng.png">
                                <p>流失客户</p>
                            </a>
                        </li>
                        <li>
                            <a href="${ctx }/qywxCustomer/orderCustomer">
                                <img src="${ctx }/images/myPoint.png">
                                <p>订单客户</p>
                            </a>
                        </li>
                        <li>
                            <a href="${ctx }/qywxCustomer/waitingHandCar">
                                <img src="${ctx }/images/myOrder.png">
                                <p>待交车客户</p>
                            </a>
                        </li>
                        <li>
                            <a href="${ctx }/qywxCustomer/successCustomer">
                                <img src="${ctx }/images/add.png">
                                <p>成交客户</p>
                            </a>
                        </li>
                        <li>
                            <a href="${ctx }/qywxCustomerImage/uploadImageWaitingCustomer">
                                <img src="${ctx }/images/uploadImgage.jpg">
                                <p>上传照片</p>
                            </a>
                        </li>
                         <li>
				        <a href="${ctx }/qywxVisitRecord/list">
				           <img src="${ctx }/images/weixin/kc.jpg">
					           <p>回访记录</p>
					       </a>
					   </li>
                        <li>
				        	<a href="${ctx }/qywxProcessRun/queryList">
				           <img src="${ctx }/images/weixin/hfkf.jpg">
					           <p>我的申请</p>
					       </a>
					   </li>
	                       <li>
					       	 <a href="${ctx }/qywxCustomer/queryInvitationList">
					           <img src="${ctx }/images/weixin/lqyhq.png">
						           <p>我的邀约</p>
						       </a>
						   </li>
                        <li>
				        	<a href="${ctx }/qywxCustomer/queryReceptierList">
				           <img src="${ctx }/images/weixin/myYY.png">
					           <p>我的谈判</p>
					       </a>
				   		</li>
                        <li>
				        	<a href="${ctx }/qywxCustomerTrack/salerTodayTrack">
				        		<div >
				        			<div id="divtips">${todayNum}</div>
						          	<img src="${ctx }/images/todayTrack.png">
				        		</div>
					          <p>今天需回访客户</p>
					       </a>
					   </li>
                        <li>
				        	<a href="${ctx }/qywxCustomerTrack/salerTommorrowTrack">
				        		<div >
				        			<div id="divtips">${tomNum }</div>
				           		 	<img src="${ctx }/images/nextDay.jpg">	
				        		</div>
					            <p>明日需要回访客户</p>
					       </a>
					   </li>
                        <li>
				        	<a href="${ctx }/qywxCustomerTrack/salerThreeDayTrack">
				        		<div >
				        			<div id="divtips">${threeDayNum }</div>
					           		<img src="${ctx }/images/threeday.jpg">
				        		</div>
					           <p>未来三天需回访客户</p>
					       </a>
					   </li>
                    </ul>
                </div>
            </article>
	</div>
	</body>
<script src="${ctx }/widgets/bootstrap3/jquery.min.js"></script>
<script src="${ctx }/widgets/bootstrap3/js/bootstrap.min.js"></script>
</html>