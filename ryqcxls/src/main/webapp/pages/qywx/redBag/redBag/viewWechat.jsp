<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="../../../commons/taglib.jsp" %>
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
<title>红包活动</title>
<style type="text/css">
table{
	border-top: 1px solid  #cccccc;
	border-left: 1px solid  #cccccc;
}
table th, table td {
	border-bottom: 1px solid  #cccccc;
	border-right: 1px solid  #cccccc;
	font-size: 14px;
	padding-left: 5px;
	height: 32px;
}
.frmContent form table tr td {
    padding-left: 5px;
}
#noLine{
	border-top: 0;
	border-left: 0;
}
#noLine td{
	border: 0;
}
</style>
</head>
<body class="bodycolor">
<div class="location">
     	<img src="${ctx}/images/homeIcon.png"/> &nbsp;
     	<a href="javascript:void(-1);" onclick="window.parent.location.href='${ctx}/main/index'">首页</a>-
<a href="javascript:void(-1);" onclick="window.location.href='${ctx}/redBag/queryList'">发放明细</a>-
<a href="javascript:void(-1);">
	红包明细
</a>
</div>
<div class="line"></div>
<div class="frmContent">
		<table border="0" align="center" cellpadding="0" cellspacing="0" style="width: 100%;">
			<tr height="42" style="background-color: #eeeeee; border-color:#eeeeee;font-size: 16px;font-weight: bold;">
					<td width="100%" colspan="4" style="">红包记录</td>
			</tr>
			<tr height="40">
				<td class="formTableTdLeft">编号：</td>
				<td>
					<span style="color: red;font-size: 15px;">
						${redBag.billno }
					</span>
				</td>
				<td class="formTableTdLeft">接收人：</td>
				<td>
						${redBag.recipientName }
				</td>
			</tr>
			<tr height="32">
				<td class="formTableTdLeft" >红包金额：</td>
				<td>
					<span style="color: red;font-size: 15px;">
						${redBag.redBagMoney }
					</span>
				</td>
				<td class="formTableTdLeft">接受OpenId：</td>
				<td>
					${redBag.openId}
				</td>
			</tr>
			<tr height="32">
				<td class="formTableTdLeft">红包状态：</td>
				<td>
					<c:if test="${redBag.turnBackStatus==1 }">
						<span style="color: yellow;">待发送</span>
					</c:if>
					<c:if test="${redBag.turnBackStatus==2 }">
						<span style="color: red;">发送失败</span>
					</c:if>
					<c:if test="${redBag.turnBackStatus==3 }">
						<span style="color: green;">发送成功</span>
					</c:if>
				</td>
				<td class="formTableTdLeft">创建时间：</td>
				<td>
					${redBag.createDate}
				</td>
			</tr>
			<tr height="32">
				<td>活动名称：</td>
				<td>
					${redBag.actName }
				</td>
				<td>祝福语：</td>
				<td>
					${redBag.wishing }
				</td>
			</tr>
			<tr height="32">
				<td>红包备注：</td>
				<td>
					${redBag.remark }
				</td>
				<td>发送IP：</td>
				<td>
					${redBag.ip }
				</td>
			</tr>
		<tr style="height: 40px;">
			<td>备注：</td>
			<td colspan="3">
					${redBag.note }
			</td>
		</tr>
		</table>
		<br>
		<table border="0" align="center" cellpadding="0" cellspacing="0" style="width: 100%;">
			<tr height="42" style="background-color: #eeeeee; border-color:#eeeeee;font-size: 16px;font-weight: bold;">
					<td width="100%" colspan="4" style="">红包参数</td>
			</tr>
			<tr height="40">
				<td class="formTableTdLeft">随机字符串：</td>
				<td>
						${scanPayReqData.nonce_str }
				</td>
				<td class="formTableTdLeft">签名：</td>
				<td>
						${scanPayReqData.sign }
				</td>
			</tr>
			<tr height="32">
				<td class="formTableTdLeft" >商户订单号：</td>
				<td>
						${scanPayReqData.mch_billno }
				</td>
				<td class="formTableTdLeft">商户号：</td>
				<td>
					${scanPayReqData.mch_id}
				</td>
			</tr>
			<tr height="32">
				<td class="formTableTdLeft">公众账号ID：</td>
				<td>
					${scanPayReqData.wxappid}
				</td>
				<td class="formTableTdLeft">发放公司：</td>
				<td>
					${scanPayReqData.send_name}
				</td>
			</tr>
			<tr height="32">
				<td>用户OpenId：</td>
				<td>
					${scanPayReqData.re_openid}
				</td>
				<td>付款金额：</td>
				<td>
					${scanPayReqData.total_amount}(分)
				</td>
			</tr>
			<tr height="32">
				<td>发放总人数：</td>
				<td>
					${scanPayReqData.total_num }
				</td>
				<td>红包祝福语：</td>
				<td>
					${scanPayReqData.wishing }
				</td>
			</tr>
			<tr height="32">
				<td>终端IP：</td>
				<td>
					${scanPayReqData.client_ip }
				</td>
				<td>活动名称：</td>
				<td>
					${scanPayReqData.act_name }
				</td>
			</tr>
			<tr height="32">
				<td>备注信息：</td>
				<td colspan="3">
					${scanPayReqData.remark }
				</td>
			</tr>
		</table>
		<br>
		<br>
		<table border="0" align="center" cellpadding="0" cellspacing="0" style="width: 100%;">
			<tr height="42" style="background-color: #eeeeee; border-color:#eeeeee;font-size: 16px;font-weight: bold;">
					<td width="100%" colspan="4" style="">红包返回参数</td>
			</tr>
			<tr height="40">
				<td class="formTableTdLeft">返回编码：</td>
				<td>
						${scanPayRespData.return_code }
				</td>
				<td class="formTableTdLeft">返回信息：</td>
				<td>
						${scanPayRespData.return_msg }
				</td>
			</tr>
			<tr height="32">
				<td class="formTableTdLeft" >返回结果：</td>
				<td>
						${scanPayRespData.result_code }
				</td>
				<td class="formTableTdLeft">商户订单号：</td>
				<td>
					${scanPayRespData.mch_billno}
				</td>
			</tr>
			<tr height="32">
				<td class="formTableTdLeft">错误编码：</td>
				<td>
					${scanPayRespData.err_code}
				</td>
				<td class="formTableTdLeft">错误描述：</td>
				<td>
					${scanPayRespData.err_code_des}
				</td>
			</tr>
			<tr height="32">
				<td>商户号：</td>
				<td>
					${scanPayRespData.mch_id}
				</td>
				<td>公众账号appid：</td>
				<td>
					${scanPayRespData.wxappid}
				</td>
			</tr>
			<tr height="32">
				<td>用户openid：</td>
				<td>
					${scanPayRespData.re_openid }
				</td>
				<td>付款金额：</td>
				<td>
					${scanPayRespData.total_amount }
				</td>
			</tr>
			<tr height="32">
				<td>微信单号：</td>
				<td colspan="3">
					${scanPayRespData.send_listid }
				</td>
			</tr>
		</table>
		<br>
	</div>
</body>
</html>