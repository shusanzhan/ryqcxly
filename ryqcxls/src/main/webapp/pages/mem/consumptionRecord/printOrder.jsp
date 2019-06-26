<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../../commons/taglib.jsp" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="content-type" content="text/html; charset=utf-8" />
<title>订单打印 - Powered By Ysshop</title>
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
		<a href="${ctx }/consumptionRecord/queryList" id="back" class="btn btn-success " onclick="" style="margin-left: 5px;">返回历史记录</a>
	</div>
	<div class="content" style="margin-left: 2px;margin-right: 2px;">
		<table cellpadding="0" cellspacing="0" border="1">
			<tr>
				<td colspan="1" rowspan="2">
					<img src="${ctx }/images/logo.png" alt="瑞一订单" />
				</td>
				<td colspan="3" align="center">
					<strong>业务流水单</strong>
				</td>
				<td> &#12288;</td>
			</tr>
			<tr>
				<td>
					操作人：${consumptionRecord.user.realName }
				</td>
				<td>
					&nbsp;
				</td>
				<td colspan="2" align="right">
					会员: ${consumptionRecord.member.name }
				</td>
				<td>
					<!-- http://www.xwqr.net -->
				</td>
			</tr>
			<tr class="separated">
				<th colspan="2">
					订单编号: ${consumptionRecord.sn }
				</th>
				<th colspan="2">
					创建日期: <fmt:formatDate value="${consumptionRecord.createTime }" pattern="yyyy-MM-dd" /> 
				</th>
				<th colspan="2">
					打印日期: <fmt:formatDate value="${now }" pattern="yyyy-MM-dd"/>
				</th>
			</tr>
			<tr>
				<td colspan="6">
					&nbsp;
				</td>
			</tr>
			<tr class="separated">
				<th>
					序号
				</th>
				<th>
					商品编号
				</th>
				<th>
					商品名称
				</th>
				<th>
					商品价格
				</th>
				<th>
					数量
				</th>
				<th>
					小计
				</th>
			</tr>
				<c:forEach var="consumptionProduct" items="${consumptionProducts }" varStatus="i">
					<tr>
						<td>
							${i.index+1 }
						</td>
						<td>
							${consumptionProduct.nProduct.no }
						</td>
						<td>
							<c:if test="${fn:length(consumptionProduct.name)>28  }" var="status">
								${fn:substring(consumptionProduct.name,0,28) }...
							</c:if>
							<c:if test="${status==false }">
								${consumptionProduct.name }
							</c:if>
						</td>
						<td>
							￥${consumptionProduct.price }
						</td>
						<td>
							${consumptionProduct.quality }
						</td>
						<td>
							￥${consumptionProduct.price*consumptionProduct.quality }
						</td>
					</tr>
				</c:forEach>
			<tr>
				<td colspan="6">
					&nbsp;
				</td>
			</tr>
			
			<tr class="separated">
				<td colspan="3">
				</td>
				<td colspan="3">
					商品数量: ${consumptionRecord.totalNum}<br />
					订单金额: ￥${consumptionRecord.totalPrice  }
				</td>
			</tr>
			<tr>
				<td colspan="6" align="right">
					客户签字：&#12288;&#12288;&#12288;&#12288;&#12288;&#12288;&#12288;&#12288;&#12288;&#12288;
				</td>
			</tr>
		</table>
	</div>
</body>
</html>