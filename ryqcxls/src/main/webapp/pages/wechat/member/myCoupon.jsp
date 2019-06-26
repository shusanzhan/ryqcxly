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
<script type="text/javascript" src="${ctx }/widgets/utile/weixin.js"></script>
<script type="text/javascript">
function showOrHiden(divId){
	var explans=$.find(".explanContent");
	$(explans).each(function (){
		if(divId!=$(this).attr("id")){
			var hiden=$(this).is(":hidden")
			if(hiden==false){
				$(this).hide();
			}	
		}
	})
	var hiden=$("#"+divId).is(":hidden")
	if(hiden==true){
		$("#"+divId).show(1000);
	}else{
		$("#"+divId).hide(1000);
	}
}
</script>
<title>我的-<c:if test="${param.type==2 }" var="status">代金券</c:if><c:if test="${status==false }">折扣券</c:if> </title>
</head>
<body>

<div class="coupon_select">
 	 <a href="${ctx }/memberWechat/myCoupon?wechat_id=${param.wechat_id }&type=1" class="coupon_selectP">折扣券</a>
  	<div class="select_line" style="float: left;"><img src="${ctx }/images/weixin/select_line_05.png"></div>
    <a href="${ctx }/memberWechat/myCoupon?wechat_id=${param.wechat_id }&type=2" class="coupon_selectP">代金券</a>
   	<div class="clear"></div>
</div>
<c:if test="${empty(couponCodes) }" var="status">
	<div id="message" class="alert alert-success" style="margin:14px;">
		<strong>提示：</strong>当前无优惠券领取记录！
  	</div>
</c:if>
<c:if test="${status==false }">
<c:forEach var="coupon" items="${couponCodes }">
	<div class="coupon_list" style="margin: 5px 5px">
	    <div class="coupon_list_img" style="margin: 8px 5px" onclick="showOrHiden('explan${coupon.dbid }')">
		    <c:if test="${fn:length(coupon.image)>0&&!empty(coupon.image)}" var="status">
		    	<img src="${coupon.image }" width="60" height="60">
		    </c:if>
		    <c:if test="${status==false } ">
		    	<img src="${ctx }/img/weixin/youhuiquan.png" width="60" height="60">
		    </c:if>
	   </div>
	    <div class="coupon_list_img_p" >
	      <div>
			<c:if test="${fn:length(coupon.name)>5 }" var="status">
				${fn:substring(coupon.name,0,5) }
			</c:if>
			<c:if test="${status==false }">
				${coupon.name }	
			</c:if>
			<c:if test="${coupon.showHiden==true }">
				<c:if test="${coupon.type==1 }">
					折扣率:<span style="color: red;font-size: 16px;">${ coupon.moneyOrRabatt} 折</span>
				</c:if>
				<c:if test="${coupon.type==2 }">
					金额￥:<span style="color: red;font-size: 16px;">
						<fmt:formatNumber value="${ coupon.moneyOrRabatt}"></fmt:formatNumber>
					</span>
				</c:if>
			</c:if>
	      </div>
	      <div style="margin-top:8px;">
	      <span>有效期<fmt:formatDate pattern="yyyy年MM月dd日" value="${coupon.startTime }"/>
	      <br>
	       至&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<fmt:formatDate pattern="yyyy年MM月dd日" value="${coupon.stopTime }"/></span></div>
	    </div>
	    <c:if test="${now<coupon.startTime }">
	    	<a href="javascript:void(-1)" class="btn_get" style="position:relative; margin-right: 2px;color: #E2E0E0">活动未开始</a>
	    </c:if>
	    <c:if test="${now>coupon.stopTime }">
	    	<a href="javascript:void(-1)" class="btn_get" style="position:relative;margin-right: 2px;color: #E2E0E0">已过期</a>
	    </c:if>
	    <c:if test="${now>=coupon.startTime&& now<=coupon.stopTime}">
	    	<c:if test="${coupon.isUsed==true }" var="statuss">
	    			<a href="javascript:void(-1)" class="btn_get" style="position:relative; margin-right: 2px;color: #E2E0E0 ">已使用</a>
	    	</c:if>
	    	<c:if test="${statuss==false }">
	    		<a href="javascript:void(-1)" class="btn_get" style="position:relative; margin-right: 2px;">未使用</a>
	    	</c:if>
	    </c:if>
	    <div class="clear"></div>
	</div>
	<div id="explan${coupon.dbid }" class="explanContent" style="margin-top: -10px;margin-left: 5px;margin-right: 5px;">
	    	<div style="font-family: 14px;border-bottom: 1px solid #D8D8D8;line-height: 36px; color: #373636; font-size: 14px; ">
	    		${ coupon.name}说明
	    	</div>
	    	<div style="margin-top:5px;font-family: 14px;border-bottom: 1px solid #D8D8D8;line-height: 28px; color: #373636; font-size: 12px;">
		      	<span>有效期<fmt:formatDate pattern="yyyy年MM月dd日" value="${coupon.startTime }"/>至<fmt:formatDate pattern="yyyy年MM月dd日" value="${coupon.stopTime }"/></span>
	       	</div>
	       	<div style="color: #373636;font-size: 12px;margin-top: 12px;line-height: 200%">
	       		${coupon.description }
	       	</div>
	    </div>		  
</c:forEach>
</c:if>
</body>
</html>
