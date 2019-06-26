 <%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../../commons/taglib.jsp" %>
 <br>
  <br>
  <br>
 <div class="bottom_menu"> 
	 <div class="bottom_menu_p">
	  	<a href="${ctx }/memberWechat/memberCardCenter?wechat_id=${param.wechat_id}">会员卡</a>
	 </div>
    <div class="bottom_menu_line" style="float: left;"><img src="${ctx }/images/weixin/menuLine_05.png"></div>
 	<div class="bottom_menu_p" style="float: right;"> 
 		<a href="${ctx }/memberWechat/memberCenter?wechat_id=${param.wechat_id}">会员中心</a> 
 	</div>
</div>
<script type="text/javascript">
document.addEventListener('WeixinJSBridgeReady', function onBridgeReady() {
	WeixinJSBridge.call('hideToolbar');
});
</script>