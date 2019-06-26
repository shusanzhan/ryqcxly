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
<title>
	<c:if test="${param.type==2 }" var="status">代金券</c:if>
	<c:if test="${status==false }">折扣券</c:if> 
</title>

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
/* 	//优惠券领取
	function receiveCoupon(url){
			$.post(url,{},function callBack(data) {
				if (data[0].mark == 0) {// 返回标志为0表示添加数据成功
					// 保存数据成功时页面需跳转到列表页面
					$("#message").addClass("alert alert-success");
					$("#message").text(data[0].message);
					$("#message").css("display","");
					$("#message").show();
					setTimeout(window.location.href=data[0].url,5000);				
				}
				if (data[0].mark == 1) {// /返回标志为1表示保存数据失败
					// 保存失败时页面停留在数据编辑页面
					$("#message").addClass("alert alert-error");
					$("#message").text(data[0].message);
					$("#message").css("display","");
					$("#message").show();
				}
				return;
			});
		} */
	function receiveCoupon(url,index){
		try {
			    var url2="";
				$.ajax({	
						url : url, 
						data : {}, 
						async : false, 
						timeout : 20000, 
						dataType : "json",
						type:"post",
						success : function(data, textStatus, jqXHR){
							var obj;
							if(data.message!=undefined){
								obj=$.parseJSON(data.message);
							}else{
								obj=data;
							}
							if (obj[0].mark == 0) {// 返回标志为0表示添加数据成功
								// 保存数据成功时页面需跳转到列表页面
								$("#message").addClass("alert alert-success");
								$("#message").text(data[0].message);
								$("#message").css("display","");
								$("#message").show();
								setTimeout(window.location.href=data[0].url,5000);				
							}
							if (obj[0].mark == 1) {// /返回标志为1表示保存数据失败
								// 保存失败时页面停留在数据编辑页面
								$("#message").addClass("alert alert-error");
								$("#message").text(data[0].message);
								$("#message").css("display","");
								$("#message").show();
								$("#applayButton"+index).attr("onclick",url2);
							}
							return;
						},
						complete : function(jqXHR, textStatus){
							$("#applayButton"+index).attr("onclick",url2);
							var jqXHR=jqXHR;
							var textStatus=textStatus;
						}, 
						beforeSend : function(jqXHR, configs){
							url2=$("#applayButton"+index).attr("onclick");
							$("#applayButton"+index).attr("onclick","");
							var jqXHR=jqXHR;
							var configs=configs;
						}, 
						error : function(jqXHR, textStatus, errorThrown){
								alert("系统请求超时");
								$("#applayButton"+index).attr("onclick",url2);
						}
					});
		} catch (e) {
			$.utile.tips(e);
			return;
		}
	}
</script>
</head>
<body>
<div id="message" class="" style="display: none;">
</div>
<div class="coupon_select">
 	 <a href="${ctx }/memberWechat/coupon?wechat_id=${param.wechat_id }&type=1" class="coupon_selectP">折扣券</a>
  	<div class="select_line" style="float: left;"><img src="${ctx }/images/weixin/select_line_05.png"></div>
    <a href="${ctx }/memberWechat/coupon?wechat_id=${param.wechat_id }&type=2" class="coupon_selectP">代金券</a>
   	<div class="clear"></div>
</div>
<div id="message" class="alert alert-success" style="margin:14px;">
	<strong>提示：</strong>点击右下角【会员中心】可以查看您已经获得的优惠券！
 </div>
<c:if test="${empty(coupons) }" var="status">
	<div id="message" class="alert alert-error" style="margin:14px;">
		商家暂未发放可领用的优惠券！
  	</div>
</c:if>
<c:if test="${status==false }">
<c:forEach var="coupon" items="${coupons }" varStatus="i">
	<div class="coupon_list">
		<s:set value="" var=""></s:set>
	    <div class="coupon_list_img" onclick="showOrHiden('explan${coupon.dbid }')">
		    <c:if test="${fn:length(coupon.image)>4&&!empty(coupon.image)}" var="status">
		    	<img src="${coupon.image }" width="60" height="60">
		    </c:if>
		    <c:if test="${status==false } ">
		    	<img src="${ctx }/img/weixin/youhuiquan.png" width="60" height="60">
		    </c:if>
	   </div>
	    <div class="coupon_list_img_p" onclick="showOrHiden('explan${coupon.dbid }')">
	      <div>
			<c:if test="${fn:length(coupon.name)>4 }" var="status">
				${fn:substring(coupon.name,0,4) }...
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
	      	<span>有效期至：<fmt:formatDate pattern="yyyy年MM月dd日" value="${coupon.stopTime }"/></span>
	      	<br>
	      	<span style="color: red;">点击图片查看详情</span>
	      </div>
	    </div>
	    <c:if test="${now<coupon.startTime }">
	    	<a href="javascript:void(-1)" class="btn_get">未开始</a>
	    </c:if>
	    <c:if test="${now>coupon.stopTime }">
	    	<a href="javascript:void(-1)" class="btn_get">已结束</a>
	    </c:if>
	    <c:if test="${now>=coupon.startTime&& now<=coupon.stopTime}">
	    	<c:if test="${coupon.receive==true }" var="status">
	    		<a href="javascript:void(-1)" class="btn_get" >已领取</a>
	    	</c:if>
	    	<c:if test="${status==false }">
	    		 <c:if test="${coupon.ausgabeCount<=coupon.receivedNum }" var="re">
			    	<a href="javascript:void(-1)" class="btn_get">已领完</a>
			    </c:if>
	    		<c:if test="${re==false }">
	    			<a href="javascript:void(-1)" id="applayButton${i.index }" class="btn_get" onclick="receiveCoupon('${ctx }/memberWechat/receiveCoupon?couponId=${coupon.dbid}&type=${param.type }&wechat_id=${param.wechat_id }',${i.index })">领取</a>
	    		</c:if>
			  
	    	</c:if>
	    </c:if>
	    <div class="clear"></div>
	</div>
	 <div id="explan${coupon.dbid }" class="explanContent" >
	    	<div style="font-family: 14px;border-bottom: 1px solid #D8D8D8;line-height: 36px; color: #373636; font-size: 14px; ">
	    		${ coupon.name}说明
	    	</div>
	    	<div style="margin-top:5px;font-family: 14px;border-bottom: 1px solid #D8D8D8;line-height: 28px; color: #373636; font-size: 12px;">
		      	<span>有效期：<fmt:formatDate pattern="yyyy年MM月dd日" value="${coupon.startTime }"/>至<fmt:formatDate pattern="yyyy年MM月dd日" value="${coupon.stopTime }"/></span>
	       	</div>
	       	<div style="color: #373636;font-size: 12px;margin-top: 12px;line-height: 200%">
	       		${coupon.description }
	       	</div>
	    </div>	  
</c:forEach>
</c:if>
</body>
</html>
