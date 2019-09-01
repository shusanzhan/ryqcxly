<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../../commons/taglib.jsp" %>
<div class="butt container" id="container">
	<div class="tabbar">
		<div class="weui_tab">
		    <div class="weui_tabbar butt">
		        <a href="${ctx }/agentWechat/index?type=1" class="weui_tabbar_item">
		            <div class="weui_tabbar_icon">
		                <img src="${ctx}/pages/wechat/WeUI/example/images/icon_nav_button.png" alt="" >
		            </div>
		            <p class="weui_tabbar_label">首页</p>
		        </a>
		        <a href="${ctx }/recommendCustomerWechat/recommendCustomer" class="weui_tabbar_item">
		            <div class="weui_tabbar_icon">
		                <img src="${ctx}/pages/wechat/WeUI/example/images/icon_nav_msg.png" alt="">
		            </div>
		            <p class="weui_tabbar_label">推荐客户</p>
		        </a>
		        <a href="${ctx }/agentWechat/memberCenter" class="weui_tabbar_item">
		            <div class="weui_tabbar_icon">
		                <img src="${ctx}/pages/wechat/WeUI/example/images/icon_nav_cell.png" alt="">
		            </div>
		            <p class="weui_tabbar_label">我</p>
		        </a>
		    </div>
		</div>
	</div>
</div>
<c:if test="${member.weixinGzuserinfo.eventStatus==0 }">
<div id="mcover" >
	<div>
		<img src="${ctx }/images/bussiCard/qrcodefor.jpg">
		<p>长按二维码选择识别二维码,关注本公众号</p>
	</div>
</div>
<div class="weui-toptips bg-warning weui-toptips_visible" style="display: block; opacity: 1;" onclick="document.getElementById('mcover').style.display='block';">为提供给您更好的服务，请点击关注成都瑞一新零售公众号</div>
</c:if>