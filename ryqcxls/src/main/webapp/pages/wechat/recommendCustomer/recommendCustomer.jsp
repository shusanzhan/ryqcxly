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
    <link rel="stylesheet" href="${ctx }/css/wechat/comm.css" type="text/css" />
    <meta name="apple-mobile-web-app-status-bar-style" content="black-translucent" />
    <link rel="stylesheet" href="${ctx }/pages/wechat/WeUI/style/weui.css?${now}" type="text/css" />
    <script src="${ctx }/widgets/bootstrap3/jquery.min.js"></script>
	<script src="${ctx }/pages/wechat/WeUI/example/zepto.min.js"></script>
    <script src="${ctx }/pages/wechat/WeUI/example/router.min.js"></script>
    <script src="${ctx }/widgets/easyvalidator/js/easy_validator.pack5.js"></script>
    <style type="text/css">
    </style>
<title>推荐客户</title>
</head>
<body>
<div class="title">
    <a class="btn-back" onclick="window.history.go(-1)" href="javascript:void(0)"><i class="icon icon-2-1"></i></a>
    <h3>推荐客户</h3>
</div>
<br>
<br>
<form action="" id="frmId" name="frmId" method="post" target="_self">
<div class="weui_cells weui_cells_form">
        <div class="weui_cell">
            <div class="weui_cell_hd">
            	<label class="weui_label" style="width: 80px">客户姓名</label>
            </div>
            <div class="weui_cell_bd weui_cell_primary">
                <input type="text" id="name" name="recommendCustomer.name"  placeholder="客户姓名"  class="weui_input" checkType="string,2">
            </div>
        </div>
         <div class="weui_cell">
            <div class="weui_cell_hd">
            	<label class="weui_label" style="width: 80px">电话</label>
            </div>
            <div class="weui_cell_bd weui_cell_primary">
                <input class="weui_input" id="mobilePhone" name="recommendCustomer.mobilePhone" type="number" pattern="[0-9]*" placeholder="请输入号码" checkType="mobilePhone" onchange="validateMobilePhone()" >
            </div>
        </div>
        <div class="weui_cell weui_cell_select weui_select_after">
            <div class="weui_cell_hd" >
               	称呼
            </div>
            <div class="weui_cell_bd weui_cell_primary">
                <select class="weui_select" name="recommendCustomer.sex" id="sex">
                    <option value="男">先生</option>
                    <option value="女">女士</option>
                </select>
            </div>
        </div>
        <div class="weui_cell weui_cell_select weui_select_after">
            <div class="weui_cell_hd" style="width: 80px">
               	推荐车型${fn:length(carSeriys) }
            </div>
            <div class="weui_cell_bd weui_cell_primary">
                <select class="weui_select" name="carSeriyId" id="carSeriyId" checkType="integer,1">
	                  <c:forEach var="carSeriy" items="${carSeriys }">
	                	<option value="${carSeriy.dbid }">${carSeriy.name }</option>
	                  </c:forEach>
                </select>
            </div>
        </div>
       <div class="weui_cell">
            <div class="weui_cell_hd">
               	<label class="weui_label" style="width: 80px">购车预算</label>
            </div>
            <div class="weui_cell_bd weui_cell_primary">
                <input class="weui_input" name="recommendCustomer.budgetMoney" id="budgetMoney" type="number" pattern="[0-9]*" placeholder="请输入购车预算" checkType="float,10000">
            </div>
        </div>
   </div>    
    <div class="weui_btn_area">
        <a class="weui_btn weui_btn_warn" href="javascript:" id="showTooltips" onclick="ajaxSubmit('${ctx}/recommendCustomerWechat/saveRecommendCustomer','frmId')">提交</a>
    </div>
     <div id="toast" style="display: none;">
	    <div class="weui_mask_transparent"></div>
	    <div class="weui_toast">
	        <i class="weui_icon_toast"></i>
	        <p class="weui_toast_content">保存数据成功</p>
	    </div>
	</div>
</form>
</body>
<script type="text/javascript">
var comm=1;
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
					alert("保存数据失败!");
					return ;
				}else if(obj[0].mark==0){
					$('#toast').show();
	                setTimeout(function () {
	                    $('#toast').hide();
	                	window.location.href = data[0].url;
	                }, 2000);
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
function validateMobilePhone(){
	var mobile=$("#mobilePhone").val();
	if(null==mobile||mobile==''){
		var cl=$("#mobilePhone").parent().attr("class");
		if(!cl.contains("add")){
			change_error_style($("#mobilePhone"),"add")
		}
		return ;
	}else{
		if (!checkMobilePhone($("#mobilePhone"))) {
			return ;
		}
	}
	$.post("${ctx}/recommendCustomerWechat/validateMobilePhone",{'mobile':mobile},function callBack(data) {
		if (data=='2') {
			alert("手机号已经存在，请确认");
		}
		if (data=='0') {
		}
	})
}
</script>
</html>