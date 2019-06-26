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
<script type="text/javascript"  src="${ctx }/widgets/utile/weixin.js"></script>
<script type="text/javascript" src="http://api.map.baidu.com/api?v=1.4"></script> 
<!-- <script type="text/javascript" src="http://api.map.baidu.com/api?v=2.0&ak=D1flUZUZQBKVtAdv4BGviREl"></script> -->
<title>紧急救援</title>
</head>
<body>
  <input type="hidden" id="zb" name="zb" value="">
  <input type="hidden" id="address" name="address" value="">
  <div class="head">
    <div  class="title">${enterprise.name }紧急救援</div>
    <div  class="titlePhone"><a href="tel:${enterprise.emergencyPhone }"><img src="${ctx }/images/weixin/phoneIcon.png"></a></div>
    <div class="clear"></div>
  </div>
  <div style="margin: ">
  		<img alt="" src="${ctx }/images/weixin/helpHeader.png" width="100%" >
  </div>
  <div id="dituContent"></div>
  <br>
  <div id="message" class="alert alert-success" style="padding: 8px;">
  	如需精确定位请在室外打开您手机GPS开关！
  </div>
  <div class="content" style="margin-top: 2px;">
  	<a href="tel:${enterprise.emergencyPhone }" onclick="sbmAddress(1)" style="padding: 0;margin: 0">
	  	<div class="item"  style="margin: 12px 30px;">
	  		<div class="itemImage call"></div>
	  		<div class="itemTitle" style="color: #19bd7f">
	  			拨打紧急电话
	  		</div>
	  	</div>
  	</a>
  	<div style=" margin: 12px 30px; " >
  		<input type="text" placeholder="发送位置前，请先输入电话号码！" name="phone" id="phone" value="${member.mobilePhone }"  required="required" style="width: 100%;border: 1px solid #E3E3EE;padding: 12px 0 12px 2px;border-radius:5px; "/>
  	</div>
  	
  	<div class="item" onclick="sbmAddress(2)" style="margin: 12px 30px;">
  		<div class="itemImage address"></div>
  		<div class="itemTitle" >
  			发送当前位置
  		</div>
  	</div>
  </div>
  <tr>
			 	<td colspan="4">
					<div class="control-group">
						<div id="l-map" style="width: 100%;height: 320px;">
						</div>
					</div>
					<input type="text" name="lat" id="lat" value="${fn:split(enterprise.point,',')[0] }">
					<input type="text" name="lng" id="lng" value="${fn:split(enterprise.point,',')[1] }">	 		
		    	<td >
		    </tr>
</body>
 <script src="http://api.map.baidu.com/api?key=6vqHE4hdIYHbGQv2By8kHp7O&v=1.1&services=true" type="text/javascript"></script>
 <script type="text/javascript">
 function setPoint(){
 	var lat=document.getElementById('lat').value;
     var lng=  document.getElementById('lng').value;
 	var point=lat+","+lng;
 	 if(point==","||null==point){
 		alert("请选定位");
 		return false;
 	}
 	 $("#point").val(point);
 }
 $(function () {
 	var po="${enterprise.point}".split(",");
 	var add="${enterprise.address}";
 	if(null!=po&&po.length>0){
 		var str='{"lng":"'+po[1]+'","lat":"'+po[0]+'","adr":"'+add+'"}';
 		var data=$.parseJSON(str);
 	    baidu_map(data);
 	}else{
 		baidu_map();
 	}
 })

 function baidu_map(data) {
     var self = this;
     var opt = this.option;
     var map = new BMap.Map("l-map");
     var myGeo = new BMap.Geocoder();
     var currentPoint;
     var marker1;
     var marker2;
     map.enableScrollWheelZoom();
     if (data) {
         var point = new BMap.Point(data.lng, data.lat);
         marker1 = new BMap.Marker(point);        // 创建标注
         map.addOverlay(marker1);
         var opts = {
             width: 220,     // 信息窗口宽度 220-730
             height: 60,     // 信息窗口高度 60-650
             title: ""  // 信息窗口标题
         }
         var infoWindow = new BMap.InfoWindow("原本位置 " + data.adr + " ,移动红点修改位置!你也可以直接修改上方位置系统自动定位!", opts);  // 创建信息窗口对象
         marker1.openInfoWindow(infoWindow);      // 打开信息窗口
         doit(point);
     } else {
         var point = new BMap.Point(104.074427, 30.668547);
         doit(point);
         window.setTimeout(function () {
             auto();
         }, 100);
     }
     map.enableDragging();
     map.enableContinuousZoom();
     map.addControl(new BMap.NavigationControl());
     map.addControl(new BMap.ScaleControl());
     map.addControl(new BMap.OverviewMapControl());



     function auto() {
         var geolocation = new BMap.Geolocation();
         geolocation.getCurrentPosition(function (r) {
             if (this.getStatus() == BMAP_STATUS_SUCCESS) {
                 //var mk = new BMap.Marker(r.point);  
                 //map.addOverlay(mk);  
                 // point = r.point;  
                 //map.panTo(r.point); 

                 var point = new BMap.Point(r.point.lng, r.point.lat);
                 marker1 = new BMap.Marker(point);        // 创建标注
                 map.addOverlay(marker1);
                 var opts = {
                     width: 220,     // 信息窗口宽度 220-730
                     height: 60,     // 信息窗口高度 60-650
                     title: ""  // 信息窗口标题
                 }

                 var infoWindow = new BMap.InfoWindow("定位成功这是你当前的位置!,移动红点标注目标位置，你也可以直接修改上方位置,系统自动定位!", opts);  // 创建信息窗口对象
                 marker1.openInfoWindow(infoWindow);      // 打开信息窗口
                 doit(point);

             } else {
                 //alert('failed' + this.getStatus());
             }
         })
     }
     function doit(point) {
         if (point) {
             document.getElementById('lat').value = point.lat;
             document.getElementById('lng').value = point.lng;
             map.setCenter(point);
             map.centerAndZoom(point, 16);
             map.panTo(point);

             var cp = map.getCenter();
             myGeo.getLocation(point, function (result) {
                 if (result) {
                     document.getElementById('suggestId').value = result.address;
                 }
             });

             marker2 = new BMap.Marker(point);        // 创建标注  
             var opts = {
                 width: 220,     // 信息窗口宽度 220-730
                 height: 60,     // 信息窗口高度 60-650
                 title: ""  // 信息窗口标题
             }
             var infoWindow = new BMap.InfoWindow("拖拽地图或红点，在地图上用红点标注您的店铺位置。", opts);  // 创建信息窗口对象
             marker2.openInfoWindow(infoWindow);      // 打开信息窗口

             map.addOverlay(marker2);                     // 将标注添加到地图中

             marker2.enableDragging();
             marker2.addEventListener("dragend", function (e) {
                 document.getElementById('lat').value = e.point.lat;
                 document.getElementById('lng').value = e.point.lng;
                 myGeo.getLocation(new BMap.Point(e.point.lng, e.point.lat), function (result) {
                     if (result) {
                         $('#suggestId').val(result.address);
                         marker2.setPoint(new BMap.Point(e.point.lng, e.point.lat));
                         map.panTo(new BMap.Point(e.point.lng, e.point.lat));
                       
                     }
                 });
             });

             map.addEventListener("dragend", function showInfo() {
                 var cp = map.getCenter();
                 myGeo.getLocation(new BMap.Point(cp.lng, cp.lat), function (result) {
                     if (result) {
                         document.getElementById('suggestId').value = result.address;
                         document.getElementById('lat').value = cp.lat;
                         document.getElementById('lng').value = cp.lng;
                      // 移动标注
                         marker2.setPoint(new BMap.Point(cp.lng, cp.lat));
                         map.panTo(new BMap.Point(cp.lng, cp.lat));
                         
                     }
                 });
             });

             map.addEventListener("dragging", function showInfo() {
                 var cp = map.getCenter();
                 //marker1.setPoint(new BMap.Point(cp.lng,cp.lat));        // 移动标注
                 marker2.setPoint(new BMap.Point(cp.lng, cp.lat));
                 map.panTo(new BMap.Point(cp.lng, cp.lat));
                 map.centerAndZoom(marker2.getPoint(), map.getZoom());
             });
         }
     }

     function loadmap() {
         //var province = document.getElementById('city').value;
         var city = document.getElementById('suggestId').value;
         var myCity = new BMap.LocalCity();
         // 将结果显示在地图上，并调整地图视野  
         myGeo.getPoint(city, function (point) {
             if (point) {
                 //marker1.setPoint(new BMap.Point(point.lng,point.lat));        // 移动标注
                 marker2.setPoint(new BMap.Point(point.lng, point.lat));
                 //window.external.setlngandlat(marker2.getPoint().lng,marker2.getPoint().lat);
                 //alert(point.lng + "  ddd " + point.lat);
                 document.getElementById('lat').value = point.lat;
                 document.getElementById('lng').value = point.lng;
                 map.panTo(new BMap.Point(marker2.getPoint().lng, marker2.getPoint().lat));
                 map.centerAndZoom(marker2.getPoint(), map.getZoom());
             }
         });//({},province)
         //var citys = new BMap.LocalSearch(map, { renderOptions: { map: map, autoViewport: true } });
         //citys.search(city)
     }

     function setarrea(address, city) {
         $('#suggestId').val(address);
         //$('city').value=city;
         window.setTimeout(function () {
             loadmap();
         }, 2000);
     }

     function initarreawithpoint(lng, lat) {
         window.setTimeout(function () {
             //marker1.setPoint(new BMap.Point(lng,lat));        // 移动标注
             marker2.setPoint(new BMap.Point(lng, lat));
             //window.external.setlngandlat(lng,lat);
             map.panTo(new BMap.Point(lng, lat));
             map.centerAndZoom(marker2.getPoint(), map.getZoom());
         }, 2000);
     }
     $("#suggestId").change(function () { loadmap(); })
     $("#positioning").click(function () { loadmap(); });

 }
 </script>
</html>