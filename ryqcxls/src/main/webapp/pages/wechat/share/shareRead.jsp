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
<script type="text/javascript" src="${ctx }/widgets/bootstrap3/jquery.min.js"></script>
<script type="text/javascript"  src="${ctx }/widgets/utile/weixin.js"></script>
<title>${share.title }</title>
<style type="text/css">
body{
background-image: none;
}
.body {
    display: block;
    font-size: 12px;
    margin: auto;
    max-width: 640px;
    min-height: 100%;
    min-width: 320px;
    position: relative;
    background-image: none;
}
#mcover {
    background: none repeat scroll 0 0 rgba(0, 0, 0, 0.7);
    display: none;
    height: 100%;
    left: 0;
    position: fixed;
    top: 0;
    width: 100%;
    z-index: 20000;
}
#mcover img {
    height: 180px;
    position: fixed;
    right: 18px;
    top: 5px;
    width: 260px;
    z-index: 20001;
}
.bg{
   bottom: 0;
    left: 0;
    position: absolute;
    right: 0;
    top: 0;
    z-index: -1;
}
 .article {
    color: #333333;
    overflow: hidden;
    padding: 12px 18px;
}

.article .content2 {
    line-height: 22px;
    word-wrap: break-word;
    font-size: 12px;
    overflow: hidden;
} 
.article header h3 {
    font-size: 15px;
    line-height: 20px;
}
#share_1 {
    display: block;
    float: left;
    width: 49%;
}

#share_2 {
    display: block;
    float: right;
    width: 49%;
}

.shareButton {
    background-color: #E8E8E8;
    background-image: linear-gradient(to top, #DBDBDB, #F4F4F4);
    border: 1px solid #ADADAB;
    border-radius: 3px;
    box-shadow: 0 1px 1px rgba(0, 0, 0, 0.45), 0 1px 1px #EFEFEF inset;
    color: #000000;
    font-size: 14px;
    text-align: center;
    text-shadow: 0.5px 0.5px 1px #FFFFFF;
    width: 100%;
}
.text {
    color: #727272;
    font-size: 14px;
    word-wrap: break-word;
}

</style>
</head>
<body >
 <div>
	<div id="mcover" onclick="document.getElementById('mcover').style.display='';"><img src="${ctx }/images/weixin/guide.png"></div>
	 <c:if test="${!empty(share) }">
		<div class="main" style="padding-bottom: 12px;">
			<section class="section_body">
				<article class="article">
					<header>
						<h3>${share.title }</h3>
						<sapn>
							<fmt:formatDate value="${share.createTime}" pattern="yyyy-MM-dd"/>
						</span>
					</header>
					<div class="content2">
						${share.content }
					</div>
				</article>
			</section>
			<section style="width:95%; margin:5px auto;">
				<div class="shareButton" style="padding: 12px 0;cursor: pointer;margin-top: 5px;margin-bottom: 5px;margin-bottom: 12px;" onclick="window.location.href='http://mp.weixin.qq.com/s?__biz=MzA4OTM1MTQxOA==&mid=200182638&idx=1&sn=fac12073d80f1f3d5cafd03246bf063a#rd'">
					关注瑞一奇瑞微信（已经关注的请无视）
				</div>
			</section>
			<c:if test="${!empty(share.phone1)&&share.show1==1 }">
			<section style="width:95%; margin:0px auto;">
				<div class="text" id="content" style="padding-bottom: 12px;">
					<div id="mess_share">
						<div id="share_1" style="width: 59%">
							<a _href="tel:${share.phone1 }" href="tel:${share.phone1 }">
								<div class="shareButton" >
										<div style="width:50px;height: 50px;float: left; ">
											<img src="${ctx }/images/mobilePhone.png" width="50" height="50">
										</div>
										<div style="height: 50px; float: left;line-height: 50px;font-size: 14px;">
											&nbsp;中锐店
										</div>
										<div style="clear: both;"></div>
								</div>
							</a>
						</div>
						<div id="share_2" style="width: 39%">
							<a _href="http://api.map.baidu.com/marker?location=30.723734,103.998875&amp;title=%E8%A5%BF%E7%89%A9%E4%B8%AD%E9%94%90%E5%BA%97&amp;content=四川省成都市金牛区兴科中路&amp;output=html" href="http://api.map.baidu.com/marker?location=30.723734,103.998875&amp;title=%E8%A5%BF%E7%89%A9%E4%B8%AD%E9%94%90%E5%BA%97&amp;content=%E5%9B%9B%E5%B7%9D%E7%9C%81%E6%88%90%E9%83%BD%E5%B8%82%E9%87%91%E7%89%9B%E5%8C%BA%E5%85%B4%E7%A7%91%E4%B8%AD%E8%B7%AF&amp;output=html" style="text-decoration: none;" target="_self" title="">
								<div class="shareButton" >
										<div style="width:50px;height: 50px;float: left; ">
											<img src="${ctx }/images/map.png" width="50" height="50">
										</div>
										<div style="height: 50px; float: left;line-height: 50px;font-size: 14px;">
											&nbsp;GPS导航
										</div>
										<div style="clear: both;"></div>
								</div>
							</a>
						</div>
						<div class="clr" style="clear: both;"></div>
					</div>
				</div>
			</section>
			</c:if>
			<c:if test="${!empty(share.phone2)&&share.show2==1 }">
			<section style="width:95%; margin:0px auto;">
				<div class="text" id="content" style="padding-bottom: 12px;">
					<div id="mess_share">
						<div id="share_1" style="width: 39%">
							<a _href="tel:${share.phone2 }" href="tel:${share.phone2 }">
								<div class="shareButton" >
										<div style="width:50px;height: 50px;float: left; ">
											<img src="${ctx }/images/mobilePhone.png" width="50" height="50">
										</div>
										<div style="height: 50px; float: left;line-height: 50px;font-size: 14px;">
											&nbsp;精锐店
										</div>
										<div style="clear: both;"></div>
								</div>
							</a>
						</div>
						<div id="share_2" style="width: 59%">
							<a _href="http://api.map.baidu.com/marker?location=30.679862,103.978544&amp;title=%E8%A5%BF%E7%89%A9%E7%B2%BE%E9%94%90%E5%BA%97&amp;content=四川省成都市青羊区日月大道一段&amp;output=html" href="http://api.map.baidu.com/marker?location=30.679862,103.978544&amp;title=%E8%A5%BF%E7%89%A9%E7%B2%BE%E9%94%90%E5%BA%97&amp;content=%E5%9B%9B%E5%B7%9D%E7%9C%81%E6%88%90%E9%83%BD%E5%B8%82%E9%9D%92%E7%BE%8A%E5%8C%BA%E6%97%A5%E6%9C%88%E5%A4%A7%E9%81%93%E4%B8%80%E6%AE%B5&amp;output=html" style="text-decoration: none;" target="_self" textvalue="点我一键GPS导航" title="">
								<div class="shareButton" >
										<div style="width:50px;height: 50px;float: left; ">
											<img src="${ctx }/images/map.png" width="50" height="50">
										</div>
										<div style="height: 50px; float: left;line-height: 50px;font-size: 14px;">
											&nbsp;GPS导航
										</div>
										<div style="clear: both;"></div>
								</div>
							</a>
						</div>
						<div class="clr" style="clear: both;"></div>
					</div>
				</div>
			</section>
			</c:if>
			<c:if test="${!empty(share.phone3)&&share.show3==1 }">
			<section style="width:95%; margin:0px auto;">
				<div class="text" id="content" style="padding-bottom: 12px;">
					<div id="mess_share">
						<div id="share_1" style="width: 59%">
							<a _href="tel:${share.phone3 }" href="tel:${share.phone3 }">
								<div class="shareButton" >
										<div style="width:50px;height: 50px;float: left; ">
											<img src="${ctx }/images/mobilePhone.png" width="50" height="50">
										</div>
										<div style="height: 50px; float: left;line-height: 50px;font-size: 14px;">
											&nbsp;红牌楼店
										</div>
										<div style="clear: both;"></div>
								</div>
							</a>
						</div>
						<div id="share_2" style="width: 39%">
							<a _href="http://api.map.baidu.com/marker?location=30.634228,104.033798&amp;title=%E8%A5%BF%E7%89%A9%E5%A5%87%E7%91%9E%E8%8E%B1%E5%85%8B%E5%BA%97&amp;content=四川省成都市武侯区董家湾北街22号&amp;output=html" href="http://api.map.baidu.com/marker?location=30.634228,104.033798&amp;title=%E8%A5%BF%E7%89%A9%E5%A5%87%E7%91%9E%E8%8E%B1%E5%85%8B%E5%BA%97&amp;content=%E5%9B%9B%E5%B7%9D%E7%9C%81%E6%88%90%E9%83%BD%E5%B8%82%E6%AD%A6%E4%BE%AF%E5%8C%BA%E8%91%A3%E5%AE%B6%E6%B9%BE%E5%8C%97%E8%A1%9722%E5%8F%B7&amp;output=html" style="text-decoration: none;" target="_self" title="">
								<div class="shareButton" >
										<div style="width:50px;height: 50px;float: left; ">
											<img src="${ctx }/images/map.png" width="50" height="50">
										</div>
										<div style="height: 50px; float: left;line-height: 50px;font-size: 14px;">
											&nbsp;GPS导航
										</div>
										<div style="clear: both;"></div>
								</div>
							</a>
						</div>
						<div class="clr" style="clear: both;"></div>
					</div>
				</div>
			</section>
			</c:if>
			<section style="width:95%; margin:0px auto;">
				<div class="text" id="content" style="padding-bottom: 20px;">
					<div id="mess_share">
						<div id="share_1">
							<div class="shareButton" onclick="document.getElementById('mcover').style.display='block';">
									<div style="width:50px;height: 50px;float: left; ">
										<img src="${ctx }/images/weixin/iconMsg.png?=2014-03-07-1" width="50" height="50">
									</div>
									<div style="height: 50px; float: left;line-height: 50px;font-size: 14px;">
										&nbsp;发送给朋友
									</div>
									<div style="clear: both;"></div>
							</div>
						</div>
						<div id="share_2">
							<div class="shareButton" onclick="document.getElementById('mcover').style.display='block';">
									<div style="width:50px;height: 50px;float: left; ">
										<img src="${ctx }/images/weixin/iconTimeline.png" width="50" height="50">
									</div>
									<div style="height: 50px; float: left;line-height: 50px;font-size: 14px;">
										&nbsp;分享到朋友圈
									</div>
									<div style="clear: both;"></div>
							</div>
						</div>
						<div class="clr" style="clear: both;"></div>
					</div>
				</div>
			</section>
		</div>
	</c:if>
	</div>
	<div style="padding-bottom:5px!important;">
		<a href="javascript:window.scrollTo(0,0);" style="font-size:14px;margin:0 auto;display:block;color:#fff;text-align:center;line-height:35px;background:#333;margin-bottom:-10px;">返回顶部</a>
	</div>
	<c:if test="${empty(share) }">
		<div class="alert-danger" style="padding: 12px 20px;font-size: 16px;">
			无积分分享信息！
		</div>
	</c:if>
	<script type="text/javascript">
		 //var urlWeb="http://192.168.3.104:8091";
		 var urlWeb="http://www.xwqr.net";
		window.shareData = {
			"imgUrl": urlWeb+"${share.shareImage}",
			"timeLineLink": urlWeb+"/shareWeixin/shareRead?dbid=${share.dbid}&wechatId=${param.wechat_id}&from=1",
			"sendFriendLink": urlWeb+"/shareWeixin/shareRead?dbid=${share.dbid}&wechatId=${param.wechat_id}&from=1",
			"weiboLink": urlWeb+"/shareWeixin/shareRead?dbid=${share.dbid}&wechatId=${param.wechat_id}&from=1",
			"tTitle": "${share.title}",
			"tContent": "			&nbsp; &nbsp;${share.title}",
			"fTitle": "${share.title}",
			"fContent": "${share.title}	",
			"wContent": "			&nbsp; &nbsp;&nbsp; &nbsp;${share.title}	"
		};
		var imgUrl =  urlWeb+"${share.shareImage}";
        var lineLink = urlWeb+"/shareWeixin/shareRead?dbid=${share.dbid}&wechatId=${param.wechat_id}&from=1";
        var descContent =  "${share.title}";
        var shareTitle = "${share.title}";
         
        function shareFriend() {
            WeixinJSBridge.invoke('sendAppMessage',{
                "img_url": imgUrl,
                "img_width": "200",
                "img_height": "200",
                "link": lineLink,
                "desc": descContent,
                "title": shareTitle
            }, function(res) {
                //_report('send_msg', res.err_msg);
            })
        }
        function shareTimeline() {
            WeixinJSBridge.invoke('shareTimeline',{
                "img_url": imgUrl,
                "img_width": "200",
                "img_height": "200",
                "link": lineLink,
                "desc": descContent,
                "title": shareTitle
            }, function(res) {
                   //_report('timeline', res.err_msg);
            });
        }
        function shareWeibo() {
            WeixinJSBridge.invoke('shareWeibo',{
                "content": descContent,
                "url": lineLink
            }, function(res) {
                //_report('weibo', res.err_msg);
            });
        }
        // 当微信内置浏览器完成内部初始化后会触发WeixinJSBridgeReady事件。
        document.addEventListener('WeixinJSBridgeReady', function onBridgeReady() {
            // 发送给好友
            WeixinJSBridge.on('menu:share:appmessage', function(argv){
                shareFriend();
            });
            // 分享到朋友圈
            WeixinJSBridge.on('menu:share:timeline', function(argv){
                shareTimeline();
            });
            // 分享到微博
            WeixinJSBridge.on('menu:share:weibo', function(argv){
                shareWeibo();
            });
        }, false);
	</script>
</body>
</html>
