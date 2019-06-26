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
<script type="text/javascript" src="${ctx }/widgets/artDialog/artDialog.js?skin=default"></script>
<script type="text/javascript" src="${ctx }/widgets/artDialog/plugins/iframeTools.source.js"></script>
<title>添加追踪记录</title>
</head>
<body class="bodycolor">
	<div class="frmContent">
	<form action="" name="frmId" id="frmId" style="margin-bottom: 40px;" target="_parent">
		<input type="hidden" name="customerId" value="${customerTrack.customer.dbid }" id="customerId"></input>
		<input type="hidden" name="customerTrack.dbid" id="dbid" value="${customerTrack.dbid }">
		<input type="hidden" name="currentPage" id="currentPage" value="${param.currentPage}">
		<input type="hidden" name="pageSize" id="pageSize" value="${param.pageSize }">
		<input type="hidden" name="typeRedirect" id="typeRedirect" value="${param.typeRedirect }">
		<input type="hidden" name="redirect" id="redirect" value="${param.redirect }">
		<input type="hidden" name="customerRecordId" id="customerRecordId" value="${param.customerRecordId }">
		<input type="hidden" name="maxDay" id="maxDay" value="">
		<input  type="hidden" name="customerTrack.trackDate" id="trackDate"	value='<fmt:formatDate value="${now }" pattern="yyyy-MM-dd HH:mm" />' class="large text" >
		<s:token></s:token>
		<table border="0" align="center" cellpadding="0" cellspacing="0" style="width: 92%;">
			<tr height="42">
				<td class="formTableTdLeft">跟进类型:&nbsp;</td>
				<td >
					<c:if test="${!empty(param.customerRecordId) }">
						<select id="trackType" name="customerTrack.trackType" class="mideaX text" checkType="integer,1" tip="请选择跟进类型" onchange="marketingAct(this.value);">
							<option value="">请选择...</option>
							<option value="1" >日常关系维护</option>
							<option value="2" selected="selected">普通邀约到店</option>
							<option value="3" ${customerTrack.trackType==3?'selected="selected"':'' }>活动邀约到店 </option>
						</select>
					</c:if>
					<c:if test="${empty(param.customerRecordId) }">
						<select id="trackType" name="customerTrack.trackType" class="mideaX text" checkType="integer,1" tip="请选择跟进类型" onchange="marketingAct(this.value);">
							<option value="">请选择...</option>
							<option value="1" ${customerTrack.trackType==1?'selected="selected"':'' }>日常关系维护</option>
							<option value="2" ${customerTrack.trackType==2?'selected="selected"':'' }>普通邀约到店</option>
							<option value="3" ${customerTrack.trackType==3?'selected="selected"':'' }>活动邀约到店 </option>
						</select>
					</c:if>
					<span style="color: red;">*</span>
				</td>
				<td class="formTableTdLeft">跟进方法:&nbsp;</td>
				<td >
					<c:if test="${empty(param.customerRecordId) }">
						<select id="trackMethod" name="customerTrack.trackMethod" class="mideaX text" checkType="integer,1" tip="请选择跟进方法" onchange="tryDriverOper()">
							<option value="">请选择...</option>
							<option value="1" ${customerTrack.trackMethod==1?'selected="selected"':'' }>电话</option>
							<option value="3" ${customerTrack.trackMethod==3?'selected="selected"':'' }>短信 </option>
							<option value="4" ${customerTrack.trackMethod==4?'selected="selected"':'' }>上门</option>
							<option value="5" ${customerTrack.trackMethod==5?'selected="selected"':'' }>微信</option>
							<option value="6" ${customerTrack.trackMethod==6?'selected="selected"':'' }>QQ</option>
						</select>
					</c:if>
					<c:if test="${!empty(param.customerRecordId) }">
						<select id="trackMethod" name="customerTrack.trackMethod" class="mideaX text" checkType="integer,1" tip="请选择跟进方法">
							<option value="">请选择...</option>
							<option value="1" ${customerTrack.trackMethod==1?'selected="selected"':'' }>电话</option>
							<option value="3" ${customerTrack.trackMethod==3?'selected="selected"':'' }>短信 </option>
							<option value="4" ${customerTrack.trackMethod==4?'selected="selected"':'' }>回访</option>
						</select>
					</c:if>
					<span style="color: red;">*</span>
				</td>
			</tr>
			<tr height="42" id="marketing" style="display: none;">
				<td class="formTableTdLeft">邀约活动:&nbsp;</td>
				<td >
					<select id="custMarketingActId" name="custMarketingActId" class="mideaX text" >
						<option value="">请选择...</option>
						<c:forEach var="custMarketingAct" items="${custMarketingActs }">
							<option value="${custMarketingAct.dbid }">${custMarketingAct.name }</option>
						</c:forEach>
					</select>
					<span style="color: red;" >*</span>
				</td>
				<td class="formTableTdLeft">邀约结果:&nbsp;</td>
				<td >
					<select id="turnBackResult" name="customerTrack.turnBackResult" class="mideaX text" >
						<option value="">请选择...</option>
						<option value="1" ${customerTrack.turnBackResult==1?'selected="selected"':'' }>接受</option>
						<option value="2" ${customerTrack.turnBackResult==2?'selected="selected"':'' }>待定</option>
						<option value="3" ${customerTrack.turnBackResult==3?'selected="selected"':'' }>拒绝 </option>
					</select>
					<span style="color: red;">*</span>
				</td>
			</tr>
			<tr height="42">
				<c:if test="${customer.lastResult==0 }" var="status">
					<td class="formTableTdLeft">更新级别:&nbsp;</td>
					<td >
						<select id="customerPhaseId" name="customerPhaseId" class="mideaX text" checkType="integer,1" tip="请选更新级别" onchange="addDate(this.value)">
							<option value="">请选择...</option>
							<c:forEach var="customerPhase" items="${customerPhases }">
								<c:if test="${customerPhase.name!='O' }">
									<option value="${customerPhase.dbid }" >${customerPhase.name }</option>
								</c:if>
							</c:forEach>
						</select>
					</td>
					<td>下次预约时间:</td>
					<td id="nextReservationTimeTr" style="display: none;">
						<input type="text" name="customerTrack.nextReservationTime" id="nextReservationTime" value="" class="mideaX text" 	onfocus="WdatePicker({readOnly:true,dateFmt:'yyyy-MM-dd HH:mm',minDate:'#F{$dp.$D(\'trackDate\')}',maxDate:'#F{$dp.$D(\'maxDay\')}'});" checkType="string,1" tip="请选择下次预约时间">
						<span style="color: red;">*</span>
					</td>
				</c:if>
				<c:if test="${status==false}">
					<td class="formTableTdLeft">更新级别:&nbsp;</td>
					<td >
						<input type="hidden" readonly="readonly" class="largeX text"  name="customerPhaseId" id="customerPhaseId"  value="${customer.customerPhase.dbid }">
						<input type="text" readonly="readonly" class="large text"    value="${customer.customerPhase.name }">
					</td>
					<td>下次预约时间:</td>
					<td >
						<input type="text" name="customerTrack.nextReservationTime" id="nextReservationTime" value="" class="mideaX text" 	onfocus="WdatePicker({readOnly:true,dateFmt:'yyyy-MM-dd HH:mm',minDate:'#F{$dp.$D(\'trackDate\')}'});" checkType="string,1" tip="请选择下次预约时间">
						<span style="color: red;">*</span>
					</td>
				</c:if>
			</tr>
			<tr height="42">
				<td class="formTableTdLeft">跟进内容:&nbsp;</td>
				<td colspan="3"><input type="text" name="customerTrack.trackContent" id="trackContent"	 class="largeXXX text"  checkType="string,1,2000"	tip="请输入跟进内容,必须小于2000个字符"></td>
			</tr>
			<tr height="42">
				<td class="formTableTdLeft">沟通结果:&nbsp;</td>
				<td colspan="3"><input type="text" name="customerTrack.result" id="result"
					 class="largeXXX text" 	></td>
			</tr>
			<tr height="42">
				<td class="formTableTdLeft">客户反馈问题:&nbsp;</td>
				<td colspan="3"><input type="text" name="customerTrack.feedBackResult" id="feedBackResult"
					 class="largeXXX text" 	></td>
			</tr>
			<tr height="42">
				<td class="formTableTdLeft">对应措施:&nbsp;</td>
				<td colspan="3"><input type="text" name="customerTrack.dealMethod" id="dealMethod"
					 class="largeXXX text" 	></td>
			</tr>
		</table>
	</form>
	<div class="formButton">
		<c:if test="${param.type==1 }" var="status">
		</c:if>
		<c:if test="${status==false }">
			<a href="javascript:void(-1)"	onclick="$.utile.submitAjaxForm('frmId','${ctx}/customerTrack/save')"	class="but butSave">保&nbsp;&nbsp;存</a> 
			<a href="javascript:void(-1)"	onclick="art.dialog.close()"	class="but butCancle">取消</a> 
		</c:if>
	</div>
</div>
</body>
<script type="text/javascript" src="${ctx }/widgets/My97DatePicker/WdatePicker.js"></script>
<script type="text/javascript">
function addDate(value){
    var d=new Date(); 
    var mm="";
    var dd="";
    $.post("${ctx}/customerPhase/ajax?dbid="+value+"&date="+new Date(),{},function(data){
    	if(0==data||data=='0'){
    		data=30;
    	}
    	data=parseInt(data)
    	d.setDate(d.getDate()+data); 
        var m=d.getMonth()+1; 
        if(m<10){
        	mm="0"+m;
        }else{
        	mm=m;
        }
        if(d.getDate()<10){
        	dd="0"+d.getDate();
        }else{
        	dd=d.getDate();
        }
        $("#nextReservationTimeTr").show();
        $("#maxDay").val(d.getFullYear()+'-'+mm+'-'+dd+' '+d.getHours()+':'+d.getMinutes());
        
    })
  } 
  function marketingAct(trackType){
	  if(trackType==3){
		  $("#marketing").show();
		  $("#custMarketingActId").attr("checkType","integer,1").attr("tip","请选择邀约活动");
		  $("#turnBackResult").attr("checkType","integer,1").attr("tip","请选择邀约结果");
	  }else{
		  $("#marketing").hide();
		  $("#custMarketingActId").removeAttr("checkType").removeAttr("tip");
		  $("#turnBackResult").removeAttr("checkType").removeAttr("tip");
	  }
  }
</script>
</html>