<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="../../commons/taglib.jsp" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link href="${ctx }/css/print.css" type="text/css" rel="stylesheet"/>
<link  href="${ctx }/widgets/easyvalidator/css/validate.css" rel="stylesheet" type="text/css" />
<script type="text/javascript" src="${ctx }/widgets/bootstrap3/jquery.min.js"></script>
<script type="text/javascript" src="${ctx }/widgets/utile/utile.js"></script>
<script type="text/javascript" src="${ctx }/widgets/easyvalidator/js/jquery.bgiframe.min.js"></script>
<script type="text/javascript" src="${ctx }/widgets/easyvalidator/js/easy_validator.pack.js"></script>
<style type="text/css">
body{
	font-family:微软雅黑;
	font-size: 13px;
}

table td, table th {
    border: 1px solid #000000;
    color: #000000;
    font-size: 14px;
    line-height: 20px;
    padding-left: 2px;
    height: 24px;
}
.noneLine{
}
.noneLine td{
border: 0;
}
#lineSpache{
	height: 12px;
}
#lineSpache td{
	height: 12px;
}
</style>
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
<title>打印入库单</title>
</head>
<body class="bodycolor">
<div class="bar">
		<a href="javascript:;" id="print" class="btn btn-success " style="margin-left: 5px;">打印</a>  |
		<a href="javascript:void(-1)"	onclick="window.history.go(-1)" class="but butCancle">返回</a> 
</div>
	<div class="frmContent">
	<table cellpadding="0" cellspacing="0" width="100%" border="1">
	 <colgroup>
        <col width="120" style=";width:160px"/>
        <col width="240" style=";width:160px"/>
        <col width="120" style=";width:120px"/>
        <col width="120" style=";width:120px"/>
        <col width="120" style=";width:160px"/>
        <col width="240" style=";width:160px"/>
    </colgroup>
    <tbody>
       <tr height="40" style=";">
	            <td colspan="9" height="28" align="center" style="border: 0;height:48px;font-size: 28px;font-weight: bold;">
	                ${enterprise.name }车辆交接单
	            </td>
        </tr>
         <tr height="30" style=";height:28px;" class="noneLine">
         	<td colspan="6"></td>
         </tr>
         <tr height="30" style=";height:28px;" class="noneLine">
            <td colspan="2" height="32" width="41" style="border-bottom: 1px solid #000;font-size: 18px;font-weight: bold;">
                日期：
               ${carHandOver.createDate }
            </td>
            <td colspan="2"  align="right" style="border-bottom: 1px solid #000;font-size: 18px;font-weight: bold;">
            </td>
            <td colspan="2" width="60" align="right" style="border-bottom: 1px solid #000;font-size: 18px;font-weight: bold;">
            	00${factoryOrder.dbid}
            </td>
        </tr>
        <tr height="32" style=";height:32px">
            <td height="32" colspan="1"  class="selectTdClass" style="text-align: center;">
                品牌
            </td>
            <td colspan="1"  style="border-top:none;border-left:none;text-align: center;" class="selectTdClass">
                车型
            </td>
            <td style="border-top:none;border-left:none;text-align: center;" class="selectTdClass">
                颜色
            </td>
            <td style="border-top:none;border-left:none;text-align: center;" class="selectTdClass">
                车架号
            </td>
            <td style="border-top:none;border-left:none;text-align: center;" class="selectTdClass">
                提车单位
            </td>
            <td style="border-top:none;border-left:none;text-align: center;" class="selectTdClass">
                提车人
            </td>
        </tr>
        <tr height="32" style=";height:32px">
            <td height="32"  colspan="1"  class="selectTdClass">
                 ${factoryOrder.brand.name }
            </td>
            <td height="32" colspan="1"   class="selectTdClass">
                ${factoryOrder.carSeriy.name } ${factoryOrder.carModel.name }
            </td>
            <td colspan="1" style="border-left:none" class="selectTdClass">
                 ${factoryOrder.carColor.name }
            </td>
            <td colspan="1" style="border-left:none" class="selectTdClass">
                 ${factoryOrder.vinCode }
            </td>
            <td style="border-top:none;border-right: 1px;text-align: center;" class="selectTdClass">
                 ${customer.successDepartment.name }
            </td>
            <td style="border-top:none;border-right: 1px solid #000;text-align: center;" class="selectTdClass">
                 ${carHandOver.saler }
            </td>
        </tr>
        <tr height="32" style=";height:32px">
            <td height="32" colspan="1"  class="selectTdClass" style="text-align: center;">
                车辆来源
            </td>
            <td colspan="1"  style="border-top:none;border-left:none;text-align: center;" class="selectTdClass">
                入总库日期
            </td>
            <td style="border-top:none;border-left:none;text-align: center;" class="selectTdClass">
                车辆外观
            </td>
            <td style="border-top:none;border-left:none;text-align: center;" class="selectTdClass">
                工具
            </td>
            <td style="border-top:none;border-left:none;text-align: center;" class="selectTdClass">
                配件
            </td>
            <td style="border-top:none;border-left:none;text-align: center;" class="selectTdClass">
                资料袋
            </td>
        </tr>
         <tr height="32" style=";height:32px">
            <td height="32"  colspan="1"  class="selectTdClass">
            	<input type="checkbox">板车入库<br>
            	<input type="checkbox">他店调入
            </td>
            <td height="32" colspan="1"   class="selectTdClass" style="text-align: center;">
            	<fmt:formatDate value="${factoryOrder.carReceiving.stockInDate}"/>
            </td>
            <td colspan="1" style="border-left:none" class="selectTdClass">
            </td>
            <td colspan="1" style="border-left:none" class="selectTdClass">
            </td>
            <td style="border-top:none;border-right: 1px;text-align: center;" class="selectTdClass">
            </td>
            <td style="border-top:none;border-right: 1px solid #000;text-align: center;" class="selectTdClass">
            </td>
        </tr>
         <tr height="32" style=";height:32px">
            <td height="32"  colspan="1"  class="selectTdClass">
                备注：
            </td>
             <td style="border-top:none;border-left:none" class="selectTdClass" colspan="5">
                 ${carHandOver.note }
            </td>
         </tr>
         <tr height="35" style=";height:35px" class="noneLine">
            <td align="left" colspan="2">
            	 制表时间：<fmt:formatDate value="${now }" pattern="yyyy年MM月dd日"/> 
            </td>
            <td align="left" colspan="2">
            	 制表人：${ carHandOver.creator}
            </td>
            <td colspan="2">
                交车人：${ carHandOver.saler}
            </td>
        </tr>
    </tbody>
</table>

</div>
</body>
</html>