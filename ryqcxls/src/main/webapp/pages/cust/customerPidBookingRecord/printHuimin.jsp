<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ include file="../../commons/taglib.jsp" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>惠民档案</title>
</head>
<link rel="stylesheet" href="${ctx }/css/print.css" ></link>
<script src="${ctx }/widgets/bootstrap3/jquery.min.js"></script>
<style type="text/css" media="print">
.bar {
	display: none;
}
</style>
<style type="text/css" >
	table td, table th {
	    border: 1px solid #000000;
	    color: #000000;
	    line-height: 17px;
	    width: 100px;
	}
	.table{
		border: 1px solid black;margin: 5px;padding: 12px;
	}
	.table p{
		line-height: 200%;font-size: 14.5pt;margin-left: 12px;
	}
	.customerTable{
		margin: 5px;padding: 12px;border: 0;
	}
	.customerTable p{
		line-height: 200%;font-size: 14.5pt;margin-left: 12px;
	}
	.customerTable td{
		width: 50%;
	}
	u,span{
		font-size: 14.5pt;font-family: "Arial","sans-serif";
	}
</style>
<body>
<div class="bar">
	<a href="javascript:;" id="print" class="btn btn-success " style="margin-left: 5px;">【带公章打印】</a>
	<a href="javascript:;" id="notPrint" class="btn btn-success " style="margin-left: 5px;">【不带公章打印】</a>
		 &nbsp;&nbsp;&nbsp;&nbsp;
	<a href="javascript:void(-1)"	onclick="window.history.go(-1)" class="but butCancle">返回</a>
	 &nbsp;&nbsp;&nbsp;&nbsp;<span style="color: red;font-size: 14px;">带公章打印请使用彩色打印机</span>
</div>
<div class="testDriverContent" style="width: 92%;margin-bottom: 10px;">
	<table cellpadding="0" cellspacing="0" border="0" style="margin-top: 5px;">
		<tr height="50">
			<td class="noLine" style="border: 0px solid #000000;font-size: 14.5pt">
				<p>
					<span><em>编号（购车发票号）：</em></span>
					<u>
						&#12288;${outboundOrder.faPiaoHao}&#12288;&#12288;&#12288;&#12288;
					</u>
				</p>                       
			</td>
			<td class="noLine" style="border: 0px solid #000000;"> </td>
			<td style="border: 0px solid #000000;text-align: center;">
			<c:if test="${factoryOrder.brand.name=='奇瑞' }">
				<img src="${ctx }/images/image001.jpg" width="80"></img>
			</c:if>
			<c:if test="${factoryOrder.brand.name=='凯翼' }">
				<img src="${ctx }/images/kaiyi.jpg" width="80"></img>
			</c:if>
			</td>
		</tr>
		<tr>
			<td colspan="3" class="noLine"  style="text-align: center;border: 0px solid #000000;width: 160px;color: black;font-family: 黑体;font-size: 24pt;">“节能产品惠民工程补贴”确认函</td>
		</tr>
	</table>
</div>
<div class="testDriverContent" style='width: 92%;margin-bottom: 10px;line-height: 200%;color: #000000;font-size: 14.5pt;font-family: 宋体,Arial,Times New Roman;'>
	<p>尊敬的客户：</p>
	<p>&#12288;&#12288;您好！</p>
	<p>&#12288;&#12288;首先，感谢您对${factoryOrder.brand.name}汽车的支持和信任，购买${factoryOrder.brand.name}汽车节能汽车产品。</p>
	<p>&#12288;&#12288;您购买的<span><u>&#12288;${factoryOrder.sqrNo }&#12288;&#12288;</u></span>车型为${factoryOrder.brand.name}节能车型，根据国家《“节能产品惠民工程”节能汽车（<span>1.6</span>升及以下乘用车）推广实施细则》，您可享受国家<span>3000</span>元节能环保补贴。如您在购车过程中享受到了此次国家“节能产品惠民工程”节能汽车<span>3000</span>元现金补贴，请您对以下购车信息给予确认：</p>
	<table cellpadding=0 cellspacing=0 width="100%" class="table">
		<tr>
			<td>
				<p>姓名：
					<u>
						&#12288;${customer.name }&#12288;&#12288;&#12288;&#12288;&#12288;&#12288;&#12288;
					</u>
				</p>
				<p> 
				${customer.paperwork.name }号码：<u>&#12288;${customer.icard }&nbsp;&#12288;&#12288;&#12288;&#12288;&#12288;&#12288;&#12288;&#12288;&#12288;&#12288;&#12288;&#12288;</u></p>
				<p>购买车型（车辆型号）：<u>&#12288;${factoryOrder.sqrNo }&#12288;&#12288;&#12288;&#12288;&#12288;&#12288;&#12288;&#12288;&#12288;&#12288;&#12288;&nbsp;</u></p>
				<p>所购车型车架号（完整VIN码）：<u>&#12288;${factoryOrder.vinCode }&#12288;&#12288;&#12288;&#12288;&#12288;&#12288;&#12288;&#12288;&#12288;&#12288;&#12288;&#12288;&#12288;&#12288;&#12288;&#12288;&#12288;&#12288;&#12288;</u>
				</p>
				<p>购车价格：<u>&#12288;
					<fmt:formatNumber value="${outboundOrder.invoicePrice }" pattern="######"></fmt:formatNumber>
				&#12288;&#12288;</u>元，客户享受节能惠民补助后实际支付价款
					<u>
						&#12288;<fmt:formatNumber value="${outboundOrder.invoicePrice-3000 }" pattern="######"></fmt:formatNumber>&#12288;&#12288;&#12288;&#12288;&#12288;
					</u>元
				</p>
				<p>车辆牌照号（用户办理上牌后再填写）：<u>&#12288;${carPlateNo }&#12288;&#12288;&#12288;&#12288;&#12288;&#12288;&#12288;&#12288;&#12288;&#12288;&#12288;&#12288;&#12288;&#12288;&#12288;&#12288;&#12288;&#12288;&#12288;&#12288;&#12288;</u>
				</p>
				<p>
					已获得国家节能补贴金额：<u>&#12288;${factoryOrder.huiminMoney }&#12288;&#12288;&#12288;</u>元
				</p>
				<br></br>
			</td>
		</tr>
	</table>
	
	<div style="width: 100%;text-align: right;margin-bottom: -170px;" id="printImage1">
		<img src="${huiminTemplate.gzUrl }" alt="" width="220" height="220" style="margin-right: 100px;"/>
	</div>
	<table cellpadding=0 cellspacing=0 width="100%" class="customerTable" style="border: 0">
		<tr>
			<td width="60%" style="border: 0;width: 60%;" height="40">
				<p style="line-height: 150%">客户签名：
					<u>
						&#12288;&#12288;&#12288;&#12288;&#12288;&#12288;&#12288;&#12288;
					</u>
				</p>
				<p style="line-height: 150%">（用户已提供车辆牌照号并确认获得3000元现金补贴后签字）</p>
			</td>
			<td width="40%" style="border: 0;width: 40%;" height="40">
					<p>${factoryOrder.brand.name}汽车
						<u>
							${huiminTemplate.name }&#12288;&#12288;&#12288;
						</u>
						销售服务店
					</p>
			</td>
		</tr>
		<tr>
			<td style="border: 0;">
				<p><u>&#12288;<fmt:formatDate value="${now }" pattern="yyyy" /> &#12288;</u>年<u>&#12288;<fmt:formatDate value="${now }" pattern="MM" />&#12288;</u>月<u>&#12288;<fmt:formatDate value="${now }" pattern="dd" />&#12288;</u>日</p>
			</td>
			<td style="border: 0;">
				<p><u>&#12288;<fmt:formatDate value="${now }" pattern="yyyy" /> &#12288;</u>年<u>&#12288;<fmt:formatDate value="${now }" pattern="MM" />&#12288;</u>月<u>&#12288;<fmt:formatDate value="${now }" pattern="dd" />&#12288;</u>日</p>
			</td>
		</tr>
	</table>
		<p style="line-height: 300%">
		再次感谢您对${factoryOrder.brand.name }汽车和
			<u>&#12288;&#12288;&#12288;${huiminTemplate.name }&#12288;&#12288;&#12288;
			</u>销售服务店的大力支持，愿我们携手共进，共同进步！
	</p>
</div>
<img width="100%" height=3 src="${ctx }/images/image004.png" v:shapes="Line_x0020_5"></img>
<div class="testDriverContent" style='width: 92%;margin-bottom: 10px;line-height: 200%;color: #000000;font-size: 14.5pt;font-family: 宋体,Arial,Times New Roman;margin-top: 12px;'>
	<p style="line-height: 300%;">
		编号（购车发票号）：
			<u>&#12288;&#12288;&#12288;${outboundOrder.faPiaoHao}&#12288;&#12288;&#12288;
			</u>
	</p>
	<center style=" font-family: 黑体;font-size: 18pt;">补充协议</center>
	<p>&#12288;&#12288;根据国家《“节能产品惠民工程”节能汽车（<span>1.6</span>升及以下乘用车）推广实施细则》，消费者须提供所购车辆的“车辆牌照号”。为此，请您务必尽快按照国家机动车牌照相关法规要求办理上牌，并于上牌后一周内，提供《机动车行驶证》复印件一份，我们审核原件无误后，在国家“节能产品惠民工程补贴”政策有效期内，将一次性兑付给您国家节能补贴<span>3000</span>元。如您未按要求提供“车辆牌照号”，我们将无法给您兑付国家节能补贴<span>3000</span>元。</p>
	<p>&#12288;&#12288;请您仔细阅读以上内容，并确认无异议。</p>
	<div style="margin-bottom:-180px;width: 100%;text-align: right;" id="printImage2">
		<img src="${huiminTemplate.gzUrl  }" alt="" width="220" height="220" style="margin-right: 180px;"/>
	</div>
	<table cellpadding=0 cellspacing=0 width="100%" class="customerTable">
		<tr>
			<td style="border: 0;height: 50px;">
				<p style="line-height: 250%;">&#12288;客户签名：
					<u>
						&#12288;&#12288;&#12288;&#12288;&#12288;&#12288;&#12288;&#12288;</u>
				</p>
				<p style="line-height: 250%">&#12288;联系电话：
					<u>
						&#12288;${customer.mobilePhone }&#12288;&#12288;&#12288;&#12288;
					</u>
				</p>
			</td>
			<td style="border: 0;height: 50px;">
					<p>${factoryOrder.brand.name }汽车
						<u>
							${huiminTemplate.name  }&#12288;&#12288;&#12288;
						</u>
						销售服务店
					</p>
				<p><u>&#12288;<fmt:formatDate value="${now }" pattern="yyyy" /> &#12288;</u>年<u>&#12288;<fmt:formatDate value="${now }" pattern="MM" />&#12288;</u>月<u>&#12288;<fmt:formatDate value="${now }" pattern="dd" />&#12288;</u>日</p>
			</td>
		</tr>
	</table>
	
		<p style="line-height: 300%;">（本活动最终解释权归${factoryOrder.brand.name }汽车<u>
						&#12288;&#12288;${huiminTemplate.name  }&#12288;&#12288;&#12288;&#12288;&#12288;&#12288;
					</u>
		 销售服务店所有）</p>
</div>

<c:if test="${empty(carPlateNo) }">
	<div style="display: none; width: 340px;" id="resultStatic">
		<table id="noLine" border="0" align="center" cellpadding="0" cellspacing="0" style="width: 320px;margin-top: 5px;">
				<tr style="height: 60px;" height="60">
					<td class="formTableTdLeft" width="120">车牌号:&nbsp;</td>
					<td colspan="3">
						<input type="text" id="carPlateNo" name="carPlateNo" value="" style="width: 160px;"/>
					</td>
				</tr>
			
			<tr style="height: 60px;" height="60">
				<td class="formTableTdLeft" width="120">打印模板:&nbsp;</td>
				<td colspan="3">
					<select id="huiminTemplateId" name="huiminTemplateId" style="width: 160px;">
						<option value="">请选择...</option>
						<c:forEach var="huiminTemplate" items="${huiminTemplates }">
							<option value="${huiminTemplate.dbid }">${huiminTemplate.name }</option>
						</c:forEach>
					</select>
				</td>
			</tr>
		</table>
	</div>
</c:if>
<c:if test="${empty(huiminTemplate) }">
	<div style="display: none; width: 340px;" id="templateId">
		<table id="noLine" border="0" align="center" cellpadding="0" cellspacing="0" style="width: 320px;margin-top: 5px;">
			<tr style="height: 60px;" height="60">
				<td class="formTableTdLeft" width="120">打印模板:&nbsp;</td>
				<td colspan="3">
					<select id="huiminTemplateId" name="huiminTemplateId" style="width: 160px;">
						<option value="">请选择...</option>
						<c:forEach var="huiminTemplate" items="${huiminTemplates }">
							<option value="${huiminTemplate.dbid }">${huiminTemplate.name }</option>
						</c:forEach>
					</select>
				</td>
			</tr>
		</table>
	</div>
</c:if>
</body>
<script type="text/javascript" src="${ctx }/widgets/artDialog/artDialog.js?skin=twitter"></script>
<script type="text/javascript" src="${ctx }/widgets/artDialog/plugins/iframeTools.source.js"></script>
<script src="${ctx }/widgets/utile/utile.js"></script>
<script type="text/javascript">
function huiminArt(){
	top.art.dialog({
	    title: '选择打印模板',
	    content: document.getElementById('templateId'),
	    lock : true,
		fixed : true,
	    ok: function () {
	    	var huiminTemplateId=window.parent.document.getElementById("huiminTemplateId").value;
	    	if(null==huiminTemplateId||huiminTemplateId==''){
	    		alert("请选择打印模板！");
	    		return false;
	    	}
    		var url='${ctx}/customerPidBookingRecord/printHuimin?customerId=${customer.dbid}&huiminTemplateId='+huiminTemplateId;
    		window.location.href=url;
			return true;
	    },
	    cancel:function(){
	    	window.history.go(-1);
			return true;
	    }
	});
}
$().ready(function() {
	var huim="${message}";
	if(huim=='非惠民'){
		alert("车辆为非惠民车，不能打印惠民单!");
		window.history.go(-1);
		return false;
	}
	if(huim=='无库存信息'){
		alert("数据为未上库存系统之前数据，不能打印惠民单!");
		window.history.go(-1);
		return false;
	}
	var carPlateNo="${carPlateNo}";
	if(null==carPlateNo||carPlateNo==''){
		alert("车牌号为空，请先填写车牌号!");
		result();
		return false;
	}
	//判断是否包含模板
	var huiminTemplate="${huiminTemplate}";
	if(null==huiminTemplate||huiminTemplate==''){
		huiminArt();
		return false;
	}
	var $print = $("#print");
	var $notPrint = $("#notPrint");
	$print.click(function() {
		window.print();
		return false;
	});
	$notPrint.click(function() {
		$("#printImage1").addClass("bar");
		$("#printImage2").addClass("bar");
		window.print();
		$("#printImage1").removeClass("bar");
		$("#printImage2").removeClass("bar");
		return false;
	});
});
function result(){
	top.art.dialog({
	    title: '填写车牌号',
	    content: document.getElementById('resultStatic'),
	    lock : true,
		fixed : true,
	    ok: function () {
	    	var carPlateNo=window.parent.document.getElementById("carPlateNo").value;
	    	var huiminTemplateId=window.parent.document.getElementById("huiminTemplateId").value;
	    	if(null==carPlateNo||carPlateNo==''){
	    		alert("请填写车牌号！");
	    		return false;
	    	}
	    	if(null==huiminTemplateId||huiminTemplateId==''){
	    		alert("请选择打印模板！");
	    		return false;
	    	}
	    	if(carPlateNo.length!=7){
	    		alert("填写车牌号格式错误，请重新填写！");
	    		return false;
	    	}
    		var url='${ctx}/customerLastBussi/saveCarNo?customerId=${customer.dbid}&carPlateNo='+carPlateNo+"&huiminTemplateId="+huiminTemplateId;
    		url=encodeURI(encodeURI(url));
    		$.post(url,{},function (data){
    			if (data[0].mark == 0) {
    				$.utile.tips(data[0].message);
    				setTimeout(
							function() {
					    		 window.location.href=data[0].url;
							}, 1000);
    				
    			}
    			if (data[0].mark == 1) {// /返回标志为1表示保存数据失败
					$.utile.tips(data[0].message);
					// 保存失败时页面停留在数据编辑页面
				}
    		}) 
			return true;
	    },
	    cancel:function(){
	    	window.history.go(-1);
			return true;
	    }
	});
}

</script>
</html>

