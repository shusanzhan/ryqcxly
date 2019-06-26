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
    <script charset="utf-8"  src="http://res.wx.qq.com/open/js/jweixin-1.0.0.js"></script>
     <script charset="utf-8" src="http://map.qq.com/api/js?v=2.exp&key=OG2BZ-A3RAU-MQ5V2-4Z46P-IQ552-LSFM6"></script>
       <style type="text/css">
    </style>
<title>紧急救援</title>
</head>
<body >
<div class="container" id="container">
	<div id="mapContent" style="height: 280px"></div>
    <div id="fitBoundsDiv"></div>
    <div id="centerDiv" style="display: none;"></div>
    <div id="zoomDiv"></div>
    <div id="containerDiv"></div>
    <div id="mapTypeIdDiv"></div>
    <div id="projection"></div>
    <input type="text" id="address" name="address" style="width: 320px;display: none;">
    <div class="weui_cells_title" id="weui_cells_title" style="display:none; ">
	   	<span style="float: left;">急救电话：</span><a href="tel:${enterprise.emergencyPhone }" style="color: #3cc51f;float: left;">${enterprise.emergencyPhone }</a>
	    <a class="weui_btn weui_btn_mini weui_btn_plain_primary" href="javascript:;" onclick="submitHelp()" id="showDialog1" style="float: right;">发起紧急救援</a>
	    <div style="clear: both;"></div>
	</div>
   <form action="" id="frmId" name="frmId" method="post">
   		<input type="hidden" value="${member.dbid }" id="memberId" name="memberId">
   		<input type="hidden" value="" id="coordinates" name="coordinates">
   		<input type="hidden" value="" id="address1" name="address1">
   		<input type="hidden" value="" id="title" name="title">
   </form>
   <table request_url="http://apis.map.qq.com/ws/geocoder/v1/?" id="online_demo_01" style="display: none;">
	 <tbody><tr>
	     <td>location</td>
	     <td><input type="text" value="39.984154,116.307490" style="width: 300px;" id="getLatlngX" querypara="location"> &nbsp;<span style="color: red">点击地图，获取坐标值</span></td>
	 </tr>
	 <tr>
	     <td>get_poi</td>
	     <td><input type="text" value="1" style="width: 300px;" querypara="get_poi"></td>
	 </tr>
	 <tr>
	     <td>key</td>
	     <td><input type="text" value="OG2BZ-A3RAU-MQ5V2-4Z46P-IQ552-LSFM6" style="width: 300px;" querypara="key"></td>
	    </tr>
	</tbody>
	</table>
	<div class="weui_cells weui_cells_radio" id="info" style=" margin-top: 5px;">
    </div>
    
    <div class="weui_dialog_confirm" id="dialog1" style="display: none;">
	    <div class="weui_mask"></div>
	    <div class="weui_dialog">
	        <div class="weui_dialog_hd"><strong class="weui_dialog_title">确认救援地址</strong></div>
	        <div class="weui_dialog_bd" id="weui_dialog_bd"></div>
	        <div class="weui_dialog_ft">
	            <a href="javascript:;" class="weui_btn_dialog default">取消</a>
	            <a href="javascript:;" class="weui_btn_dialog primary" id="showTooltips" onclick="ajaxSubmit('${ctx}/emergencyHelpWechat/save','frmId')">确定</a>
	        </div>
	    </div>
	</div>
</div>
    <script type="text/javascript">
    // dialog
	    wx.config({
	        debug: false,
	        appId: '${weixinCommon.appId}',
	        timestamp: '${weixinCommon.timestamp}',
	        nonceStr: '${weixinCommon.nonceStr}',
	        signature: '${weixinCommon.signature}',
	        jsApiList: [
	          'checkJsApi',
	          'getLocation',
	          'openLocation'
	        ]
	    });
	    wx.ready(function () {
	    	
	    	  // 1 判断当前版本是否支持指定 JS 接口，支持批量判断
	    	    wx.checkJsApi({
	    	      jsApiList: [
	    	        'getNetworkType',
	    	        'previewImage'
	    	      ],
	    	      success: function (res) {
	    	       	//alert(JSON.stringify(res));
	    	      }
	    	    });
	    	    wx.getLocation({
	                type: 'gcj02', // 默认为wgs84的gps坐标，如果要返回直接给openLocation用的火星坐标，可传入'gcj02'
	                success: function (res) {
	                	var  latitude = res.latitude; // 纬度，浮点数，范围为90 ~ -90
	                	var longitude = res.longitude; // 经度，浮点数，范围为180 ~ -180。
	                    var speed = res.speed; // 速度，以米/每秒计
	                    var accuracy = res.accuracy; // 位置精度
	                    init(latitude,longitude);
	                }
	            });
	    	    wx.error(function (res) {
	    	    	  alert(res.errMsg);
	    	    });
	    })
	    var geocoder=null,map=null,array=new Array(),beginLat,beginLng;
        function init(lat,lng) {
            //div容器
            var container = document.getElementById("mapContent");
            var centerDiv = document.getElementById("centerDiv");
            var center=new qq.maps.LatLng(lat,lng);
            //初始化地图
            map = new qq.maps.Map(container, {
                // 地图的中心地理坐标
                center: center,
                minZoom:6,             //此处设置地图的缩放级别  最小值是6
                maxZoom:18,            //此处设置地图的缩放级别  最大值是7
                zoom:16,
                scaleControl: true,
                scaleControlOptions: {
                    //设置控件位置相对右下角对齐，向左排列
                    position: qq.maps.ControlPosition.TOP_LEFT
                }
            });
            beginLat=lat;
            beginLng=lng;
           geocoder=new qq.maps.Geocoder();
          //创建自定义控件
           var  width=($("#mapContent").width()-20)/2;
           var top=(280-28)/2;
           var middleControl = document.createElement("div");
            middleControl.style.left=width+"px";
            middleControl.style.top=top+"px";
			middleControl.style.position="relative";
			middleControl.style.width="36px";
            middleControl.style.height="36px";
			middleControl.style.zIndex="100000";
            middleControl.innerHTML ='<img src="${ctx}/images/marker.png?=11" width="20" height="28"/>';
		    document.getElementById("mapContent").appendChild(middleControl);
		    
		    //创建会到默认地址
		    createNav();
		    
		    setMarkImage(center);
		    
            //返回地图当前中心点地理坐标
            centerDiv.innerHTML = "latlng:" + map.getCenter();
            codeLatLng(lat,lng);
            $("#getLatlngX").val(lat+","+lng);
            
            //
            $("#weui_cells_title").show();
            //当地图中心属性更改时触发事件 
            var i=0;
            qq.maps.event.addListener(map, 'dragend', function() {
                centerDiv.innerHTML = "latlng:" + map.getCenter();
                $("#getLatlngX").val(map.getCenter().getLat()+","+map.getCenter().getLng());
               	codeLatLng(map.getCenter().getLat(),map.getCenter().getLng());
            });
          
        }
	    function codeLatLng(lat,lng) {
	        //对指定经纬度进行解析
		    var latLng = new qq.maps.LatLng(lat, lng);
	        geocoder.getAddress(latLng);
	        //设置服务请求成功的回调函数
	        geocoder.setComplete(function(result) {
	            $("#address").val("");
 	            $("#address").val(result.detail.address);
	 	        run_demo($('#online_demo_01'),$('#show_01'));
	 	       
	        });
	        //若服务请求失败，则运行以下函数
	        geocoder.setError(function() {
	        	aelrt("请求服务器失败，请退出再试");
	        });
	 
	    }
	    function run_demo($form,$show){
	        var $ipts=$form.find('input');
	        var data={};
	        var url=$form.attr('request_url');
	        var datas_list="";
	        for(var i=0;i<$ipts.length;i++){
	            var datas = eval("data."+$ipts[i].getAttribute('querypara')+"=\""+$ipts[i].value+"\"");
	           datas_list = datas_list+"&"+$ipts[i].getAttribute('querypara')+"="+datas;
	        }
	        var url_list = url+datas_list.substr(1);
	        data.output="jsonp";
	        $.ajax({
	            type:"get",
	            dataType:'jsonp',
	            data:data,
	            jsonp:"callback",
	            jsonpCallback:"QQmap",
	            url:url,
	            success:function(json){
	                var status=json.status;
	                if(status=="0"){
	                	var result=json.result;
	                	var obj=result.pois;
	                	var res="";
	                	for(var i=0;i<obj.length;i++){
	                		var m=obj[i];
	                		var lat=m.location.lat;
	                		var lgn=m.location.lng;
	                		res=res+'<label class="weui_cell weui_check_label" for="x'+i+'" style="padding: 5px 10px;">';
	                			res=res+'<div class="weui_cell_bd weui_cell_primary" style="line-height: 100%;">';
	                				res=res+'<p style="font-size: 14px;">'+m.title+'</p>';
	                				res=res+' <p style="font-size: 12px;color:#999999">'+m.address+'</p>';
	                			res=res+'</div>';
		                		res=res+'<div class="weui_cell_ft">';
			                		if(i==0){
				                		res=res+'<input type="radio" class="weui_check" name="radio1" checked="checked" id="x'+i+'" onclick="changeMapCneter('+lat+','+lgn+')" point="'+lat+','+lgn+'" titleValue="'+m.title+'" address="'+m.address+'">';
			                		}else{
				                		res=res+'<input type="radio" class="weui_check" name="radio1" id="x'+i+'" onclick="changeMapCneter('+lat+','+lgn+')" point="'+lat+','+lgn+'" titleValue="'+m.title+'" address="'+m.address+'">';
			                		}
			                		res=res+'<span class="weui_icon_checked"></span>';
		                		res=res+'</div>';
	                		res=res+'</label>';
	                	}
	                	$("#info").text("");
	                	$("#info").append(res);
	                	$("#weui_cells_title").show();
	                }else{
	                	alert("服务端错误，请刷新浏览器后重试");
	                }
	            },
	            error : function(err){alert("服务端错误，请刷新浏览器后重试")}

	    })
	    }
	    function changeMapCneter(lat,lng) {
	    	 map.panTo(new qq.maps.LatLng(lat, lng));
	    	 
        }
	    //创建返回当前定位位置
	    function createNav(){
	    	var width=$("#mapContent").width();
	    	var middleControl = document.createElement("div");
            middleControl.style.left=(width-50)+"px";
            middleControl.style.top=185+"px";
			middleControl.style.position="relative";
			middleControl.style.width="40px";
            middleControl.style.height="40px";
            middleControl.style.backgroundColor="#FFF";
			middleControl.style.zIndex="100000";
			$(middleControl).css({"border-radius":"20px","box-shadow":"0 0 10px #b4b4b4"})
            middleControl.innerHTML ='<img src="${ctx}/images/nav.png?=11" width="30" height="30" style="margin-top:5px;margin-left:5px;"/>';
		    document.getElementById("mapContent").appendChild(middleControl);
		    
		    middleControl.addEventListener('click', function(){  
		    	changeMapCneter(beginLat,beginLng);
		    });  
	    }
	    function setMarkImage(center){
	    	//设置Marker自定义图标的属性，size是图标尺寸，该尺寸为显示图标的实际尺寸，origin是切图坐标，该坐标是相对于图片左上角默认为（0,0）的相对像素坐标，anchor是锚点坐标，描述经纬度点对应图标中的位置
	        var anchor = new qq.maps.Point(14,14),
	            size = new qq.maps.Size(30, 30),
	            scaleSize = new qq.maps.Size(28, 28),
	            origin = new qq.maps.Point(0, 0),
	            icon = new qq.maps.MarkerImage(
	                "${ctx}/images/location.png",
	                size,
	                origin,
	                anchor,
	                scaleSize
	            );
	        var marker = new qq.maps.Marker({
	            map: map,
	            position: center
	        });
	        marker.setIcon(icon);
	    }
	    function submitHelp(){
	    	var point=$('#info input[type="radio"]:checked').attr("point");
	    	$("#coordinates").val(point);
	    	var titleValue=$('#info input[type="radio"]:checked').attr("titleValue");
	    	$("#title").val(titleValue);
	    	var address=$('#info input[type="radio"]:checked').attr("address");
	    	$("#address1").val(address);
	    	$("#weui_dialog_bd").text("");
	    	$("#weui_dialog_bd").append("您当前位于：“<span style='color:#04be02'>"+address+" "+titleValue+"</span>“,点击确定发起救援请求");
	    	$('#dialog1').show().on('click', '.weui_btn_dialog', function () {
                $('#dialog1').off('click').hide();
            });
	    }
	    function ajaxSubmit(url,frmId){
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
    </script>
</body>
</html>