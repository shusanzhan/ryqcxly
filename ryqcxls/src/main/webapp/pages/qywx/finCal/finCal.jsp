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
 <!-- apple devices fullscreen -->
    <meta name="apple-mobile-web-app-status-bar-style" content="black-translucent" />
    <link rel="stylesheet" href="${ctx }/widgets/WeUI/style/weui.css?${now}" type="text/css" />
	<script src="${ctx }/widgets/bootstrap3/jquery.min.js"></script>
	<script src="${ctx }/widgets/WeUI/example/zepto.min.js"></script>
    <script src="${ctx }/widgets/WeUI/example/router.min.js"></script>
<title>金融计算器</title>
<style type="text/css">
	.form-controlSe{
		margin-top: 5px;
	}
	.form-group{
		margin-bottom: 10px;
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
    <span id="page_title">金融计算器</span>
</div>
<div class="weui_cells_title">车型</div>
<form action="" name="frmId" id="frmId"  target="_self">
<div class="weui_cells weui_cells_form">
  <div class="weui_cell weui_cell_select weui_select_after">
      <div class="weui_cell_hd" style="width: 80px">
         	品牌
      </div>
      <div class="weui_cell_bd weui_cell_primary">
          <select id="brandId" name="brandId" class="weui_select" onchange="ajaxCarSeriy(this.value)" checkType="integer,1" tip="请选择品牌">
         	 <option value="">请选择...</option>
             <c:forEach var="brand" items="${brands }">
           	<option value="${brand.dbid }" >${brand.name }</option>
             </c:forEach>
          </select>
      </div>
	</div>
   <div class="weui_cell weui_cell_select weui_select_after">
      <div class="weui_cell_hd" style="width: 80px">
         	车系
      </div>
      <div class="weui_cell_bd weui_cell_primary" id="carModelLabel">
          <select id="carSeriyId" name="carSeriyId" class="weui_select" onchange="ajaxFinProduct(this.value)" >
				<option value="">请先选择品牌...</option>
			</select>
      </div>
  </div>
</div>
<div class="weui_cells_title">贷款信息</div>
<div class="weui_cells weui_cells_form">
  <div class="weui_cell weui_cell_select weui_select_after">
      <div class="weui_cell_hd" style="width: 80px">
         	贷款产品
      </div>
      <div class="weui_cell_bd weui_cell_primary" id="finProductTr">
          <select id="finProductId" name="finProductId" class="weui_select" onchange="ajaxFinProductItem(this.value)">
				<option value="">请先选择车系...</option>
			</select>
      </div>
	</div>
   <div class="weui_cell weui_cell_select weui_select_after">
      <div class="weui_cell_hd" style="width: 80px">
         	年限
      </div>
      <div class="weui_cell_bd weui_cell_primary" id="finProductItemTr">
          <select id="finProductItemId" name="finProductItemId" class="weui_select" onchange="jisuan()">
				<option value="">请先选择贷款产品...</option>
			</select>
      </div>
  </div>
  <div class="weui_cell">
       <div class="weui_cell_hd">
       	<label class="weui_label" style="width: 120px">贷款金额（元）</label>
       </div>
       <div class="weui_cell_bd weui_cell_primary">
           <input type="text" id="loanMoney" name="loanMoney"  value="" placeholder="请输入贷款金额"  class="weui_input">
       </div>
   </div>
</div>
</form>
<div class="weui_btn_area">
	<a href="javascript:;" class="weui_btn weui_btn_primary" onclick="sbmit()">计算</a>
</div>
<br>
<br>
<div class="orderContrac" style="border: 0;width: 100%;">
			<div class="title" align="left">
	  			贷款信息
  			</div>
  			<div class="line"></div>
			<div style="margin: 0 auto;margin: 5px;">
				<div style="color:#8a8a8a;padding-left: 5px; ">
					月供：<span id="monthSupPrice">0.00</span>&#12288;
					<br>
					实际利息（元）：<span id="actureDis">0.00</span>
					<br>
					年利率%：<span id="annualInterest">0.00</span>
					<br>
					贷款期数（月）：<span id="monthLong">0.00</span>
					<br>
					公司承担利息（元）：<span id="shopDis">0.00</span>
				</div>
			</div>
			<div class="line"></div>
		</div>
<br>
<br>
</body>
<script src="${ctx }/widgets/bootstrap3/jquery.min.js"></script>
<script src="${ctx }/widgets/bootstrap3/js/bootstrap.min.js"></script>
<script type="text/javascript">
function ajaxCarSeriy(val){
	if(null==val||val==''){
		alert("请选择品牌");
		return false;
	}
	$("#carModelLabel").text("");
	$.post("${ctx}/qywxFinCal/ajaxCarSeriyByStatus?brandId="+val+"&dateTime="+new Date(),{},function (data){
		if(data!="error"){
			$("#carModelLabel").append(data);
		}
	});
}
function ajaxFinProduct(val){
	if(null==val||val==''){
		alert("请选择车系");
		return false;
	}
	$("#finProductTr").text("");
	$.post("${ctx}/qywxFinCal/ajaxFinProduct?carSeriyId="+val+"&dateTime="+new Date(),{},function (data){
		if(data!="error"){
			$("#finProductTr").append(data);
		}
	});
}
function ajaxFinProductItem(val){
	if(null==val||val==''){
		alert("请选产品");
		return false;
	}
	$("#finProductItemTr").text("");
	$.post("${ctx}/qywxFinCal/ajaxFinProductItem?finProductId="+val+"&dateTime="+new Date(),{},function (data){
		if(data!="error"){
			$("#finProductItemTr").append(data);
		}
	});
}
function jisuan(){
	var loanMoney=$("#loanMoney").val();
	if(null!=loanMoney&&loanMoney!=''){
		sbmit();
	}
}
function sbmit(){
	var params = $("#frmId").serialize();
	$.post("${ctx}/qywxFinCal/ajaxJs",params,function (data){
		if(data!="error"){
			if(data.repayType=="1"){
				$("#year").hide();
				$("#month").show();
			}
			if(data.repayType=="2"){
				$("#year").show();
				$("#month").hide();
			}
			$("#annualInterest").text(data.annualInterest);
			$("#yearSupPirce").text(data.yearSupPirce);
			$("#monthSupPrice").text(data.monthSupPrice);
			$("#actureDis").text(data.actureDis);
			$("#shopDis").text(data.shopDis);
			$("#monthLong").text(data.monthLong);
			$("#repayType").text(data.repayType);
		}
	});
}
</script>
</html>