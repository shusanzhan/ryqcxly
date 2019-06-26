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
<script type="text/javascript" src="${ctx }/widgets/utile/utile.js"></script>
<script type="text/javascript" src="${ctx }/widgets/easyvalidator/js/jquery.bgiframe.min.js"></script>
<script type="text/javascript" src="${ctx }/widgets/easyvalidator/js/easy_validator.pack.js"></script>
<title>问题管理</title>
</head>
<body class="bodycolor">
<div class="location">
     	<img src="${ctx}/images/homeIcon.png"/> &nbsp;
     	<a href="javascript:void(-1);" onclick="window.parent.location.href='${ctx}/main/index'">首页</a>-
<a href="javascript:void(-1);" onclick="window.location.href='${ctx}/quest/queryList'">问题管理</a>-
<a href="javascript:void(-1);">
	<c:if test="${empty(quest) }">添加问题</c:if>
	<c:if test="${!empty(quest) }">编辑问题</c:if>
</a>
</div>
<div class="line"></div>
<div class="frmContent">
	<form action="" name="frmId" id="frmId"  target="_self">
		<input type="hidden" name="quest.dbid" id="dbid" value="${quest.dbid }">
		<table border="0" align="center" cellpadding="0" cellspacing="0" style="width: 92%;">
			<tr height="42">
				<%-- <td class="formTableTdLeft">标题:&nbsp;</td>
				<td ><input type="text" name="quest.title" id="title"
					value="${quest.title }" class="large text" title="标题"	checkType="string,1,50" tip="标题不能为空"><span style="color: red;">*</span></td> --%>
				<td class="formTableTdLeft">编号:&nbsp;</td>
				<td ><input type="text" name="quest.no" id="no"
					value="${quest.no }" class="large text" title="编号"	checkType="string,1,50" tip="编号不能为空"><span style="color: red;">*</span></td>
				<td class="formTableTdLeft">品牌:&nbsp;</td>
				<td >
					<select id="brandId" name="brandId" checkType="string,1" class="large text" tip="请选择题型" onchange="ajaxQuestionBigType(this.value)">
							<option value="">请选择...</option>
							<c:forEach var="brand" items="${brands }">
								<option value="${brand.dbid }"  ${brand.dbid==quest.brand.dbid?'selected="selected"':'' }>${brand.name }</option>
							</c:forEach>
					</select>
				
				<span style="color: red;">*</span></td>
			</tr>
			<tr height="42">
				<td class="formTableTdLeft">是否区分题干:&nbsp;</td>
				<td >
					<c:if test="${empty(quest) }">
						<label> 
							<input type="radio" checked="checked" id="isBetweenNetOne1" name="quest.isBetweenNetOne" onclick="showHidenContent(this.value)" value="1" >&nbsp;&nbsp;否&nbsp;&nbsp;
						</label>
						<label>
							<input type="radio" id="isBetweenNetOne2" name="quest.isBetweenNetOne" value="2" onclick="showHidenContent(this.value)">&nbsp;&nbsp;是&nbsp;&nbsp;
						</label>
					</c:if>
					<c:if test="${!empty(quest) }">
						<label> 
							<input type="radio" ${quest.isBetweenNetOne==1?'checked="checked"':'' } onclick="showHidenContent(this.value)"  id="isBetweenNetOne1" name="quest.isBetweenNetOne" value="1" >
							&nbsp;&nbsp;否&nbsp;&nbsp;
						</label>
						<label>
							<input type="radio" ${quest.isBetweenNetOne==2?'checked="checked"':'' } onclick="showHidenContent(this.value)" id="isBetweenNetOne2" name="quest.isBetweenNetOne" value="2">
							&nbsp;&nbsp;是&nbsp;&nbsp;
						</label>
					</c:if>
				<span style="color: red;">*</span></td>
				<td class="formTableTdLeft">题型:&nbsp;</td>
				<td >
				<select id="checkType" name="quest.checkType" checkType="string,1" class="large text" tip="请选择题型">
						<option value="">请选择...</option>
						<option value="单选" ${quest.checkType=='单选'?'selected="selected"':'' }>单选</option>
						<option value="多选" ${quest.checkType=='多选'?'selected="selected"':'' }>多选</option>
				</select>
				<span style="color: red;">*</span></td>
			</tr>
			<tr>
				<td class="formTableTdLeft">是否考核:&nbsp;</td>
				<td >
					<c:if test="${empty(quest) }">
						<label> 
							<input type="radio" checked="checked" id="isAssessment1" name="quest.isAssessment" onclick="showHidenAssessment(this.value)" value="1" >&nbsp;&nbsp;否&nbsp;&nbsp;
						</label>
						<label>
							<input type="radio" id="isAssessment2" name="quest.isAssessment" value="2" onclick="showHidenAssessment(this.value)">&nbsp;&nbsp;是&nbsp;&nbsp;
						</label>
					</c:if>
					<c:if test="${!empty(quest) }">
						<label> 
							<input type="radio" ${quest.isAssessment==1?'checked="checked"':'' } onclick="showHidenAssessment(this.value)"  id="isAssessment1" name="quest.isAssessment" value="1" >
							&nbsp;&nbsp;否&nbsp;&nbsp;
						</label>
						<label>
							<input type="radio" ${quest.isAssessment==2?'checked="checked"':'' } onclick="showHidenAssessment(this.value)" id="isAssessment2" name="quest.isAssessment" value="2">
							&nbsp;&nbsp;是&nbsp;&nbsp;
						</label>
					</c:if>
				</td>
				<td class="formTableTdLeft" >类型:&nbsp;</td>
				<td colspan="">
					<select id="questBigTypeId" name="questBigTypeId" checkType="string,1" class="large text" tip="请选择提类型">
						<option value="">请选择...</option>
						<c:forEach var="questBigType" items="${questBigTypes }">
							<option value="${questBigType.dbid }" ${quest.questBigType.dbid==questBigType.dbid?'selected="selected"':'' }>${questBigType.name }</option>
						</c:forEach>
				</select>
				</td>
			</tr>
			
			<c:if test="${empty(quest)||quest.isAssessment==1 }">
				<tr id="assessmentTypLabel" style="display: none;">
					<td class="formTableTdLeft">考核类型:&nbsp;</td>
					<td >
						<select id="assessmentType" name="quest.assessmentType" checkType="string,1" class="large text" tip="请选择题型">
							<option value="">请选择...</option>
							<option value="1" ${quest.checkType=='1'?'selected="selected"':'' }>工厂考核</option>
							<option value="2" ${quest.checkType=='2'?'selected="selected"':'' }>自由店考核</option>
					</select>
					</td>
				</tr>
			</c:if>
			<c:if test="${quest.isAssessment==2 }">
				<tr id="assessmentTypLabel" >
					<td class="formTableTdLeft">考核类型:&nbsp;</td>
					<td >
						<select id="assessmentType" name="quest.assessmentType" checkType="string,1" class="large text" tip="请选择题型">
							<option value="">请选择...</option>
							<option value="1" ${quest.assessmentType=='1'?'selected="selected"':'' }>工厂考核</option>
							<option value="2" ${quest.assessmentType=='2'?'selected="selected"':'' }>自由店考核</option>
					</select>
					</td>
				</tr>
			</c:if>
			<tr>
				<td class="formTableTdLeft">排序号:&nbsp;</td>
				<td colspan="3"><input type="text" name="quest.orderNum" id="orderNum"
					value="${quest.orderNum }" class="large text" title="排序号"	checkType="string,1,50" tip="排序号不能为空"><span style="color: red;">*</span></td>
			</tr>
			
			<!-- 添加时页面显示 -->
			<c:if test="${empty(quest) }">
				<tr height="42" style="height: 45px;">
					<td class="formTableTdLeft" id="commContentLabel">题干:&nbsp;</td>
					<td class="formTableTdLeft" id="oneContentLabel" style="display:none; ">一网题干:&nbsp;</td>
					<td colspan="3">
						<textarea class="text textarea" rows="8" cols="60" name="quest.content" id="content" checkType="string,5,4000" tip="请输入题干，题干5-4000个字符">${quest.content }</textarea>
					</td>
				</tr>
				<tr height="42" id="netTwoLabel" style="display: none;height: 45px;">
					<td class="formTableTdLeft" >二网题干:&nbsp;</td>
					<td colspan="3">
						<textarea class="text textarea" rows="8" cols="60" name="quest.contentNet" id="contentNet" checkType="string,5,4000" tip="请输入题干，题干5-4000个字符">${quest.contentNet }</textarea>
					</td>
				</tr>
			</c:if>
			<!-- 编辑时页面显示 -->
			<c:if test="${!empty(quest) }">
				<c:if test="${quest.isBetweenNetOne==1 }">
					<tr height="42" style="height: 45px;">
						<td class="formTableTdLeft" id="commContentLabel">题干:&nbsp;</td>
						<td class="formTableTdLeft" id="oneContentLabel" style="display:none; ">一网题干:&nbsp;</td>
						<td colspan="3">
							<textarea class="text textarea" rows="8" cols="60" name="quest.content" id="content" checkType="string,5,4000" tip="请输入题干，题干5-4000个字符">${quest.content }</textarea>
						</td>
					</tr>
					<tr height="42" id="netTwoLabel" style="display: none;height: 45px;">
						<td class="formTableTdLeft" >二网题干:&nbsp;</td>
						<td colspan="3">
							<textarea class="text textarea" rows="8" cols="60" name="quest.contentNet" id="contentNet" checkType="string,5,4000" tip="请输入题干，题干5-4000个字符">${quest.contentNet }</textarea>
						</td>
					</tr>
				</c:if>
				<c:if test="${quest.isBetweenNetOne==2 }">
					<tr height="42" style="height: 45px;">
						<td class="formTableTdLeft" id="commContentLabel" style="display:none; ">题干:&nbsp;</td>
						<td class="formTableTdLeft" id="oneContentLabel">一网题干:&nbsp;</td>
						<td colspan="3">
							<textarea class="text textarea" rows="8" cols="60" name="quest.content" id="content" checkType="string,5,4000" tip="请输入题干，题干5-4000个字符">${quest.content }</textarea>
						</td>
					</tr>
					<tr height="42" id="netTwoLabel" style="height: 45px;">
						<td class="formTableTdLeft" >二网题干:&nbsp;</td>
						<td colspan="3">
							<textarea class="text textarea" rows="8" cols="60" name="quest.contentNet" id="contentNet" checkType="string,5,4000" tip="请输入题干，题干5-4000个字符">${quest.contentNet }</textarea>
						</td>
					</tr>
				</c:if>
			</c:if>
			<tr height="80" style="height: 60px;">
				<td class="formTableTdLeft" >备注:&nbsp;</td>
				<td colspan="3">
					<textarea class="text textarea" rows="3" cols="60" name="quest.note" id="note" style="height: 50px;">${quest.note }</textarea>
				</td>
			</tr>
		</table>
		 <div class="listOperate">
			<div class="operate">
				<a	class="but butSave" href="javascript:void(-1)" onclick="crateTr()">添加选择项目</a>
		   </div>
		   <div style="clear: both;"></div>
		</div>
			<!-- 商品图片tab        开始 -->
				<table width="100%" cellpadding="0" cellspacing="0"	class="mainTable" border="0">
					<thead class="TableHeader">
						<tr>
							<th style="width: 120px;">值</th>
							<th style="width: 120px;">显示</th>
							<th style="width: 60px;">考核状态</th>
							<th style="width: 60px;">考核金额</th>
							<th style="width: 300px;">备注</th>
							<th style="width: 60px;" align="center">操作</th>
						</tr>
					</thead>
					<tbody id="attributeBodyTable">
					
						<c:if test="${!empty(quest.questAnswerItems)&&fn:length(quest.questAnswerItems)>0 }" var="status">
							<c:forEach var="questAnswerItem" items="${ quest.questAnswerItems}"		varStatus="i">
								<tr id="tr1">
									<td align="left">
										<input type="hidden" name="questAnswerItemDbid"		id="questAnswerItemDbid${i.index }" value="${questAnswerItem.dbid }"> 
										<input class="mideaX text" type="text" id="value${i.index}"	name="value" value="${questAnswerItem.value }" />
									</td>
									<td>
										<input class="midea text" type="text" id="lable${i.index}"	name="lable" value="${questAnswerItem.lableName }" />
									</td>
									<td>
										<select id="assessmentState${i.index}" name="assessmentState"  class="midea text" >
												<option value="">请选择...</option>
												<option value="1" ${questAnswerItem.assessmentState=='1'?'selected="selected"':'' }>正常</option>
												<option value="2" ${questAnswerItem.assessmentState=='2'?'selected="selected"':'' }>异常</option>
										</select>
									</td>
									<td>
										<input class="midea text" type="text" id="assessmentMoney${i.index}"	name="assessmentMoney" value="${questAnswerItem.assessmentMoney }" />
									</td>
									<td style="text-align: center;">
										<input class="midea text" id="note${i.index}" type="text"	name="note" value="${questAnswerItem.note }" />
									</td>
									<td align="center" style="text-align: center;">
										<a class="aedit" 	href="javascript:void(-1)" onclick="deleteTrAndValue(this,${questAnswerItem.dbid})"> 删除</a>
									</td>
								</tr>
							</c:forEach>
						</c:if>
						<c:if test="${status==false }">
							<tr id="tr1">
								<td>
									<input type="hidden" name="questAnswerItemDbid"		id="questAnswerItemDbid0" value=""> 
									<input class="mideaX text" type="text" id="value0"		name="value" value="" />
								</td>
								<td>
									<input class="large text" type="text" id="label0"		name="lable" value="" />
								</td>
								<td>
										<select id="assessmentState0" name="assessmentState"  class="midea text" >
												<option value="">请选择...</option>
												<option value="1" ${questAnswerItem.assessmentState=='1'?'selected="selected"':'' }>正常</option>
												<option value="2" ${questAnswerItem.assessmentState=='2'?'selected="selected"':'' }>异常</option>
										</select>
									</td>
									<td>
										<input class="midea text" type="text" id="assessmentMoney0"	name="assessmentMoney" value="0" />
									</td>
								<td style="text-align: center;">
											<input class="midea text" id="note0" type="text" name="note" value="" />
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
		<a href="javascript:void(-1)"	onclick="$.utile.submitForm('frmId','${ctx}/quest/save')"	class="but butSave">保&nbsp;&nbsp;存</a> 
	    <a href="javascript:void(-1)"	onclick="window.history.go(-1)" class="but butCancle">取&nbsp;&nbsp;消</a>
	</div>
	</div>
</body>
<script type="text/javascript">
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
		$.utile.tips("必须至少保留一个备选答案", 1);
		return;
	} else {
		window.top.art.dialog({
			content : '您确定删除选择数据吗？',
			icon : 'question',
			width:"250px",
			height:"80px",
			lock : true,
			ok : function() {// 点击去定按钮后执行方法
				$.post('${ctx}/quest/deleteQuestAnswerItem?dbid='+dbid,{},function(data){
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
	var size = $("#attributeBodyTable").find("tr").size();
	size = size + 1;
	var str = ' <tr style="height:40px;">'
			+'<td>'
			+ '<input type="hidden" name="questAnswerItemDbid" id="questAnswerItemDbid'+size+'" value="">'
			+ '<input class="mideaX text" id="value" type="text" name="value"  />'
			+'</td>'
			+ '<td >'
			+ '<input class="large text" id="lable" type="text" name="lable"  />'
			+ '</td>'
			+'<td>'
			+'	<select id="assessmentState'+size+'" name="assessmentState"  class="midea text" >'
			+'			<option value="">请选择...</option>'
			+'			<option value="1">正常</option>'
			+'			<option value="2">异常</option>'
			+'	</select>'
			+'</td>'
			+'<td>'
			+'	<input class="midea text" type="text" id="assessmentMoney'+size+'"	name="assessmentMoney" value="0" />'
			+'</td>'
			+ '<td style="text-align: center;">'
			+ '<input class="midea text" id="note" type="text" name="note"  />'
			+ '</td>'
			+ '<td align="center" style="text-align: center;">'
			+ '<a class="aedit" href="javascript:void(-1)" onclick="deleteTr(this)"><i class="icon-remove icon-white"></i> 删除</a>'
			+ '</td>' + '</tr>';
	$("#attributeBodyTable").append(str);
}
function showHidenContent(val){
	if(val==1){
		$("#netTwoLabel").hide();
		$("#oneContentLabel").hide();
		$("#commContentLabel").show();
	}
	if(val==2){
		$("#netTwoLabel").show();
		$("#oneContentLabel").show();
		$("#commContentLabel").hide();
	}
}
function showHidenAssessment(val){
	if(val==1){
		$("#assessmentTypLabel").hide();
	}
	if(val==2){
		$("#assessmentTypLabel").show();
	}
}

function ajaxQuestionBigType(val){
	if(null==val||val==''){
		alert("请选择品牌");
		return false;
	}
	$("#questBigTypeId").empty();
	$.post("${ctx}/questBigType/ajaxQuestBigTypeByBrandId?brandId="+val+"&dateTime="+new Date(),{},function (data){
		if(data!="error"){
			$("#questBigTypeId").append(data);
		}
	});
}
</script>
</html>