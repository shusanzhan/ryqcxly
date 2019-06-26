<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../../../commons/taglib.jsp" %>
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
<title>${customerRecord.name } 线索无效登记</title>
</head>
<body>
<div class="views content_title navbar-fixed-top">
	 <a id="back" href="javascript:history.back()">
        <img src="${ctx }/images/jm/NavButtonBack.png" class="return">
    </a>
    <span id="page_title">${customerRecord.name }线索无效登记</span>
</div>
<br>
<br>
<br>
<div class="orderContrac detail">
	<div class="title" align="left">
	 		<c:if test="${empty(customerRecord.name) }">
				客户：	
				<c:if test="${empty(customerRecord.customer.name) }">
					无
				</c:if>
				<c:if test="${!empty(customerRecord.customer.name) }">
					${customerRecord.customer.name }
				</c:if>
				<br/>
			</c:if>
 			<c:if test="${!empty(customerRecord.name) }">
				客户：	${customerRecord.name }<br>
				联系电话：<a href="tel:${customerRecord.mobilePhone }">${customerRecord.mobilePhone }</a><br>
				所在区域：${customerRecord.address }
			</c:if><br>
			</div>
			<div class="line"></div>
	<div style="margin: 0 auto;margin: 5px;">
		<div style="color:#8a8a8a;padding-left: 5px; ">
			登记日期：<fmt:formatDate value="${customerRecord.createDate }" pattern="yyyy-MM-dd"/><br/>
			线索类型：
  			${customerRecord.customerType.name }
			<br>
			车型：
			<c:if test="${empty(customerRecord.brand) }">
				<c:if test="${empty(customerRecord.carModels)}">
					-
				</c:if>
				<c:if test="${!empty(customerRecord.carModels)}">
					${customerRecord.carModels }
				</c:if>
			</c:if>
			${customerRecord.brand.name }
			${customerRecord.carSeriy.name }
			${customerRecord.carModel.name }${customerRecord.carModelStr}
			<br>
			进店/来电时间：
			<c:if test="${customerRecord.customerType.dbid!=1 }">
				<fmt:formatDate value="${customerRecord.createDate }" pattern="yyyy-MM-dd HH:mm"/> 
			</c:if>
			<c:if test="${customerRecord.customerType.dbid==1 }">
				${customerRecord.comeInTime}
			</c:if>
			<br>
			进店人数：
				<c:if test="${customerRecord.customerType.dbid!=1 }">
					?
				</c:if>
				<c:if test="${customerRecord.customerType.dbid==1 }">
					${customerRecord.customerNum}
					人
				</c:if>
			<br>
			信息来源：${customerRecord.customerInfrom.name }
			<br>
			线索状态：
			<c:if test="${customerRecord.resultStatus==2 }">
				<span style="color: green;">转为登记</span>
			</c:if>
			<c:if test="${customerRecord.resultStatus==1 }">
				<span style="color: pink;">等待...</span>
			</c:if>
			<c:if test="${customerRecord.resultStatus==3 }">
				<span style="color: red;">无效</span>
			</c:if>
			<c:if test="${customerRecord.resultStatus==4 }">
				<span style="color: green;">已绑定</span>
			</c:if><br>
			来店次数：
			<c:if test="${customerRecord.comeinNum==0 }">
				未到店
			</c:if>
			<c:if test="${customerRecord.comeinNum==1 }">
				初次到店
			</c:if>
			<c:if test="${customerRecord.comeinNum==2 }">
				二次来店
			</c:if>
			<br>
			备注：
			${customerRecord.note }
			<br>
		</div>
		<br>
	</div>
</div>
<div style="margin: 0 auto;width: 92%;margin-top: 20px;">
<form class="form-inline" action="" name="frmId" id="frmId" method="post" >
	    <input type="hidden" name="dbid" id="dbid" value="${customerRecord.dbid}">
		<div class="form-group" >
		  	<label class="control-label" for="inputWarning1">无效原因</label>
		  	<select class="form-control"  id="customerRecordClubInvalidReasonId" name="customerRecordClubInvalidReasonId" checkType="integer,1" error='请选择品牌'>
		  		<option value="">请选择...</option>
		  		<c:forEach var="customerRecordClubInvalidReason" items="${customerRecordClubInvalidReasons }">	  	
		  			<option value="${customerRecordClubInvalidReason.dbid }">${customerRecordClubInvalidReason.name }</option>
		  		</c:forEach>
			</select>
		</div>
		<div class="form-group" >
		  	<label class="control-label" for="inputWarning1">备注</label>
		  	<textarea  name="note" id="note"	 class="form-control"  title="" checkType="string,2" tip="请填写一点备注吧">${customerLastBussi.note }</textarea>
		</div>
</form>
</div>
<div class="buttomBar">
    <input type="button" name="mobileCommit" value="保存" id="tele_register" class="addbutton" onclick="submitFrm('frmId','${ctx}/qywxCustomerRecord/saveInvalid')">
</div>	
<br>
<br>
<br>
</body>
<script src="${ctx }/widgets/bootstrap3/jquery.min.js"></script>
<script src="${ctx }/widgets/bootstrap3/js/bootstrap.min.js"></script>
<script src="${ctx }/widgets/utile/wechat.js"></script>
<script type="text/javascript">
function submitFrm(frmId,url){
	try {
		if (undefined != frmId && frmId != "") {
			var params = $("#" + frmId).serialize();
				var url2="";
				$.ajax({	
					url : url, 
					data : params, 
					async : false, 
					timeout : 20000, 
					dataType : "json",
					type:"post",
					success : function(data, textStatus, jqXHR){
						//alert(data.message);
						var obj;
						if(data.message!=undefined){
							obj=$.parseJSON(data.message);
						}else{
							obj=data;
						}
						if(obj[0].mark==1){
							//错误
							showMo(data[0].message,false);
							$(".addbutton").attr("onclick",url2);
							return ;
						}else if(obj[0].mark==0){
							showMo(data[0].message,true);
							setTimeout(
									function() {
										window.location.href = obj[0].url
									}, 1000);
						}
					},
					complete : function(jqXHR, textStatus){
						$(".addbutton").attr("onclick",url2);
						var jqXHR=jqXHR;
						var textStatus=textStatus;
					}, 
					beforeSend : function(jqXHR, configs){
						url2=$(".addbutton").attr("onclick");
						$(".addbutton").attr("onclick","");
						var jqXHR=jqXHR;
						var configs=configs;
					}, 
					error : function(jqXHR, textStatus, errorThrown){
								showMo(data[0].message);
							$(".addbutton").attr("onclick",url2);
					}
				});
			} else {
				return;
			}
	} catch (e) {
		showMo(e,false);
		return;
	}
}
</script>
</html>