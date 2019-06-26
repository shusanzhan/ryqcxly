<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="../../commons/taglib.jsp" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link href="${ctx }/css/common.css" type="text/css" rel="stylesheet"/>
<link  href="${ctx }/widgets/easyvalidator/css/validate.css" rel="stylesheet" type="text/css" />
<link rel="stylesheet" href="${ctx }/widgets/auto/jquery.autocomplete.css" />
<script type="text/javascript" src="${ctx }/widgets/bootstrap3/jquery.min.js"></script>
<script type="text/javascript" src="${ctx }/widgets/utile/utile.js"></script>
<script type="text/javascript" src="${ctx }/widgets/easyvalidator/js/jquery.bgiframe.min.js"></script>
<script type="text/javascript" src="${ctx }/widgets/easyvalidator/js/easy_validator.pack.js"></script>
<script type="text/javascript"	src="${ctx}/widgets/auto/jquery.autocomplete.js"></script>
<script type="text/javascript" src="${ctx }/widgets/My97DatePicker/WdatePicker.js"></script>
<style type="text/css">
#shopNumber{
	border-top: 1px solid  #cccccc;
	border-left: 1px solid  #cccccc;
	font-size: 12px;
}
#shopNumber th,#shopNumber td{
border-bottom: 1px solid  #cccccc;
	border-right: 1px solid  #cccccc;
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
[class^="icon-"], [class*=" icon-"] {
    background-image: url("../images/bootstrap/glyphicons-halflings.png");
    background-position: 14px 14px;
    background-repeat: no-repeat;
    display: inline-block;
    height: 14px;
    line-height: 14px;
    margin-top: 1px;
    vertical-align: text-top;
    width: 14px;
}
[class^="icon-"], [class*=" icon-"] {
    background-image: url("../images/bootstrap/glyphicons-halflings.png");
    background-position: 14px 14px;
    background-repeat: no-repeat;
    display: inline-block;
    height: 14px;
    line-height: 14px;
    margin-top: 1px;
    vertical-align: text-top;
    width: 14px;
}
.icon-remove {
    background-position: -312px 0;
}

.icon-ok {
    background-position: -288px 0;
}
</style>
<title>毛利统计</title>
</head>
<body class="bodycolor">
<div class="location">
     	<img src="${ctx}/images/homeIcon.png"/> &nbsp;
     	<a href="javascript:void(-1);" onclick="window.parent.location.href='${ctx}/main/index'">首页</a>-
<a href="javascript:void(-1);">渗透率统计</a>
</div>
<div class="line"></div>
<br>
<div id="detail_nav">
     <div class="detail_nav_inner">
         <ul class="clearfix padding10">
           <li class="detail_tap3 detail_tap pull_left " id="imgs_tap" onclick="window.location.href='${ctx}/finStaticalPer/perMonth'">月报</li>
           <li class="detail_tap3 detail_tap pull_left " style="border-left:1px solid #ff9f29 " id="pingjia_tap" onclick="window.location.href='${ctx}/finStaticalPer/perQuarter'">季报</li>
           <li class="detail_tap3 detail_tap pull_left select" id="pingjia_tap" onclick="window.location.href='${ctx}/finStaticalPer/perYear'">年报</li>
      	</ul>
     </div>
 </div>
<form action="${ctx}/finStaticalPer/perYear" name="frmId" id="frmId" method="post">
<table border="0" align="left" cellpadding="0" cellspacing="0" style="width: 300px;margin-top: 12px;border: 0px;">
	<tr height="42">
		<td class="formTableTdLeft" width="40">年:&nbsp;
			<input readonly="readonly" type="text" name="year" id="year" value="${param.year }"  onfocus="WdatePicker({dateFmt:'yyyy'})" class="small text" >
			<a href="javascript:void(-1)"	onclick="$('#frmId')[0].submit()"	class="but butSave">查询</a> 
		</td>
	</tr>
</table>
</form>	
<div style="clear: both;"></div>
<div class="frmTitle" onclick="showOrHiden('contactTable')">${title }年车系渗透率统计</div>
<table id="shopNumber" border="0" align="center" cellpadding="0" cellspacing="0" style="margin-top: 5px;width: 98%;margin-right: 5px;margin-left: 5px;">
	<tr height="32" style="background-color: #eeeeee; border-color:#eeeeee;font-size: 14px;font-weight: bold;">
			<th style="width: 30px;text-align: center;">序号</th>
			<th style="width: 60px;text-align: center;">车系</th>
			<th style="width: 60px;text-align: center;"  >实效</th>
			<th style="width: 70px;text-align: center;"  >按揭</th>
			<th style="width: 70px;text-align: center;"  >渗透率</th>
			<th style="width: 80px;text-align: center;"  >产值</th>
			<th style="width: 120px;text-align: center;"  >平均产值</th>
	</tr>
	<c:set value="0.0" var="sactNum"></c:set>
	<c:set value="0.0" var="sloanNum"></c:set>
	<c:set value="0.0" var="sprofit"></c:set>
		<!-- 编辑时展示页面 结束 -->
	<c:forEach var="finStatical" items="${finStaticals }" varStatus="i">
		<tr id="tr${i.index+1 }" height="24">
			<td style="text-align: center;">
				${i.index+1 }
			</td>
			<td style="text-align: center;">
				${finStatical.name}
			</td>
			<td style="text-align: center;">
				${finStatical.actNum }
				<c:set value="${sactNum+finStatical.actNum }" var="sactNum"></c:set>
			</td>
			<td style="text-align: center;">
				${finStatical.loanNum}
				<c:set value="${sloanNum+finStatical.loanNum }" var="sloanNum"></c:set>
			</td>
			<td style="text-align: center;">
				<fmt:formatNumber value="${finStatical.per*100}" pattern="##0.00"></fmt:formatNumber>
			</td>
			<td style="text-align: center;">
				${finStatical.profit }
				<c:set value="${sprofit+finStatical.profit }" var="sprofit"></c:set>
			</td>
			<td style="text-align: center;">
				<fmt:formatNumber value="${finStatical.avgs }" pattern="##0.00"></fmt:formatNumber>
			</td>
			
		</tr>
	</c:forEach>
		<tr height="32" style="background-color: #eeeeee; border-color:#eeeeee;font-size: 13px;color: red;">
			<td colspan="2" style="text-align: right;padding-right: 12px;">
			</td>
			<td style="text-align: right;padding-right: 12px;">
				<fmt:formatNumber value=" ${sactNum }"></fmt:formatNumber>
			</td>
			<td style="text-align: right;padding-right: 12px;">
				<fmt:formatNumber value=" ${sloanNum }"></fmt:formatNumber>
			</td>
			<td style="text-align: right;padding-right: 12px;">
				<c:if test="${sactNum!='0.0' }">
					<c:if test="${sloanNum/sactNum>0 }" var="status">
						<fmt:formatNumber value="${sloanNum/sactNum*100 }" pattern="###,###,##0.00"></fmt:formatNumber>
					</c:if>
					<c:if test="${status==false }">
						0.00
					</c:if>
				</c:if>
				<c:if test="${sloanNum=='0.0' }">
					0.00
				</c:if>
			</td>
			<td style="text-align: right;padding-right: 12px;">
				<fmt:formatNumber value=" ${sprofit }" pattern="###,###,##0.00"></fmt:formatNumber>
			</td>
			<td style="text-align: right;padding-right: 12px;">
				<c:if test="${sloanNum!='0.0' }">
					<c:if test="${sprofit/sloanNum>0 }" var="status">
						<fmt:formatNumber value=" ${sprofit/sloanNum }" pattern="###,###,##0.00"></fmt:formatNumber>
					</c:if>
					<c:if test="${status==false }">
						0.00
					</c:if>
				</c:if>
				<c:if test="${sloanNum=='0.0' }">
					0.00
				</c:if>
			</td>
		</tr>
</table>
<div class="frmTitle" onclick="showOrHiden('contactTable')">${title }年部门渗透率统计</div>
<table id="shopNumber" border="0" align="center" cellpadding="0" cellspacing="0" style="margin-top: 5px;width: 98%;margin-right: 5px;margin-left: 5px;">
	<tr height="32" style="background-color: #eeeeee; border-color:#eeeeee;font-size: 14px;font-weight: bold;">
			<th style="width: 30px;text-align: center;">序号</th>
			<th style="width: 60px;text-align: center;">部门</th>
			<th style="width: 60px;text-align: center;"  >实效</th>
			<th style="width: 70px;text-align: center;"  >按揭</th>
			<th style="width: 70px;text-align: center;"  >渗透率</th>
			<th style="width: 80px;text-align: center;"  >产值</th>
			<th style="width: 120px;text-align: center;"  >平均产值</th>
	</tr>
		<!-- 编辑时展示页面 结束 -->
	<c:forEach var="finStatical" items="${depFinStaticals }" varStatus="i">
		<tr id="tr${i.index+1 }" height="24">
			<td style="text-align: center;">
				${i.index+1 }
			</td>
			<td style="text-align: center;">
				${finStatical.name}
			</td>
			<td style="text-align: center;">
				${finStatical.actNum }
			</td>
			<td style="text-align: center;">
				${finStatical.loanNum}
			</td>
			<td style="text-align: center;">
				<fmt:formatNumber value="${finStatical.per*100}" pattern="##0.00"></fmt:formatNumber>
			</td>
			<td style="text-align: center;">
				${finStatical.profit }
			</td>
			<td style="text-align: center;">
				<fmt:formatNumber value="${finStatical.avgs }" pattern="##0.00"></fmt:formatNumber>
			</td>
		</tr>
	</c:forEach>
		<tr height="32" style="background-color: #eeeeee; border-color:#eeeeee;font-size: 13px;color: red;">
			<td colspan="2" style="text-align: right;padding-right: 12px;">
			</td>
			<td style="text-align: right;padding-right: 12px;">
				<fmt:formatNumber value=" ${sactNum }"></fmt:formatNumber>
			</td>
			<td style="text-align: right;padding-right: 12px;">
				<fmt:formatNumber value=" ${sloanNum }"></fmt:formatNumber>
			</td>
			<td style="text-align: right;padding-right: 12px;">
				<c:if test="${sactNum!='0.0' }">
					<c:if test="${sloanNum/sactNum>0 }" var="status">
						<fmt:formatNumber value="${sloanNum/sactNum*100 }" pattern="###,###,##0.00"></fmt:formatNumber>
					</c:if>
					<c:if test="${status==false }">
						0.00
					</c:if>
				</c:if>
				<c:if test="${sloanNum=='0.0' }">
					0.00
				</c:if>
			</td>
			<td style="text-align: right;padding-right: 12px;">
				<fmt:formatNumber value=" ${sprofit }" pattern="###,###,##0.00"></fmt:formatNumber>
			</td>
			<td style="text-align: right;padding-right: 12px;">
				<c:if test="${sloanNum!='0.0' }">
					<c:if test="${sprofit/sloanNum>0 }" var="status">
						<fmt:formatNumber value=" ${sprofit/sloanNum }" pattern="###,###,##0.00"></fmt:formatNumber>
					</c:if>
					<c:if test="${status==false }">
						0.00
					</c:if>
				</c:if>
				<c:if test="${sloanNum=='0.0' }">
					0.00
				</c:if>
			</td>
		</tr>
</table>
<div class="frmTitle" onclick="showOrHiden('contactTable')">${title }年销售人员渗透率统计</div>
<table id="shopNumber" border="0" align="center" cellpadding="0" cellspacing="0" style="margin-top: 5px;width: 98%;margin-right: 5px;margin-left: 5px;">
	<tr height="32" style="background-color: #eeeeee; border-color:#eeeeee;font-size: 14px;font-weight: bold;">
			<th style="width: 30px;text-align: center;">序号</th>
			<th style="width: 60px;text-align: center;">部门</th>
			<th style="width: 60px;text-align: center;"  >实效</th>
			<th style="width: 70px;text-align: center;"  >按揭</th>
			<th style="width: 70px;text-align: center;"  >渗透率</th>
			<th style="width: 80px;text-align: center;"  >产值</th>
			<th style="width: 120px;text-align: center;"  >平均产值</th>
	</tr>
	<c:set value="0.0" var="scountFee"></c:set>
	<c:set value="0.0" var="sdqxProfitPrice"></c:set>
	<c:set value="0.0" var="sdiscountMony"></c:set>
	<c:set value="0.0" var="sotherPrice"></c:set>
	<c:set value="0.0" var="sactDiscountPrice"></c:set>
	<c:set value="0.0" var="scompanyDiscountPrice"></c:set>
	<c:set value="0.0" var="sprofitPrice"></c:set>
		<!-- 编辑时展示页面 结束 -->
	<c:forEach var="finStatical" items="${userFinStaticals }" varStatus="i">
		<tr id="tr${i.index+1 }" height="24">
			<td style="text-align: center;">
				${i.index+1 }
			</td>
			<td style="text-align: center;">
				${finStatical.name}
			</td>
			<td style="text-align: center;">
				${finStatical.actNum }
			</td>
			<td style="text-align: center;">
				${finStatical.loanNum}
			</td>
			<td style="text-align: center;">
				<fmt:formatNumber value="${finStatical.per*100}" pattern="##0.00"></fmt:formatNumber>
			</td>
			<td style="text-align: center;">
				${finStatical.profit }
			</td>
			<td style="text-align: center;">
				<fmt:formatNumber value="${finStatical.avgs }" pattern="##0.00"></fmt:formatNumber>
				
			</td>
			
		</tr>
	</c:forEach>
		<tr height="32" style="background-color: #eeeeee; border-color:#eeeeee;font-size: 13px;color: red;">
			<td colspan="2" style="text-align: right;padding-right: 12px;">
			</td>
			<td style="text-align: right;padding-right: 12px;">
				<fmt:formatNumber value=" ${sactNum }"></fmt:formatNumber>
			</td>
			<td style="text-align: right;padding-right: 12px;">
				<fmt:formatNumber value=" ${sloanNum }"></fmt:formatNumber>
			</td>
			<td style="text-align: right;padding-right: 12px;">
				<c:if test="${sactNum!='0.0' }">
					<c:if test="${sloanNum/sactNum>0 }" var="status">
						<fmt:formatNumber value="${sloanNum/sactNum*100 }" pattern="###,###,##0.00"></fmt:formatNumber>
					</c:if>
					<c:if test="${status==false }">
						0.00
					</c:if>
				</c:if>
				<c:if test="${sloanNum=='0.0' }">
					0.00
				</c:if>
			</td>
			<td style="text-align: right;padding-right: 12px;">
				<fmt:formatNumber value=" ${sprofit }" pattern="###,###,##0.00"></fmt:formatNumber>
			</td>
			<td style="text-align: right;padding-right: 12px;">
				<c:if test="${sloanNum!='0.0' }">
					<c:if test="${sprofit/sloanNum>0 }" var="status">
						<fmt:formatNumber value=" ${sprofit/sloanNum }" pattern="###,###,##0.00"></fmt:formatNumber>
					</c:if>
					<c:if test="${status==false }">
						0.00
					</c:if>
				</c:if>
				<c:if test="${sloanNum=='0.0' }">
					0.00
				</c:if>
			</td>
		</tr>
</table>
<div class="frmTitle" onclick="showOrHiden('contactTable')">${title }贷款产品分析</div>
${productCarSeriy }
<br>
<br>
<br>
</body>
<script type="text/javascript">
function exportExcel(searchFrm){
 	var params;
 	if(null!=searchFrm&&searchFrm!=undefined&&searchFrm!=''){
 		params=$("#"+searchFrm).serialize();
 	}
 	window.location.href='${ctx}/grossProfitStatic/exportGrossProfit?'+params;
 }
</script>
</html>