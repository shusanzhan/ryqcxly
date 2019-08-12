<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../../commons/taglib.jsp" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>意向客户跟踪卡</title>
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
	</div>
	<table cellpadding="0" cellspacing="0"  border="1" >
		<tr><td colspan="9" align="center" style="font-size: 18px;font-weight: bold;padding:12px 0px;">意向客户跟踪卡</td></tr>
		<tr>
			<td colspan="4" style="border-right: 0px;">
				制卡日期：
				<c:if test="${empty(customer) }" var="status">
					<fmt:formatDate value="${now }" pattern="yyyy  年 MM 月 dd 日"/>
				</c:if>
				<c:if test="${status==false }">
					<fmt:formatDate value="${customer.createFolderTime }" pattern="yyyy  年 MM 月 dd 日"/>
				</c:if>
			</td>
			<td colspan="3" style="border-left: 0px;border-right: 0px;">意向级别：
				<c:forEach var="customerPhase" items="${customerPhases }" varStatus="i" end="3">
					<label style="margin-right:20px;">
						<input type="checkbox" name="customerPhase" ${customerPhase.dbid==customer.customerPhase.dbid?'checked="checked"':'' }  value="${customerPhase.dbid }" id="customerPhase${i.index }" >${customerPhase.name }</label>
				</c:forEach>
			</td>
			<td colspan="2" style="border-left: 0px;">编码：${customer.sn }</td>
		</tr>
		<!-- 基本信息  开始 -->
		<tr>
			<td rowspan="7" class="fristHeader">客户基本资料</td>
			<td class="labelTitle">客户姓名</td>
			<td colspan="2">${customer.name }</td>
			<td class="labelTitle" rowspan="2">
				<label style="margin-right:2px;"><input type="checkbox" name="sex" ${'男'==customer.sex?'checked="checked"':'' }  value="男" id="sex" >男</label>
				<label style="margin-right:2px;"><input type="checkbox" name="sex" ${'女'==customer.sex?'checked="checked"':'' }  value="女" id="sex" >女</label>
			</td>
			<td rowspan="2" class="labelTitle">联系电话</td>
			<td class="labelTitle">微信号</td>
			<td colspan="2">${customer.phone }</td>
		</tr>
		<tr>
			<td class="labelTitle">年龄</td>
			<td colspan="2">${customer.age }</td>
			<td class="labelTitle">常用手机号</td>
			<td colspan="2">${customer.mobilePhone  }</td>
		</tr>
		<tr>
			<td class="labelTitle">E-MAIL</td>
			<td colspan="2">
				${customer.email }
			</td>
			<td class="labelTitle">QQ/MSN</td>
			<td colspan="4">${customer.qq }</td>
		</tr>
		<tr>
			<td class="labelTitle">家庭情况</td>
			<td colspan="2">
				${customer.family }
			</td>
			<td class="labelTitle">单位信息</td>
			<td colspan="4">${customer.companyName1 }</td>
		</tr>
		<tr>
			<td class="labelTitle">证件类型</td>
			<td colspan="2">
				${customer.paperwork.name }
			</td>
			<td class="labelTitle">证件号码</td>
			<td colspan="4">${customer.icard }</td>
		</tr>
		<tr>
			<td class="labelTitle">家庭住址</td>
			<td colspan="4">
				${customer.area.fullName }${customer.address }
			</td>
			<td class="labelTitle">邮编</td>
			<td colspan="2">${customer.zipCode }</td>
		</tr>
		<!-- 基本信息  结束 -->
		
		<!-- 初次评估信息  开始 -->
		<tr>
			<td rowspan="5" class="fristHeader">初次需求评估（根据实际情况填写）</td>
		</tr>
		<tr>
			<td class="labelTitle">购车关注点</td>
			<td colspan="7">
				<c:forEach var="buyCarCare" items="${buyCarCares }" varStatus="i">
					<label style="margin-right:20px;"><input type="checkbox" name="buyCarCare" ${buyCarCare.dbid==customer.customerBussi.buyCarCare.dbid?'checked="checked"':'' }  value="${buyCarCare.dbid }" id="buyCarCare${i.index }" >${buyCarCare.name }</label>
				</c:forEach>
			</td>
		</tr>
		<tr>
			<td class="labelTitle">购车主要目的</td>
			<td colspan="7">
				<c:forEach var="buyCarTarget" items="${buyCarTargets }" varStatus="i">
					<label style="margin-right:20px;"><input type="checkbox" name="buyCarCare" ${buyCarTarget.dbid==customer.customerBussi.buyCarTarget.dbid?'checked="checked"':'' }  value="${buyCarTarget.dbid }" id="buyCarCare${i.index }" >${buyCarTarget.name }</label>
				</c:forEach>
			</td>
		</tr>
		<tr>
			<td class="labelTitle">购买类型</td>
			<td colspan="7">
			<c:forEach var="buyCarType" items="${buyCarTypes }" varStatus="i">
					<label style="margin-right:20px;"><input type="checkbox" name="buyCarType" ${buyCarType.dbid==customer.customerBussi.buyCarType.dbid?'checked="checked"':'' }  value="${buyCarType.dbid }" id="buyCarCare${i.index }" >${buyCarType.name }</label>
				</c:forEach>
			</td>
		</tr>
		<tr>
			<td  colspan="8">
				<div style="float: left;margin-right: 100px;">意向车型:&#12288;&#12288;${customer.customerBussi.carModel.name }</div>
				<div style="float: left;margin-right: 100px;">购车预算:&#12288;&#12288;${customer.customerBussi.buyCarBudget.name }</div>
				<div style="float: left;margin-right: 100px;">主要使用者:&#12288;&#12288;${customer.customerBussi.buyCarMainUse.name }</div>
				<div class="clear"></div>
			</td>
		</tr>
		<!-- 初次评估信息  结束 -->
		
		<!-- 第一次接待结果  开始 -->
		<tr>
			<td rowspan="5" class="fristHeader">第一次接待结果（情形）</td>
			<td rowspan="5">结合初次接待洽谈实际情况分析并填写</td>
			<td colspan="7">客户性格特征：${customerBussi.customerSpecification }</td>
		</tr>
		<tr>
			<td colspan="7">客户阐述需求：${customerBussi.customerNeed }</td>
		</tr>
		<tr>
			<td colspan="7">主要关注竞品：${customerBussi.customerCareAbout }</td>
		</tr>
		<tr>
			<td colspan="7">其它重点描述：${customerBussi.otherMainDescription }</td>
		</tr>
		<tr>
			<td colspan="7">后续跟进计划：${customerBussi.afterPlan }</td>
		</tr>
		<!-- 第一次接待结果  结束 -->
		
		<tr><td colspan="9" align="center" class="fristHeader" style="border-bottom: 0px;">客户跟进内容</td></tr>
		<tr ><td colspan="9" style="border: 0px solid #000000;border-bottom: 0px;">
			<table cellpadding="0" cellspacing="0" frame="void" id="contentTrack" style="border: 0px solid #000000;width: 100%">
				<thead>
					<tr>
						<th class="labelTitle" style="width: 80px;" width="80">跟进日期</th>
						<th class="labelTitle" style="width: 40px;" width="40">跟进方法</th>
						<th class="labelTitle"  style="width: 100px;" width="100">跟进内容</th>
						<th class="labelTitle" colspan="2"  style="width: 100px;" width="100">客户反馈问题</th>
						<th class="labelTitle" style="width: 100px;" width="100">应对措施</th>
						<th class="labelTitle" style="width: 30px;" width="40">更新级别</th>
						<th class="labelTitle" style="width: 80px;" width="80">下次预约时间</th>
						<th class="labelTitle" style="width: 80px;">展厅记录建议</th>
					</tr>
				</thead>
				<tbody>
						<c:forEach var="customertrack" items="${customertracks }">
							<tr>
								<td  style="width: 80px;line-height: 20px;text-align: center;">
									<fmt:formatDate value="${customertrack.createTime }" pattern="yyyy-MM-dd"/>
								</td>
								<td  style="width: 40px;line-height: 20px;text-align: center;">
									<c:if test="${customer.lastResult==1 }">
										电话
									</c:if>
									<c:if test="${customer.lastResult==2 }">
										到店
									</c:if>
									<c:if test="${customer.lastResult==3 }">
										短信
									</c:if>
									<c:if test="${customer.lastResult==4 }">
										上门
									</c:if>
									<c:if test="${customer.lastResult==5 }">
										微信
									</c:if>
									<c:if test="${customer.lastResult==6 }">
										QQ
									</c:if>
								</td>
								<td    style="width: 100px;line-height: 20px;">${customertrack.trackContent }</td>
								<td colspan="2" style="width: 100px;line-height: 20px;">${customertrack.feedBackResult }</td>
								<td  style="width: 100px;line-height: 20px;">${customertrack.dealMethod }</td>
								<td  style="width: 30px;line-height: 20px;text-align: center;">${customerTrack.beforeCustomerPhase.name }</td>
								<td  style="width: 80px;line-height: 20px;text-align: center;">
									<fmt:formatDate value="${customertrack.nextReservationTime }" pattern="yyyy-MM-dd"/>
								</td>
								<td  style="width: 80px;line-height: 20px;">${customertrack.showroomManagerSuggested }</td>
							</tr>
						</c:forEach>
					<c:if test="${fn:length(customertracks)<7 }" var="status">
						<c:forEach  begin="0" end="${7-fn:length(customertracks) }">
						<tr>
							<td style="line-height: 20px;">&#12288;</td>
							<td style="line-height: 20px;">&#12288;</td>
							<td   style="line-height: 20px;">&#12288;</td>
							<td colspan="2" style="line-height: 20px;">&#12288;</td>
							<td style="line-height: 20px;">&#12288;</td>
							<td style="line-height: 20px;">&#12288;</td>
							<td style="line-height: 20px;">&#12288;</td>
							<td style="line-height: 20px;">&#12288;</td>
						</tr>
						</c:forEach>
					</c:if>
				</tbody>
			</table>
		</td></tr>
		<tr >
			<td class="fristHeader" style="border-top: 0px;">结案情形</td>
			<td colspan="8" style="border-top: 0px;">
				<label style="margin-right:20px;"><input type="checkbox" name="lastResult" value="" id="" ${customer.lastResult==1?'checked="checked"':'' } >成交—购车</label>
				<label style="margin-right:20px;"><input type="checkbox" name="lastResult" value="" id="" ${customer.lastResult==2?'checked="checked"':'' }>流失—购买其它品牌产品等 </label>
				<label style="margin-right:20px;"><input type="checkbox" name="lastResult" value="" id="" ${customer.lastResult==3?'checked="checked"':'' }>暂缓购车</label>
			</td>
		</tr>
		<tr style="line-height: 20px;">
			<td rowspan="2" class="fristHeader">成交后信息</td>
			<td class="labelTitle">购买车型</td>
			<td class="labelTitle">车辆颜色</td>
			<td colspan="1" class="labelTitle">vin码</td>
			<td class="labelTitle">
				上牌
			</td>
			<td style="line-height: 20px;">
				牌照号
			</td>
			<td class="labelTitle">购买保险</td>
			<td class="labelTitle">
				加装精品
			</td>
			<td class="labelTitle">
				精品
			</td>
		</tr>
		<tr style="line-height: 20px;">
			<td style="line-height: 20px;">${customer.customerLastBussi.carSeriy.name }  ${customer.customerLastBussi.carModel.name }${customer.carModelStr}</td>
			<td>${customer.customerLastBussi.carColor.name }</td>
			<td  colspan="1">${customer.customerPidBookingRecord.vinCode }
			</td>
			<td align="center">
				<label ><input type="checkbox" name="lastResult" value="" id="" ${customer.customerLastBussi.isCarPlate==true?'checked="checked"':'' } >是</label>
				<label ><input type="checkbox" name="lastResult" value="" id="" ${customer.customerLastBussi.isCarPlate==false?'checked="checked"':'' } >否</label>
			</td>
			<td colspan="" style="line-height: 20px;">${customer.customerLastBussi.carPlateNo }</td>
			<td>
				<label ><input type="checkbox" name="lastResult" value="" id="" ${customer.customerLastBussi.isBuySafe==true?'checked="checked"':'' } >是</label>
				<label ><input type="checkbox" name="lastResult" value="" id="" ${customer.customerLastBussi.isBuySafe==false?'checked="checked"':'' } >否</label></td>
			<td>
				<label ><input type="checkbox" name="lastResult" value="" id="" ${customer.customerLastBussi.isBoutique==true?'checked="checked"':'' } >是</label>
				<label ><input type="checkbox" name="lastResult" value="" id="" ${customer.customerLastBussi.isBoutique==false?'checked="checked"':'' } >否</label>
			</td>
			<td>
			</td>
		</tr>
		<tr>
			<td colspan="4">销售顾问：${customer.bussiStaff }</td>
			<td colspan="6">展厅主管：${customer.showRoomManager }</td>
		</tr>
	</table>
</body>
</html>