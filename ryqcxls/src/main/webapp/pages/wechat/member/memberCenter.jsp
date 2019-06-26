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
<link rel="stylesheet" type="text/css"  href="${ctx }/css/weixin.css?${now}"/>
<link rel="stylesheet" href="${ctx }/pages/wechat/WeUI/style/weui.css?${now}" type="text/css" />
<script src="${ctx }/pages/wechat/WeUI/example/zepto.min.js"></script>
<script src="${ctx }/pages/wechat/WeUI/example/router.min.js"></script>
<style type="text/css">

.center_head_menu {
    background-color: #000000;
    height: 45px;
    margin-top: -17px;
    opacity: 0.71;
    position: absolute;
    top: 152px;
    width: 100%;
}
.colom{
	width: 33%;
	text-align: center;
	border-right: 1px solid #FFF;
	margin-top: 8px;
	margin-bottom:5px;
	height: 35px;
	float: left;
	color: #FFF;
	cursor: pointer;
}
.colom div{
	widows: 100%;font-size: 14px;line-height: 100%;
}
.noneLine{
	border-right: 0px solid #FFF;
}
.weui-toptips {
    display: none;
    position: fixed;
    -webkit-transform: translateZ(0);
    transform: translateZ(0);
    top: 0;
    left: 0;
    right: 0;
    padding: 5px;
    font-size: 14px;
    text-align: center;
    color: #FFF;
    z-index: 5000;
    word-wrap: break-word;
    word-break: break-all;
}
.bg-warning {
    background-color: #EF4F4F;
}
.weui-toptips {
    z-index: 100;
    opacity: 0;
    -webkit-transition: opacity .3s;
    transition: opacity .3s;
}
#mcover {
    background: none repeat scroll 0 0 rgba(0, 0, 0, 0.7);
    display: none;
    height: 100%;
    left: 0;
    position: fixed;
    top: 0;
    width: 100%;
    z-index: 10000;
}
#mcover div {
	 position: fixed;
    width: 80%;
	height:80%;
	margin: 0 auto;
	top:50%;
	left:50%;
	-webkit-transform: translate(-50%, -50%);
	-moz-transform: translate(-50%, -50%);
	-ms-transform: translate(-50%, -50%);
	-o-transform: translate(-50%, -50%);
	transform: translate(-50%, -50%);
	z-index: 99990;
	color: #FFF;
	text-align: center;
}
#mcover img{
    width: 100%;
	margin: 0 auto;
}
#mcover p{
	line-height: 200%;font-size: 14px;
}
</style>
<title>会员中心</title>
</head>
<body>
<div class="centerHead">
    <div class="center_head_info"> 
      <c:if test="${empty(weixinGzuserinfo) }">
    	  <img src="${ctx }/img/weixin/head_05.png" width="57" height="57"/>
      </c:if>
      <c:if test="${!empty(weixinGzuserinfo) }">
    	  <img src="${weixinGzuserinfo.headimgurl }" height="57" width="57">
      </c:if>
      <div class="center_head_infos">
        <ul>
          <li>${member.name }</li>
          <li><span>
          	<c:if test="${empty(member.memberShipLevel)}">
          		普通会员
          	</c:if>
          	<c:if test="${!empty(member.memberShipLevel)}">
          		${member.memberShipLevel.name }
          	</c:if>
          </span></li>
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
	          <div>
	          	<c:if test="${empty(member.overagePiont) }">
	          		0.0
	          	</c:if>
	          	<c:if test="${!empty(member.overagePiont) }">
	          		 ${member.overagePiont }
	          	</c:if>
	         </div>
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
 <div class="container" id="container">
	 <div class="panel">
	 	<div class="bd">
		    <div class="weui_panel">
		        <div class="weui_panel_bd">
		            <div class="weui_media_box weui_media_small_appmsg">
		                <div class="weui_cells weui_cells_access">
		                    <a class="weui_cell" href="javascript:;" onclick="window.location.href='${ctx}/memberWechat/myTrading?wechat_id=${param.wechat_id}&selectType=0'">
		                        <div class="weui_cell_hd"><img src="${ctx}/img/weixin/wdye.png" alt="" style="width:20px;margin-right:5px;display:block"></div>
		                        <div class="weui_cell_bd weui_cell_primary">
		                            <p>我的余额</p>
		                        </div>
		                        <span class="weui_cell_ft"></span>
		                    </a>
		                    <a class="weui_cell" href="javascript:;" onclick="window.location.href='${ctx}/memberWechat/myCoupon?wechat_id=${param.wechat_id}'">
		                        <div class="weui_cell_hd"><img src="${ctx}/img/weixin/wdyhq.png" alt="" style="width:20px;margin-right:5px;display:block"></div>
		                        <div class="weui_cell_bd weui_cell_primary">
		                            <p>我的优惠券</p>
		                        </div>
		                        <span class="weui_cell_ft"></span>
		                    </a>
		                    <a class="weui_cell" href="javascript:;" onclick="window.location.href='${ctx}/memberWechat/myScoreRecord?wechat_id=${param.wechat_id}&selectType=0'">
		                        <div class="weui_cell_hd"><img src="${ctx}/img/weixin/mypoint.png" alt="" style="width:20px;margin-right:5px;display:block"></div>
		                        <div class="weui_cell_bd weui_cell_primary">
		                            <p>我的积分</p>
		                        </div>
		                        <span class="weui_cell_ft"></span>
		                    </a>
		                    <a class="weui_cell" href="javascript:;" onclick="window.location.href='${ctx}/memberWechat/myOnlineBooking?wechat_id=${param.wechat_id}'">
		                        <div class="weui_cell_hd"><img src="${ctx}/img/weixin/online.png" alt="" style="width:20px;margin-right:5px;display:block"></div>
		                        <div class="weui_cell_bd weui_cell_primary">
		                            <p>预约记录</p>
		                        </div>
		                        <span class="weui_cell_ft"></span>
		                    </a>
		                </div>
		            </div>
		        </div>
		    </div>
		    <div class="weui_panel">
		        <div class="weui_panel_bd">
		            <div class="weui_media_box weui_media_small_appmsg">
		                <div class="weui_cells weui_cells_access">
		                    <%-- <a class="weui_cell" href="javascript:;" onclick="window.location.href='${ctx}/memberWechat/myTrading?wechat_id=${param.wechat_id}&selectType=0'">
		                        <div class="weui_cell_hd"><img src="${ctx }/img/weixin/myInfo.png" alt="" style="width:20px;margin-right:5px;display:block"></div>
		                        <div class="weui_cell_bd weui_cell_primary">
		                            <p>车主认证</p>
		                        </div>
		                        <span class="weui_cell_ft"></span>
		                    </a> --%>
		                    <a class="weui_cell" href="javascript:;" onclick="window.location.href='${ctx}/memberWechat/coupon?wechat_id=${param.wechat_id}&bussiId=2'">
		                         <div class="weui_cell_hd"><img src="${ctx }/img/weixin/getcou.png" alt="" style="width:20px;margin-right:5px;display:block"></div>
		                        <div class="weui_cell_bd weui_cell_primary">
		                            <p>领取优惠券</p>
		                        </div>
		                        <span class="weui_cell_ft"></span>
		                    </a>
		                    <a class="weui_cell" href="javascript:;" onclick="window.location.href='${ctx}/agentWechat/jionIn?code=83a3e919bcb0b83fc264d78ed92bb521'">
		                        <div class="weui_cell_hd"><img src="${ctx }/img/weixin/tj.png" alt="" style="width:20px;margin-right:5px;display:block"></div>
		                        <div class="weui_cell_bd weui_cell_primary">
		                            <p>瑞一经纪人</p>
		                        </div>
		                        <span class="weui_cell_ft"></span>
		                    </a>
		                    <a class="weui_cell" href="javascript:;" onclick="window.location.href='${ctx}/memberWechat/memberInfo?wechat_id=${param.wechat_id}'">
		                        <div class="weui_cell_hd"><img src="${ctx }/img/weixin/set.png" alt="" style="width:20px;margin-right:5px;display:block"></div>
		                        <div class="weui_cell_bd weui_cell_primary">
		                            <p>完善资料</p>
		                        </div>
		                        <span class="weui_cell_ft"></span>
		                    </a>
		                    <a class="weui_cell" href="javascript:;" onclick="window.location.href='${ctx}/memberWechat/modifyPhone?memberId=${member.dbid }'">
		                        <div class="weui_cell_hd"><img src="${ctx }/images/modifyPhone.png" alt="" style="width:20px;margin-right:5px;display:block"></div>
		                        <div class="weui_cell_bd weui_cell_primary">
		                            <p>更换手机号码</p>
		                        </div>
		                        <span class="weui_cell_ft"></span>
		                    </a>
		                </div>
		            </div>
		        </div>
		    </div>
		    <div class="weui_panel">
		        <div class="weui_panel_bd">
		            <div class="weui_media_box weui_media_small_appmsg">
		                <div class="weui_cells weui_cells_access">
		                    <a class="weui_cell" href="javascript:;" onclick="urlEddncode('${enterprise.point }','${enterprise.name }','${enterprise.address }')">
		                        <div class="weui_cell_hd"><img src="${ctx }/img/weixin/memberAddress.png" alt="" style="width:20px;margin-right:5px;display:block"></div>
		                        <div class="weui_cell_bd weui_cell_primary">
		                            <p>公司地址：<span style="color: #999999;font-size: 13px;">${enterprise.address }</span>
					  				</p>
		                        </div>
		                        <span class="weui_cell_ft"></span>
		                    </a>
		                    <a class="weui_cell" href="tel:028-87464321" >
		                        <div class="weui_cell_hd"><img src="${ctx }/img/weixin/lianxi.png" style="width:20px;margin-right:5px;display:block"></div>
		                        <div class="weui_cell_bd weui_cell_primary">
		                            <p>电话号码：<span style="color: #999999;font-size: 13px;">&nbsp;&nbsp;${enterprise.phone }</span></p>
		                        </div>
		                        <span class="weui_cell_ft"></span>
		                    </a>
		                </div>
		            </div>
		        </div>
		    </div>
	 	</div>
	 </div>
</div>
<br>
<br>
<c:if test="${member.weixinGzuserinfo.eventStatus==0 }">
	<div id="mcover" >
		<div>
			<img src="${ctx }/images/bussiCard/qrcodefor.jpg">
			<p>长按二维码选择识别二维码,关注本公众号</p>
		</div>
	</div>
	<div class="weui-toptips bg-warning weui-toptips_visible" style="display: block; opacity: 1;" onclick="document.getElementById('mcover').style.display='block';">
	为提供给您更好的服务，请点击关注成都瑞一公众号
	</div>
</c:if>
</body>
<script type="text/javascript">
function urlEddncode(point,name,content){
	var en=encodeURI(name);
	window.location.href="http://api.map.baidu.com/marker?location="+point+"&title="+en+"&content="+content+"&output=html";
}
</script>
</html>
