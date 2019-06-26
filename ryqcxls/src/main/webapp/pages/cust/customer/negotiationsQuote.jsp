<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
   <%@ include file="../../commons/taglib.jsp" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<title>奇瑞汽车商谈报价单</title>
<link rel="stylesheet" href="${ctx }/css/print.css" />
<script src="${ctx }/widgets/bootstrap3/jquery.min.js"></script>
<style type="text/css" media="print">
.bar {
	display: none;
}
</style>
<script type="text/javascript">
$().ready(function() {
	var $print = $("#print");
	$print.click(function() {
		window.print();
		return false;
	});
});
</script>
</head>
<body>
<div class="bar">
	<a href="javascript:;" id="print" class="btn btn-success " style="margin-left: 5px;">打 印</a>
</div>
 <div class="testDriverContent" style="width: 92%;">
<table cellpadding="0" cellspacing="0" border="0" style="margin-top: 10px;">
	<tr height="50">
		<td class="noLine" style="border: 0px solid #000000;width: 20%" width="">
			<img src="${ctx }/images/xwqr/logo.png" width="175"></img>
		</td>
		<td class="noLine" width="60%" style="text-align: center;font-size: 18px;font-weight: bold;border: 0px solid #000000;width: 20%">奇瑞汽车商谈报价单</td>
		<td style="border: 0px solid #000000;width: 20%"  width="20%"></td>
	</tr>
</table>
<table cellpadding="0" cellspacing="0" border="0">
	<tr>
		<td style="width:30px;border: 0px solid #000000;line-height: 1px;">&nbsp;</td>
		<td style="width:40px;border: 0px solid #000000;line-height: 1px;">&nbsp;</td>
		<td style="width:100px;border: 0px solid #000000;line-height: 1px;">&nbsp;</td>
		<td style="width:120px;border: 0px solid #000000;line-height: 1px;">&nbsp;</td>
		<td style="width:120px;border: 0px solid #000000;line-height: 1px;">&nbsp;</td>
		<td style="width:30px;border: 0px solid #000000;line-height: 1px;">&nbsp;</td>
		<td style="width:40px;border: 0px solid #000000;line-height: 1px;">&nbsp;</td>
		<td style="width:40px;border: 0px solid #000000;line-height: 1px;">&nbsp;</td>
		<td style="width:80px;border: 0px solid #000000;line-height: 1px;">&nbsp;</td>
		<td style="width:80px;border: 0px solid #000000;line-height: 1px;">&nbsp;</td>
		<td style="width:100px;border: 0px solid #000000;line-height: 1px;">&nbsp;</td>
		<td style="width:120px;border: 0px solid #000000;line-height: 1px;">&nbsp;</td>
	</tr>
	<tr>
		<c:if test="${empty(customer.sn) }">
			<td colspan="12" style="text-align: right;padding-right: 200px;">编号：${customer.sn }</td>
		</c:if>
		<c:if test="${!empty(customer.sn) }">
			<td colspan="12" style="text-align: right;padding-right: 100px;">编号：${customer.sn }</td>
		</c:if>
	</tr>
	<tr>
		<td colspan="4" style="text-align: right;">${customer.name }&#12288;&#12288;&#12288;&#12288;先生/女士</td>	
		<td colspan="5">联系方式：${customer.mobilePhone }</td>
		<td colspan="3" rowspan="2">
		日期：<c:if test="${empty(customer) }" var="status">
					<fmt:formatDate value="${now }" pattern="yyyy  &#12288;年 &#12288;MM &#12288;月 &#12288;dd &#12288;日"/>
				</c:if>
				<c:if test="${status==false }">
					<fmt:formatDate value="${customer.createFolderTime }" pattern="yyyy  &#12288;年 &#12288;MM &#12288;月 &#12288;dd &#12288;日"/>
				</c:if>
			<br>
			销售顾问：${customer.bussiStaff }
		</td>
	</tr>
	<tr>
		<td colspan="2">品牌：${customer.customerBussi.carModel.brand.name}</td>
		<td colspan="3">型号：${customer.customerBussi.carModel.carseries.name }&#12288;${customer.customerBussi.carModel.name }</td>
		<td colspan="4">颜色</td>
	</tr>
	<tr>
		<td colspan="5" style="background-color: #C0C0C0;text-align: center;">费用合计项</td>
		<td colspan="5" style="background-color: #C0C0C0;text-align: center;">签约金融机构</td>					
		<td colspan="2" style="background-color: #C0C0C0;text-align: center;">抵押方式</td>	
	</tr>
	<tr>
		<td rowspan="6" style="width:30px;text-align: center;">购车应付款总额</td>
		<td colspan="3">奇瑞公司市场统一价</td>
		<td colspan="1" align="right" style="padding-right:2px; ">元</td>
		<td rowspan="7" style="width:30px;text-align: center;">按揭费用明细</td>
		<td rowspan="2" colspan="4"></td>
		<td rowspan="2" colspan="2"></td>
	</tr>
	<tr>
		<td colspan="3">店面促销价让利</td>
		<td colspan="1" align="right" style="padding-right:2px; ">元</td>
	</tr>
	<tr>
		<td colspan="3">赠送装潢项目</td>
		<td colspan="1" align="right" style="padding-right:2px; ">元</td>
		<td colspan="4">分期付款金额</td>
		<td rowspan="5"  colspan="2">其它：</td>
	</tr>
	<tr>
		<td colspan="3">其他赠送项目</td>
		<td colspan="1" align="right" style="padding-right:2px; ">元</td>
		<td colspan="2">期限：</td>
		<td colspan="1"></td>
		<td colspan="1">月</td>
	</tr>
	<tr>
		<td colspan="3">商谈成交最终价</td>
		<td colspan="1" align="right" style="padding-right:2px; ">元</td>
		<td colspan="2">利率：</td>
		<td colspan="1"></td>
		<td colspan="1">%每年/月</td>
	</tr>
	<tr>
		<td colspan="3"></td>
		<td colspan="1"></td>
		<td colspan="2">月供：</td>
		<td colspan="1"></td>
		<td colspan="1" align="right" style="padding-right:2px; ">元</td>
	</tr>
	<tr>
		<td colspan="2">合计:</td>
		<td colspan="3"></td>
		<td colspan="2"></td>
		<td colspan="1"></td>
		<td colspan="1"></td>
	</tr>
	<tr>
		<td colspan="5" style="background-color: #C0C0C0;text-align: center;">费用明细项</td>
		<td rowspan="3" style="width:30px;text-align: center;">付款方式</td>
		<td colspan="2">一次性全款</td>
		<td colspan="4">1.现金 2.汇票/支票 3.转帐 4.其它</td>
	</tr>
	<tr>
		<td rowspan="14" style="width:30px;text-align: center;">保险费用明细</td>
		<td rowspan="6" style="width:30px;text-align: center;">基本险</td>
		<td colspan="2">交强险</td>
		<td align="right" style="padding-right:2px; ">元</td>
		<td colspan="2">按揭首付</td>
		<td colspan="4">1.现金 2.汇票/支票 3.转帐 4.其它</td>
	</tr>
	<tr>
		<td colspan="2">第三者责任险</td>
		<td align="right" style="padding-right:2px; ">元</td>
		<td colspan="2">费用</td>
		<td colspan="4">1.现金 2.汇票/支票 3.转帐 4.其它</td>
	</tr>
	<tr>
		<td colspan="2">车辆损失险</td>
		<td align="right" style="padding-right:2px; ">元</td>
		<td colspan="7" rowspan="2" style="background-color: #C0C0C0;text-align: center;">装饰品</td>
	</tr>
	<tr>
		<td colspan="2">车辆盗抢险</td>
		<td align="right" style="padding-right:2px; ">元</td>
	</tr>
	<tr>
		<td colspan="2">车上人员险	</td>
		<td align="right" style="padding-right:2px; ">元</td>
		<td style="width:30px;text-align: center;" >序号</td>
		<td colspan="3" style="text-align: center;">项目</td>
		<td style="text-align: center;">数量</td>
		<td style="text-align: center;">单价</td>
		<td style="text-align: center;">总价</td>
	</tr>
	<tr>
		<td colspan="2">	</td>
		<td></td>
		<td style="width:30px;padding-left: 2px;">1</td>
		<td colspan="3"></td>
		<td></td>
		<td align="right" style="padding-right:2px; ">元</td>
		<td align="right" style="padding-right:2px; ">元</td>
	</tr>
	<tr>
		<td rowspan="7" style="width:30px;text-align: center;">附加险</td>
		<td colspan="2">不计免赔险</td>
		<td align="right" style="padding-right:2px; ">元</td>
		<td  style="width:30px;padding-left: 2px;">2</td>
		<td colspan="3"></td>
		<td></td>
		<td align="right" style="padding-right:2px; ">元</td>
		<td align="right" style="padding-right:2px; ">元</td>
	</tr>
	<tr>
		<td colspan="2">玻璃破碎险</td>
		<td align="right" style="padding-right:2px; ">元</td>
		<td  style="width:30px;padding-left: 2px;">3</td>
		<td colspan="3"></td>
		<td></td>
		<td align="right" style="padding-right:2px; ">元</td>
		<td align="right" style="padding-right:2px; ">元</td>
	</tr>
	<tr>
		<td colspan="2">车身划痕险</td>
		<td align="right" style="padding-right:2px; ">元</td>
		<td  style="width:30px;padding-left: 2px;">4</td>
		<td colspan="3"></td>
		<td></td>
		<td align="right" style="padding-right:2px; ">元</td>
		<td align="right" style="padding-right:2px; ">元</td>
	</tr>
	<tr>
		<td colspan="2">自燃损失险</td>
		<td align="right" style="padding-right:2px; ">元</td>
		<td  style="width:30px;padding-left: 2px;">5</td>
		<td colspan="3"></td>
		<td></td>
		<td align="right" style="padding-right:2px; ">元</td>
		<td align="right" style="padding-right:2px; ">元</td>
	</tr>
	<tr>
		<td colspan="2">无过失责任险</td>
		<td align="right" style="padding-right:2px; ">元</td>
		<td  style="width:30px;padding-left: 2px;">6</td>
		<td colspan="3"></td>
		<td></td>
		<td align="right" style="padding-right:2px; ">元</td>
		<td align="right" style="padding-right:2px; ">元</td>
	</tr>
	<tr>
		<td colspan="2">指定专修厂险</td>
		<td align="right" style="padding-right:2px; ">元</td>
		<td  style="width:30px;padding-left: 2px;">7</td>
		<td colspan="3"></td>
		<td></td>
		<td align="right" style="padding-right:2px; ">元</td>
		<td align="right" style="padding-right:2px; ">元</td>
	</tr>
	<tr>
		<td colspan="2"></td>
		<td align="right" style="padding-right:2px; ">元</td>
		<td  style="width:30px;padding-left: 2px;">8</td>
		<td colspan="3"></td>
		<td></td>
		<td align="right" style="padding-right:2px; ">元</td>
		<td align="right" style="padding-right:2px; ">元</td>
	</tr>
	<tr>
		<td style="text-align: center;" colspan="3">保险合计</td>
		<td align="right" style="padding-right:2px; ">元</td>
		<td style="text-align: center;" colspan="4">装饰合计</td>
		<td></td>
		<td align="right" style="padding-right:2px; ">元</td>
		<td align="right" style="padding-right:2px; ">元</td>
	</tr>
	<tr>
		<td rowspan="6" style="width:30px;text-align: center;">附加费</td>
		<td colspan="3">上牌相关手续费用</td>
		<td align="right" style="padding-right:2px; ">元</td>
		<td rowspan="6" colspan="7" style="width:30px;">
			商谈记录：
		</td>
	</tr>
	<tr>
		<td colspan="3">购置税</td>
		<td align="right" style="padding-right:2px; ">元</td>
	</tr>
	<tr>
		<td colspan="3"></td>
		<td align="right" style="padding-right:2px; ">元</td>
	</tr>
	<tr>
		<td colspan="3"></td>
		<td align="right" style="padding-right:2px; ">元</td>
	</tr>
	<tr>
		<td colspan="3"></td>
		<td align="right" style="padding-right:2px; ">元</td>
	</tr>
	<tr>
		<td colspan="" style="width:30px;text-align: center;">合计</td>
		<td colspan="3" align="right" style="padding-right:2px; ">元</td>
	</tr>
	<tr>
		<td colspan="12">
			保险公司：&#12288;&#12288;&#12288;&#12288;&#12288;&#12288;&#12288;&#12288;&#12288;&#12288;&#12288;&#12288;&#12288;&#12288;
			参考交车日期：&#12288;&#12288;&#12288;&#12288;&#12288;&#12288; 年&#12288;&#12288;&#12288;&#12288; 月&#12288;&#12288;&#12288;&#12288;日						
		</td>
	</tr>
	<tr>
		<td colspan="12">
			<div style="float: left;">备注：以上报价以实时行情为准，解释权归奇瑞汽车</div>
			<div style="border-bottom: 1px solid #000;width: 200px;float: left;margin-top:-8px;position: relative;">&#12288;&#12288;&#12288;&#12288;&#12288;&#12288;&#12288;&#12288;</div>
			<div style="float: left;">销售服务商所有</div>
			<div class="clear"></div>					
		</td>
	</tr>
	</table>
	<!-- <div style="padding-left: 24px;margin-top: 12px;color: #000;">◆注：销售服务商自行制作，一式两联，一份给客户，一份留存</div> -->	
</div> 
</body>
</html>