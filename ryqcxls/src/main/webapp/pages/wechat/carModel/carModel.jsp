<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../../commons/taglib.jsp" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
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
    <!-- apple devices fullscreen -->
    <meta name="apple-mobile-web-app-status-bar-style" content="black-translucent" />
    <link rel="stylesheet" href="${ctx }/css/wechat/comm.css" type="text/css" />
    <link rel="stylesheet" href="${ctx }/widgets/idangerous/idangerous.swiper.css" type="text/css" />
    <link rel="stylesheet" href="${ctx }/pages/wechat/WeUI/style/weui.css?${now}" type="text/css" />
	<script src="${ctx }/pages/wechat/WeUI/example/zepto.min.js"></script>
    <script src="${ctx }/pages/wechat/WeUI/example/router.min.js"></script>
    <script src="${ctx }/widgets/bootstrap3/jquery.min.js"></script>
    <script src="${ctx }/widgets/idangerous/idangerous.swiper-2.0.min.js"></script>
    <style type="text/css">
     .swiper-container, .swiper-slide {
		  height:100%;
	  }
	  .swiper-slide img{
	  	height: 100%;width: 100%;
	  }
    </style>
<title>${carModel.name}车型介绍</title>
</head>
<body>
<div class="title">
    <a class="btn-back" onclick="window.history.go(-1)" href="javascript:void(0)">
    	<i class="icon icon-2-1"></i>
    </a>
    <h3>${carModel.name }车型介绍</h3>
</div>
<br>
<br>
<div class="content">
    <div class="cpzs">
        <!--s 轮播图-->
       <div class="banner" id="banner">
            <div class="swiper-container">
                 <div class="swiper-wrapper">
                 	<c:forEach var="carModelImage" items="${carModelImages }">
	                 	<div class="swiper-slide"><a href="#"><img width="100%" src="${carModelImage.url }" height="100%"></a></div>
                 	</c:forEach>
                </div>
                <div class="pagination">
                </div>
            </div>
        </div>
        <!--汽车品牌系列名称-->
        <div class="car-name">${carModel.brand.name }${carModel.name }</div>
        <!--汽车参数-->
        <div class="car-cs">
        	<div class="box-orient-h car-zdjg">
            	<div class="box-flex car-zdjg-c">指导价：<em>￥${ carModel.navPrice}起</em></div>
            	<div class="box-flex car-zdjg-c"><span>推荐价：￥${carModel.saleCSPrice }起</span></div>
            </div>
        	<div class="box-orient-h car-cs-list">
            	<ul>
                	<li>
                    	<dl class="box-orient-h">
                        	<dt>品牌: </dt>
                            <dd class="box-flex">${carModel.brand.name }</dd>
                        </dl>
                    </li>
                	<li>
                    	<dl class="box-orient-h">
                        	<dt>车型: </dt>
                            <dd class="box-flex">${carModel.brand.name }${carModel.name }</dd>
                        </dl>
                    </li>
                	<li>
                    	<dl class="box-orient-h">
                        	<dt>颜色分类: </dt>
                            <dd class="box-flex">${carModel.carColors }</dd>
                        </dl>
                    </li>
                	<li>
                    	<dl class="box-orient-h">
                        	<dt>汽车级别:</dt>
                            <dd class="box-flex">${carModel.carLevel }</dd>
                        </dl>
                    </li>
                	<li>
                    	<dl class="box-orient-h">
                        	<dt>排量: </dt>
                            <dd class="box-flex">${carModel.pailiang }</dd>
                        </dl>
                    </li>
                	<li>
                    	<dl class="box-orient-h">
                        	<dt>变速箱类型: </dt>
                            <dd class="box-flex">${carModel.bianxueType }</dd>
                        </dl>
                    </li>
                	<li>
                    	<dl class="box-orient-h">
                        	<dt>新车价格区间(万): </dt>
                            <dd class="box-flex">${carModel.priceFrom }</dd>
                        </dl>
                    </li>
                	<li>
                    	<dl class="box-orient-h">
                        	<dt>汽车动力类型: </dt>
                            <dd class="box-flex">${carModel.carDriverType }</dd>
                        </dl>
                    </li>
                	<li>
                    	<dl class="box-orient-h">
                        	<dt>是否进口: </dt>
                            <dd class="box-flex">${carModel.hasJk }</dd>
                        </dl>
                    </li>
                	<li>
                    	<dl class="box-orient-h">
                        	<dt>提车时间: </dt>
                            <dd class="box-flex">${carModel.handCarTime }</dd>
                        </dl>
                    </li>
                	<li>
                    	<dl class="box-orient-h">
                        	<dt>整车质保: </dt>
                            <dd class="box-flex">${carModel.zbType }</dd>
                        </dl>
                    </li>
                </ul>
            </div>
        </div>
        <br>
        <!--汽车详细-->
        <div class="box-orient-h car-menu">
        	<a class="box-flex on" href="#">详细参数</a>
        </div>
</div>
</div>
<div class="article" style="">
	<div class="bd" >
	    <article class="weui_article" style="padding:0;">
	       ${carModel.description }
	    </article>
	</div>
</div>
</body>
<script type="text/javascript">
function set() {
    $(".swiper-container").css({ "width": $(".banner").width(), "height": $(".banner").width()/2 });
}
set();
window.onresize = set;
var mySwiper = new Swiper('.swiper-container', {
    pagination: '.pagination',
    loop: true,
    grabCursor: true,
    paginationClickable: true,
    autoplay: 3000
})
</script>
</html>