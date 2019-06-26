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
<script type="text/javascript" src="${ctx }/widgets/artDialog/artDialog.js?skin=default"></script>
<script type="text/javascript" src="${ctx }/widgets/artDialog/plugins/iframeTools.source.js"></script>
<script type="text/javascript" src="${ctx }/widgets/easyvalidator/js/jquery.bgiframe.min.js"></script>
<script type="text/javascript" src="${ctx }/widgets/easyvalidator/js/easy_validator.pack.js"></script>
<style type="text/css">
.contentTable{
	 border: 1px solid #767474;
 	border-collapse: collapse;
	border-spacing: 0px;
}
.contentTable td{
 border: 1px solid #767474;
}
.contentTable th{
 border: 1px solid #767474;
}
table { 
border-collapse:collapse; /* 关键属性：合并表格内外边框(其实表格边框有2px，外面1px，里面还有1px哦) */ 
} 
#orderDecore {
}
#orderDecore td,#orderDecore tr{
	height: 24px;
}
.table-c{
}
.table-c table{border: 0}
.table-c table td{border-left:1px solid #767474;border-bottom: 1px solid #767474;}
.table-c table td:FIRST-CHILD{border-left:0;}
.table-c table td:nth-last-child(0){border-right:0;border-left:0;}
.table-c table tr:nth-last-child(0) td{border-right:0;border-left:0;border: 0;}
.tabletr{
	border: 0;
}
.tabletr td{
	
}
</style>
<title>绑定车辆</title>
</head>
<div class="location">
	<img src="${ctx}/images/homeIcon.png"/> &nbsp;
	<a href="javascript:void(-1);" onclick="window.parent.location.href='${ctx}/main/index'">首页</a>-
	<a href="javascript:void(-1);" onclick="window.parent.location.href='${ctx}/customerPidBookingRecord/queryWlbWatingList‘">车辆调配</a>-
	<a href="javascript:void(-1);" onclick="">绑定车辆</a>
</div>
 <!--location end-->
<div class="line"></div>
<body class="bodycolor">
	<div class="frmContent">
	<form action="" name="frmId" id="frmId" style="margin-bottom: 40px;" target="_parent">
		<c:if test="${!empty(customerPidBookingRecord) }">
			<input type="hidden" name="customerId" value="${customerPidBookingRecord.customer.dbid }" id="customerId"></input>
		</c:if>
		<c:if test="${empty(customerPidBookingRecord) }">
			<input type="hidden" name="customerId" value="${param.customerId }" id="customerId"></input>
		</c:if>
		<input type="hidden" name="customerPidBookingRecord.createTime" id="createTime" value="${customerPidBookingRecord.createTime}">
		<input type="hidden" name="customerPidBookingRecord.dbid" id="dbid" value="${customerPidBookingRecord.dbid }">
		<s:token></s:token>
		
		<table border="0" align="center" cellpadding="0" cellspacing="0" style="width: 96%;">
			<tr height="42">
				<td class="formTableTdLeft">车源情况:&nbsp;</td>
				<td colspan="3">
					<c:if test="${!empty(customerPidBookingRecord.hasCarOrder)&&customerPidBookingRecord.hasCarOrder<3 }" var="hasCarStatus">
						<input type="hidden" value="${customerPidBookingRecord.hasCarOrder }" id="hasCarOrder" name="customerPidBookingRecord.hasCarOrder">
						<c:if test="${customerPidBookingRecord.hasCarOrder==1 }">
							现车订单
						</c:if>
						<c:if test="${customerPidBookingRecord.hasCarOrder==2 }">
							在途订单
						</c:if>
					</c:if>
					<c:if test="${hasCarStatus==false }">
						<select id="hasCarOrder" name="customerPidBookingRecord.hasCarOrder" class="mediaX text" checkType="string,1" tip="请选择车源情况" onchange="onchage(this.value)">
							<option value="" >请选择车源情况</option>
							<option value="1" ${customerPidBookingRecord.hasCarOrder==1?'selected="selected"':'' } >现车订单</option>
							<option value="2" ${customerPidBookingRecord.hasCarOrder==2?'selected="selected"':'' } >在途订单</option>
							<option value="3" ${customerPidBookingRecord.hasCarOrder==3?'selected="selected"':'' } >无车订单</option>
						</select>
					</c:if>
				</td>
			</tr>
			<c:if test="${empty(customerPidBookingRecord.hasCarOrder)}" var="status">
				<tr height="42" id="vinCodeTr" style="display: none;">
					<td class="formTableTdLeft">车架号:&nbsp;</td>
					<td colspan="3">
						<input type="hidden" class="mediaX text" name="vinCodeId" id="vinCodeId" readonly="readonly"  />
						<input type="text" class="mediaX text" name="vinCode" id="vinCode" readonly="readonly"  />
						<a href="javascript:void(-1)" class="aedit" onclick="choice()">选择车辆</a>
					</td>
				</tr>
			</c:if>
			<c:if test="${status==false }">
				<!-- 无车订单 无车架好 -->
				<c:if test="${customerPidBookingRecord.hasCarOrder==3 }" var="sta">
					<tr height="42" id="vinCodeTr" style="display: none;">
						<td class="formTableTdLeft">车架号:&nbsp;</td>
						<td colspan="3">
							<input type="hidden" class="mediaX text" name="vinCodeId" id="vinCodeId" readonly="readonly"  />
							<input type="text" class="mediaX text" name="vinCode" id="vinCode" readonly="readonly"  tip="车架号不能为空！"/>
							<a href="javascript:void(-1)" class="aedit" onclick="choice()">选择车辆</a>
						</td>
					</tr>
				</c:if>
				<!-- 有车订单 有车架好 -->
				<c:if test="${sta==false }">
					<tr height="42" id="vinCodeTr" >
						<td class="formTableTdLeft">车架号:&nbsp;</td>
						<td colspan="3">
							<input type="hidden" class="mediaX text" name="vinCodeId" id="vinCodeId" readonly="readonly"  />
							<input type="text" class="mediaX text" name="vinCode" id="vinCode" value="${ customerPidBookingRecord.vinCode}"  tip="车架号不能为空！"/>
						</td>
					</tr>
				
				</c:if>
			</c:if>
			<tr height="42">
				<td class="formTableTdLeft">物流备注:&nbsp;</td>
				<td colspan="3"><textarea   name="customerPidBookingRecord.wlNote" id="wlNote"	 class="textarea largeXXX text" title="备注">${customerPidBookingRecord.wlNote }</textarea></td>
			</tr>
			<tr height="120" id="messageKd" style="display: none;height: 100px;">
				<td class="formTableTdLeft">绑车申请备注:&nbsp;</td>
				<td colspan="3"><textarea   name="buySalerNote" id="buySalerNote"	 class="textarea largeXXX text" title="绑车申请备注"></textarea></td>
			</tr>
		</table>
	</form>
	<div class="formButton">
		<a href="javascript:void(-1)"	onclick="if(vlida()){$.utile.submitAjaxForm('frmId','${ctx}/customerPidBookingRecord/saveWlb')}"	class="but butSave">保&nbsp;&nbsp;存</a> 
		<a href="javascript:void(-1)"	onclick="goBack()" class="but butCancle">取&nbsp;&nbsp;消</a>
	</div>
</div>
<div id="message" class="alert alert-error" style="display: none;">
	提示：【<span id="msVinCode"></span>】车辆属于【<span id="msCompany"></span>】公司，绑定该车辆将发起<strong>“经销商买车车申请“</strong>。
</div>
<div id="warme" class="alert alert-error" style="display: none;">
		<div id="warme1"><strong>绑车申请流程：</strong>申请（销售商）—》审批（进货商）</div>
		<div id="warme2"><strong>绑车申请流程：</strong>申请（销售商）—》审批（进货商）—》发车（进货商）—》收车（销售商）</div>
	</div>
<div class="frmContent">
		<div class="frmTitle" onclick="showOrHiden('contactTable')">基本信息</div>
		<table border="0" align="center" cellpadding="0" cellspacing="0" style="width: 92%;">
			<tr height="42">
				<td class="formTableTdLeft" >客户名称：</td>
				<td>
					${customer.name }&nbsp;&nbsp;&nbsp;&nbsp; ${customer.mobilePhone}
				</td>
			</tr>
			<tr height="42">
				<td>销售顾问：</td>
				<td>
					${customer.bussiStaff}
					&nbsp;&nbsp;&nbsp;&nbsp;
					${customer.user.mobilePhone }
				</td>
			</tr>
			<tr height="42">
				<td>车辆信息：</td>
				<td>
					${customerPidBookingRecord.brand.name }
					${customerPidBookingRecord.carSeriy.name }
					${customerPidBookingRecord.carModel.name }
					${customerPidBookingRecord.carColor.name }
				</td>
			</tr>
			<tr height="42">
				<td>预约时间：</td>
				<td>
					${customerPidBookingRecord.bookingDate }
				</td>
			</tr>
			<tr height="42">
				<td>交车备注：</td>
				<td>
					${customerPidBookingRecord.note }
				</td>
			</tr>
		</table>
	<div class="frmTitle" onclick="showOrHiden('contactTable')">附加通知单</div>		
		<c:if test="${empty(orderContractDecore) }">
			<div class="alert alert-error">
				<strong>提示：</strong> 
				该客户无附加通知单！				
			</div>
		</c:if>
		<c:if test="${!empty(orderContractDecore) }">
			<table id="orderDecore" cellpadding="0" cellspacing="0" border="1" style="margin:0 auto;width: 92%;" class="table-c">
					<tr>
						<td align="center" colspan="4">&#12288;销售装饰项目</td>
						<td  align="center" colspan="4">&#12288;赠送装饰项目</td>	
					</tr>
					<tr style="border-bottom: 0;">
						<td colspan="4" style="border-bottom: 0;" width="50%">
							<table cellpadding="0" cellspacing="0" width="100%" border="0" >
								<tr class="tabletr">
									<td align="center" style="0">序号</td>
									<td align="center">编号</td>
									<td align="center">项目</td>
									<td align="center">单价</td>
									<td align="center">数量</td>
								</tr>
								<c:set value="0" var="zs"></c:set>	
								<c:set value="0" var="xs"></c:set>	
								<c:set value="0" var="total"></c:set>	
								<c:forEach  var="decoreNoticeItem" items="${orderContractDecore.orderContractDecoreItem }"  varStatus="i">
									<c:if test="${decoreNoticeItem.type==1 }">
										<c:set value="${xs+1 }" var="xs"></c:set>
									</c:if>
									<c:if test="${decoreNoticeItem.type==2 }">
										<c:set value="${zs+1 }" var="zs"></c:set>
									</c:if>
								</c:forEach>
								<c:if test="${xs>zs }" var="status">
									<c:set value="${xs }" var="total"></c:set>
								</c:if>
								<c:if test="${status==false }">
									<c:set value="${zs }" var="total"></c:set>
								</c:if>
								<c:set value="1" var="indexVar"></c:set>
								<c:forEach  var="decoreNoticeItem" items="${orderContractDecore.orderContractDecoreItem }"  varStatus="i">
									<c:if test="${decoreNoticeItem.type==1 }">
										<tr> 
											<td align="center">${indexVar } </td>
											<td align="center">
												${decoreNoticeItem.serNo }
											</td>
											<td align="center">
												${decoreNoticeItem.itemName }
											</td>
											<td align="left">
												${decoreNoticeItem.price }
											</td>
											<td align="left">
												${decoreNoticeItem.quality }
											</td>
										</tr>
										<c:set value="${indexVar+1 }" var="indexVar"></c:set>
									</c:if>
								</c:forEach>
								<c:if test="${xs<zs }" var="status">
									<c:forEach var="ind" begin="${xs+1 }" end="${zs }">
										<tr> 
												<td align="center">${ind } </td>
												<td align="center">
												</td>
												<td align="center">
												</td>
												<td align="left">
												</td>
												<td align="left">
												</td>
											</tr> 
									</c:forEach>
								</c:if>
							</table>
						</td>
						<td colspan="4" style="border-bottom: 0;" width="50%">
							<table cellpadding="0" cellspacing="0" width="100%" border="0" >
								<tr class="tabletr">
									<td align="center" style="0">序号</td>
									<td align="center">编号</td>
									<td align="center">项目</td>
									<td align="center">单价</td>
									<td align="center">数量</td>
								</tr>	
								<c:set value="1" var="indexVar"></c:set>
								<c:forEach  var="decoreNoticeItem" items="${orderContractDecore.orderContractDecoreItem }"  varStatus="i">
									<c:if test="${decoreNoticeItem.type==2 }">
										<tr> 
											<td align="center">${indexVar } </td>
											<td align="center">
												${decoreNoticeItem.serNo }
											</td>
											<td align="center">
												${decoreNoticeItem.itemName }
											</td>
											<td align="left">
												${decoreNoticeItem.price }
											</td>
											<td align="left">
												${decoreNoticeItem.quality }
											</td>
										</tr>
										<c:set value="${indexVar+1 }" var="indexVar"></c:set>
									</c:if> 
									<c:set value="${i.index+1 }" var="size"></c:set>
								</c:forEach>
								<c:forEach var="ind" begin="${zs+1 }" end="${xs }">
									<tr> 
											<td align="center">${ind }</td>
											<td align="center">
											</td>
											<td align="center">
											</td>
											<td align="left">
											</td>
											<td align="left">
											</td>
										</tr> 
								</c:forEach>
							</table>
						</td>
					</tr>
					<tr>
						
						<td align="center">销售装饰合计</td>
						<td colspan="3">
							${orderContractDecore.decoreSaleTotalPrce }
						</td>
						<td align="center">赠送装饰合计</td>
						<td  colspan="3">
							${orderContractDecore.giveTotalPrice }
						</td>
					</tr>
					<tr>
						<td align="center" colspan="">装饰实收合计</td>
						<td  colspan="8">
							${orderContractExpenses.decoreMoney}
							折扣率
							${orderContractDecore.zkl }
						</td>
					</tr>
				</table>
			</c:if>
</div>
</body>
<script type="text/javascript" src="${ctx }/widgets/My97DatePicker/WdatePicker.js"></script>
<script type="text/javascript">
var kdSaleStatus=true;

function commonSelect(title,url,smsIds,smsNames,targetId,swidth,sheight,status){
	var width = swidth || 720;
	var heigth = sheight || 400;
	var stat = status || false;
	var path="";
	art.dialog.open(path+url, {
		title: title,
		width:width,height:heigth,
		fixed: true,
		lock : true,
	    drag: false,
	    resize: false,
		init: function () {
			var iframe = this.iframe.contentWindow;
			var top = art.dialog.top;// 引用顶层页面window对象
		},
		ok: function () {
			var iframe = this.iframe.contentWindow;
			if (!iframe.document.body) {
				alert('iframe还没加载完毕呢')
				return false;
			};
			$("#message").hide();
			$("#warme").hide();
			var members= iframe.document.getElementById(targetId).value;
			if(null!=members&&members.length>0){
				$('#'+smsIds).val(members.split("|")[0]);
				$('#'+smsNames).val(members.split("|")[1]);
				kdSaleStatus=members.split("|")[2];
				var ws=members.split("|")[4];
				if(kdSaleStatus=="false"){
					$("#msVinCode").text("");
					$("#msVinCode").text(members.split("|")[1]);
					$("#msCompany").text("");
					$("#msCompany").text(members.split("|")[3]);
					$("#message").show();
					$("#messageKd").show();
					$("#warme").show();
					if(ws=="false"){
						$("#warme1").hide();
						$("#warme2").show();
					}else{
						$("#warme1").show();
						$("#warme2").hide();
					}
					kdSaleStatus=false;
				}else{
					$("#message").hide();
					$("#messageKd").hide();
					kdSaleStatus=true;
				}
				return true;
			}else{
				alert("请选择数据！");
				return false;
			}
		},
		cancel: true
	});
}
function ajaxCarModel(sel){
		var options=$("#"+sel+" option:selected");
		var value=options[0].value;
		$("#carModelId").remove();
		if(value==''||value<=0){
			return;
		}
		$.post("${ctx}/carModel/ajaxCarModelBySeriyStatus?carSeriyId="+value+"&dateTime="+new Date(),{},function (data){
			if(data!="error"){
				$("#carModelLabel").append(data);
			}
		});
	}
function validate(){
	var hasCarOrder=$("#hasCarOrder").val();
	if(hasCarOrder==''){
		alert("请先选择车源情况！");
		return false;
	}
	return true;
}
function onchage(value){
	if(value!=3){
		$("#vinCodeTr").show();
	}else{
		$("#vinCodeTr").hide();
	}
}
function choice(){
	var hasCarOrder=$('#hasCarOrder').val();
	var url="${ctx}/factoryOrder/choiceVinCode?pidDbid=${customerPidBookingRecord.dbid }&hasCarOrder="+hasCarOrder;
	if(validate()){
		commonSelect('请选择车辆信息',url,'vinCodeId','vinCode','vinCode',1280,540)
	}
}
function vlida(){
	var hasCarOrder=$("#hasCarOrder").val();
	var vinCode=$("#vinCode").val();
	if(hasCarOrder==''){
		alert("请先选择车源情况！");
		return false;
	}
	if(hasCarOrder!='3'){
		if(null==vinCode||vinCode==''){
			alert("请先选择车架号");
			return false;
		}
	}
	return true;
}
</script>
</html>