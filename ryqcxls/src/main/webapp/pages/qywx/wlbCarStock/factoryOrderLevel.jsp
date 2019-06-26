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
<title>库存查询</title>
<style type="text/css">
body {
    font-family: "Microsoft Yahei",tahoma,verdana,arial,sans-serif;
    font-size: 14px;
    line-height: 1.231;
}
	#badgeSelf{
		float: none;
		color: #FFF;
		background-color:  #eb6877;
	}
	
.list-group-item {
    background-color: #fff;
    border: 1px solid #ddd;
    display: block;
    margin-bottom: -1px;
    padding: 15px 10px;
    position: relative;
}
.form-inline tr{
	height: 45px;
}
</style>
</head>
<body>
<div class="views content_title navbar-fixed-top">
    <a id="back" href="javascript:history.back()">
        <img src="${ctx }/images/jm/NavButtonBack.png" class="return">
    </a>
    <span id="page_title">
    ${storeAgeLevel.name}
	    <c:if test="${!empty(carSeriy) }">
	    -${carSeriy.name }
	    </c:if>
    </span>
    <a class="go_home" href="${ctx }/qywxWlbFacotoryOrder/index">
    	<img src="${ctx }/images/jm/go_home.png" alt="">
    </a>
</div>
<br>
<br>
<br>
<ul class="list-group">
<c:if test="${fn:length(factoryOrders)>0 }" var="status">
	<c:forEach items="${factoryOrders }" var="factoryOrder" varStatus="i">
		<div class="orderContrac" onclick="window.location.href='${ctx}/qywxWlbFacotoryOrder/factoryOrderDetail?dbid=${factoryOrder.dbid }'">
			<div class="title" align="left">
	  			车&#12288;&#12288;型：${factoryOrder.carSeriy.name }${factoryOrder.carModel.name }${factoryOrder.carColor.name }<br/>
	  			工厂日期：<fmt:formatDate value="${factoryOrder.factoryOrderDate}" pattern="yyyy-MM-dd"/>
	  			<br>
	  			序&#12288;&#12288;号：${i.index+1 }
  			</div>
  			<div class="line"></div>
			<div style="margin: 0 auto;margin: 5px;">
			<div style="color:#8a8a8a;padding-left: 5px; ">
				<table>
				<tr>
					<td colspan="2">VIN码：${factoryOrder.vinCode}&#12288;</td>
				</tr>
				<tr>
					<td colspan="2">
						<c:set value="${factoryOrder.carReceiving }" var="carReceiving"></c:set>
						库房：&#12288;
						${carReceiving.storeArea.name }
						${carReceiving.storeRoom.name }
						${carReceiving.storage.name }
					</td>
				</tr>
				<tr>
					<td>奖励：${factoryOrder.totalRewardMoney }</td>
					<td class="formTableTdLeft">
						惠民：${factoryOrder.huimin }
					</td>
				</tr>
				<tr >
					<td >加装：
						<c:if test="${factoryOrder.isInstall==1 }">
							<span style="color: red;">未加装</span>
						</c:if>
						<c:if test="${factoryOrder.isInstall==2 }">
							<span style="color: green;">加装</span>
						</c:if>
					</td>
					<td >
						预定：
						<c:if test="${factoryOrder.reserveStatus==2 }">
							<span style="color: blue;">已绑定</span>
						</c:if>
						<c:if test="${factoryOrder.reserveStatus==3 }">
							<span style="color: green;">已预定</span>
						</c:if>
						<c:if test="${factoryOrder.reserveStatus==1 }">
							<span style="color: red;">未预定</span>
						</c:if>
					</td>				
				</tr>
				<tr >
					<td class="formTableTdLeft">异常：
						<c:if test="${factoryOrder.abnormalStatus==2 }">
							<span style="color:red;">异常</span>
						</c:if>
						<c:if test="${factoryOrder.abnormalStatus==1 }">
							<span style="color: green;">正常</span>
						</c:if>
					</td>
					<td class="formTableTdLeft">库存：
						<c:if test="${factoryOrder.carStatus==2 }">
							<span style="color: green;">在库</span>
						</c:if>
						<c:if test="${factoryOrder.carStatus==1 }">
							<span style="color: red;">在途</span>
						</c:if>
					</td>
				</tr>
			</table>
					
				</div>
			</div>
			<%-- <div class="line"></div>
			<div style="margin: 5px;line-height: 20px;min-height: 30px;">
				<div class="status">待审批</div>
  				<div class="des">
  					总价：<span class="price"><fmt:formatNumber value="${orderContract.totalPrice }" pattern="￥#,#00.00"></fmt:formatNumber></span>
  				</div>
  				<div style="clear: both;"></div>
			</div> --%>
		</div>
	</c:forEach>
 </c:if>
 <c:if test="${status==false }">
 	 <li class="list-group-item">
 	 	${carModel.name } 车型无库存
	 </li>
 </c:if>
</ul>
<div class="modal fade" id="exampleModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
  <div class="modal-dialog">
    <div class="modal-content">
      <div class="modal-body">
      	<form class="form-inline" action="${ctx }/qywxWlbFacotoryOrder/factoryOrderList?carModelId=${param.carModelId}" name="frmId" id="frmId" method="post">
      	 <table>
      	 	<tr height="">
      	 		<td width="60"><label for="exampleInputName2">颜色</label></td>
      	 		<td width="240">
	      	 		<select class="form-control" id="carColorId" name="carColorId">
			    	<option value="">请选择...</option>
			    	<c:forEach var="carColor" items="${carColors }">
				    	<option value="${carColor.dbid }" ${param.carColorId==carColor.dbid }>${carColor.name }</option>
			    	</c:forEach>
			    </select>
			    </td>
      	 	</tr>
      	 	<tr>
      	 		<td width="60"><label for="exampleInputName2">惠民</label></td>
      	 		<td width="240">
	      	 		<select class="form-control" id="huimin" name="huimin" >
			    	<option value="" >请选择...</option>
						<option value="惠民" ${param.huimin=='惠民'?'selected="selected"':'' } >惠民</option>
						<option value="非惠民" ${param.huimin=='非惠民'?'selected="selected"':'' } >非惠民</option>
			    </select>
			    </td>
      	 	</tr>
      	 	<tr>
      	 		<td width="60"><label for="exampleInputName2">加装</label></td>
      	 		<td width="240">
	      	 		<select class="form-control"  id="isInstall" name="isInstall">
			    	<option value="0" >请选择...</option>
						<option value="1" ${param.isInstall==1?'selected="selected"':'' } >未加装</option>
						<option value="2" ${param.isInstall==2?'selected="selected"':'' } >加装</option>
			    </select>
			    </td>
      	 	</tr>
      	 	<tr>
      	 		<td width="60"><label for="exampleInputName2">库存状态</label></td>
      	 		<td width="240">
	      	 		<select class="form-control" id="carStatus" name="carStatus" >
			    		<option value="0" >请选择...</option>
						<option value="1" ${param.carStatus==1?'selected="selected"':'' } >在途</option>
						<option value="2" ${param.carStatus==2?'selected="selected"':'' } >在库</option>
			    </select>
			    </td>
      	 	</tr>
      	 	<tr>
      	 		<td width="60"><label for="exampleInputName2">预定</label></td>
      	 		<td width="240">
	      	 		<select class="form-control" id="reserveStatus" name="reserveStatus" >
			    		<option value="0" >请选择...</option>
						<option value="1" ${param.reserveStatus==1?'selected="selected"':'' } >未预定</option>
						<option value="2" ${param.reserveStatus==2?'selected="selected"':'' } >已绑定</option>
						<option value="3" ${param.reserveStatus==3?'selected="selected"':'' } >已预定</option>
			    </select>
			    </td>
      	 	</tr>
      	 	<tr>
      	 		<td width="60"><label for="exampleInputName2">异常</label></td>
      	 		<td width="240">
	      	 		<select class="form-control" id="abnormalStatus" name="abnormalStatus">
				    	<option value="0" >请选择...</option>
						<option value="1" ${param.abnormalStatus==1?'selected="selected"':'' } >正常</option>
						<option value="2" ${param.abnormalStatus==2?'selected="selected"':'' } >异常</option>
			    </select>
			    </td>
      	 	</tr>
      	 </table>
		</form>
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-default" data-dismiss="modal">取&nbsp;&nbsp;消</button>
        <button type="button" class="btn btn-primary" onclick="$('#frmId')[0].submit()">查询</button>
      </div>
    </div>
  </div>
</div>
<br>
<br>
<br>
<br>
</body>
<script src="${ctx }/widgets/bootstrap3/jquery.min.js"></script>
<script src="${ctx }/widgets/bootstrap3/js/bootstrap.min.js"></script>
<script type="text/javascript">
function showSearch(){
	$('.modal-dialog').css({  
        'margin-top':'0','width':'100%','height':'100%'
    });  
	$('.modal-content').css({'border-radius':'0','box-shadow':'0 0 rgba(0, 0, 0, 0.5)'});
	$('#exampleModal').modal();
}
$(function () {
	var window_w=window.innerWidth|| document.documentElement.clientWidth|| document.body.clientWidth;
	var window_h=window.innerHeight|| document.documentElement.clientHeight|| document.body.clientHeight;
	if($('.go_top').length==0){
	    $('body').append('<a href="#" class="go_top"><img src="${ctx}/images/jm/icon_top.png" data-original=${ctx}/images/jm/icon_top.png" alt=""></a>');
	}
	$(window).scroll(function(e){
	    if(document.body.scrollTop+document.documentElement.scrollTop>window_h){
	        $('.go_top').show();
	    }
	    else{
	        $('.go_top').hide();
	    }
	});
	$('.go_top').click(function(){
	    document.body.scrollTop = 0;
	    document.documentElement.scrollTop = 0;
	    return false;
	})
})
</script>
</html>