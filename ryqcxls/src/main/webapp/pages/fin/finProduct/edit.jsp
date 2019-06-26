<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="../../commons/taglib.jsp" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link href="${ctx }/css/common.css" type="text/css" rel="stylesheet"/>
<link  href="${ctx }/widgets/easyvalidator/css/validate.css" rel="stylesheet" type="text/css" />
<script type="text/javascript" src="${ctx }/widgets/bootstrap3/jquery.min.js"></script>
<script type="text/javascript" src="${ctx }/widgets/ckeditor/ckeditor.js"></script>
<script type="text/javascript" src="${ctx }/widgets/utile/utile.js"></script>
<script type="text/javascript" src="${ctx }/widgets/easyvalidator/js/jquery.bgiframe.min.js"></script>
<script type="text/javascript" src="${ctx }/widgets/easyvalidator/js/easy_validator.pack.js"></script>
<title>金融产品添加</title>
</head>
<body class="bodycolor">
<div class="location">
     	<img src="${ctx}/images/homeIcon.png"/> &nbsp;
     	<a href="javascript:void(-1);" onclick="window.parent.location.href='${ctx}/main/index'">首页</a>-
<a href="javascript:void(-1);" onclick="window.location.href='${ctx}/finProduct/queryList'">金融产品</a>-
<a href="javascript:void(-1);">
	<c:if test="${empty(finProduct) }">添加金融产品</c:if>
	<c:if test="${!empty(finProduct) }">编辑金融产品</c:if>
</a>
</div>
<div class="line"></div>
<div class="frmContent">
	<form action="" name="frmId" id="frmId"  target="_self">
		<s:token></s:token>
		<input type="hidden" name="finProduct.dbid" id="dbid" value="${finProduct.dbid }">
		<input type="hidden" name="finProduct.createDate" id="createDate" value="${finProduct.createDate }">
		<table border="0" align="center" cellpadding="0" cellspacing="0" style="width: 92%;">
			<tr height="42">
				<td class="formTableTdLeft">名称:&nbsp;</td>
				<td ><input type="text" name="finProduct.name" id="name" value="${finProduct.name }" class="largeX text" title="名称"	checkType="string,1,50" tip="名称不能为空"><span style="color: red;">*</span></td>
				<td class="formTableTdLeft">基数（元）:&nbsp;</td>
				<td >
				<c:if test="${empty(finProduct) }">
					<input type="text" name="finProduct.baseMoney" id="baseMoney" readonly="readonly" value="10000" class="largeX text" title="基数" 	checkType="integer,1" tip="月数不能为空,且只能为数字"><span style="color: red;">*</span>
				</c:if>
				<c:if test="${!empty(finProduct) }">
					<input type="text" name="finProduct.baseMoney" id="baseMoney" value="${finProduct.baseMoney }" class="largeX text" title="基数" 	checkType="integer,1" tip="月数不能为空,且只能为数字"><span style="color: red;">*</span>
				</c:if>
				</td>
			</tr>
			<tr>
				<td class="formTableTdLeft">适用类型:&nbsp;</td>
				<td>
					<c:if test="${empty(finProduct.type) }">
						<label>
							<input type="radio" id="type" name="finProduct.type" checked="checked" value="1" onclick="showHide()">通用
						</label>
						<label>
							<input type="radio" id="type" name="finProduct.type" value="2"  onclick="showHide()">专用
						</label>
					</c:if>
					<c:if test="${!empty(finProduct.type) }">
						<label>
							<input type="radio" id="type" name="finProduct.type" ${finProduct.type==1?'checked="checked" ':'' }  value="1"  onclick="showHide()">通用
						</label>
						<label>
							<input type="radio" id="type" name="finProduct.type" ${finProduct.type==2?'checked="checked" ':'' } value="2"  onclick="showHide()">专用
						</label>
					</c:if>
				<span style="color: red;">*</span>
				</td>
				<td class="formTableTdLeft">利息计算类型:&nbsp;</td>
				<td>
					<c:if test="${empty(finProduct) }">
						<label>
							<input type="radio" id="interestType" name="finProduct.interestType" checked="checked" value="1" onclick="lixiJs()">年息
						</label>
						<label>
							<input type="radio" id="interestType" name="finProduct.interestType" value="2" onclick="lixiJs()">半年息
						</label>
					</c:if>
					<c:if test="${!empty(finProduct) }">
						<label>
							<input type="radio" id="interestType" name="finProduct.interestType" ${finProduct.interestType==1?'checked="checked"':'' }  value="1" onclick="lixiJs()">年息
						</label>
						<label>
							<input type="radio" id="interestType" name="finProduct.interestType" ${finProduct.interestType==2?'checked="checked"':'' } value="2" onclick="lixiJs()">半年息
						</label>
					</c:if>
				<span style="color: red;">*</span></td>
			</tr>
			
			<c:if test="${empty(finProduct.type)||finProduct.type==1 }">
				<tr id="brandTr" height="42" style="display: none;">
					<td class="formTableTdLeft">品牌:&nbsp;</td>
					<td >
						<select id="brandId" name="brandId" class="largeX text" onchange="ajaxCarSeriy(this.value)" checkType="integer,1" tip="请选择品牌">
							<option value="">请选择...</option>
							<c:forEach var="brand" items="${brands }">
								<option value="${brand.dbid }" ${finProduct.brand.dbid==brand.dbid?'selected="selected"':'' } >${brand.name }</option>
							</c:forEach>
						</select>
					</td>
					<td class="formTableTdLeft">车型:&nbsp;</td>
					<td id="carModelLabel">
						请选择品牌
					</td>
				</tr>
			</c:if>
			<c:if test="${finProduct.type==2 }">
				<tr id="brandTr" height="42" >
					<td class="formTableTdLeft">车型:&nbsp;</td>
					<td>
						<select id="brandId" name="brandId" class="largeX text" onchange="ajaxCarSeriy(this.value)" checkType="integer,1" tip="请选择品牌">
							<option value="">请选择...</option>
							<c:forEach var="brand" items="${brands }">
								<option value="${brand.dbid }" ${finProduct.brand.dbid==brand.dbid?'selected="selected"':'' } >${brand.name }</option>
							</c:forEach>
						</select>
					</td>
					<td class="formTableTdLeft">车型:&nbsp;</td>
					<td id="carModelLabel">
						<c:if test="${empty(check) }">
							请选择品牌
						</c:if>
						<c:if test="${!empty(check) }">
							${check }
						</c:if>
					</td>
				</tr>
			</c:if>
			<tr height="42">
				<td class="formTableTdLeft">年限类型:&nbsp;</td>
				<td >
					<select id="finYearId" name="finYearId" class="largeX text" checkType="integer,1">
						<option value="0">请选择...</option>
						<c:forEach items="${finYears }" var="finYear">
							<option value="${finYear.dbid }" ${finYear.dbid==finProduct.finYear.dbid?'selected="selected"':'' } >${finYear.name }</option>
						</c:forEach>
					</select>
				<span style="color: red;">*</span></td>
				<td class="formTableTdLeft">排序:&nbsp;</td>
				<td >
					<input type="text" name="finProduct.orderNum" id="orderNum" value="${finProduct.orderNum }" class="largeX text" title="名称"	checkType="integer,1" canEmpty="Y" tip="名称不能为空"></td>
			</tr>
			<tr height="32">
				<td class="formTableTdLeft">贷款渠道:&nbsp;</td>
				<td>
					<select id="productType" name="finProduct.productType" class="largeX text" checkType="integer,1">
						<option value="0">请选择...</option>
						<option value="1" ${finProduct.productType==1?'selected="selected"':'' } >奇瑞徽银</option>
						<option value="2" ${finProduct.productType==2?'selected="selected"':'' }>银行</option>
						<option value="3" ${finProduct.productType==3?'selected="selected"':'' }>担保公司</option>
						<option value="5" ${finProduct.productType==5?'selected="selected"':'' }>安吉</option>
						<option value="6" ${finProduct.productType==6?'selected="selected"':'' }>沣邦</option>
						<option value="4" ${finProduct.productType==4?'selected="selected"':'' }>其他贷款渠道</option>
					</select>
				</td>
			</tr>
			<tr height="32">
				<td class="formTableTdLeft">备注:&nbsp;</td>
				<td>
					<textarea name="finProduct.note" id="note" title="内容简介"  class="textarea largeXX">${finProduct.note }</textarea>
				</td>
			</tr>
		</table>
		<div class="listOperate">
			<div class="operate">
				<a	class="but butSave" href="javascript:void(-1)" onclick="crateTr()">添加产品项目</a>
		   </div>
		   <div style="color: red;clear: both;">
		   </div>
		</div>
		<table width="100%" cellpadding="0" cellspacing="0"	class="mainTable" border="0" style="margin-top: 12px;">
					<thead class="TableHeader">
						<tr>
							<th style="width: 300px;">标题</th>
							<th style="width: 100px;">基数</th>
							<th style="width: 120px;">月数（单位/月）</th>
							<th style="width: 200px;">客户万元基数</th>
							<th style="width: 200px;">经销商万元贴息</th>
							<th style="width: 200px;">贴息类型</th>
							<th style="width: 200px;">贴息金额（元）</th>
							<th style="width: 200px;">还款方式</th>
							<th style="width: 50px;">排序</th>
							<th style="width: 120px;" align="center">操作</th>
						</tr>
					</thead>
					<tbody id="attributeBodyTable">
						<c:if test="${!empty(finProductItems)&&fn:length(finProductItems)>0 }" var="status">
							<c:forEach var="finProductItem" items="${ finProductItems}"		varStatus="i">
								<tr id="tr1">
									<td align="left" style="text-align: left;">
											<input type="hidden" name="finProductItemDbid"	id="finProductItemDbid${i.index}" value="${finProductItem.dbid }">
											<input	class="largeX text" type="text" name="name"	id="name${i.index}" value="${finProductItem.name }" checkType="string,1"/> 
									</td>
									<td>
										<input class="small text" type="text" id="basePrice${i.index}" readonly="readonly"	name="basePrice" value="${finProductItem.basePrice }" />
									</td>
									<td>
										<input class="small text" type="text" id="monthLong${i.index}"	name="monthLong" value="${finProductItem.monthLong }" checkType="integer,1"/>
									</td>
									<td>
										<input class="small text" type="text" id="discription${i.index}"	name="monthSupPrice" value="${finProductItem.monthSupPrice }" checkType="float,0"/>
									</td>
									<td style="text-align: center;">
										<input class="small text" id="discount${i.index}" type="text"	name="discount" value="${finProductItem.discount }" checkType="float,0"/>
									</td>
									<td >
										<select id="discountType${i.index}" name="discountType" class="small text" checkType="integer,1">
											<option value="0">请选择...</option>
											<option value="1" ${finProductItem.discountType==1?'selected="selected"':'' } >免息</option>
											<option value="2" ${finProductItem.discountType==2?'selected="selected"':'' }>低息</option>
										</select>
									</td>
									<td>
										<input class="small text" type="text" id="discountMony0" name="discountMony" value="${finProductItem.discountMony }" checkType="float,0"/>
									</td>
									<td >
										<select id="repayType${i.index}" name="repayType" class="small text" checkType="integer,1">
											<option value="0">请选择...</option>
											<option value="1" ${finProductItem.repayType==1?'selected="selected"':'' } >按月还</option>
											<option value="2" ${finProductItem.repayType==2?'selected="selected"':'' }>按年还</option>
										</select>
									</td>
									<td style="text-align: center;">
												<input class="small text" id="orderNum${i.index}" type="text"	name="orderNum" value="${finProductItem.orderNum }" />
									</td>
									<td align="center" style="text-align: center;">
										<a class="aedit" 	href="javascript:void(-1)" onclick="deleteTrAndValue(this,${finProductItem.dbid})"> 删除</a>
									</td>
								</tr>
							</c:forEach>
						</c:if>
						<c:if test="${status==false }">
							<tr id="tr1">
								<td align="left" style="text-align: left;">
									<input	class="largeX text" type="text" name="name"	id="name0" value="" checkType="string,1"/> 
								</td>
								<td>
									<input class="small text" readonly="readonly" type="text" id="basePrice0"		name="basePrice" value="10000" />
								</td>
								<td>
									<input class="small text" type="text" id="monthLong0" name="monthLong" value="12" checkType="integer,1"/>
								</td>
								<td>
									<input class="small text" type="text" id="monthSupPrice0" name="monthSupPrice" value="" checkType="float,0" />
								</td>
								<td>
									<input class="small text" type="text" id="discount0" name="discount" value=""  checkType="float,0" />
								</td>
								<td >
									<select id="discountType" name="discountType" class="small text" checkType="integer,1">
										<option value="0">请选择...</option>
										<option value="1" ${finProductItem.discountType==1?'selected="selected"':'' } >免息</option>
										<option value="2" ${finProductItem.discountType==2?'selected="selected"':'' }>低息</option>
									</select>
								</td>
								<td>
									<input class="small text" type="text" id="discountMony0" name="discountMony" value="" checkType="float,0" />
								</td>
								<td >
									<select id="repayType" name="repayType" class="small text" checkType="integer,1">
										<option value="0">请选择...</option>
										<option value="1" ${finProductItem.repayType==1?'selected="selected"':'' } >按月还</option>
										<option value="2" ${finProductItem.repayType==2?'selected="selected"':'' }>按年还</option>
									</select>
								</td>
								<td style="text-align: center;">
									<input class="small text" id="orderNum0" type="text" name="orderNum" value="" />
								</td>
								<td align="center" style="text-align: center;">
									<a class="aedit" href="javascript:void(-1)"		onclick="deleteTr(this)"> 删除</a>
								</td>
							</tr>
						</c:if>
					</tbody>
				</table>
	</form>
	<div class="formButton">
		<a href="javascript:void(-1)"	onclick="$.utile.submitForm('frmId','${ctx}/finProduct/save')"	class="but butSave">保&nbsp;&nbsp;存</a> 
	    <a href="javascript:void(-1)"	onclick="window.history.go(-1)" class="but butCancle">取&nbsp;&nbsp;消</a>
	</div>
	</div>
</body>
<script type="text/javascript">
function ajaxCarSeriy(val){
	if(null==val||val==''){
		alert("请选择品牌");
		return false;
	}
	$("#carModelLabel").text("");
	$.post("${ctx}/finProduct/ajaxCarSeriy?brandId="+val+"&dateTime="+new Date(),{},function (data){
		if(data!="error"){
			$("#carModelLabel").append(data);
		}
	});
}
function showHide(){
	var value=$("input[name='finProduct.type']:checked").val();
	if(value==1){
		$("#brandTr").hide();
		$("#carSeriyTr").hide();
	}
	if(value==2){
		$("#brandTr").show();
		$("#carSeriyTr").show();
	}
}
function lixiJs(){
	var value=$("input[name='finProduct.interestType']:checked").val();
	if(value==1){
		$("#monthLong0").val(12);
	}
	if(value==2){
		$("#monthLong0").val(6);
	}
}
function deleteTr(tr) {
	// 删除规格值
	if ($("#attributeBodyTable").find("tr").size() <= 1) {
		$.utile.tips("必须至少保留一个规格值", 1);
		return;
	} else {
		var dd = $(tr).parent().parent();
		$(dd).remove();
	}
}
function deleteTrAndValue(tr,dbid){
	// 删除规格值
	if ($("#attributeBodyTable").find("tr").size() <= 1) {
		$.utile.tips("必须至少保留一个规格值", 1);
		return;
	} else {
		window.top.art.dialog({
			content : '您确定删除选择数据吗？',
			icon : 'question',
			width:"250px",
			height:"80px",
			lock : true,
			ok : function() {// 点击去定按钮后执行方法
				$.post('${ctx}/finProduct/deleteFinProductItem?dbid='+dbid,{},function(data){
					if (data[0].mark == 1) {// 删除数据失败时提示信息
						$.utile.tips(data[0].message);
					}
					if (data[0].mark == 0) {// 删除数据成功提示信息
						$.utile.tips(data[0].message);
						var dd = $(tr).parent().parent();
						$(dd).remove();
					}
				})
			},
			cancel : true
		})
	}
}
function crateTr() {
	var value=$("input[name='finProduct.interestType']:checked").val();
	var monthLong=0;
	var size = $("#attributeBodyTable").find("tr").size();
	size = size + 1;
	if(value==1){
		monthLong=size*12;
	}
	if(value==2){
		monthLong=size*6;
	}
	var str = ' <tr >'
			+ '<td style="text-align: left;">'
			+ '<input class="mideaX text" name="name" id="name'+size+'" value="" checkType="string,1"/>'
			+ '</td>'
			+'<td>'
			+ '<input class="small text" readonly="readonly" type="text" id="basePrice'+size+'"		name="basePrice" value="10000"  />'
			+'</td>'
			+ '<td >'
			+ '<input class="small text" type="text" id="monthLong'+size+'" name="monthLong" value="'+monthLong+'" checkType="integer,1" />'
			+ '</td>'
			+ '<td >'
			+ '<input class="small text" type="text" id="monthSupPrice'+size+'" name="monthSupPrice" value="" checkType="float,0" />'
			+ '</td>'
			+ '<td >'
			+ '<input class="small text" type="text" id="discount'+size+'" name="discount" value="" checkType="float,0" />'
			+ '</td>'
			+ '<td >'
			+ '<select id="discountType'+size+'" name="discountType" class="small text" checkType="integer,1">'
			+'	<option value="0">请选择...</option>'
			+'	<option value="1" ${finProductItem.discountType==1?'selected="selected"':'' } >免息</option>'
			+'	<option value="2" ${finProductItem.discountType==2?'selected="selected"':'' }>低息</option>'
			+'</select>'
			+ '</td>'
			+ '<td >'
			+ '<input class="small text" type="text" id="discountMony'+size+'" name="discountMony" value="" checkType="float,0"/>'
			+ '</td>'
			+ '<td >'
			+ '<select id="repayType$'+size+'" name="repayType" class="small text" checkType="integer,1">'
			+'	<option value="0">请选择...</option>'
			+'	<option value="1" ${finProductItem.repayType==1?'selected="selected"':'' } >按月还</option>'
			+'	<option value="2" ${finProductItem.repayType==2?'selected="selected"':'' }>按年还</option>'
			+'</select>'
			+ '</td>'
			+ '<td style="text-align: center;">'
			+ '<input class="small text" id="orderNum" type="text" name="orderNum"  />'
			+ '</td>'
			+ '<td align="center" style="text-align: center;">'
			+ '<a class="aedit" href="javascript:void(-1)" onclick="deleteTr(this)"><i class="icon-remove icon-white"></i> 删除</a>'
			+ '</td>' + '</tr>';
	$("#attributeBodyTable").append(str);
}
</script>
</html>