<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../../commons/taglib.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta name="viewport" content="width=device-width,height=device-height,inital-scale=1.0,maximum-scale=1.0,user-scalable=no;">
<meta name="format-detection" content="telephone=no">
<meta name="apple-mobile-web-app-capable" content="yes">
<meta name="apple-mobile-web-app-status-bar-style" content="black">
<link rel="stylesheet" href="${ctx }/css/weixin/skdslider.css" type="text/css" />
<link href="${ctx }/css/saleActivity/index.css" type="text/css" rel="stylesheet"/>
<title>新瑞虎5 为爱前行 公益活动</title>
</head>
<body>
<div class="header">
	<img src="${saleActivity.frontImage }" alt="${ saleActivity.frontImage}" >
</div>
<div class="detail">
	<div class="proj">
		<div class="tt">
			<div class="bb">${publicBenefitActivity.title }</div>
		</div>
		<div class="desc">
			${publicBenefitActivity.content }
		</div>
	</div>
</div> 
<br>
<br>
<br>
<div class="btns">
	<div style="margin:5px;">
		<table style="width:100%">
			<tbody>
				<tr>
					<td width="49%">
						<a id="btn_submit1" href="javascript:void(0)">
							<div class="btn">
								<img src="http://mat1.gtimg.com/gongyi/m/wx/btn_icon1.png">我要分享
							</div>
						</a>                                      
					</td>
				</tr>
			</tbody>
		</table>             
	</div>
</div>
</body>
<script src="${ctx }/widgets/bootstrap3/jquery.min.js"></script>
<script src="${ctx }/widgets/skdslider/skdslider.js"></script>
<script type="text/javascript">
		$(document).ready(function(){
			$('#slider').skdslider({delay:5000, animationSpeed: 2000,showNextPrev:false,showPlayButton:false,autoSlide:false,animationType:'fading'});
		  var totalWidth=$("#slider").closest('div.skdslider').outerWidth();
		  var leftContent= $('.itemConent').find('.itemRight');
		  for(var i=0;i<leftContent.length;i++){
			  $(leftContent[i]).css({'width':totalWidth-112});
		  }
		   $( window ).resize(function() {
			   var totalWidth=$(container).closest('div.skdslider').outerWidth();
			  var leftContent= $('.itemConent').find('.itemRight');
			  for(var i=0;i<leftContent.length;i++){
				  $(leftContent[i]).css({'width':totalWidth-112});
			  }
		   });
		});
</script>
</html>