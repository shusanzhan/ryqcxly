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
    <link rel="stylesheet" href="${ctx }/pages/wechat/WeUI/style/weui.css?" type="text/css" />
    <script src="${ctx }/widgets/bootstrap3/jquery.min.js"></script>
	<script src="${ctx }/pages/wechat/WeUI/example/zepto.min.js"></script>
    <script src="${ctx }/pages/wechat/WeUI/example/router.min.js"></script>
    <style type="text/css">
    </style>
<title>上门接送车服务须知</title>
</head>
<body style="font-size: 11px;">
<div class="container" id="container">
<div class="article">
	<div class="bd">
	    <article class="weui_article">
	        <h1>第一条 接送车服务</h1>
	           <section>
	               <p>（一）服务提供方所提供的接送车服务范围仅限于成都市主城区（绕城以内）及服务提供方20公里内的其他区域范围。</p>
	               <p>（二）用户在成功预约后，等候服务提供方指派工作人员到达用户指定出发地点，由服务提供方工作人员为其执行接送车服务；用户车辆符合规定的上路许可（车辆行驶证、车牌号等与车辆有关的保险手续齐全），并在保险期内；</p>
	           </section>
	        <h1>第二条  风险控制</h1>
	          <section>
	              <p>（一）服务提供方指派的工作人员需持有有效驾驶证且在审核有效期内。服务提供方除了把车开至维修站维修之外，不能挪作他用，服务提供方应当有保管车辆的义务；</p>
	              <p>（二）如车辆造成交通意外，造成的损失由保险公司处理；如因用户车辆原因，用户故意隐瞒的用户自行处理；如因第三方因素造成的意外，由交通管理部门裁决后，由责任方承担，服务提供方协助处理，服务提供方不承担其他任何额外费用；如因不可抗力（如地震、台风、战争等）双方免责免赔。因接送车过程中出现的交通违章概由服务负责处理，并承担罚款扣分。</p>
	          </section>
	        <h1>第三条  车辆检查确认</h1>
	          <section>
	              <p>（一）用户车辆在交付给服务提供方时，要主动把车辆相关问题告知服务提供方，不得隐瞒车辆问题；</p>
	              <p>（二）服务提供方在维修过程中，如发现有用户报修范围以外的故障及潜在隐患，应主动电话联系用户，并确认维修方案。</p>
	          </section>
	        <h1>第四条 其他 </h1>
	          <section>
	              <p>（一）用户在签订接送车服务协议后，应将车内贵重物件转移，避免丢失引发纠纷，如因用户原因不转移贵重物件而丢失的，服务提供方不负任何责任；</p>
	              <p>（二）服务提供方在上门接车时，用户需签署纸质协议<a href="${ctx }/images/agreenment.jpg" style="color: #225fba;font-size: 16px;">（协议模版）</a>。</p>
	              <p>未尽事宜，双方协商解决，如协商不成，双方有权向服务提供方所在地有管辖权的人民法院进行起诉解决。</p>
	          </section>
	    </article>
	</div>
	</div>
</div>
<br>
<br>
<br>
<br>
<br>
<br>
<div class="butt container" id="container" style="position: fixed;bottom: 0px;left: 0px;width: 100%;background: #FFF;">
	<div class="weui_cells weui_cells_checkbox" >
        <label class="weui_cell weui_check_label" for="s11">
            <div class="weui_cell_hd">
                <input type="checkbox" class="weui_check" name="checkbox1" id="s11" value="1">
                <i class="weui_icon_checked"></i>
            </div>
            <div class="weui_cell_bd weui_cell_primary">
                <p>我已阅读并同意预约须知</p>
            </div>
        </label>
    </div>
    <div class="cell" style="margin-bottom: 12px;">
    	<a href="javascript:;" class="weui_btn weui_btn_primary" onclick="redreict()">预约维修保养</a>
   	</div>
</div>
</body>
<script type="text/javascript">
	function redreict(){
		 var chkRadio = $('input:checkbox[name="checkbox1"]:checked').val();
		 if(chkRadio==1){
			 window.location.href='${ctx}/onlineBookingWechat/selectAddress?serviceType=2';
		 }
		 else{
			 alert("请先阅读并同意预约须知");
		 }
	}
</script>
</html>