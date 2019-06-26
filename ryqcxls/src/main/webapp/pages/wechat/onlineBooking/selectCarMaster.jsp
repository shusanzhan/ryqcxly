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
    <link rel="stylesheet" href="${ctx }/css/wechat/comm.css?${now}" type="text/css" />
    <meta name="apple-mobile-web-app-status-bar-style" content="black-translucent" />
    <link rel="stylesheet" href="${ctx }/pages/wechat/WeUI/style/weui.css?" type="text/css" />
    <script src="${ctx }/widgets/bootstrap3/jquery.min.js"></script>
	<script src="${ctx }/pages/wechat/WeUI/example/zepto.min.js"></script>
    <script src="${ctx }/pages/wechat/WeUI/example/router.min.js"></script>
    <script src="${ctx }/widgets/easyvalidator/js/easy_validator.pack5.js"></script>
    <style type="text/css">
    </style>
<title>选择车辆</title>
</head>
<body>
<div class="title">
    <a class="btn-back" onclick="window.history.go(-1)" href="javascript:void(0)"><i class="icon icon-2-1"></i></a>
    <h3>选择车辆</h3>
</div>
<br>
<br>
<div class="container" id="container">
	<div class="msg">
		<div class="weui_msg">
		    <div class="weui_text_area">
		    	<c:if test="${type==1 }">
			        <p class="weui_msg_desc">请选择您的年审车辆</p>
		    	</c:if>
		    	<c:if test="${type==2 }">
			        <p class="weui_msg_desc">请选择您的保养维修车辆</p>
		    	</c:if>
		    	<c:if test="${type==3 }">
			        <p class="weui_msg_desc">请选择您的旧车置换车辆</p>
		    	</c:if>
		    </div>
		</div>
	</div>
</div>
	<form action="" id="frmId" name="frmId" method="post" target="_self">
	<div class="weui_cells weui_cells_radio">
	<c:forEach var="memberCarInfo" items="${memberCarInfos }" varStatus="i">
		<c:if test="${i.index==0 }" var="status">
	        <label class="weui_cell weui_check_label" for="x${i.index+1 }">
	            <div class="weui_cell_bd weui_cell_primary">
	                <p>${memberCarInfo.name }  ${memberCarInfo.car } ${memberCarInfo.carPlate }</p>
	            </div>
	            <div class="weui_cell_ft">
	                <input type="radio" class="weui_check" name="radio1" id="x${i.index+1 }" checked="checked" value="${memberCarInfo.dbid }">
	                <span class="weui_icon_checked"></span>
	            </div>
	        </label>
		</c:if>
		<c:if test="${status==false }">
			 <label class="weui_cell weui_check_label" for="x${i.index+1 }">
	            <div class="weui_cell_bd weui_cell_primary">
	                <p>${memberCarInfo.name }  ${memberCarInfo.car } ${memberCarInfo.carPlate }</p>
	            </div>
	            <div class="weui_cell_ft">
	                <input type="radio" class="weui_check" name="radio1" value="${memberCarInfo.dbid }" id="x${i.index+1 }">
	                <span class="weui_icon_checked"></span>
	            </div>
	        </label>
		</c:if>
     </c:forEach>
    </div>
    <div class="weui_btn_area">
        <a class="weui_btn weui_btn_warn" href="javascript:" id="showTooltips" onclick="redreict()">下一步</a>
    </div>
    </form>
     <div id="toast" style="display: none;">
	    <div class="weui_mask_transparent"></div>
	    <div class="weui_toast">
	        <i class="weui_icon_toast"></i>
	        <p class="weui_toast_content">保存数据成功</p>
	    </div>
	</div>
</body>
<script type="text/javascript">
	function redreict(){
		 var chkRadio = $('input:radio[name="radio1"]:checked').val();
		 window.location.href='${url}?memberCarInfoId='+chkRadio;
	}
</script>
</html>