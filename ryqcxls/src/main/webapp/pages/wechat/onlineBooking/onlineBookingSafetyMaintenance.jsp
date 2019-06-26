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
    <script src="${ctx }/widgets/utile/jsdateUtile.js"></script>
	<script src="${ctx }/pages/wechat/WeUI/example/zepto.min.js"></script>
    <script src="${ctx }/pages/wechat/WeUI/example/router.min.js"></script>
    <script src="${ctx }/widgets/easyvalidator/js/easy_validator.pack5.js"></script>
    <style type="text/css">
    </style>
<title>维修保养</title>
</head>
<body>
<div class="title">
    <a class="btn-back" onclick="window.history.go(-1)" href="javascript:void(0)"><i class="icon icon-2-1"></i></a>
    <h3>${enterprise.name }维修保养</h3>
</div>
<br>
<br>
<br>
<div class="alert alert-danger" style="height: 20px;line-height: 20px;">
	<i class="weui_icon_waiting_circle" style="float: left;"></i>
	<span style="margin-top: 5px;"><span style="float: left;">若您在预约过程中有任何问题，请拨打:</span><a  href="tel:${enterprise.phone}" style="float: left;color: #888;font-size: 14px;">${enterprise.phone }</a></span>
</div>
<div style="clear: both;"></div>
<c:if test="${param.serviceType==2 }">
	<div class="weui_panel weui_panel_access">
	      <div class="weui_panel_hd">取车地址</div>
	      <div class="weui_panel_bd">
	          <div class="weui_media_box weui_media_text">
	              <h4 class="weui_media_title">${title }</h4>
	              <p class="weui_media_desc">${address }</p>
	          </div>
	      </div>
	      <a href="${ctx }/onlineBookingWechat/selectAddress?serviceType=2" class="weui_panel_ft" >更换地址</a>
	  </div>
</c:if>
<form action="" id="frmId" name="frmId" method="post" target="_self">
	<input type="hidden" value="${param.wechat_id }" id="microId" name="onlineBookingSafetyMaintenance.microId">
  	<input type="hidden" value="2" id="bookingType" name="onlineBookingSafetyMaintenance.bookingType">
  	<input type="hidden" value="${param.serviceType }" id="serviceType" name="serviceType" >
  	<input type="hidden" value="${title }" id="title" name="title" >
  	<input type="hidden" value="${address }" id="address" name="address" >
  	<input type="hidden" value="${param.point }" id="point" name="point" >
		  <div class="weui_cells weui_cells_form">
	       <div class="weui_cell">
	           <div class="weui_cell_hd"><label class="weui_label" style="width: 90px;">车型</label></div>
	           <div class="weui_cell_bd weui_cell_primary">
	               <input type="text"  placeholder="请输入车型" name="carModel" id="carModel"  value="${memberCarInfo.car }" class="weui_input" checkType="string,1"/>
	          </div>
	       </div>
	       <div class="weui_cell">
	           <div class="weui_cell_hd"><label class="weui_label" style="width: 90px;">联系人</label></div>
	           <div class="weui_cell_bd weui_cell_primary">
	               <input type="text"  placeholder="请输入联系人" value="${memberCarInfo.name  }" name="onlineBookingSafetyMaintenance.name" id="name" class="weui_input" checkType="string,1"/>
	          </div>
	       </div>
	       <div class="weui_cell">
	           <div class="weui_cell_hd"><label class="weui_label" style="width: 90px;">手机</label></div>
	           <div class="weui_cell_bd weui_cell_primary">
	               <input type="text" placeholder="请输入手机" value="${memberCarInfo.mobilePhone }" name="onlineBookingSafetyMaintenance.mobilePhone" id="mobilePhone"  class="weui_input" checkType="mobilePhone" />
	          </div>
	       </div>
	       <div class="weui_cell">
	           <div class="weui_cell_hd" ><label class="weui_label" style="width: 90px;">车牌号</label></div>
	           <div class="weui_cell_bd weui_cell_primary" >
	               <input type="text" placeholder="请输入车牌号" name="onlineBookingSafetyMaintenance.carPlate" id="carPlate"  class="weui_input" value="${memberCarInfo.carPlate }" checkType="string,1"/>
	          </div>
	       </div>
	          <div class="weui_cell">
	           <div class="weui_cell_hd" ><label class="weui_label" style="width: 90px;">预约日期</label></div>
	           <div class="weui_cell_bd weui_cell_primary" >
	               <input type="date" name="onlineBookingSafetyMaintenance.bookingDate" id="bookingDate" value=""  class="weui_input" checkType="dateComp,>"/>
	          </div>
	       </div>
	       <c:if test="${param.serviceType==2 }">
	       <div class="weui_cell">
	           <div class="weui_cell_hd" ><label class="weui_label" style="width: 90px;">取车时间段</label></div>
	           <div class="weui_cell_bd weui_cell_primary" >
	               <input type="time" name="startDate" id="startDate" onchange="addDateTime()" class="weui_input" checkType="dateComp,<,endDate" style="float: left;width: 100px;text-align: center;" placeholder="开始" />
	               <span style="float: left;">~</span>
	               <input type="time" name="endDate" id="endDate" class="weui_input"  checkType="dateComp,>,startDate" style="float: left;width: 100px;margin-left: 8px;text-align: center;" placeholder='结束'/>
	          </div>
	       </div>
	       </c:if>
	</div>      
    <div class="weui_btn_area">
        <a class="weui_btn weui_btn_primary" href="javascript:" id="showTooltips" onclick="ajaxSubmit('${ctx}/onlineBookingWechat/saveOnlineBookingSM','frmId')">提交预约</a>
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
var start = new Date();
start.add("d", 1); //昨天 
var tset= start.format("yyyy-MM-dd");
$("#bookingDate").val(tset);

function addDateTime(){
	var startDate=$("#startDate").val();
	if(null!=startDate){
		var date=stringToYYYYMMDDHHMM(new Date().format("yyyy-MM-dd")+" "+startDate);
		date.add("n", 120);
		var endDate=date.format("hh:mm");
		$("#endDate").val(endDate);
	}
}

function redreict(){
	 var chkRadio = $('input:radio[name="radio1"]:checked').val();
	 if(chkRadio==1){
		// window.location.href='${ctx}/onlineBookingWechat/onlineBookingSM?metholdType=1'
	 }
	 if(chkRadio==2){
		 window.location.href='${ctx}/onlineBookingWechat/agreenment?metholdType=2';
	 }
}

function ajaxSubmit(url,frmId){
	var validata = validateForm(frmId);
	if(validata){
		var params = $("#"+frmId).serialize();
		var url2="";
		$.ajax({	
			url : url, 
			data : params, 
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
				if(obj[0].mark==1){
					//错误
					$("#showTooltips").attr("onclick",url2);
					$("#showTooltips").removeClass("weui_btn_disabled");
					window.location.href = data[0].url;
					return ;
				}else if(obj[0].mark==0){
					window.location.href = data[0].url;
					//$('#toast').show();
	                /* setTimeout(function () {
	                    //$('#toast').hide();
	                	window.location.href = data[0].url;
	                }, 2000); */
				}
			},
			complete : function(jqXHR, textStatus){
				$("#showTooltips").attr("onclick",url2);
				var jqXHR=jqXHR;
				var textStatus=textStatus;
			}, 
			beforeSend : function(jqXHR, configs){
				url2=$(".butSave").attr("onclick");
				$("#showTooltips").attr("onclick","");
				$("#showTooltips").addClass("weui_btn_disabled");
				var jqXHR=jqXHR;
				var configs=configs;
			}, 
			error : function(jqXHR, textStatus, errorThrown){
					alert("系统请求超时");
					$("#showTooltips").attr("onclick",url2);
					$("#showTooltips").removeClass("weui_btn_disabled");
			}
		});
	}
}

</script>
</html>