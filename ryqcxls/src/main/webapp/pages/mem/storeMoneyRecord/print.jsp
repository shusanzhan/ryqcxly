<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ include file="../../commons/taglib.jsp" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>打印优惠券</title>
</head>
<link rel="stylesheet" href="${ctx }/css/print.css" />
<script src="${ctx }/widgets/bootstrap3/jquery.min.js"></script>
<style type="text/css" media="print">
.bar {
	display: none;
}
</style>
<style type="text/css">

	table td, table th {
    border: 1px solid #000000;
    color: #000000;
    font-size: 18px;
    line-height: 36px;
    width: 100px;
    font-weight: normal;
    height: 50px;
    padding-left: 12px;
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
<body >
<div class="bar">
	<c:if test="${param.type==1 }">
		<a href="javascript:;" id="print" class="btn btn-success " style="margin-left: 5px;">打 印</a>
		<a href="javascript:;" id="" class="btn btn-success " onclick="window.history.go(-1)" style="margin-left: 5px;">返 回</a>
	</c:if>
	<c:if test="${param.type==2 }">
		<a href="javascript:;" id="" class="btn btn-success " onclick="window.history.go(-1)" style="margin-left: 5px;">返 回</a>
	</c:if>
</div>
<table  border="1" cellpadding="0" cellspacing="0" style="margin-bottom: 12px;margin-top: 12px;font-size: 24px;" class="contentTable" >
<tr>
	<td colspan="2"  align="center" style="font-size: 20px;">瑞一会员储值凭证</td>
</tr>
<%-- <tr>
    <td colspan="2">
       SN码：${storeMoneyRecord.code }
    </td>
</tr> --%>
<tr>
    <td style="border-right: 0">
    会员名称：${storeMoneyRecord.member.name }
    </td>
   <td style="border-left: 0">
    会员ＩＤ：${storeMoneyRecord.member.mobilePhone }
   </td>
</tr>
<tr>
   <td style="border-right: 0">
    	储值状态：
    	<c:if test="${ storeMoneyRecord.status==1}">
    		<span style="color: green;">成功</span>
    	</c:if>
    	<c:if test="${ storeMoneyRecord.status==2}">
    		<span style="color: red;">作废</span>
    	</c:if>
    </td>
   <td style="border-left: 0">
   		储值方式：
    	<c:if test="${ storeMoneyRecord.payWay==1}">
    		<span style="color: green;">现金储值</span>
    	</c:if>
    	<c:if test="${ storeMoneyRecord.payWay==2}">
    		<span style="color: green;">刷卡储值</span>
    	</c:if>
   </td>
</tr>
<tr>
   <td   style="border-right: 0">
   	实收金额：
  	<ystech:urlEncrypt enCode="${storeMoneyRecord.actMoney }" />&nbsp;&nbsp;元
   </td>
   <td style="border-left: 0">
   	充值金额：
  	<ystech:urlEncrypt enCode="${storeMoneyRecord.rechargeMoney }" />&nbsp;&nbsp;元
   </td>
</tr>
<tr>
	<td style="border-right: 0">
		创建人：${storeMoneyRecord.user.realName }&#12288;&#12288;&#12288;&#12288;&#12288;&#12288;
    </td>
	<td style="border-left: 0">
    	充值时间：${storeMoneyRecord.createTime }
    </td>
  </tr>
<tr>
    <td style="border-right: 0">储值说明：<br>
       ${storeMoneyRecord.rechargeExplain }
    </td>
   <td style="border-left: 0">备注：<br>
       ${storeMoneyRecord.note }
    </td>
  </tr>
<tr>
 	<td style="border-right: 0">
    </td>
    <td style="border-left: 0">
    	客户签字：
       	&#12288;&#12288;&#12288;&#12288;&#12288;&#12288;&#12288;&#12288;&#12288;&#12288;&#12288;&#12288;&#12288;
    </td>
  </tr>
  </table>
</body>
</html>