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
<title>展厅管理</title>
</head>
<body>
<div class="views content_title">
    <span id="page_title">展厅管理</span>
</div>
	<div class="mycenterMian" style="">
	  	 <article>
                <div class="mycenterTow">
                    <ul>
                    	<li>
                            <a href="${ctx }/qywxCustomerTrack/customerTrackRecord">
                               <img src="${ctx }/images/todayTrack.png">
                                <p>回访记录查阅</p>
                            </a>
                        </li>
                    	<li>
                            <a href="${ctx }/qywxCustomerTrack/tommorrowNeedTrackCustomer">
                                <img src="${ctx }/images/nextDay.jpg">	
                                <p>需次日跟踪客户</p>
                            </a>
                        </li>
                         <li>
                            <a href="${ctx }/qywxCustomerTrack/needTrackCustomer">
                                <img src="${ctx }/images/threeday.jpg">
                                <p>待回访客户</p>
                            </a>
                        </li>
                         <li>
                            <a href="${ctx }/qywxCustomer/leaderList">
                                <img src="${ctx }/images/myInfo.png">
                                <p>登记客户</p>
                            </a>
                        </li>
                         <li>
                            <a href="${ctx}/qywxCustomer/queryLeaderOutFlow">
                                <img src="${ctx }/images/kecheng.png">
                                <p>流失客户</p>
                            </a>
                        </li>
                             <li>
                            <a href="${ctx }/qywxCustomer/queryLeaderOrderCustomer">
                                <img src="${ctx }/images/myPoint.png">
                                <p>订单客户</p>
                            </a>
                        </li>
                        <li>
                            <a href="${ctx }/qywxCustomer/queryLeaderSuccessCustomer">
                                <img src="${ctx }/images/add.png">
                                <p>成交客户</p>
                            </a>
                        </li>
                           <li>
				        <a href="${ctx }/qywxCustomerTrack/queryCompList">
				           <img src="${ctx }/images/weixin/kc.jpg">
					           <p>回访记录</p>
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