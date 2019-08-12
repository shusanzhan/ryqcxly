
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
    <meta name="apple-mobile-web-app-status-bar-style" content="black-translucent" />
   	<link rel="stylesheet" href="${ctx }/weui-master/css/weui.css"/>
    <link rel="stylesheet" href="${ctx }/weui-master/css/weuix.css"/>
<title>客户综合管理</title>
<style type="text/css">
	.header{
		background: #18b4ed;height: 40px;line-height: 40px;font-size: 14px;color: #FFF;text-align: center;
	}
</style>
</head>
<body>
<div class="header">
	客户综合管理
</div>
<div class="page-bd">
	<div class="weui-cells__title">线索统计</div>
	<div class="weui-cells">
        <a class="weui-cell weui-cell_access" href="${ctx }/qywxCustomerRecord/queryLeaderList">
            <div class="weui-cell__bd">
               <p>登记线索</p>
            </div>
            <div class="weui-cell__ft f11">
            </div>
        </a>
        <a class="weui-cell weui-cell_access" href="${ctx }/qywxCustomerRecord/queryLeaderEffList">
            <div class="weui-cell__bd">
                <p>有效线索</p>
            </div>
            <div class="weui-cell__ft f11">
            </div>
        </a>
    </div>
	<div class="weui-cells__title">跟踪回访管理</div>
	<div class="weui-cells">
        <a class="weui-cell weui-cell_access" href="${ctx }/qywxCustomerTrack/needTrackCustomer">
            <div class="weui-cell__bd">
                <p>今日需回访客户</p>
            </div>
            <div class="weui-cell__ft f11">
            </div>
        </a>
        <a class="weui-cell weui-cell_access" href="${ctx }/qywxCustomerTrack/tommorrowNeedTrackCustomer">
            <div class="weui-cell__bd">
                <p>次日需回访客户</p>
            </div>
            <div class="weui-cell__ft f11">
            </div>
        </a>
        <a class="weui-cell weui-cell_access" href="${ctx }/qywxCustomerTrack/customerTrackRecord">
            <div class="weui-cell__bd">
                <p>回访记录批阅</p>
            </div>
            <div class="weui-cell__ft f11">
            </div>
        </a>
     </div>
    <div class="weui-cells__title">客户管理</div>
	<div class="weui-cells">
        <a class="weui-cell weui-cell_access" href="${ctx }/qywxCustomer/leaderList">
            <div class="weui-cell__bd">
                <p>登记客户</p>
            </div>
        </a>
        <a class="weui-cell weui-cell_access" href="${ctx }/qywxCustomerTrack/queryCompList">
            <div class="weui-cell__bd">
                <p>跟踪记录</p>
            </div>
            <div class="weui-cell__ft f11">
            </div>
        </a>
        <a class="weui-cell weui-cell_access" href="${ctx}/qywxCustomer/queryLeaderOutFlow">
            <div class="weui-cell__bd">
                <p>流失客户</p>
            </div>
            <div class="weui-cell__ft f11">
            </div>
        </a>
        <a class="weui-cell weui-cell_access" href="${ctx }/qywxCustomer/queryLeaderOrderCustomer">
            <div class="weui-cell__bd">
                <p>订单客户</p>
            </div>
            <div class="weui-cell__ft f11">
            </div>
        </a>
        <a class="weui-cell weui-cell_access" href="${ctx }/qywxCustomer/queryLeaderSuccessCustomer">
            <div class="weui-cell__bd">
                <p>成交客户</p>
            </div>
            <div class="weui-cell__ft f11">
            	
            </div>
        </a>
    </div>
</div>
</body>
 <script src="${ctx }/weui-master/js/zepto.min.js"></script>
 <script src="${ctx }/weui-master/js/swipe.js"></script>
 <script src="${ctx }/weui-master/js/zepto.weui.min.js"></script>
</html>