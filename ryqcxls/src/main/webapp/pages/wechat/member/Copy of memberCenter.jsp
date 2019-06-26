<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../../commons/taglib.jsp" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta name="viewport" content="width=device-width,height=device-height,inital-scale=1.0,maximum-scale=1.0,user-scalable=no;">
<meta name="format-detection" content="telephone=no">
<meta name="apple-mobile-web-app-capable" content="yes">
<meta name="apple-mobile-web-app-status-bar-style" content="black">
<link rel="stylesheet" type="text/css"  href="${ctx }/css/weixin.css"/>
<style type="text/css">

.center_head_menu {
    background-color: #000000;
    height: 45px;
    margin-top: -17px;
    opacity: 0.71;
    position: absolute;
    top: 120px;
    width: 100%;
}
.colom{
	width: 33%;
	text-align: center;
	border-right: 1px solid #FFF;
	margin-top: 5px;
	margin-bottom:5px;
	height: 35px;
	float: left;
	color: #FFF;
	cursor: pointer;
}
.colom div{
	widows: 100%;font-size: 14px;
}
.noneLine{
	border-right: 0px solid #FFF;
}
</style>
<title>会员中心</title>
</head>
<body>
<div class="centerHead">
    <div class="center_head_info"> 
      <img src="${ctx }/images/weixin//head_05.png">
      <div class="center_head_infos">
        <ul>
          <li>${member.name }</li>
          <li><span>普通会员</span></li>
        </ul>
      </div>
    </div>
    <div class="center_head_menu"> 
     	<div class="colom" onclick="window.location.href='${ctx}/memberWechat/myCoupon?wechat_id=${param.wechat_id}'">
	          <div>优惠券</div>
	          <div><ystech:couponMemberCountTag memberId="${member.dbid }"/></div>
     	</div>
     	<div  class="colom" onclick="window.location.href='${ctx}/memberWechat/myScoreRecord?wechat_id=${param.wechat_id}&selectType=0'">
     		 <div>积分</div>
	          <div>${member.overagePiont }</div>
     	</div>
     	<div  class="colom noneLine" onclick="window.location.href='${ctx}/memberWechat/myTrading?wechat_id=${param.wechat_id}&selectType=0'">
     		  <div>余额</div>
	          <div>
	          	<ystech:urlEncrypt enCode="${member.balance }"/> 
	          </div>
     	</div> 
     	<div style="clear: both;"></div>
    </div>
 </div>
  <div class="itemContent" style="margin:12px 23px;border: 1px solid #cdcdcd;border-radius:5px;" onclick="window.location.href='${ctx}/memberWechat/myTrading?wechat_id=${param.wechat_id}&selectType=0'">
  		<div style="float: left;"><h3>我的余额</h3></div>
  		<div class="leftPre"></div>
  		<div style="clear: both;"></div>
  </div> 
  <div class="itemContent" style="margin:12px 23px;border: 1px solid #cdcdcd;border-radius:5px;" onclick="window.location.href='${ctx}/memberWechat/myCoupon?wechat_id=${param.wechat_id}'">
  		<div style="float: left;"><h3>我的优惠券</h3></div>
  		<div class="leftPre"></div>
  		<div style="clear: both;"></div>
  </div> 
   <div class="itemContent" style="margin:12px 23px;border: 1px solid #cdcdcd;border-radius:5px;" onclick="window.location.href='${ctx}/memberWechat/myScoreRecord?wechat_id=${param.wechat_id}&selectType=0'">
  		<div style="float: left;"><h3>我的积分</h3></div>
  		<div class="leftPre"></div>
  		<div style="clear: both;"></div>
  </div> 
   <div class="itemContent" style="margin:12px 23px;border: 1px solid #cdcdcd;border-radius:5px;" onclick="window.location.href='${ctx}/memberWechat/myOnlineBooking?wechat_id=${param.wechat_id}'">
  		<div style="float: left;"><h3>预约记录</h3></div>
  		<div class="leftPre"></div>
  		<div style="clear: both;"></div>
  </div> 
   <div class="itemContent" style="margin:12px 23px;border: 1px solid #cdcdcd;border-radius:5px;" onclick="window.location.href='${ctx}/agentWechat/jionIn?code=83a3e919bcb0b83fc264d78ed92bb521'">
  		<div style="float: left;"><h3>经纪人</h3></div>
  		<div class="leftPre"></div>
  		<div style="clear: both;"></div>
  </div> 
 <div class="itemContent" style="margin:12px 23px;border: 1px solid #cdcdcd;border-radius:5px;" >
  		<div style="float: left;"><h3>电话号码：<a href="tel:02887464321" style="font-family: '微软雅黑'">&nbsp;&nbsp;028-87464321</a></h3></div>
  		<div class="leftPre"></div>
  		<div style="clear: both;"></div>
  </div>
   <div class="itemContent" style="margin:12px 23px;border: 1px solid #cdcdcd;border-radius:5px;margin-bottom: 43px;">
  		<div style="float: left;">
  		<h3 style="overflow: hidden;">公司地址：
  				<a href="javascript:void(-1)" style="font-size: 12px;" onclick="window.location.href='http://api.map.baidu.com/marker?location=30.723734,103.998875&title=%E8%A5%BF%E7%89%A9%E4%B8%AD%E9%94%90%E5%BA%97&content=四川省成都市金牛区兴科中路&output=html'">
					成都市金牛区兴科中路36号
				</a>
		</div>
  		<div class="leftPre"></div>
  		<div style="clear: both;"></div>
  </div>
   
</body>
<script type="text/javascript">
	
</script>
</html>
