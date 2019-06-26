<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
   <%@ include file="../../commons/taglib.jsp" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<title> 交车确认单     </title>
<link rel="stylesheet" href="${ctx }/css/print.css" />
<style type="text/css" media="print">
.bar {
	display: none;
}
</style>
<script src="${ctx }/widgets/bootstrap3/jquery.min.js"></script>
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
<div class="testDriverContent" style="width: 92%;margin-bottom: 40px;">
<table cellpadding="0" cellspacing="0" border="0" style="margin-top: 10px;">
	<tr height="50">
		<td class="noLine" style="border: 0px solid #000000;width: 20%">
			<img src="${ctx }/images/xwqr/logo.png" width="175"></img>
		</td>
		<td class="noLine" style="text-align: center;font-size: 18px;font-weight: bold;border: 0px solid #000000;width: 20%">交车确认单</td>
		<td style="border: 0px solid #000000;width: 20%"></td>
	</tr>
</table>

<table cellpadding="0" cellspacing="0" border="0" class="contentTr">
	<tr>
		<td colspan="2">车主姓名：${customer.name }</td>
		<td colspan="3">联系电话：${ customer.mobilePhone}</td>
	</tr>
	<tr>
		<td colspan="2">
			车    型：${customer.customerPidBookingRecord.brand.name }&nbsp;&nbsp;${customer.customerPidBookingRecord.carModel.carseries.name }
			&#12288;${customer.customerPidBookingRecord.carModel.name }
		</td>
		<td colspan="3">VIN码：${customer.customerPidBookingRecord.vinCode}</td>
	</tr>
	<tr>
		<td colspan="5"><p>◆ 注：感谢客户购买${customer.customerPidBookingRecord.brand.name }汽车，并在新车交付之前为车进行检查及确认</p></td>
	</tr>
	<tr height="60">
		<td colspan="5">
			 <p style="text-indent: 24px;">车主于签收车辆前，下面各项证件及车辆功能操作均需经过销售体验师及服务关怀师详细说明，请车主确认并签收；</p>
			 <p style="text-indent: 24px;">若有「委托交车代理人」，交车时所做的任何行为，将视同委托人的行为，车辆离开公司后概由委托人负责。</p>
		</td>
	</tr>
	<tr>
		<td colspan="4" align="center" style="background-color: #BFBFBF">新车交付确认事项</td>
		<td colspan="1" align="center" style="background-color: #BFBFBF;width: 150px;">车主/代理人签字确认</td>
	</tr>
	<tr>
		<td align="center">车辆检查</td>
		<td colspan="3" style="line-height: 20px;">
			<br>
			<p>
				<div style="width:120px;float:left;"><input type="checkbox">车内外整洁 </div>
				<div style="width:120px;float:left;"><input type="checkbox">漆面完好</div>
				<div style="width:120px;float:left;"><input type="checkbox">玻璃完好</div>
				<div class="clear"></div>
			</p>
			<p>
				<div style="width:120px;float:left;"><input type="checkbox">轮胎轮毂完好 </div>
				<div style="width:120px;float:left;"><input type="checkbox">灯具完好</div>
				<div style="width:120px;float:left;"><input type="checkbox">后视镜完好</div>
				<div class="clear"></div>
			</p>
			<br>
			<p>
				<div style="width:120px;float:left;"><input type="checkbox">千斤顶 </div>
				<div style="width:120px;float:left;"><input type="checkbox">工具包</div>
				<div style="width:120px;float:left;"><input type="checkbox">备胎</div>
				<div style="width:120px;float:left;"><input type="checkbox">警示三角牌</div>
				<div class="clear"></div>
			</p>
			<br>
			<p><input type="checkbox">确认油料足够到达最近加油站</p>
			<p>其他_______________ </p>                     
		</td>
		<td align="center"></td>
	</tr>
	<tr>
		<td align="center">资料确认</td>
		<td colspan="3" style="line-height: 20px;">
			<br>
			<p>
				<div style="width:120px;float:left;"><input type="checkbox">购车合同 </div>
				<div style="width:120px;float:left;"><input type="checkbox">购车发票</div>
				<div style="width:120px;float:left;"><input type="checkbox">车辆合格证</div>
				<div class="clear"></div>
			</p>
			<p>
				<div style="width:120px;float:left;"><input type="checkbox">使用说明书  </div>
				<div style="width:120px;float:left;"><input type="checkbox">三包凭证</div>
				<div class="clear"></div>
			</p>
			<br>
			<p>
				<div style="width:120px;float:left;"><input type="checkbox">领牌相关资料 </div>
				<div style="width:120px;float:left;"><input type="checkbox">保险单据</div>
				<div style="width:120px;float:left;"><input type="checkbox">行驶证(若有)</div>
				<div style="width:120px;float:left;"><input type="checkbox">贷款资料(若有)</div>
				<div class="clear"></div>
			</p>
			<br>
			<p>
				<div style="width:160px;float:left;"><input type="checkbox">车辆购置税凭证(若有)</div>
				<div style="width:140px;float:left;"><input type="checkbox">手续服务费(若有)</div>
				<div style="width:160px;float:left;"><input type="checkbox">加装选配件费用(若有)</div>
				<div class="clear"></div>
			</p>
			<p>
				<div style="width:230px;float:left;"><input type="checkbox">其他_______________</div>
				<div class="clear"></div>
			</p>
		</td>
		<td align="center"></td>
	</tr>
	
	<tr>
		<td align="center">车辆功能使用介绍</td>
		<td colspan="3" style="line-height: 20px">
			<p>
				<div style="width:120px;float:left;"><input type="checkbox">座椅调节</div>
				<div style="width:120px;float:left;"><input type="checkbox">方向盘调节</div>
				<div style="width:120px;float:left;"><input type="checkbox">中控锁操作</div>
				<div style="width:120px;float:left;"><input type="checkbox">后视镜调整</div>
				
				<div style="width:120px;float:left;"><input type="checkbox">灯具</div>
				<div class="clear"></div>
			</p>
			<p>
				<div style="width:120px;float:left;"><input type="checkbox">仪表指示</div>
				<div style="width:120px;float:left;"><input type="checkbox">雨刮器</div>
				<div style="width:180px;float:left;"><input type="checkbox">空调操作（除霜除雾）</div>
				<div style="width:120px;float:left;"><input type="checkbox">音响系统使用</div>
				<div style="width:120px;float:left;"><input type="checkbox">儿童安全锁</div>
				<div class="clear"></div>
			</p>
			<p>
				<div style="width:120px;float:left;"><input type="checkbox">发动机舱盖开启</div>
				<div style="width:140px;float:left;"><input type="checkbox">发动机舱液体介绍</div>
				<div style="width:120px;float:left;"><input type="checkbox">加油口盖操作</div>
				<div style="width:120px;float:left;"><input type="checkbox">油箱容积</div>
				<div class="clear"></div>
			</p>
			<p>
				<div style="width:120px;float:left;"><input type="checkbox">新车磨合介绍</div>
				<div style="width:280px;float:left;"><input type="checkbox">自动变速箱操作注意事项</div>
				<div class="clear"></div>
			</p>
			<p>
				<div style="width:540px;"><input type="checkbox">特有配备（ESP、电动天窗、电动尾门操作、先进驾驶辅助系统）</div>
				<div class="clear"></div>
			</p>
			<br>
			<p style="font-size: 14px;font-weight: bold;">Cloudrive智云互联行车系统（适用于有此配置车型）</p>
			
			<br>
			<p>
				<div style="width:280px;float:left;"><input type="checkbox">“智云互联”APP下载及客户车辆绑定&认证</div>
				<div class="clear"></div>
			</p>
			<p>
				<div style="width:160px;float:left;"><input type="checkbox">流量开通</div>
				<div style="width:160px;float:left;"><input type="checkbox">续费方式说明</div>
				<div class="clear"></div>
			</p>
			<p>
				<div style="width:440px;float:left;"><input type="checkbox">功能讲解（语音控制/在线功能/远程控制/手机互联/救援服务等）</div>
				<div class="clear"></div>
			</p>
		</td>
		<td align="center"></td>
	</tr>
	<tr>
		<td align="center">保修和服务介绍</td>
		<td colspan="3" style="line-height: 20px">
			<br>
			<p>
				<div style="width:200px;float:left;"><input type="checkbox">营业地点</div>
				<div style="width:200px;float:left;"><input type="checkbox">营业时间</div>
				<div style="width:200px;float:left;"><input type="checkbox">介绍服务关怀师</div>
				<div class="clear"></div>
			</p> 
			<p>
				<div style="width:200px;float:left;"><input type="checkbox">维护保养说明</div>
				<div style="width:200px;float:left;"><input type="checkbox">保修事项说明</div>
				<div class="clear"></div>
			</p> 
			<p>
				<div style="width:200px;float:left;"><input type="checkbox">交车礼品赠送（若有）</div>
				<div style="width:200px;float:left;"><input type="checkbox">交车仪式</div>
				<div class="clear"></div>
			</p>   
		</td>
		<td align="center"></td>
	</tr>
	<tr height="60">
		<td colspan="" style="border-bottom: 1px solid #000;">
			 加入车主俱乐部
		</td>
		<td colspan="3" style="border-bottom: 1px solid #000;">
			<div style="width:500px;float:left;"><input type="checkbox">邀请车主加入俱乐部，向客户介绍奇瑞车主俱乐部权益</div>
		</td>
		<td align="center"></td>
	</tr>
	<tr >
		<td colspan="5" style="border-bottom: 1px solid #000;">
			 <p> 说明：以上请逐项与客户确认，无误后签字，本单一式两份，客户和销售服务商各存一份。</p>
		</td>
	</tr>
	<tr height="120">
		<td colspan="2">
			 <p style="height: 60px">销售体验师签字确认：&#12288;&#12288;&#12288;&#12288;&#12288;&#12288;&#12288;&#12288;&#12288;&#12288;&#12288;&#12288;&#12288;&#12288;&#12288;&#12288;      </p>
			 <p style="height: 60px;text-align: left;"> 年&#12288;&#12288;&#12288;&#12288;月&#12288;&#12288;日&#12288;&#12288;   </p>
		</td>
		<td colspan="3">
			 <p style="height: 60px"> 服务关怀师签字确认：&#12288;&#12288;&#12288;&#12288;&#12288;&#12288;&#12288;&#12288;&#12288;&#12288;&#12288;&#12288;&#12288;&#12288;</p>
			 <p style="height: 60px;text-align: left;"> 年&#12288;&#12288;&#12288;&#12288;月&#12288;&#12288;日&#12288;&#12288;   </p>
		</td>
	</tr>
	</table>
	<table cellpadding="0" cellspacing="0" border="0" style="margin-top: 10px;">
		<tr style="border: 0;">
			<td colspan="2" style="border: 0;text-align: ">
				保存期限：1年
			</td>
			<td colspan="3" style="border: 0;text-align: center;">
				*本文件随客户资料一并存档
			</td>
		</tr>
	</table>
</div>
</body>
</html>