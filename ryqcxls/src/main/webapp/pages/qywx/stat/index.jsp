
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
<title>统计分析</title>
<style type="text/css">
	.header{
		background: #18b4ed;height: 40px;line-height: 40px;font-size: 14px;color: #FFF;text-align: center;
	}
</style>
</head>
<body>
<div class="header">
	SCRM系统数据统计
</div>
<div class="page-bd">
	<div class="weui-cells__title">线索统计</div>
	<div class="weui-cells">
        <a class="weui-cell weui-cell_access" href="${ctx }/qywxStatCustomerRecord/queryReceptionStat">
            <div class="weui-cell__bd">
               <p>展厅流量统计</p>
            </div>
            <div class="weui-cell__ft f11">
            	到店留资率指标
            </div>
        </a>
        <a class="weui-cell weui-cell_access" href="${ctx }/qywxStatCustomerRecordNet/queryNetStaMonth">
            <div class="weui-cell__bd">
                <p>网销线索统计</p>
            </div>
            <div class="weui-cell__ft f11">
            	线索有效率指标
            </div>
        </a>
    </div>
	<div class="weui-cells__title">潜客分析</div>
	<div class="weui-cells">
        <a class="weui-cell weui-cell_access" href="${ctx }/qywxStatCustomerInvitation/queryInvitationList">
            <div class="weui-cell__bd">
                <p>网销邀约统计</p>
            </div>
            <div class="weui-cell__ft f11">
            	邀约到店率指标
            </div>
        </a>
        <a class="weui-cell weui-cell_access" href="${ctx }/qywxComeShop/queryComeShopList">
            <div class="weui-cell__bd">
                <p>客户到店统计</p>
            </div>
            <div class="weui-cell__ft f11">
            	客户到店率、到店成交率
            </div>
        </a>
        <a class="weui-cell weui-cell_access" href="${ctx }/qywxStaTryCar/queryTryCarList">
            <div class="weui-cell__bd">
                <p>试乘试驾统计</p>
            </div>
            <div class="weui-cell__ft f11">
            	试驾率、试驾成交率指标
            </div>
        </a>
        <a class="weui-cell weui-cell_access" href="${ctx}/qywxTwoComeShop/queryTwoComeShopList">
            <div class="weui-cell__bd">
                <p>二次到店统计</p>
            </div>
            <div class="weui-cell__ft f11">
            	二次到店率、二次到店成交率指标
            </div>
        </a>
        <a class="weui-cell weui-cell_access" href="${ctx }/qywxFlow/queryFlowList">
            <div class="weui-cell__bd">
                <p>流失客户</p>
            </div>
            <div class="weui-cell__ft f11">
            	客户流失率指标
            </div>
        </a>
        <a class="weui-cell weui-cell_access" href="${ctx }/qywxComplex/generalManager?type=1&role=gm">
            <div class="weui-cell__bd">
                <p>集客统计</p>
            </div>
            <div class="weui-cell__ft f11">
            	集客等级统计
            </div>
        </a>
        <a class="weui-cell weui-cell_access" href="${ctx }/qywxCustSuccess/custSuccess?type=1&role=gm">
            <div class="weui-cell__bd">
                <p>成交统计</p>
            </div>
            <div class="weui-cell__ft f11">
            	交车、归档
            </div>
        </a>
        <a class="weui-cell weui-cell_access" href="${ctx }/qywxCityCross/queryCityCrossCount">
            <div class="weui-cell__bd">
                <p>交叉客户</p>
            </div>
            <div class="weui-cell__ft f11">
            	
            </div>
        </a>
        <a class="weui-cell weui-cell_access" href="${ctx }/qywxCust/queryList">
            <div class="weui-cell__bd">
                <p>基盘统计</p>
            </div>
            <div class="weui-cell__ft f11">
            	客户等级分析
            </div>
        </a>
    </div>
    <div class="weui-cells__title">订单分析</div>
	<div class="weui-cells">
        <a class="weui-cell weui-cell_access" href="${ctx }/qywxOrder/queryOrderList">
            <div class="weui-cell__bd">
                <p>订单报表</p>
            </div>
            <div class="weui-cell__ft f11">
            	新增订单
            </div>
        </a>
        <a class="weui-cell weui-cell_access" href="${ctx }/qywxOrderStatic/order?type=1&role=gm">
            <div class="weui-cell__bd">
                <p>留存订单</p>
            </div>
            <div class="weui-cell__ft f11">
            	留存订单综合分析
            </div>
        </a>
        <a class="weui-cell weui-cell_access" href="${ctx }/qywxOrderStatic/noCar">
            <div class="weui-cell__bd">
                <p>无车订单</p>
            </div>
            <div class="weui-cell__ft f11">
            </div>
        </a>
    </div>
     <div class="weui-cells__title">回访统计</div>
	<div class="weui-cells">
        <a class="weui-cell weui-cell_access" href="${ctx }/qywxComprehensiveStatic/queryCustomerTrackCountList">
            <div class="weui-cell__bd">
                <p>回访超时统计</p>
            </div>
            <div class="weui-cell__ft f11">
            </div>
        </a>
        <a class="weui-cell weui-cell_access" href="${ctx }/qywxComprehensiveStatic/today?type=1&role=gm">
            <div class="weui-cell__bd">
                <p>每日回访监控</p>
            </div>
            <div class="weui-cell__ft f11">
            </div>
        </a>
        <a class="weui-cell weui-cell_access" href="${ctx }/qywxTrack/queryTrackList">
            <div class="weui-cell__bd">
                <p>回访统计</p>
            </div>
            <div class="weui-cell__ft f11">
            	回访超时率、回访频次指标
            </div>
        </a>
     </div>
</div>
</body>
 <script src="${ctx }/weui-master/js/zepto.min.js"></script>
 <script src="${ctx }/weui-master/js/swipe.js"></script>
 <script src="${ctx }/weui-master/js/zepto.weui.min.js"></script>
</html>