<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="../../commons/taglib.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html lang="en">
<head>
<title>商品添加</title>
<meta charset="UTF-8" />
<meta name="viewport" content="width=device-width, initial-scale=1.0" />
<link href="${ctx }/css/common.css" type="text/css" rel="stylesheet">
<link  href="${ctx }/widgets/easyvalidator/css/validate.css" rel="stylesheet" type="text/css" />
<script type="text/javascript" src="${ctx }/widgets/bootstrap3/jquery.min.js"></script>
<script type="text/javascript" src="${ctx }/widgets/utile/utile.js"></script>
<script type="text/javascript" src="${ctx }/widgets/easyvalidator/js/jquery.bgiframe.min.js"></script>
<script type="text/javascript" src="${ctx }/widgets/easyvalidator/js/easy_validator.pack.js"></script>
<script type="text/javascript" src="${ctx}/widgets/charscode.js"></script>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
</head>
<script type="text/javascript">
	function showOrHidn(varCheck,id){
		var va=varCheck.checked;
		if(va){
			$("#"+id).attr("disabled",false);
		}else{
			$("#"+id).attr("disabled",true);
		}
	}
</script>
<body class="bodycolor">
<div class="location">
   	<img src="${ctx}/images/homeIcon.png"/> &nbsp;
   	<a href="javascript:void(-1);" onclick="window.parent.location.href='${ctx}/main/index'">首页</a>-
	<a href="javascript:void(-1);" onclick="window.location.href='${ctx}/product/queryList'">商品类型</a>-
	<a href="javascript:void(-1)" class="current">
		<c:if test="${product.dbid>0 }" var="status">编辑商品</c:if>
		<c:if test="${status==false }">添加商品</c:if>
	</a>
</div>
<div class="frmContent">
   <form class="form-horizontal" method="post" action="" 	name="frmId" id="frmId">
   <table border="0" align="center" cellpadding="0" cellspacing="0" style="width: 92%;">
		<input type="hidden" value="${product.dbid }" id="dbid" name="product.dbid">
		<tr>
			<td class="formTableTdLeft">商品类型：</td>
			<td>
				<select class="largeX text" id="productTypeDbid" name="productTypeDbid" checkType="string,1,20"  tip="请选择商品规格类型！" >
					<option value="">请选择...</option>
					${nProductTypeSelect }
				</select>
			</td>
			<td class="formTableTdLeft">适用类型：</td>
			<td>
				<select class="largeX text" id="suitableTtype" name="product.suitableTtype" checkType="string,1,20" >
					<option value="0">请选择...</option>
					<option value="1" ${product.suitableTtype==1?'selected="selected"':'' } >奇瑞专用</option>
					<option value="2" ${product.suitableTtype==2?'selected="selected"':'' }>通用</option>
				</select>
			</td>
		</tr>
		<tr>
			<td class="formTableTdLeft">编码：</td>
			<td>
				<input  type="text" class="largeX text" name="product.no" id="no"  value="${product.no }" checkType="string,1,20" placeholder="请输入商品编码信息"  tip="请输入商品编码！编码为1至20个字符"/>
			</td>
			<td class="formTableTdLeft">名称：</td>
			<td>
				<input type="text" class="largeX text" name="product.name"	id="name" value="${product.name }" onchange="jym.value = getCharsCode(this.value);" checkType="string,1,500"  tip="请输入商品名称！字符长度必须为1-500个字符"  />
				<input type="hidden" name="product.jym" id="jym" value="${product.jym }">
			</td>
		</tr>
		<tr>
			<td class="formTableTdLeft">销售价格：</td>
			<td>
				<input type="text" class="largeX text" name="product.price" id="price"  value="${product.price }" checkType="float"  tip="请输入商品销售价格！"/>
			</td>
			<td class="formTableTdLeft">成本价：</td>
			<td>
				<input type="text" class="largeX text" name="product.costPrice" id="costPrice"  value="${product.costPrice }" checkType="float" canEmpty="Y" tip="请输入成本价格！可为空"/>
			</td>
		</tr>
		<tr>
			<td class="formTableTdLeft">单位：</td>
			<td>
				<input type="text" class="largeX text" name="product.unit" id="unit"  value="${product.unit }" />
			</td>
			</td>
				<td class="formTableTdLeft">库存：</td>
				<td>
					<input type="text"  class="mideaXX text" name="product.stockNum" id="stockNum" value="${product.stockNum }" checkType="integer" canEmpty="Y" tip="请输入库存量！可以为空">
				</td>
		</tr>
		<tr>
			<td class="formTableTdLeft" >赠送积分：</td>
			<td colspan="">
				<input type="text"  class="largeX text" name="product.integral" id="integral"  value="${product.integral }" />
			<td class="formTableTdLeft" >折扣：</td>
			<td colspan="">
				<input type="text"  class="largeX text" name="product.discount" id="discount"  value="${product.discount }" />
			</tr>
		<tr height="80">
			<td class="formTableTdLeft">备注：</td>
			<td  colspan="3">
				<textarea type="text" class="largeX text" style="height: 120px;width: 600px;" name="product.note" id="note"  value="">${product.note }</textarea>
			</td>
		</tr>
</table>
</form>                            
<div class="formButton">
		<a href="javascript:void(-1)"	onclick="$.utile.submitForm('frmId','${ctx}/nProduct/save')"	class="but butSave">保&nbsp;&nbsp;存</a> 
	    <a href="javascript:void(-1)"	onclick="goBack()" class="but butCancle">取&nbsp;&nbsp;消</a>
	</div>
</div>
</body>

</html>
