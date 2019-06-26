<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ include file="../../commons/taglib.jsp" %>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
 <meta charset="UTF-8">
    <meta content="width=device-width, initial-scale=1.0, minimum-scale=1.0, maximum-scale=1.0, user-scalable=no" name="viewport">
    <meta content="application/xhtml+xml;charset=UTF-8" http-equiv="Content-Type">
    <meta content="no-cache,must-revalidate" http-equiv="Cache-Control">
    <meta content="no-cache" http-equiv="pragma">
    <meta content="0" http-equiv="expires">
    <meta content="telephone=no, address=no" name="format-detection">
    <meta name="apple-mobile-web-app-capable" content="yes" />
    <meta name="apple-mobile-web-app-status-bar-style" content="black-translucent" />
    <link rel="stylesheet" href="${ctx }/pages/wechat/WeUI/style/weui.css" type="text/css" />
	<script src="${ctx }/widgets/bootstrap3/jquery.min.js"></script>
	<script src="${ctx }/pages/wechat/WeUI/example/zepto.min.js"></script>
    <script src="${ctx }/pages/wechat/WeUI/example/router.min.js"></script>
    <script src="${ctx }/pages/wechat/WeUI/example/example.js"></script>
    <script src="${ctx }/widgets/easyvalidator/js/easy_validator.pack5.js"></script>
<title>车主认证</title>
</head>
<body>
<div class="container" id="container">
	<div class="searchbar">
		<div class="hd">
		    <h1 class="page_title" style="text-align: center;">车主认证</h1>
		</div>
		<div class="bd">
		    <div id="search_bar" class="weui_search_bar">
		        <form class="weui_search_outer">
		            <div class="weui_search_inner">
		                <i class="weui_icon_search"></i>
		                <input type="search" required="" placeholder="请输入车主姓名或电话搜索" id="search_input" value="${member.mobilePhone }" class="weui_search_input">
		                <a id="search_clear" class="weui_icon_clear" href="javascript:"></a>
		            </div>
		            <label id="search_text" class="weui_search_text" for="search_input">
		                <i class="weui_icon_search"></i>
		                <span>请输入车主姓名或电话搜索</span>
		            </label>
		        </form>
		        <a id="search_cancel" class="weui_search_cancel" href="javascript:">取消</a>
		    </div>
		    <div id="search_show" class="weui_cells weui_cells_access search_show" style="display: none;">
		    </div>
		</div>
	</div>
	<form action="" id="frmId" name="frmId" method="post" target="_self">
	   <input type="hidden" id="customerId" name="customerId"  value=""  >
	   <input type="hidden" name="memberId" id="memberId" value="${member.dbid }">
	   <input type="hidden" name="memberCarInfo.dbid" id="memberCarInfoId" value="${memberCarInfo.dbid }">
	<div class="cell">
		<div class="bd">
			 <div class="weui_cells_title">用车区域</div>
		    <div class="weui_cells weui_cells_form">
		    	<div class="weui_cell weui_cell_select ">
		            <div class="weui_cell_bd weui_cell_primary">
		                <select class="weui_select" id="useCarAreaId" name="useCarAreaId"  checkType="integer,1">
		                	<option value="">请选择</option>
		                    ${useCarArea }
		                </select>
		            </div>
		        </div>
		     </div>
		     
			 <div class="weui_cells_title">车主信息</div>
		     <div class="weui_cells weui_cells_form">
		        <div class="weui_cell">
		            <div class="weui_cell_hd"><label class="weui_label">姓名</label></div>
		            <div class="weui_cell_bd weui_cell_primary">
		                <input type="text" id="name" name="memberCarInfo.name" value="${customer.name }" placeholder="请输姓名"  class="weui_input" checkType="string,1">
		            </div>
		        </div>
		        <div class="weui_cell">
		            <div class="weui_cell_hd"><label class="weui_label">手机号</label></div>
		            <div class="weui_cell_bd weui_cell_primary">
		                <input class="weui_input" id="mobilePhone" name="memberCarInfo.mobilePhone" value="${customer.mobilePhone }"  type="number" pattern="[0-9]*" placeholder="请输入号码" checkType="mobilePhone" onchange="validateAgent()" >
		            </div>
		        </div>
		        <div class="weui_cell">
		            <div class="weui_cell_hd"><label class="weui_label">车型</label></div>
		            <div class="weui_cell_bd weui_cell_primary">
		                <input type="text" id="car" name="memberCarInfo.car" placeholder="请输入车型" value="${car }" class="weui_input" checkType="string,1">
		            </div>
		        </div>
		        <div class="weui_cell">
		            <div class="weui_cell_hd"><label class="weui_label">VIN码</label></div>
		            <div class="weui_cell_bd weui_cell_primary">
		                <input type="text" id="vinCode" name="memberCarInfo.vinCode" placeholder="请输入VIN码" value="${customer.customerPidBookingRecord.vinCode }"  class="weui_input" checkType="string,17,17">
		            </div>
		        </div>
		        <div class="weui_cell">
		            <div class="weui_cell_hd"><label class="weui_label">车牌</label></div>
		            <div class="weui_cell_bd weui_cell_primary">
		                <input type="text" id="carPlate" name="memberCarInfo.carPlate" value="" placeholder="请输入车牌"  class="weui_input" >
		            </div>
		        </div>
		    </div>
		    <div class="weui_cells_title">备注</div>
		    <div class="weui_cells weui_cells_form">
		        <div class="weui_cell">
		            <div class="weui_cell_bd weui_cell_primary">
		                <textarea class="weui_textarea" id="note" name="memberCarInfo.note" placeholder="请输入备注" rows="3"></textarea>
		                <div class="weui_textarea_counter"></div>
		            </div>
		        </div>
		    </div>
			  <div class="weui_btn_area">
		        <a class="weui_btn weui_btn_primary" href="javascript:" id="showTooltips" onclick="ajaxSubmit('${ctx}/memberWechat/saveCarAuth','frmId')">提交</a>
		    </div>
		   
		     <div id="toast" style="display: none;">
			    <div class="weui_mask_transparent"></div>
			    <div class="weui_toast">
			        <i class="weui_icon_toast"></i>
			        <p class="weui_toast_content" id="weui_toast_content">认证成功</p>
			    </div>
			</div>
		</div>
	</div>
	 </form>
</div>

</body>
<script type="text/javascript">
var jsonData=null;
$(function () {
        $('#container').on('focus', '#search_input', function () {
            var $weuiSearchBar = $('#search_bar');
            $weuiSearchBar.addClass('weui_search_focusing');
        }).on('blur', '#search_input', function () {
            var $weuiSearchBar = $('#search_bar');
            $weuiSearchBar.removeClass('weui_search_focusing');
            if ($(this).val()) {
                $('#search_text').hide();
            } else {
                $('#search_text').show();
            }
        }).on('input', '#search_input', function () {
            var $searchShow = $("#search_show");
            if ($(this).val()) {
            	var  value=$(this).val();
            	$.post('${ctx}/memberWechat/autoCustomer?q='+value,{},function (data){
            		if(null!=data&&data!=undefined){
            			$searchShow.text("");
            			var items="";
            			jsonData=data;
            			for(var i=0;i<data.length;i++){
            				var ite=JSON.stringify(data[i]);
            				items=items+'<div class="weui_cell">'+
						            		'<div class="weui_cell_bd weui_cell_primary" onclick="confirmValue('+i+')">'+
							                '<p>'+data[i].name+'  '+data[i].mobilePhone+'</p>'+
								            '</div>'+
								        '</div>';
            			}
            			$searchShow.append(items);
	                	$searchShow.show();
            		}
            	})
            } else {
                $searchShow.hide();
            }
        }).on('touchend', '#search_cancel', function () {
            $("#search_show").hide();
            $('#search_input').val('');
        }).on('touchend', '#search_clear', function () {
            $("#search_show").hide();
            $('#search_input').val('');
        });
        $("#search_show").children().each(function(i){
        	$(this).bind("click",function(){
        		alert(123);
        	})
        })
})
function confirmValue(index){
	var data=jsonData[index];
	$("#customerId").val(data.customerId);
	$("#name").val(data.name);
	$("#mobilePhone").val(data.mobilePhone);
	$("#car").val(data.car);
	$("#vinCode").val(data.vinCode);
	$("#carPlate").val(data.carPlate);
	$("#search_show").hide();
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
					alert(obj[0].message);
					//错误
					$("#showTooltips").attr("onclick",url2);
					$("#showTooltips").removeClass("weui_btn_disabled");
					return ;
				}else if(obj[0].mark==0){
					$("#weui_toast_content").text("");
					$("#weui_toast_content").text(obj[0].message);
					$('#toast').show();
	                setTimeout(function () {
	                    $('#toast').hide();
	                	window.location.href = data[0].url;
	                }, 5000);
				}
			},
			complete : function(jqXHR, textStatus){
				$("#showTooltips").attr("onclick",url2);
				var jqXHR=jqXHR;
				var textStatus=textStatus;
			}, 
			beforeSend : function(jqXHR, configs){
				url2=$("#showTooltips").attr("onclick");
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