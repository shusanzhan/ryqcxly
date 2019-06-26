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
	<a href="javascript:;" id="print" class="btn btn-success " style="margin-left: 5px;">打 印</a>
</div>
<table  border="1" cellpadding="0" cellspacing="0" style="margin-bottom: 12px;margin-top: 12px;font-size: 24px;" class="contentTable" >
<tr>
	<td colspan="2"  align="center" style="font-size: 20px;">成都瑞一电子优惠券使用凭证</td>
</tr>
<tr>
   <td colspan="2">
       优惠券名称：${couponCode.coupon.name }
    </td>
</tr>
<tr>
    <td colspan="2">
       SN码：${couponCode.code }
    </td>
</tr>

<tr>
   <td   colspan="2">
   	卷面价值/备注：<br>
   ${couponCode.money }
   </td>
</tr>

<tr>
	<td style="border-right: 0">
		创建人：${couponCode.creatorName }&#12288;&#12288;&#12288;&#12288;&#12288;&#12288;
    </td>
	<td style="border-left: 0">
    	使用人：${couponCode.usedPersonName }
    </td>
  </tr>
<tr>
    <td style="border-right: 0">
    会员名称：${couponCode.member.name }
    </td>
   <td style="border-left: 0">
    会员ＩＤ：${couponCode.member.mobilePhone }
   </td>
</tr>
<tr>
    <td style="border-right: 0">创建日期：
       <fmt:formatDate value="${couponCode.createTime }" pattern="yyyy年MM月dd日"/>
    </td>
   <td style="border-left: 0">到期日期：<fmt:formatDate value="${couponCode.validDate }" pattern="yyyy年MM月dd日"/>
    </td>
  </tr>
<tr>
	<td style="border-right: 0">使用日期：<fmt:formatDate value="${couponCode.usedDate }" pattern="yyyy年MM月dd日"/>
    </td>
    <td style="border-left: 0">
    	客户签字：
       	&#12288;&#12288;&#12288;&#12288;&#12288;&#12288;&#12288;&#12288;&#12288;&#12288;&#12288;&#12288;&#12288;
    </td>
  </tr>
  </table>
</body>
</html>