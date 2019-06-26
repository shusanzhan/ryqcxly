<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="../../commons/taglib.jsp" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link href="${ctx }/css/common.css" type="text/css" rel="stylesheet"/>
<link  href="${ctx }/widgets/easyvalidator/css/validate.css" rel="stylesheet" type="text/css" />
<script type="text/javascript" src="${ctx }/widgets/bootstrap3/jquery.min.js"></script>
<script type="text/javascript" src="${ctx }/widgets/utile/utile.js"></script>
<script type="text/javascript" src="${ctx }/widgets/easyvalidator/js/jquery.bgiframe.min.js"></script>
<script type="text/javascript" src="${ctx }/widgets/easyvalidator/js/easy_validator.pack.js"></script>
<!-- <script type="text/javascript" src="http://api.map.baidu.com/api?v=1.4"></script> -->
  <script charset="utf-8" src="http://map.qq.com/api/js?v=2.exp"></script>
<title>用户购车关注点</title>
<style type="text/css">
#allmap {width: 100%;height: 400px;overflow: hidden;margin:0;}
</style>
</head>
<body class="bodycolor" onload="init()">
<div class="location">
     	<img src="${ctx}/images/homeIcon.png"/> &nbsp;
     	<a href="javascript:void(-1);" onclick="window.parent.location.href='${ctx}/main/index'">首页</a>-
<a href="javascript:void(-1);" onclick="window.location.href='${ctx}/emergencyHelp/queryList'">道路救援</a>-
<a href="javascript:void(-1);">
	道路紧急救援查看
</a>
</div>
<div class="line"></div>
<div id="mapContent" style="height: 340px;"></div>
  <div id="fitBoundsDiv"></div>
  <div id="centerDiv" style="display: none;"></div>
  <div id="zoomDiv"></div>
  <div id="containerDiv"></div>
  <div id="mapTypeIdDiv"></div>
  <div id="projection"></div>
  <input type="text" id="address" name="address" style="width: 320px;display: none;">
<div class="frmContent" style="margin-top: 25px;">
	<c:if test="${emergencyHelp.status==false }">
		<form action="" name="frmId" id="frmId"  target="_self">
			<s:token></s:token>
			<input type="hidden" name="dbid" id="dbid" value="${emergencyHelp.dbid }">
			<table border="0" align="center" cellpadding="0" cellspacing="0" style="width: 92%;">
				<tr height="32">
					<td class="formTableTdLeft">详细地址:&nbsp;</td>
					<td colspan="3">
						${emergencyHelp.address }
						${emergencyHelp.title }
					</td>
				</tr>
				<tr height="32">
					<td class="formTableTdLeft">会员:&nbsp;</td>
					<td colspan="3">
						${emergencyHelp.member.name }
					</td>
				</tr>
				<tr height="32">
					<td class="formTableTdLeft">手机号码:&nbsp;</td>
					<td colspan="3">
						${emergencyHelp.phone }
					</td>
				</tr>
				<tr height="32">
					<td class="formTableTdLeft">处理人状态:&nbsp;</td>
					<td colspan="3">
					<c:if test="${emergencyHelp.status==false }">
						<span style="color: red;">未处理</span>					
					</c:if>
					</td>
				</tr>
				<tr height="32">
					<td class="formTableTdLeft">备注:&nbsp;</td>
					<td>
						<textarea class="text textarea" rows="8" cols="60" name="note" id="note">${emergencyHelp.note }</textarea>
					</td>
				</tr>
			</table>
		</form>
		<div class="formButton">
			<a href="javascript:void(-1)"	onclick="$.utile.submitForm('frmId','${ctx}/emergencyHelp/update')"	class="but butSave">保&nbsp;&nbsp;存</a> 
		    <a href="javascript:void(-1)"	onclick="window.history.go(-1)" class="but butCancle">取&nbsp;&nbsp;消</a>
		</div>
	</c:if>
	<c:if test="${emergencyHelp.status==true }">
		<table border="0" align="center" cellpadding="0" cellspacing="0" style="width: 92%;">
				<tr height="32">
					<td class="formTableTdLeft">详细地址:&nbsp;</td>
					<td colspan="3">
						${emergencyHelp.address }
						${emergencyHelp.title }
					</td>
				</tr>
				<tr height="32">
					<td class="formTableTdLeft">会员:&nbsp;</td>
					<td colspan="3">
						${emergencyHelp.member.name }
					</td>
				</tr>
				<tr height="32">
					<td class="formTableTdLeft">手机号码:&nbsp;</td>
					<td colspan="3">
						${emergencyHelp.phone }
					</td>
				</tr>
				<tr height="32">
					<td class="formTableTdLeft">处理人状态:&nbsp;</td>
					<td colspan="1">
					<c:if test="${emergencyHelp.status==true }">
						<span style="color: blue;">已经处理</span>					
					</c:if>
					</td>
				</tr>
				<tr height="32">
					<td class="formTableTdLeft">处理人:&nbsp;</td>
					<td>
						${emergencyHelp.operator }
					</td>
				</tr>
				<tr>
					<td class="formTableTdLeft">处理时间:&nbsp;</td>
					<td>
						 <fmt:formatDate value="${emergencyHelp.modifyTime }" pattern="yyyy年MM月dd日 HH:mm "/>
					</td>
					
				</tr>
				<tr height="32">
					<td class="formTableTdLeft">备注:&nbsp;</td>
					<td colspan="1">
						${emergencyHelp.note }
					</td>
				</tr>
			</table>
			<div class="formButton">
		    <a href="javascript:void(-1)"	onclick="window.history.go(-1)" class="but butCancle">返&nbsp;&nbsp;回</a>
		</div>
	</c:if>
</div>
</body>
<script type="text/javascript">

// 百度地图API功能
var ipAddress="${emergencyHelp.coordinates}";
var geocoder=null,map=null,array=new Array(),beginLat,beginLng;
function init() {
    //div容器
    var container = document.getElementById("mapContent");
    var centerDiv = document.getElementById("centerDiv");
    var lat=ipAddress.split(",")[0];
    var lng=ipAddress.split(",")[1];
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
            position: qq.maps.ControlPosition.BOTTOM_LEFT
        }
    });
   beginLat=lat;
   beginLng=lng;
   geocoder=new qq.maps.Geocoder();
  //创建自定义控件
   var  width=($("#mapContent").width()-20)/2;
   var top=(340-28)/2;
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
    $("#getLatlngX").val(lat+","+lng);
    
    //
    //当地图中心属性更改时触发事件 
    var i=0;
    qq.maps.event.addListener(map, 'dragend', function() {
        centerDiv.innerHTML = "latlng:" + map.getCenter();
        $("#getLatlngX").val(map.getCenter().getLat()+","+map.getCenter().getLng());
       	codeLatLng(map.getCenter().getLat(),map.getCenter().getLng());
    });
  
}
//创建返回当前定位位置
function createNav(){
	var width=$("#mapContent").width();
	var middleControl = document.createElement("div");
    middleControl.style.left=(width-50)+"px";
    middleControl.style.top=245+"px";
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
function changeMapCneter(lat,lng) {
	 map.panTo(new qq.maps.LatLng(lat, lng));
	 
}
</script>
</html>