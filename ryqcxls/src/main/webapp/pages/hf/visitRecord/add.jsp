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
<script type="text/javascript" src="${ctx }/widgets/My97DatePicker/WdatePicker.js"></script>
<script type="text/javascript" src="${ctx }/widgets/artDialog/artDialog.js?skin=twitter"></script>
<script type="text/javascript" src="${ctx }/widgets/artDialog/plugins/iframeTools.source.js"></script>
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
</style>
<title>客户回访</title>
</head>
<body class="bodycolor">
<div class="location">
     	<img src="${ctx}/images/homeIcon.png"/> &nbsp;
     	<a href="javascript:void(-1);" onclick="window.parent.location.href='${ctx}/main/index'">首页</a>-
<a href="javascript:void(-1);" onclick="window.location.href='${ctx}/quest/queryList'">客户回访</a>-
<a href="javascript:void(-1);">
	<c:if test="${empty(quest) }">添加客户回访</c:if>
	<c:if test="${!empty(quest) }">编辑客户回访</c:if>
</a>
</div>
<div class="line"></div>
<div class="frmContent" >
	<form action="" name="frmId" id="frmId"  target="_self">
		<input type="hidden" name="visitRecord.dbid" id="dbid" value="${visitRecord.dbid }">
		<input type="hidden" name="visitRecord.createTime" id="createTime" value="${visitRecord.createTime }">
		<input type="hidden" name="customerId" id="customerId" value="${visitRecord.customer.dbid }">
		<input type="hidden" name="visitRecord.fileDate" id="fileDate" value="${visitRecord.fileDate }">
		<input type="hidden" name="visitRecord.vinCode" id="vinCode" value="${visitRecord.vinCode }">
		<input type="hidden" name="enterpriseId" id="enterpriseId" value="${visitRecord.enterprise.dbid }">
		<c:set value="${customer.customerPidBookingRecord }" var="customerPidBookingRecord"></c:set>
		<table border="0" align="center" cellpadding="0" cellspacing="0" style="width: 100%;">
			<tr height="42">
				<td class="formTableTdLeft">姓名:&nbsp;</td>
				<td >${customer.name }</td>
				<td class="formTableTdLeft">电话:&nbsp;</td>
				<td >${customer.mobilePhone}</td>
			</tr>
			<tr height="42">
				<td class="formTableTdLeft">车型:&nbsp;</td>
				<c:set value="${customerPidBookingRecord.carSeriy.name}${ customerPidBookingRecord.carModel.name }${customerPidBookingRecord.carColor.name }" var="carModel"></c:set>
				<td >${carModel} ${customer.carModelStr}</td>
				<td class="formTableTdLeft">车架号:&nbsp;</td>
				<td >
					<a class="aedit" style="color: #2b7dbc" href="${ctx }/factoryOrder/factoryOrderDetail?vinCode=${customer.customerPidBookingRecord.vinCode}&type=1">
						${customerPidBookingRecord.vinCode}
					</a>
				
				</td>
			</tr>
			
			<tr height="42">
				<td class="formTableTdLeft">销售顾问:&nbsp;</td>
				<td >${customer.user.realName }</td>
				<td class="formTableTdLeft">联系电话:&nbsp;</td>
				<td >${customer.user.mobilePhone }</td>
			</tr>
			<tr height="32">
				<td class="formTableTdLeft">销售日期:&nbsp;</td>
				<td ><fmt:formatDate value="${customerPidBookingRecord.modifyTime }" /></td>
				<td class="formTableTdLeft">车牌号:&nbsp;</td>
				<td >
					<c:if test="${empty(customer.customerLastBussi.carPlateNo)  }">
						<span style="color: red;">未上牌</span>
					</c:if>
					<c:if test="${!empty(customer.customerLastBussi.carPlateNo)  }">
						${customer.customerLastBussi.carPlateNo }
					</c:if>
				</td>
			</tr>
		</table>
		<c:forEach var="questBigType" items="${questBigTypes }" varStatus="bigIndex">
			<table border="0" align="center" cellpadding="0" cellspacing="0" style="width: 100%;margin-top: 5px;">
				<tr height="42" style="background-color: #eeeeee; border-color:#eeeeee;font-size: 16px;font-weight: bold;">
					<td width="100%" colspan="4" style="">${questBigType.name }</td>
				</tr>
				<tr height="42">
					<td width="40"></td>
					<td width="360" align="center">调查内容&nbsp;</td>
					<td width="320" align="center">调查结果</td>
					<td width="320" align="center">意见</td>
				</tr>
				<c:forEach var="quest" items="${questBigType.quests }" varStatus="questIndex">
						<tr height="60" style="height: 60px;">
							<td width="40">
								${bigIndex.index+1 }、${questIndex.index+1 }
								<input type="hidden" id="${bigIndex.index+1 }${questIndex.index+1 }questId" name="questId" value="${quest.dbid }">
							</td>
							<c:if test="${quest.isBetweenNetOne==1 }">
								<td  width="360">${quest.content }</td>
							</c:if>
							<c:if test="${quest.isBetweenNetOne==2 }">
								<c:if test="${customer.customerType==1 }">
									<td  width="360">${quest.content }</td>
								</c:if>
								<c:if test="${customer.customerType==2 }">
									<td  width="360">${quest.contentNet }</td>
								</c:if>
							</c:if>
							<td  width="320">
								<c:forEach var="questAnswerItem" items="${quest.questAnswerItems }" varStatus="itemIdex">
									<c:if test="${itemIdex.index==0 }">
										<label>
											<input type="radio" name="resultValue${quest.dbid }" id="${bigIndex.index+1 }${questIndex.index+1 }" value="${questAnswerItem.dbid }" checked="checked">${questAnswerItem.lableName }&nbsp;&nbsp;</label>
									</c:if>
									<c:if test="${itemIdex.index!=0 }">
										<label>
											<input type="radio" name="resultValue${quest.dbid }" id="${bigIndex.index+1 }${questIndex.index+1 }" value="${questAnswerItem.dbid }">${questAnswerItem.lableName }&nbsp;&nbsp;</label>
									</c:if>
									
								</c:forEach>
							</td>
							<td width="320">
								<textarea class="text" rows="9" cols="" id="resultNote" name="resultNote" style="width: 95%;height: 50px;"></textarea>
							</td>
						</tr>
				</c:forEach>
			</table>
		</c:forEach>
		<table border="0" align="center" cellpadding="0" cellspacing="0" style="width: 100%;margin-top: 5px;">
				<tr height="42" style="background-color: #eeeeee; border-color:#eeeeee;font-size: 16px;font-weight: bold;">
					<td width="100%" colspan="4" style="">回访结果</td>
				</tr>
				<tr style="height: 60px;" height="60">
					<td class="formTableTdLeft" width="120">任务状态:&nbsp;</td>
					<td colspan="" >
						<select id="taskStatus" name="visitRecord.taskStatus" class="text large" checkType="integer,1" tip="请选择任务状态">
							<option value="">请选择...</option>
							<option value="2" ${visitRecord.taskStatus==2?'selected="selected"':'' }>处理中</option>
							<option value="3" ${visitRecord.taskStatus==3?'selected="selected"':'' }>回访完成</option>
							<option value="4" ${visitRecord.taskStatus==4?'selected="selected"':'' }>不再回访</option>
						</select>
					</td>
					<td class="formTableTdLeft">ssi状态:&nbsp;</td>
					<td >
						<select id="ssiStatus" name="visitRecord.ssiStatus" class="text large" checkType="integer,1" tip="请选择SSI状态">
							<option value="">请选择...</option>
							<option value="1" ${visitRecord.ssiStatus==1?'selected="selected"':'' }>成功</option>
							<option value="2" ${visitRecord.ssiStatus==2?'selected="selected"':'' }>失败</option>
							<option value="3" ${visitRecord.ssiStatus==3?'selected="selected"':'' }>未调研</option>
						</select>
					</td>
				</tr>
				<tr style="height: 60px;" height="60">
					<td class="formTableTdLeft" width="120">回访结果:&nbsp;</td>
					<td colspan="" >
						<select id="visitResultStatus" name="visitRecord.visitResultStatus" class="text large" checkType="integer,1" tip="请选择任务状态">
							<option value="">请选择...</option>
							<option value="1" ${visitRecord.visitResultStatus==1?'selected="selected"':'' } >失败</option>
							<option value="2" ${visitRecord.visitResultStatus==2?'selected="selected"':'' }>成功</option>
							<option value="3" ${visitRecord.visitResultStatus==3?'selected="selected"':'' }>跟踪</option>
							<option value="4" ${visitRecord.visitResultStatus==4?'selected="selected"':'' }>未提车</option>
						</select>
					</td>
					<td class="formTableTdLeft" width="120">回访次数:&nbsp;</td>
					<td colspan="" >
						<select id="returnNumber" name="visitRecord.returnNumber" class="text large" >
							<option value="">请选择...</option>
							<option value="1" ${visitRecord.returnNumber==1?'selected="selected"':'' } >一次</option>
							<option value="2" ${visitRecord.returnNumber==2?'selected="selected"':'' }>二次及以上</option>
						</select>
					</td>
				</tr>
				<tr>
					<td class="formTableTdLeft" width="120">再访原因:&nbsp;</td>
					<td colspan="3">
						<select id="aginReasonId" name="aginReasonId" class="large text" >
							<option value="">请选择</option>
							<c:forEach var="aginReason" items="${aginReasons }">
								<option value="${aginReason.dbid}" ${visitRecord.aginReason.dbid==aginReason.dbid?'selected="selected"':'' } >${aginReason.name }</option>
							</c:forEach>
						</select>
					</td>
				</tr>
				<tr style="height: 60px;" height="60">
					<td class="formTableTdLeft" width="120">车牌号:&nbsp;</td>
					<td colspan="" >
						<input id="carPlateNo" class="large text"  name="carPlateNo" value="${customer.customerLastBussi.carPlateNo }">
					</td>
					<td class="formTableTdLeft">上传档案日期:&nbsp;</td>
					<td ><input type="text" name="visitRecord.uploadFileDate" id="uploadFileDate"
					value="${visitRecord.uploadFileDate }" class="large text"  title="上传档案日期" onfocus="new WdatePicker()"	checkType="string,1,50" canEmpty="Y" tip="上传档案日期不能为空"></td>
				</tr>
				<tr style="height: 60px;" height="60">
					<td class="formTableTdLeft" width="120">内容:&nbsp;</td>
					<td colspan="3" width="1000">
						<textarea class="text" rows="9" cols="" id="note" name="visitRecord.note" style="width: 98%;height: 50px;">${visitRecord.note }</textarea>
					</td>
				</tr>
			</table>
		</form>
	<div class="formButton">
		<a href="javascript:void(-1)"	onclick="$.utile.submitForm('frmId','${ctx}/visitRecord/save')"	class="but butSave">保存数据</a> 
	    <a href="javascript:void(-1)"	onclick="window.history.go(-1)" class="but butCancle">取&nbsp;&nbsp;消</a>
	</div>
	</div>
</body>
</html>