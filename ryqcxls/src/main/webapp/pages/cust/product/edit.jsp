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
		<input type="hidden" id="currentPage" name="currentPage" value='${param.currentPage}'>
		<input type="hidden" id="paramPageSize" name="pageSize" value='${param.pageSize}'>
		<tr>
			<td class="formTableTdLeft">商品类型：</td>
			<td>
				<select class="largeX text" id="productCategoryDbid" name="productCategoryDbid" checkType="string,1,20"  tip="请选择商品规格类型！" >
					<option value="">请选择...</option>
					${productCateGorySelect }
				</select>
			</td>
			<td class="formTableTdLeft">适用类型:&nbsp;</td>
				<td>
					<c:if test="${empty(product.commType) }">
						<label>
							<input type="radio" id="commType" name="product.commType" checked="checked" value="1" onclick="showHide()">通用
						</label>
						<label>
							<input type="radio" id="commType" name="product.commType" value="2"  onclick="showHide()">专用
						</label>
					</c:if>
					<c:if test="${!empty(product.commType) }">
						<label>
							<input type="radio" id="commType" name="product.commType" ${product.commType==1?'checked="checked" ':'' }  value="1"  onclick="showHide()">通用
						</label>
						<label>
							<input type="radio" id="commType" name="product.commType" ${product.commType==2?'checked="checked" ':'' } value="2"  onclick="showHide()">专用
						</label>
					</c:if>
				<span style="color: red;">*</span>
				</td>
		</tr>
		<c:if test="${empty(product.commType)||product.commType==1 }">
			<tr id="brandTr" style="display: none;" >
				<td class="formTableTdLeft">品牌：</td>
				<td colspan="3"> 
					${brandCheck }
				</td>
			</tr>
		</c:if>
		<c:if test="${product.commType==2 }">
			<tr id="brandTr" >
				<td class="formTableTdLeft">品牌：</td>
				<td colspan="3"> 
					${brandCheck }
				</td>
			</tr>
		</c:if>
		<tr>
			<td class="formTableTdLeft">编码：</td>
			<td>
				<input  type="text" class="largeX text" name="product.sn" id="sn"  value="${product.sn }" checkType="string,1,20" placeholder="请输入商品编码信息"  tip="请输入商品编码！编码为1至20个字符"/>
			</td>
			<td class="formTableTdLeft">名称：</td>
			<td>
				<input type="text" class="largeX text" name="product.name"	id="name" value="${product.name }" onchange="pingyin.value = getCharsCode(this.value);" checkType="string,1,500"  tip="请输入商品名称！字符长度必须为1-500个字符"  />
				<input type="hidden" name="product.pingyin" id="pingyin" value="${product.pingyin }">
			</td>
		</tr>
		<tr>
			<td class="formTableTdLeft">销售指导价格：</td>
			<td>
				<c:if test="${empty(product) }">
					<input type="text" class="largeX text" name="product.price" id="price"  value="0" checkType="float"  tip="请输入商品销售价格！"/>
				</c:if>
				<c:if test="${!empty(product) }">
					<input type="text" class="largeX text" name="product.price" id="price"  value="${product.price }" checkType="float"  tip="请输入商品销售价格！"/>
				</c:if>
			</td>
			<td class="formTableTdLeft">含税成本价：</td>
			<td>
				<c:if test="${empty(product) }">
					<input type="text" class="largeX text" name="product.costPrice" id="costPrice"  value="0" checkType="float" canEmpty="Y" tip="请输入成本价格！可为空"/>
				</c:if>
				<c:if test="${!empty(product) }">
					<input type="text" class="largeX text" name="product.costPrice" id="costPrice"  value="${product.costPrice }" checkType="float" canEmpty="Y" tip="请输入成本价格！可为空"/>
				</c:if>
			</td>
		</tr>
		<tr>
			<td class="formTableTdLeft" >销售顾问结算价：</td>
			<td colspan="1">
				<c:if test="${empty(product) }">
					<input type="text"  class="largeX text" name="product.salerCostPrice" id="salerCostPrice"  value="0" checkType="float,0" tip="请输入销售顾问结算价"/>
				</c:if>
				<c:if test="${!empty(product) }">
					<input type="text"  class="largeX text" name="product.salerCostPrice" id="salerCostPrice"  value="${product.salerCostPrice }" checkType="float,0" tip="请输入销售顾问结算价"/>
				</c:if>
			</td>
			<td class="formTableTdLeft" >施工成本：</td>
			<td colspan="1">
				<c:if test="${empty(product) }">
					<input type="text"  class="largeX text" name="product.constructCostPrice" id="constructCostPrice"  value="0" checkType="float,0" tip="请输入施工成本"/>
				</c:if>
				<c:if test="${!empty(product) }">
					<input type="text"  class="largeX text" name="product.constructCostPrice" id="constructCostPrice"  value="${product.constructCostPrice }" checkType="float,0" tip="请输入施工成本"/>
				</c:if>
			</td>
		</tr>
		<tr>
			<td class="formTableTdLeft">单位：</td>
			<td>
				<input type="text" class="largeX text" name="product.unit" id="unit"  value="${product.unit }" />
			</td>
			<td class="formTableTdLeft">规格：</td>
			<td>
				<input type="text" class="largeX text" name="product.specification" id="specification"  value="${product.specification }" />
			</td>
		</tr>
		<tr>
			<c:if test="${empty(product) }">
				<td class="formTableTdLeft">当前库存量：</td>
				<td>
					<input type="text"  readonly="readonly" class="largeX text" name="product.stockNum" id="stockNum" value="0" checkType="integer,0" canEmpty="Y"  tip="请输入库存量！可以为空">
				</td>
				<td class="formTableTdLeft">初始库存量：</td>
				<td>
					<input type="text"  readonly="readonly" class="largeX text" name="product.startStockNum" id="startStockNum" value="0" checkType="integer,0" canEmpty="Y" tip="请输入库存量！可以为空">
				</td>
			</c:if>
			<c:if test="${!empty(product) }">
				<td class="formTableTdLeft">当前库存量：</td>
				<td>
					<input type="text" readonly="readonly" class="largeX text" name="product.stockNum" id="stockNum" value="${product.stockNum }" checkType="integer,0" canEmpty="Y" tip="请输入库存量！可以为空">
				</td>
				<td class="formTableTdLeft">初始库存量：</td>
				<td>
					<input type="text" readonly="readonly"  class="largeX text" name="product.startStockNum" id="startStockNum" value="${product.startStockNum }" checkType="integer,0" canEmpty="Y"  tip="请输入库存量！可以为空">
				</td>
			</c:if>
			</tr>
		<tr>
				<td class="formTableTdLeft">最大库存量：</td>
				<td>
					<input type="text"  class="largeX text" name="product.maxStockNum" id="maxStockNum" value="${product.maxStockNum }" checkType="integer,0"  tip="请输入库存量！可以为空">
				</td>
				<td class="formTableTdLeft">最低库存量：</td>
				<td>
					<input type="text"  class="largeX text" name="product.minStockNum" id="minStockNum" value="${product.minStockNum }" checkType="integer,0"  tip="请输入库存量！可以为空">
				</td>
			</tr>
		<tr>
				<td class="formTableTdLeft">可见范围：</td>
				<td colspan="3">
						<c:if test="${!empty(check) }">
							${check }
						</c:if>
				</td>
		</tr>
		<%-- <tr>
			<td class="formTableTdLeft" >赠送积分：</td>
			<td colspan="3">
				<input type="text"  class="largeX text" name="product.integral" id="integral"  value="${product.integral }" />
			</td>
		</tr>
		<tr>
		    <td class="formTableTdLeft">是否进行追踪：</td>
			<td>
				<label>
					<input  type="checkbox" id="isTrack" name="product.isTrack" onclick="showOrHidn(this,'trackTimeLong')" ${product.isTrack==true?'checked="checked"':''}  value="true">启用
				</label>
			</td>
			<td>
				售出后：
			</td>
			<td>
				<input name="product.trackTimeLong" ${product.isTrack==true?'':'disabled="disabled"' }  class="mideaXX text" id="trackTimeLong" title="售出后"  value="${product.trackTimeLong }" checkType="integer" canEmpty="Y" tip="请输入售出后开始追踪日期"></input>天开始追踪
			</td>
		</tr>
		<tr>
			<td class="formTableTdLeft">是否参与提成：</td>
			<td>
				<label>
					<input  type="checkbox" id="isDeductPercentage" onclick="showOrHidn(this,'deductPercert')" name="product.isDeductPercentage" ${product.isDeductPercentage==true?'checked="checked"':''} value="true">启用
				</label>
			</td>
			<td class="formTableTdLeft">提成比例：</td>
			<td>
				<input type="text" ${product.isDeductPercentage==true?'':'disabled="disabled"' } class="mideaXX text" name="product.deductPercert" id="deductPercert"  value="${product.deductPercert }" checkType="float,0,100" canEmpty="Y" tip="请输入库存量！可以为空"/>%
			</td>
		</tr>
		
		
		<tr>
			<td class="formTableTdLeft">是否设置为礼品：</td>
			<td>
				<label>
					<input onclick="showOrHidn(this,'deductionScore')" type="checkbox" id="isGift" name="product.isGift" ${product.isGift==true?'checked="checked"':''}  value="true">启用
				</label>
			</td>
			<td class="formTableTdLeft">扣除积分：</td>
			<td>
				<input   ${product.isGift==true?'':'disabled="disabled"' } name="product.deductionScore" class="mideaXX text" id=deductionScore title="扣除积分" value="${product.deductionScore }" ></input>
			</td>
		</tr> --%>
		<tr height="80">
			<td class="formTableTdLeft">备注：</td>
			<td  colspan="3">
				<textarea type="text" class="largeX text" style="height: 120px;width: 600px;" name="product.note" id="note"  value="">${product.note }</textarea>
			</td>
		</tr>
</table>
</form>                            
<div class="formButton">
		<a href="javascript:void(-1)"	onclick="$.utile.submitForm('frmId','${ctx}/product/save')"	class="but butSave">保&nbsp;&nbsp;存</a> 
	    <a href="javascript:void(-1)"	onclick="goBack()" class="but butCancle">取&nbsp;&nbsp;消</a>
	</div>
</div>
</body>
<script type="text/javascript">
	function showHide(){
		var value=$("input[name='product.commType']:checked").val();
		if(value==1){
			$("#brandTr").hide();
		}
		if(value==2){
			$("#brandTr").show();
		}
	}
</script>
</html>
