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
<script type="text/javascript" src="${ctx }/widgets/My97DatePicker/WdatePicker.js"></script>
<title>经销商管理</title>
</head>
<body class="bodycolor">
<div class="location">
	<img src="${ctx}/images/homeIcon.png"/> &nbsp;
	<a href="javascript:void(-1);" onclick="window.parent.location.href='${ctx}/main/index'">首页</a>-
	<a href="javascript:void(-1);" onclick="">经销商管理</a>
</div>
<div class="line"></div>
<div class="frmContent" style="margin-bottom: 50px;">
	<form action="" name="frmId" id="frmId" style="margin-bottom: 40px;" target="_parent">
		<input type="hidden" name="enterprise.dbid" value="${enterprise.dbid }" id="dbid">
		<s:token></s:token>
		<table border="0" align="center" cellpadding="0" cellspacing="0" style="width: 92%;">
			<tr height="42">
				<td class="formTableTdLeft">全称:&nbsp;</td>
				<td ><input type="text" name="enterprise.allName" id="allName"	value="${enterprise.allName }" class="largeX text" title="用户名"	checkType="string,1" tip="全称不能为空"><span style="color: red;">*</span></td>
					<td class="formTableTdLeft">业务类型:&nbsp;</td>
				<td>
					<select id="bussiType" class="large text" name="enterprise.bussiType" checkType="integer,1">
						<option value="-1">请选择业务类型</option>
						<option value="1" ${enterprise.bussiType=='1'?'selected="selected"':'' } >小车业务</option>
						<option value="2" ${enterprise.bussiType=='2'?'selected="selected"':'' }>卡车业务</option>
						<option value="3" ${enterprise.bussiType=='3'?'selected="selected"':'' }>多品牌</option>
					</select>
				<span style="color: red;">*</span></td>
			</tr>
			<tr height="42">
				<td class="formTableTdLeft">简称:&nbsp;</td>
				<td ><input type="text" name="enterprise.name" id="name" value="${enterprise.name }" class="largeX text" title="简称"	checkType="string" tip="简称不能为空"><span style="color: red;">*</span></td>
				<td class="formTableTdLeft">电话:&nbsp;</td>
				<td ><input type="text" name="enterprise.phone" id="phone"	value="${enterprise.phone }" class="largeX text" title="电话"	checkType="phone" tip="电话不能为空"><span style="color: red;">*</span></td>
			</tr>
			<tr height="42">
				<td class="formTableTdLeft">传真:&nbsp;</td>
				<td ><input type="text" name="enterprise.fax" id="fax"
					value="${enterprise.fax }" class="largeX text" title="传真" checkType="phone" canEmpty="Y" tip="请输入正确的传真格式"></td>
				<td class="formTableTdLeft">邮编:&nbsp;</td>
				<td ><input type="text" name="enterprise.zipCode" id="zipCode"
					value="${enterprise.zipCode }" class="largeX text" checkType="zipCode" canEmpty="Y" tip="邮编" title="邮编"></td>
			</tr>
			<tr height="42">
				<td class="formTableTdLeft">地址:&nbsp;</td>
				<td >
					<input type="hidden" name="enterprise.point" id="point" value="${enterprise.point }">
					<input type="text" name="enterprise.address" id="suggestId"	value="${enterprise.address }" class="largeX text" title="地址">
					<a id="positioning" class="but butSave"  style="cursor: pointer;">定位</a>	
				</td>
				<td class="formTableTdLeft">网址:&nbsp;</td>
				<td ><input type="text" name="enterprise.webAddress" id="webAddress"
					value="${enterprise.webAddress }" class="largeX text" checkType="string" canEmpty="Y" tip="必须输入数字" title="网址"></td>
			</tr>
			<tr height="42">
				<td class="formTableTdLeft">到期时间:&nbsp;</td>
				<td>
					<input type="text" name="enterprise.endDate" id="endDate" value="${enterprise.endDate}"  class="largeX text" checkType="string,1" tip="到期时间不能为空" onFocus="WdatePicker({isShowClear:false,readOnly:true})">
				</td>
			</tr>
			<tr height="42">
				<td class="formTableTdLeft">开户银行:&nbsp;</td>
				<td ><input type="text" name="enterprise.bank" id="bank"
					value="${enterprise.bank }" class="largeX text" checkType="string" canEmpty="Y" tip="开户银行必须输入数字" title="开户银行"></td>
				<td class="formTableTdLeft">账号:&nbsp;</td>
				<td ><input type="text" name="enterprise.account" id="account"
					value="${enterprise.account }" class="largeX text" checkType="integer" canEmpty="Y" tip="账号必须输入数字" title="账号"></td>
			</tr>
			<tr height="32">
					<td class="formTableTdLeft">备注:&nbsp;</td>
					<td colspan="3">
						<textarea cols="120" rows="12" id="content" class="largeXX text" style="width: 786px;height: 60px;" name="enterprise.content">${enterprise.content }</textarea>
					</td>
				</tr>
				<tr>
			 	<td colspan="4">
					<div class="control-group">
						<div id="l-map" style="width: 100%;height: 320px;">
						</div>
					</div>
					<input type="hidden" name="lat" id="lat" value="${fn:split(enterprise.point,',')[0] }">
					<input type="hidden" name="lng" id="lng" value="${fn:split(enterprise.point,',')[1] }">	 		
		    	<td >
		    </tr>
		</table>
	</form>
	<div class="formButton">
		<a href="javascript:void(-1)"	onclick="setPoint();$.utile.submitForm('frmId','${ctx}/enterprise/save')"	class="but butSave">保存</a> 
		<a href="javascript:void(-1)"	onclick="window.history.go(-1)"	class="but butCancle">返回</a> 
	</div>
	</div>
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