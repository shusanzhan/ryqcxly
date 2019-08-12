<%@page import="com.ystech.cust.model.CustomerImage"%>
<%@page import="java.util.Date"%>
<%@page import="com.ystech.core.util.DateUtil"%>
<%@page import="java.net.URLEncoder"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../../commons/taglib.jsp" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
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
<link href="${ctx }/css/qywx.css?da=${now}" type="text/css" rel="stylesheet"/>
<link href="${ctx }/widgets/bootstrap3/css/bootstrap.min.css?da=${now}" type="text/css" rel="stylesheet"/>
<link href="${ctx }/widgets/bootstrap3/css/bootstrap-theme.min.css" type="text/css" rel="stylesheet"/>
<title>${customer.name }上传交车照片</title>
<style type="text/css">
	#img{
		padding: 5px;
	}
	#img img{
		width: 100%;
	}
	.uploadMenu {
    background-color: #fafafa;
    border-top: 1px solid #c7c7c7;
    height: 40px;
    margin: auto 0;
    width: 100%;
	}
	.uploadMenu ul{
	   margin: 0 auto;
    overflow: hidden;
}
</style>
</head>
<body>
<div id="hearder_nav" class="views content_title navbar-fixed-top">
    <a id="back" href="javascript:history.back()">
        <img src="${ctx }/images/jm/NavButtonBack.png" class="return">
    </a>
    <span id="page_title">${customer.name }上传交车照片</span>
    <c:if test="${param.type==1 }">
	    <a class="go_home" href="${ctx }/qywxCustomer/index">
	    	<img src="${ctx }/images/jm/go_home.png" alt="">
	    </a>
    </c:if>
</div>
<br>
<br>
<br>

<div class="orderContrac detail">
	<div class="title" align="left">
 			客户：${customer.name }&nbsp;&nbsp;${customer.sex }<br/>
	  		电话：<a href="tel:${customer.mobilePhone }">${customer.mobilePhone }</a>
	</div>
	<div class="line"></div>
	<div style="margin: 0 auto;margin: 5px;">
		<div style="color:#8a8a8a;padding-left: 5px; ">
			车型：${customer.customerBussi.brand.name}&#12288;
			<c:set value="${customer.customerBussi.carSeriy.name}${ customer.customerBussi.carModel.name }" var="carModel"></c:set>
			<c:if test="${fn:length(carModel)>16 }" var="status">
				${fn:substring(carModel,0,16) }...
			</c:if>
			<c:if test="${ status==false}">
				${carModel }${customer.carModelStr}
			</c:if>
			<br>
			意向级别：${customer.customerPhase.name}<br>
			登记时间：<fmt:formatDate value="${customer.createFolderTime }"/> <br/>
			顾问：${customer.bussiStaff}（${customer.department.name}）<br>
		</div>
	</div>
	<c:if test="${customer.customerPidBookingRecord.wlStatus==2 }">
		<div class="line"></div>
		<div class="title" align="left">
	 			物流状态
		</div>
		<div class="line"></div>
		<div style="margin: 0 auto;margin: 5px;">
			<div style="color:#8a8a8a;padding-left: 5px; ">
			合同状态：<c:if test="${customer.customerPidBookingRecord.pidStatus==1 }">
				<span style="color: blue">已打印合同</span>
			</c:if>
			<c:if test="${customer.customerPidBookingRecord.pidStatus==2 }">
				<span style="color: blue">已经归档</span>
			</c:if>
			<c:if test="${customer.customerPidBookingRecord.pidStatus==3 }">
				<span style="color: #DD9A4B;">等待销售副总审批</span>
			</c:if>
			<c:if test="${customer.customerPidBookingRecord.pidStatus==4 }">
				<span style="color: #DD9A4B;">等待总经理审批</span>
			</c:if>
			<c:if test="${customer.customerPidBookingRecord.pidStatus==5 }">
				<span style="color: blue;">总经理同意流失</span>
			</c:if>
			<c:if test="${customer.customerPidBookingRecord.pidStatus==6 }">
				<span style="color: red;">总经理驳回申请</span>
			</c:if>
			<c:if test="${customer.customerPidBookingRecord.pidStatus==7 }">
				<span style="color: red;">销售副总驳回申请</span>
			</c:if>
			<br>
			交车状态：<c:if test="${customer.customerPidBookingRecord.wlStatus==0 }">
				<span class="dropDownContent">未提交</span>
			</c:if>
			<c:if test="${customer.customerPidBookingRecord.wlStatus==1 }">
				<span style="color: red;" class="dropDownContent">等待处理</span>
			</c:if>
			<c:if test="${customer.customerPidBookingRecord.wlStatus==2 }">
				<span class="dropDownContent" onclick="$.utile.openDialog('${ctx}/customerPidBookingRecord/viewWlbCustomerPidRecord?customerId=${customer.dbid }','查看处理记录',1024,380)">已经处理</span>
			</c:if>
			<br>
			车辆状态：
			<c:if test="${customer.customerPidBookingRecord.hasCarOrder==1 }">
				<span style="color: blue;">现车订单</span>
			</c:if>
			<c:if test="${customer.customerPidBookingRecord.hasCarOrder==2 }">
				<span style="color: green;">在途订单</span>
			</c:if>
			<c:if test="${customer.customerPidBookingRecord.hasCarOrder==3 }">
				<span style="color: red;">无车订单</span>
			</c:if>
			<br>
			vin码:
			<a href="${ctx }/qywxCustomer/factoryOrderDetail?vinCode=${customer.customerPidBookingRecord.vinCode}&type=1">${customer.customerPidBookingRecord.vinCode}</a>
		</div>
		</div>
	</c:if>
</div>
<c:if test="${!empty(customerImage) }">
<div class="buttomBar">
	<c:if test="${customerImageApproval.drivingStatus==1 }">
	    <input type="button" name="mobileCommit" value="上传行驶证照片" id="tele_register" class="addbutton" onclick="window.location.href='${ctx }/qywxCustomerImage/uploadImageDriving?customerid=${customer.dbid }&type=1'">
	</c:if>
	<c:if test="${customerImageApproval.drivingStatus==2||customerImageApproval.drivingStatus==4 }">
	    <input type="button" name="mobileCommit" value="查看行驶证照片" id="tele_register" class="addbutton" onclick="window.location.href='${ctx }/qywxCustomerImage/uploadImageDriving?customerid=${customer.dbid }&type=1'">
	</c:if>
	<c:if test="${customerImageApproval.drivingStatus==3 }">
	    <input type="button" name="mobileCommit" value="重传行驶证照片" id="tele_register" class="addbutton" onclick="window.location.href='${ctx }/qywxCustomerImage/uploadImageDriving?customerid=${customer.dbid }&type=1'">
	</c:if>
</div>
</c:if>
<div class="orderContrac detail" >
	<div class="title" align="left">
		上传交车图片
	</div>
	<div class="line"></div>
	<div style="margin: 0 auto;margin: 5px;" id="img">
		<c:if test="${!empty(customerImage) }">
			<img alt=''  src='${customerImage.url }'></img>
			<div id='chooseImage1' style='height: 120px;width: 100%;font-size: 82px;line-height: 120px;text-align: center;color: #8a8a8a;display:none;'>+</div>
		</c:if>
		<c:if test="${empty(customerImage) }">
			<div id='chooseImage1' style='height: 120px;width: 100%;font-size: 82px;line-height: 120px;text-align: center;color: #8a8a8a'>+</div>
		</c:if>
	</div>
</div>
<c:if test="${customerImageApproval.handCarStatus<4 }">
<div class="oneMenu">
	<ul style="width: 90%;">
		<c:if test="${empty(customerImage) }">
			 <li  style="width: 50%;">
             <a id="chooseImage" href="javascript:void(-1)">
             	选择照片
             </a>
         </li>
		</c:if>
		<c:if test="${!empty(customerImage) }">
		  <li id="deleteBut" style="width: 50%;">
             <a  href="javascript:void(-1)" onclick="deleteCustomerImage()">
             	删除照片
             </a>
         </li>
		  <li id="uploadBut" style="width: 50%;display: none;">
             <a id="chooseImage" href="javascript:void(-1)">
             	选择照片
             </a>
         </li>
		</c:if>
        
         <li  style="width: 50%">
             <a id="uploadImage"  href="javascript:void(-1)">
             	上传照片
             </a>
         </li>
      </ul>
</div>	
</c:if>
<br>
<br>
<br>
<br>
</body>
<script src="${ctx }/widgets/bootstrap3/jquery.min.js"></script>
<script src="${ctx }/widgets/bootstrap3/js/bootstrap.min.js"></script>
<script src="${ctx }/widgets/utile/wechat.js"></script>
<script src="http://res.wx.qq.com/open/js/jweixin-1.0.0.js"></script>
<script type="text/javascript">
wx.config({
    debug: false,
    appId: '${weixin.appId}',
    timestamp: '${weixin.timestamp}',
    nonceStr: '${weixin.nonceStr}',
    signature: '${weixin.signature}',
    jsApiList: [
      'checkJsApi',
      'chooseImage',
      'uploadImage'
    ]
});
function deleteCustomerImage(){
	$.post('${ctx}/qywxCustomerImage/delete?dbid=${customerImage.dbid}',{},function(data){
		 if (data[0].mark == 0) {// 返回标志为0表示添加数据成功
			 	$("#deleteBut").hide();
			 	$("#uploadBut").show();
			 	$("#chooseImage1").show();
			 	$("#img img").remove();
 	  			alert(data[0].message);
			}
			if (data[0].mark == 1) {// /返回标志为1表示保存数据失败
 	  			alert(data[0].message);
				// 保存失败时页面停留在数据编辑页面
			}
	})
}
wx.ready(function () {
    // 1 判断当前版本是否支持指定 JS 接口，支持批量判断
      wx.checkJsApi({
        jsApiList: [
             'checkJsApi',
             'chooseImage',
             'uploadImage'
        ],
        success: function (res) {
         	//alert(JSON.stringify(res));
        }
      });
      // 5 图片接口
      // 5.1 拍照、本地选图
      var images = {
        localId: [],
        serverId: []
      };
      document.querySelector('#chooseImage').onclick = function () {
        wx.chooseImage({
          success: function (res) {
        	if(res.localIds.length>1){
        		alert("只能选择一张图片!");
        		return ;
        	}
            images.localId = res.localIds;
            var img="";
            for(var i=0;i<res.localIds.length;i++){
           		img=img+"<img alt='' src='"+res.localIds[i]+"'></img>";
            }
            $("#chooseImage1").hide();
            $("#img").text("");
            $("#img").append(img);
           	$("#chooseImage").text("重新选择照片");
          }
        });
      };
      document.querySelector('#chooseImage1').onclick = function () {
        wx.chooseImage({
          success: function (res) {
        	if(res.localIds.length>1){
          		alert("只能选择一张图片!");
          		return ;
          	}
            images.localId = res.localIds;
            var img="";
            for(var i=0;i<res.localIds.length;i++){
           		img=img+"<img alt='' src='"+res.localIds[i]+"'></img>";
            }
            $("#chooseImage1").hide();
            $("#img").text("");
           	$("#img").append(img);
        	$("#chooseImage").text("重新选择照片");
          }
        });
      };

      // 5.3 上传图片
      document.querySelector('#uploadImage').onclick = function () {
        var i = 0, length = images.localId.length;
        if (length== 0) {
          alert('请先选择图片,在上传照片.');
          return;
        }
        if(length!=1){
        	 alert('只能上传一张图片，请确认.');
             return;
        }
        images.serverId = [];
        function upload() {
          wx.uploadImage({
            localId: images.localId[i],
            success: function (res) {
              i++;
              //alert('已上传：' + i + '/' + length);
              images.serverId.push(res.serverId);
              if (i < length) {
                upload();
              }
              //服务器同步数据
              var serverId = res.serverId; // 返回图片的服务器端ID
              $.post("${ctx}/qywxCustomerImage/saveImage?mediaId="+serverId+"&customerId=${customer.dbid}&num=1",{},function(data){
            	  if (data[0].mark == 0) {// 返回标志为0表示添加数据成功
            	  		alert(data[0].message);
            	  		window.location.href=data[0].url;
            	  		return ;
					}
					if (data[0].mark == 1) {// /返回标志为1表示保存数据失败
            	  		alert(data[0].message);
						// 保存失败时页面停留在数据编辑页面
					}
              });
            },
            fail: function (res) {
              alert(JSON.stringify(res));
            }
          });
        }
        upload();
      };

});
wx.error(function (res) {
    //alert(res.errMsg);
  });
</script>
</html>