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
table{
	border-top: 1px solid  #cccccc;
	border-left: 1px solid  #cccccc;
}
table th, table td {
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
.ac_results{
	width: 460px;
}
.dis{
	color:#DCDCDC;
}
</style>
<title>支出明细查询</title>
</head>
<body class="bodycolor">
<div class="location">
     	<img src="${ctx}/images/homeIcon.png"/> &nbsp;
     	<a href="javascript:void(-1);" onclick="window.parent.location.href='${ctx}/main/index'">首页</a>-
<a href="javascript:void(-1);" onclick="window.location.href='${ctx}/expenditureManagement/queryList'">支出明细列表</a>-
<a href="#">支出明细</a>
</div>
<div class="line"></div>
 <div class="frmContent">
<table border="0" align="center" cellpadding="0" cellspacing="0"  style="width:100%">
	<tr height="42" style="background-color: #eeeeee; border-color:#eeeeee;font-size: 16px;font-weight: bold;">
					<td width="100%" colspan="4" style="">支出信息</td>
	</tr>
	<tr height = "42px">
		<td style="width:20%">支出信息：&nbsp;</td>
		<td style="width:30%;color:green;font-size:20px" >
				${expenditure.custNames }
		</td>
		<td>电话号码：&nbsp;</td>
		<td >
				<c:if test="${empty expenditure.custTel }">
					无
				</c:if>
				<c:if test="${!empty expenditure.custTel}">
					${expenditure.custTel }
				</c:if>
		</td>
	</tr>
	<tr height = "42px">
		<td style="width:20%">支出单号：&nbsp;</td>
		<td style="width:30%" >
				${expenditure.expenditureSingleNumber }
		</td>
		<td style="width:20%">支出金额：&nbsp;</td>
		<td style="width:30%" >
				<span style="color:red">${expenditure.expenditureAmount }</span>
		</td>
	</tr>
	<tr height = "42px">
		<td style="width:20%">支出项目：&nbsp;</td>
		<td style="width:30%" >
				${expenditure.expenditureItem }
		</td>
		<td style="width:20%">支出时间：&nbsp;</td>
		<td style="width:30%" >
				<fmt:formatDate value="${expenditure.expenditureDate }" />
		</td>
	</tr>
	<tr height = "42px">
		<td style="width:20%">销售人员：&nbsp;</td>
		<td style="width:30%" >
				<c:if test="${empty expenditure.user.realName }">
					无
				</c:if>
				<c:if test="${empty expenditure.user.realName }">
					${expenditure.user.realName }
				</c:if>
		</td>
		<td style="width:20%">支出人：&nbsp;</td>
		<td style="width:30%" >
				${expenditure.payee }
		</td>
	</tr>
	<tr height = "42px">
		<td style="width:20%">备注</td>
		<td colspan="3">
			${expenditure.remarks}
			<c:if test="${empty expenditure.remarks }">
				无
			</c:if>
			<c:if test="${!empty expenditure.remarks }">
				${expenditure.remarks }
			</c:if>
		</td>
	</tr>
</table> 
<c:if test="${empty type}">
<div class="frmTitle" onclick="showOrHiden('contactTable')">装饰项目</div>
		<div id='te' style="width: 100%">
			<table id="shopNumber" border="0" align="center" cellpadding="0" cellspacing="0" style="width: 100%;margin-top: 5px;">
				<tr height="40" style="background-color: #eeeeee; border-color:#eeeeee;font-size: 16px;font-weight: bold;">
						<th style="width: 120px;text-align: center;">品名</th>
						<th style="width: 40px;text-align: center;">数量</th>
						<c:if test="${!empty decoreOuts}">
						<th style="width: 80px;text-align: center;">出库单</th>
						</c:if>
						<!-- <th style="width: 60px;text-align: center;">单位</th> -->
						<c:if test="${!empty decoreOuts}">
							<th style="width: 60px;text-align: center;">销售单价</th>
						</c:if>
						<c:if test="${!empty purchaseStorages}">
							<th style="width: 60px;text-align: center;">单价</th>
						</c:if>
						<c:if test="${!empty purchaseStorages}">
							<th style="width: 60px;text-align: center;">总价</th>
						</c:if>
						<c:if test="${!empty decoreOuts}">
							<th style="width: 60px;text-align: center;">进货价</th>
						</c:if>
						<c:if test="${!empty decoreOuts}">
						<th style="width: 140px;text-align: center;">备注</th>
						</c:if>
				</tr>
				<c:choose>
					<c:when test="${!empty decoreOuts}">
						<c:forEach var="decoreOut" items="${decoreOuts}">
						 <c:forEach var="decoreoutProduct"  items="${decoreOut.decoreoutProducts}">
							<tr height="40">
								<td  id="productName${decoreoutProduct.dbid}" >
									${decoreoutProduct.productName }
								</td>
								<td id="num${decoreoutProduct.dbid}" >
									${decoreoutProduct.num }
								</td>
								<td id="purchaseProductNo${decoreoutProduct.dbid}" >
									${decoreoutProduct.decoreOut.outNo}
								</td>
								<td id="price${decoreoutProduct.dbid}">
									${decoreoutProduct.price}
								</td>
								<td id="subtotal${decoreoutProduct.dbid}">
									${decoreoutProduct.purchasePrice}
								</td>
								<td id="note${decoreoutProduct.dbid}">
									<c:if test="${empty decoreoutProduct.note}">
										无
									</c:if>
									<c:if test="${!empty decoreoutProduct.note}">
										${decoreoutProduct.note}
									</c:if>
								</td>
							</tr>
						</c:forEach>
						</c:forEach>
					</c:when>
					<c:when test="${!empty purchaseStorages}">
						<c:forEach var="purchaseStorage" items="${purchaseStorages}">
						 <c:forEach var="purchaseProduct"  items="${purchaseStorage.purchaseProducts}">
							<tr height="40">
								<td  id="productName${purchaseProduct.dbid}" >
									${purchaseProduct.productName }
								</td>
								<td id="num${purchaseProduct.dbid}" >
									${purchaseProduct.num }
								</td>
								<td id="price${decoreoutProduct.dbid}">
									${purchaseProduct.price}
								</td>
								<td id="subtotal${decoreoutProduct.dbid}">
									${purchaseProduct.totalMoney}
								</td>
							</tr>
						</c:forEach>
						</c:forEach>
					</c:when>
				</c:choose>		
			</table>
		</div>
	</c:if>
</div>
	<div class="formButton">
	    <a href="javascript:void(-1)"	onclick="window.history.go(-1)" class="but butCancle">返&nbsp;&nbsp;回</a>
	</div>
</body>
<script type="text/javascript">

</script>
</html>