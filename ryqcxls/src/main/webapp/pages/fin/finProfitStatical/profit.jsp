<%@page import="java.util.Date"%>
<%@page import="com.ystech.core.util.DateUtil"%>
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
           <li class="detail_tap3 detail_tap pull_left ${param.type==1?'select':''}" id="imgs_tap" onclick="window.location.href='${ctx}/finProfitStatical/profit?role=${param.role }&type=1'">月报</li>
           <li class="detail_tap3 detail_tap pull_left ${param.type==2?'select':''}" style="border:1px solid #ff9f29 " id="pingjia_tap" onclick="window.location.href='${ctx}/finProfitStatical/profit?role=${param.role }&type=2'">季报</li>
           <li class="detail_tap3 detail_tap pull_left ${param.type==3?'select':''}" id="pingjia_tap" onclick="window.location.href='${ctx}/finProfitStatical/profit?role=${param.role }&type=3'">年报</li>
      	</ul>
     </div>
 </div>
<form class="form-inline" action="${ctx }/finProfitStatical/profit" name="frmId" id="frmId" method="post">
      	 <table>
      	 	<tr>
      	 		<td width="60"><label for="exampleInputName2">分公司</label></td>
      	 		<td width="240">
      	 			<input type="hidden" class="form-control" id="role" name="role" value="${param.role }">
      	 			<input type="hidden" class="form-control" id="type" name="type" value="${param.type }">
	      	 			<select id="enterpriseId" name="enterpriseId" class="small text">
	      	 				<option value="-1">请选择...</option>
	      	 				<c:forEach var="enterprise1"  items="${enterprises }">
	      	 					<option value="${enterprise1.dbid }" ${enterprise1.dbid==enterprise.dbid?'selected="selected"':'' } >${enterprise1.name }</option>
	      	 				</c:forEach>
	      	 			</select>
			    </td>
      	 		<td width="60"><label for="exampleInputName2">查询日期</label></td>
      	 		<td width="240">
      	 			<c:if test="${param.type==1 }">
	      	 			<c:if test="${!empty(param.month) }">
	      	 				<input type="month" class="small text" id="month" name="month" value="${param.month }">
	      	 		    </c:if>
	      	 		    <c:if test="${empty(param.month) }">
	      	 				<input type="month" class="small text" id="month" name="month" value="<%=DateUtil.format(new Date())%>">
	      	 		    </c:if>
      	 			</c:if>
      	 			<c:if test="${param.type==2 }">
	      	 			<select id="year" name="year" class="small text">
	      	 				<c:forEach var="i"  begin="2014" end="2500" step="1">
	      	 					<option value="${i }" ${param.year==i?'selected="selected"':'' } >${i }年</option>
	      	 				</c:forEach>
	      	 			</select>
	      	 			<select id="quarter" name="quarter" class="small text">
							<option value="-1">请选择</option>
							<option value="1" ${param.quarter==1?'selected="selected"':''} >1季度</option>
							<option value="2" ${param.quarter==2?'selected="selected"':''} >2季度</option>
							<option value="3" ${param.quarter==3?'selected="selected"':''} >3季度</option>
							<option value="4" ${param.quarter==4?'selected="selected"':''} >4季度</option>
						</select>
      	 			</c:if>
      	 			<c:if test="${param.type==3 }">
	      	 			<select id="year" name="year" class="small text">
	      	 				<c:forEach var="i"  begin="2014" end="2500" step="1">
	      	 					<option value="${i }" ${param.year==i?'selected="selected"':'' } >${i }年</option>
	      	 				</c:forEach>
	      	 			</select>
      	 			</c:if>
			    </td>
			    <td>
			    	<a href="javascript:void(-1)"	onclick="$('#frmId')[0].submit()"	class="but butSave">查询</a>
			    </td>
      	 	</tr>
      	 </table>
		</form>
<div style="clear: both;"></div>
<div class="frmTitle">
		${title }车系利润统计 
</div>
<div class="row-fluid">
	<table id="shopNumber" border="0" align="center" cellpadding="0" cellspacing="0" style="margin-top: 5px;width: 98%;margin-right: 5px;margin-left: 5px;">
		<tbody>
			<tr height="32" style="background-color: #eeeeee; border-color:#eeeeee;font-size: 14px;font-weight: bold;">
				<td align="center" width="20">序号</td>
				<td align="center" width="70">车系</td>
				<td align="center" width="40">数量</td>
				<td align="center" width="40">手续费</td>
				<td align="center" width="40">盗抢险产值</td>
				<td align="center" width="40">实际利息</td>
				<td align="center" width="40">贴息金额</td>
				<td align="center" width="40">公司承担利息</td>
				<td align="center" width="40">利润</td>
				<td align="center" width="40">平均产值</td>
			</tr>
	<c:set value="0.0" var="sloanNum"></c:set>
	<c:set value="0.0" var="scountFee"></c:set>
	<c:set value="0.0" var="sdqxProfitPrice"></c:set>
	<c:set value="0.0" var="sactDiscountPrice"></c:set>
	<c:set value="0.0" var="sdiscountMony"></c:set>
	<c:set value="0.0" var="scompanyDiscountPrice"></c:set>
	<c:set value="0.0" var="sprofitPrice"></c:set>
		<!-- 编辑时展示页面 结束 -->
	<c:forEach var="finStatical" items="${csFinProfitStaticals }" varStatus="i">
		<tr id="tr${i.index+1 }" height="24">
			<td style="text-align: center;">
				${i.index+1 }
			</td>
			<td style="text-align: center;width: 70px;">
				${finStatical.name}
			</td>
			<td style="text-align: center;width: 40px;">
				${finStatical.loanNum }
				<c:set value="${sloanNum+finStatical.loanNum }" var="sloanNum"></c:set>
			</td>
			<td style="text-align: center;width: 40px;">
				${finStatical.countFee}
				<c:set value="${scountFee+finStatical.countFee }" var="scountFee"></c:set>
			</td>
			<td style="text-align: center;width: 40px;">
				${finStatical.dqxProfitPrice}
				<c:set value="${sdqxProfitPrice+finStatical.dqxProfitPrice }" var="sdqxProfitPrice"></c:set>
			</td>
			<td style="text-align: center;width: 50px;">
				${finStatical.actDiscountPrice }
				<c:set value="${sactDiscountPrice+finStatical.actDiscountPrice }" var="sactDiscountPrice"></c:set>
			</td>
			<td style="text-align: center;width: 50px;">
				${finStatical.discountMony }
				<c:set value="${sdiscountMony+finStatical.discountMony }" var="sdiscountMony"></c:set>
			</td>
			<td style="text-align: center;width: 50px;">
				${finStatical.companyDiscountPrice }
				<c:set value="${scompanyDiscountPrice+finStatical.companyDiscountPrice }" var="scompanyDiscountPrice"></c:set>
			</td>
			<td style="text-align: center;width: 50px;">
				${finStatical.profitPrice }
				<c:set value="${sprofitPrice+finStatical.profitPrice }" var="sprofitPrice"></c:set>
			</td>
			<td style="text-align: center;width: 50px;">
					<fmt:formatNumber value="${finStatical.avgs }" pattern="##0.00"></fmt:formatNumber>
			</td>
		</tr>
	</c:forEach>
	
	 <tr height="32" style="background-color: #eeeeee; border-color:#eeeeee;font-size: 13px;color: red;">
			<td colspan="2" style="text-align: right;padding-right: 12px;">
			</td>
			<td style="text-align: right;padding-right: 12px;">
				${sloanNum }
			</td>
			 <td style="text-align: right;padding-right: 12px;">
				<fmt:formatNumber value=" ${scountFee }" pattern="##0.00"></fmt:formatNumber>
			</td>
			<td style="text-align: right;padding-right: 12px;">
				<fmt:formatNumber value=" ${sdqxProfitPrice }" pattern="###,###,##0.00"></fmt:formatNumber>
			</td>
			<td style="text-align: right;padding-right: 12px;">
				<fmt:formatNumber value=" ${sactDiscountPrice }" pattern="###,###,##0.00"></fmt:formatNumber>
			</td>
			<td style="text-align: right;padding-right: 12px;">
				<fmt:formatNumber value=" ${sdiscountMony }" pattern="###,###,##0.00"></fmt:formatNumber>
			</td>
			<td style="text-align: right;padding-right: 12px;">
				<fmt:formatNumber value=" ${scompanyDiscountPrice }" pattern="###,###,##0.00"></fmt:formatNumber>
			</td>
			<td style="text-align: right;padding-right: 12px;">
				<fmt:formatNumber value=" ${sprofitPrice }" pattern="###,###,##0.00"></fmt:formatNumber>
			</td>
			<td style="text-align: right;padding-right: 12px;">
				<c:if test="${sloanNum!='0.0' }">
					<c:if test="${sprofitPrice/sloanNum>0 }" var="status">
						<fmt:formatNumber value=" ${sprofitPrice/sloanNum }" pattern="###,###,##0.00"></fmt:formatNumber>
						0.00
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
		</tbody>
	</table>
</div>
<div class="frmTitle">
		${title }部门利润统计
</div>
<div class="row-fluid">
	<table id="shopNumber" border="0" align="center" cellpadding="0" cellspacing="0" style="margin-top: 5px;width: 98%;margin-right: 5px;margin-left: 5px;">
		<tbody>
			<tr height="32" style="background-color: #eeeeee; border-color:#eeeeee;font-size: 14px;font-weight: bold;">
				<td align="center" width="20">序号</td>
				<td align="center" width="70">部门</td>
				<td align="center" width="40">数量</td>
				<td align="center" width="40">手续费</td>
				<td align="center" width="40">盗抢险产值</td>
				<td align="center" width="40">实际利息</td>
				<td align="center" width="40">贴息金额</td>
				<td align="center" width="40">公司承担利息</td>
				<td align="center" width="40">利润</td>
				<td align="center" width="40">平均产值</td>
			</tr>
		<!-- 编辑时展示页面 结束 -->
	<c:forEach var="finStatical" items="${depFinProfitStaticals }" varStatus="i">
		<tr id="tr${i.index+1 }" height="24">
			<td style="text-align: center;">
				${i.index+1 }
			</td>
			<td style="text-align: center;width: 70px;">
				${finStatical.name}
			</td>
			<td style="text-align: center;width: 40px;">
				${finStatical.loanNum }
			</td>
			<td style="text-align: center;width: 40px;">
				${finStatical.countFee}
			</td>
			<td style="text-align: center;width: 40px;">
				${finStatical.dqxProfitPrice}
			</td>
			<td style="text-align: center;width: 50px;">
				${finStatical.actDiscountPrice }
			</td>
			<td style="text-align: center;width: 50px;">
				${finStatical.discountMony }
			</td>
			<td style="text-align: center;width: 50px;">
				${finStatical.companyDiscountPrice }
			</td>
			<td style="text-align: center;width: 50px;">
				${finStatical.profitPrice }
			</td>
			<td style="text-align: center;width: 50px;">
				<fmt:formatNumber value="${finStatical.avgs }" pattern="##0.00"></fmt:formatNumber>
			</td>
		</tr>
	</c:forEach>
	 <tr height="32" style="background-color: #eeeeee; border-color:#eeeeee;font-size: 13px;color: red;">
			<td colspan="2" style="text-align: right;padding-right: 12px;">
			</td>
			<td style="text-align: right;padding-right: 12px;">
				${sloanNum }
			</td>
			<td style="text-align: right;padding-right: 12px;">
				<fmt:formatNumber value=" ${scountFee }" pattern="##0.00"></fmt:formatNumber>
			</td>
			<td style="text-align: right;padding-right: 12px;">
				<fmt:formatNumber value=" ${sdqxProfitPrice }" pattern="###,###,##0.00"></fmt:formatNumber>
			</td>
			<td style="text-align: right;padding-right: 12px;">
				<fmt:formatNumber value=" ${sactDiscountPrice }" pattern="###,###,##0.00"></fmt:formatNumber>
			</td>
			<td style="text-align: right;padding-right: 12px;">
				<fmt:formatNumber value=" ${sdiscountMony }" pattern="###,###,##0.00"></fmt:formatNumber>
			</td>
			<td style="text-align: right;padding-right: 12px;">
				<fmt:formatNumber value=" ${scompanyDiscountPrice }" pattern="###,###,##0.00"></fmt:formatNumber>
			</td>
			<td style="text-align: right;padding-right: 12px;">
				<fmt:formatNumber value=" ${sprofitPrice }" pattern="###,###,##0.00"></fmt:formatNumber>
			</td>
			<td style="text-align: right;padding-right: 12px;">
					<c:if test="${sloanNum!='0.0' }">
					<c:if test="${sprofitPrice/sloanNum>0 }" var="status">
						<fmt:formatNumber value=" ${sprofitPrice/sloanNum }" pattern="###,###,##0.00"></fmt:formatNumber>
						0.00
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
		</tbody>
	</table>
	<!-- <div class="span6">
		<div class="widget-box">
			<div id="container" style="height: 300px; margin: 0 auto"></div>
		</div>
	</div> -->
</div>
 <div class="frmTitle">
		${title }销售人员利润统计
</div>
<div class="row-fluid">
	<table id="shopNumber" border="0" align="center" cellpadding="0" cellspacing="0" style="margin-top: 5px;width: 98%;margin-right: 5px;margin-left: 5px;">
		<tbody>
			<tr height="32" style="background-color: #eeeeee; border-color:#eeeeee;font-size: 14px;font-weight: bold;">
				<td align="center" width="20">序号</td>
				<td align="center" width="70">销售顾问</td>
				<td align="center" width="40">数量</td>
				<td align="center" width="40">手续费</td>
				<td align="center" width="40">盗抢险产值</td>
				<td align="center" width="40">实际利息</td>
				<td align="center" width="40">贴息金额</td>
				<td align="center" width="40">公司承担利息</td>
				<td align="center" width="40">利润</td>
				<td align="center" width="40">平均产值</td>
			</tr>
		<!-- 编辑时展示页面 结束 -->
	<c:forEach var="finStatical" items="${userFinProfitStaticals }" varStatus="i">
		<tr id="tr${i.index+1 }" height="24">
			<td style="text-align: center;">
				${i.index+1 }
			</td>
			<td style="text-align: center;width: 70px;">
				${finStatical.name}
			</td>
			<td style="text-align: center;width: 40px;">
				${finStatical.loanNum }
			</td>
			<td style="text-align: center;width: 40px;">
				${finStatical.countFee}
			</td>
			<td style="text-align: center;width: 40px;">
				${finStatical.dqxProfitPrice}
			</td>
			<td style="text-align: center;width: 50px;">
				${finStatical.actDiscountPrice }
			</td>
			<td style="text-align: center;width: 50px;">
				${finStatical.discountMony }
			</td>
			<td style="text-align: center;width: 50px;">
				${finStatical.companyDiscountPrice }
			</td>
			<td style="text-align: center;width: 50px;">
				${finStatical.profitPrice }
			</td>
			<td style="text-align: center;width: 50px;">
				<c:if test="${sloanNum!='0.0' }">
					<c:if test="${sprofitPrice/sloanNum>0 }" var="status">
						<fmt:formatNumber value=" ${sprofitPrice/sloanNum }" pattern="###,###,##0.00"></fmt:formatNumber>
						0.00
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
	</c:forEach>
	 <tr height="32" style="background-color: #eeeeee; border-color:#eeeeee;font-size: 13px;color: red;">
			<td colspan="2" style="text-align: right;padding-right: 12px;">
			</td>
			<td style="text-align: right;padding-right: 12px;">
				${sloanNum }
			</td>
			 <td style="text-align: right;padding-right: 12px;">
				<fmt:formatNumber value=" ${scountFee }" pattern="##0.00"></fmt:formatNumber>
			</td>
			<td style="text-align: right;padding-right: 12px;">
				<fmt:formatNumber value=" ${sdqxProfitPrice }" pattern="###,###,##0.00"></fmt:formatNumber>
			</td>
			<td style="text-align: right;padding-right: 12px;">
				<fmt:formatNumber value=" ${sactDiscountPrice }" pattern="###,###,##0.00"></fmt:formatNumber>
			</td>
			<td style="text-align: right;padding-right: 12px;">
				<fmt:formatNumber value=" ${sdiscountMony }" pattern="###,###,##0.00"></fmt:formatNumber>
			</td>
			<td style="text-align: right;padding-right: 12px;">
				<fmt:formatNumber value=" ${scompanyDiscountPrice }" pattern="###,###,##0.00"></fmt:formatNumber>
			</td>
			<td style="text-align: right;padding-right: 12px;">
				<fmt:formatNumber value=" ${sprofitPrice }" pattern="###,###,##0.00"></fmt:formatNumber>
			</td>
			<td style="text-align: right;padding-right: 12px;">
				<c:if test="${sloanNum!='0.0' }">
					<c:if test="${sprofitPrice/sloanNum>0 }" var="status">
						<fmt:formatNumber value=" ${sprofitPrice/sloanNum }" pattern="###,###,##0.00"></fmt:formatNumber>
						0.00
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
		</tbody>
	</table>
	<!-- <div class="span6">
		<div class="widget-box">
			<div id="container" style="height: 300px; margin: 0 auto"></div>
		</div>
	</div> -->
</div>
<div class="frmTitle">
		${title }贷款产品分析
</div>
<div class="row-fluid">
	<table id="shopNumber" border="0" align="center" cellpadding="0" cellspacing="0" style="margin-top: 5px;width: 98%;margin-right: 5px;margin-left: 5px;">
		<tbody>
			<tr height="32" style="background-color: #eeeeee; border-color:#eeeeee;font-size: 14px;font-weight: bold;">
				<td align="center" width="20">序号</td>
				<td align="center" width="70">贷款产品</td>
				<td align="center" width="40">数量</td>
				<td align="center" width="40">手续费</td>
				<td align="center" width="40">盗抢险产值</td>
				<td align="center" width="40">实际利息</td>
				<td align="center" width="40">贴息金额</td>
				<td align="center" width="40">公司承担利息</td>
				<td align="center" width="40">利润</td>
				<td align="center" width="40">平均产值</td>
			</tr>
		<!-- 编辑时展示页面 结束 -->
	<c:forEach var="finStatical" items="${proFinProfitStaticals }" varStatus="i">
		<tr id="tr${i.index+1 }" height="24">
			<td style="text-align: center;">
				${i.index+1 }
			</td>
			<td style="text-align: center;width: 70px;">
				${finStatical.name}
			</td>
			<td style="text-align: center;width: 40px;">
				${finStatical.loanNum }
			</td>
			<td style="text-align: center;width: 40px;">
				${finStatical.countFee}
			</td>
			<td style="text-align: center;width: 40px;">
				${finStatical.dqxProfitPrice}
			</td>
			<td style="text-align: center;width: 50px;">
				${finStatical.actDiscountPrice }
			</td>
			<td style="text-align: center;width: 50px;">
				${finStatical.discountMony }
			</td>
			<td style="text-align: center;width: 50px;">
				${finStatical.companyDiscountPrice }
			</td>
			<td style="text-align: center;width: 50px;">
				${finStatical.profitPrice }
			</td>
			<td style="text-align: center;width: 50px;">
				<c:if test="${sloanNum!='0.0' }">
					<c:if test="${sprofitPrice/sloanNum>0 }" var="status">
						<fmt:formatNumber value=" ${sprofitPrice/sloanNum }" pattern="###,###,##0.00"></fmt:formatNumber>
						0.00
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
	</c:forEach>
	 <tr height="32" style="background-color: #eeeeee; border-color:#eeeeee;font-size: 13px;color: red;">
			<td colspan="2" style="text-align: right;padding-right: 12px;">
			</td>
			<td style="text-align: right;padding-right: 12px;">
				${sloanNum }
			</td>
			<td style="text-align: right;padding-right: 12px;">
					<fmt:formatNumber value=" ${scountFee }" pattern="##0.00"></fmt:formatNumber>
			</td>
			<td style="text-align: right;padding-right: 12px;">
				<fmt:formatNumber value=" ${sdqxProfitPrice }" pattern="###,###,##0.00"></fmt:formatNumber>
			</td>
			<td style="text-align: right;padding-right: 12px;">
				<fmt:formatNumber value=" ${sactDiscountPrice }" pattern="###,###,##0.00"></fmt:formatNumber>
			</td>
			<td style="text-align: right;padding-right: 12px;">
				<fmt:formatNumber value=" ${sdiscountMony }" pattern="###,###,##0.00"></fmt:formatNumber>
			</td>
			<td style="text-align: right;padding-right: 12px;">
				<fmt:formatNumber value=" ${scompanyDiscountPrice }" pattern="###,###,##0.00"></fmt:formatNumber>
			</td>
			<td style="text-align: right;padding-right: 12px;">
				<fmt:formatNumber value=" ${sprofitPrice }" pattern="###,###,##0.00"></fmt:formatNumber>
			</td>
			<td style="text-align: right;padding-right: 12px;">
				<c:if test="${sloanNum!='0.0' }">
					<c:if test="${sprofitPrice/sloanNum>0 }" var="status">
						<fmt:formatNumber value=" ${sprofitPrice/sloanNum }" pattern="###,###,##0.00"></fmt:formatNumber>
						0.00
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
		</tbody>
	</table>
</div>
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