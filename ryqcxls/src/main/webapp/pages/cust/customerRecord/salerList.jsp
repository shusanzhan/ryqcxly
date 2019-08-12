<%@page import="java.util.Date"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="../../commons/taglib.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html lang="en">
<head>
<title>我的线索</title>
<meta charset="UTF-8" />
<meta name="viewport" content="width=device-width, initial-scale=1.0" />
<link href="${ctx }/css/common.css" type="text/css" rel="stylesheet"/>
<script type="text/javascript" src="${ctx }/widgets/bootstrap3/jquery.min.js"></script>
<script type="text/javascript" src="${ctx }/widgets/utile/utile.js"></script>
<script type="text/javascript" src="${ctx }/widgets/easyvalidator/js/easy_validator.pack.js"></script>
<script type="text/javascript" src="${ctx }/widgets/artDialog/artDialog.js?skin=twitter"></script>
<script type="text/javascript" src="${ctx }/widgets/artDialog/plugins/iframeTools.source.js"></script>
<script type="text/javascript" src="${ctx }/widgets/My97DatePicker/WdatePicker.js"></script>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<style type="text/css">
	.staltalbe{
		width: 98%;background-color:#63BA79;line-height: 30px;color:white;border: 0px;margin: 0 auto;margin-top: 10px;
	}
	.staltalbe td{
		border-bottom: 1px solid #FFF;
	}
	.staltalbe td:last-child{ 
		border-right: 0px;
	}
	.staltalbe td{
		border-right: 1px solid #FFF;text-align: center;
	}
	.staltalbe tr:last-child td{
		border-bottom:0px;
	}
	.staltalbe .label{
		text-align: center;font-weight: bold;
	}
</style>
</head>

<body class="bodycolor">
<div class="location">
	<img src="${ctx}/images/homeIcon.png"/> &nbsp;
	<a href="javascript:void(-1);" onclick="window.parent.location.href='${ctx}/main/index'">首页</a>-
	<a href="javascript:void(-1);" onclick="">我的线索</a>
</div>
 <!--location end-->
<div class="line"></div>
	<table class="staltalbe" border="0" cellpadding="0" cellspacing="0">
		<tr>
			<td  class="label" colspan="7"><fmt:formatDate value="${now }"/>来店线索统计</td>
		</tr>
		<tr>
			<td class="label">项目</td>
			<td class="label">今日线索</td>
			<td class="label">今日留资</td>
			<td class="label">今日留资率</td>
			<td class="label">本月累计线索</td>
			<td class="label">本月累计留资</td>
			<td class="label">本月留资率</td>
		</tr>
		<c:forEach items="${statCustomerRecords }" var="statCustomerRecord">
			<tr>
				<td>${statCustomerRecord.name}</td>
				<td>${statCustomerRecord.todayNum }</td>
				<td>${statCustomerRecord.todayCreateFolderNum}</td>
				<td>
					<c:if test="${statCustomerRecord.todayNum>0 }">
						<fmt:formatNumber value="${statCustomerRecord.todayCreateFolderNum/statCustomerRecord.todayNum*100 }" pattern="##.00"></fmt:formatNumber>%
					</c:if>
					<c:if test="${statCustomerRecord.todayNum<=0 }">
						0
					</c:if>
				</td>
				<td>
					${statCustomerRecord.monthNum }
				</td>
				<td>
					${statCustomerRecord.monthCreateFolderNum }
				</td>
				<td>
					<c:if test="${statCustomerRecord.monthNum>0 }">
						<fmt:formatNumber value="${statCustomerRecord.monthCreateFolderNum/statCustomerRecord.monthNum*100 }" pattern="##.00"></fmt:formatNumber>%
					</c:if>
					<c:if test="${statCustomerRecord.monthNum<=0 }">
						0
					</c:if>
				</td>
			</tr>
		</c:forEach>
		<tr>
			<td colspan="7" style="color: red;text-align: left">说明：来店指到店看车</td>
		</tr>
	</table>
<div class="listOperate">
	<div class="operate">
		<a class="but butSave" href="javascript:void();" onclick="window.location.href='${ctx}/customerRecord/salerEdit'">添加线索</a>
		<c:if test="${sessionScope.user.bussiType==2}">
			<a class="but butSave" href="javascript:void();" onclick="window.location.href='${ctx}/customerRecord/importExcel'">批量导入</a>
			<a class="but butSave" href="javascript:void(-1);" onclick="customerFlowResult()">无效处理</a>
		</c:if>
   </div>
  	<div class="seracrhOperate" style="margin: 20px 1px;">
  		<form name="searchPageForm" id="searchPageForm"  action="${ctx}/customerRecord/querySalerList" method="post" >
		<input type="hidden" id="currentPage" name="currentPage" value='${page.currentPageNo}'>
		<input type="hidden" id="paramPageSize" name="pageSize" value='${page.pageSize}'>
		<table cellpadding="0" cellspacing="0" class="searchTable" >
  			<tr>
  				<td><label>类型：</label></td>
  				<td>
  					<select class="text midea" id="customerTypeId" name="customerTypeId"  onchange="$('#searchPageForm')[0].submit()">
						<option value="-1" >请选择...</option>
						<c:forEach var="customerType" items="${customerTypes }">
							<option value="${customerType.dbid }" ${param.customerTypeId==customerType.dbid?'selected="selected"':'' } >${customerType.name }</option>
						</c:forEach>
					</select>
  				</td>
  				<td><label>来店次数：</label></td>
  				<td>
  					<select class="midea text" id="comeinNum" name="comeinNum" onchange="$('#searchPageForm')[0].submit()" >
						<option value="-1">请选择...</option>
						<option value="0" ${param.comeinNum==0?'selected="selected"':'' } >未到店</option>
						<option value="1" ${param.comeinNum==1?'selected="selected"':'' } >初次来店</option>
						<option value="2" ${param.comeinNum==2?'selected="selected"':'' } >2次来店</option>
					</select>
				</td>
  				<td><label>处理状态：</label></td>
  				<td>
  					<select class="midea text" id="resultStatus" name="resultStatus" onchange="$('#searchPageForm')[0].submit()" >
						<option value="-1">请选择...</option>
						<option value="1" ${param.resultStatus==1?'selected="selected"':'' } >待处理</option>
						<option value="2" ${param.resultStatus==2?'selected="selected"':'' } >转为登记</option>
						<option value="3" ${param.resultStatus==3?'selected="selected"':'' } >已回访</option>
						<option value="4" ${param.resultStatus==4?'selected="selected"':'' } >无效</option>
					</select>
				</td>
			</tr>
			<tr>
				<td><label>姓名：</label></td>
  				<td>
  					<input class="midea text" id="name" name="name" value="${param.name }" >
  				</td>
				<td><label>电话：</label></td>
  				<td>
  					<input class="midea text" id="mobilePhone" name="mobilePhone" value="${param.mobilePhone }" >
  				</td>
				<td><label>开始时间：</label></td>
  				<td>
  					<input class="small text" id="startTime" name="startTime" onFocus="WdatePicker({isShowClear:true})" value="${param.startTime }" >~
  					<input class="small text" id="endTime" name="endTime" onFocus="WdatePicker({isShowClear:true})" value="${param.endTime }">
  				</td>
  				<td><div href="javascript:void(-1)" onclick="$('#searchPageForm')[0].submit()" class="searchIcon"></div></td>
   			</tr>
   		</table>
   		</form>
   	</div>
   	<div style="clear: both;"></div>
</div>

<c:if test="${empty(page.result)||page.result==null }" var="status">
	<div class="alert alert-info" style="margin-top: 12px;">
		<strong>提示!</strong> 当前未添加数据.
	</div>
</c:if>
<c:if test="${status==false }">
<table width="100%" border="0" class="mainTable" cellpadding="0" cellspacing="0">
	<thead>
		<tr>
			<c:if test="${sessionScope.user.bussiType==2}">
				<td style="width: 20px;">
					<div class="checker" id="uniform-title-table-checkbox">
						<span><input type="checkbox" name="title-table-checkbox" id="title-table-checkbox" onclick="selectAll(this,'id')"></span>
					</div>
				</td>
			</c:if>
			<td style="width: 100px;">登记日期</td>
			<td style="width: 100px;">类型</td>
			<td style="width: 100px;">客户姓名</td>
			<td style="width: 220px;">关注车型</td>
			<td style="width: 100px;">进店/来电时间</td>
			<td style="width: 100px;">随行人数</td>
			<td style="width: 100px;">处理结果</td>
			<td style="width: 100px;">来店次数</td>
			<td style="width: 100px;">超时状态</td>
			<td style="width: 120px;">操作</td>
		</tr>
	</thead>
	<tbody>
		<c:forEach items="${page.result }" var="customerRecord">
		<tr>
			<c:if test="${sessionScope.user.bussiType==2}">
				<td style="text-align: center;">
						<input type="checkbox"   name="id" id="id1" value="${customerRecord.dbid }" ${customerRecord.resultStatus==1?'':'disabled="disabled"'} custName='${customerRecord.name }'>
				</td>
			</c:if>
			<td style="text-align: left;">
				<a href="javascript:void(-1)" class="aedit" onclick="window.location.href='${ctx }/customerRecord/view?dbid=${customerRecord.dbid}'">
					<fmt:formatDate value="${customerRecord.createDate }" pattern="yyyy-MM-dd HH:mm"/>
					<c:if test="${!empty(customerRecord.agentUser) }">
						<br>${customerRecord.agentUser.realName}[代办]
					</c:if>
				</a> 
				<c:if test="${customerRecord.resultStatus==1 }">
					<c:if test="${sessionScope.user.dbid==customerRecord.user.dbid}">
						| <a href="javascript:void(-1)" class="aedit" onclick="window.location.href='${ctx }/customerRecord/salerEdit?dbid=${customerRecord.dbid}'">编辑</a> 
					</c:if>
				</c:if>
			</td>
			<td>
				${customerRecord.customerType.name }
			</td>
			<td style="text-align: left;">
				<c:if test="${empty(customerRecord.name) }">
					无
					${customerRecord.customer.name }
				</c:if>
				<c:if test="${!empty(customerRecord.name) }">
					${customerRecord.name }
					${customerRecord.mobilePhone }
					<br>${customerRecord.address }
				</c:if>
			</td>
			<td>
				<c:if test="${empty(customerRecord.brand) }">
					<c:if test="${empty(customerRecord.carModels)}">
						-
					</c:if>
					<c:if test="${!empty(customerRecord.carModels)}">
						${customerRecord.carModels }
					</c:if>
				</c:if>
					${customerRecord.brand.name }
					${customerRecord.carSeriy.name }
					${customerRecord.carModel.name }${customerRecord.carModelStr}
			</td>
			<td>
				<c:if test="${customerRecord.customerType.dbid!=1 }">
					<fmt:formatDate value="${customerRecord.createDate }" pattern="yyyy-MM-dd HH:mm"/> 
					
				</c:if>
				<c:if test="${customerRecord.customerType.dbid==1 }">
					${customerRecord.comeInTime}
				</c:if>
			</td>
			<td>
				<c:if test="${customerRecord.customerType.dbid!=1 }">
					?
				</c:if>
				<c:if test="${customerRecord.customerType.dbid==1 }">
					${customerRecord.customerNum}
					人
				</c:if>
			</td>
			<td>
				<c:if test="${customerRecord.resultStatus==2 }">
					<span style="color: green;">转为登记</span>
				</c:if>
				<c:if test="${customerRecord.resultStatus==1 }">
					<span style="color: pink;">等待...</span>
				</c:if>
				<c:if test="${customerRecord.resultStatus==3 }">
					<span style="color: green;">已回访</span>
				</c:if>
				<c:if test="${customerRecord.resultStatus==4 }">
					<span style="color: red;">无效</span>
				</c:if>
			</td>
			<td>
				<c:if test="${customerRecord.comeinNum==0 }">
					未到店
				</c:if>
				<c:if test="${customerRecord.comeinNum==1 }">
					初次到店
				</c:if>
				<c:if test="${customerRecord.comeinNum==2 }">
					二次来店
				</c:if>
			</td>
			<td>
					<c:if test="${customerRecord.overtimeStatus==1 }">
						<span>未超时</span>
					</c:if>
					<c:if test="${customerRecord.overtimeStatus==2 }">
						<span style="color: red">已超时</span>
					</c:if>
			</td>
			<td style="text-align: center;">
				<!-- 待处理 -->
				<c:if test="${customerRecord.resultStatus==1 }">
					<a href="javascript:void(-1)" class="aedit" onclick="vlidateCustomer(${customerRecord.customerType.dbid},${customerRecord.dbid})">转登记</a> 
					|
					<a href="javascript:void(-1)" class="aedit" onclick="$.utile.openDialog('${ctx }/customerRecord/invalid?dbid=${customerRecord.dbid}&type=1','客户无效登记',760,400)">线索无效</a>
				</c:if> 
				<c:if test="${customerRecord.resultStatus>1 }">
					已处理 
				</c:if>
		</td> 
		</tr>
		</c:forEach>
	</tbody>
</table>
</c:if>
<div id="fanye">
	<%@ include file="../../commons/commonPagination.jsp" %>
</div>
<div style="display: none; width: 340px;" id="templateId">
		<table id="noLine" border="0" align="center" cellpadding="0" cellspacing="0" style="width: 320px;margin-top: 5px;">
			<tr style="height: 60px;" height="60">
				<td class="formTableTdLeft" width="120">到店成交:&nbsp;</td>
				<td colspan="3">
					<label><input  type="radio"  id="comeShopeStatus" name="comeShopeStatus" value="1">到店成交</label>
					<label><input  type="radio"  id="comeShopeStatus" name="comeShopeStatus" value="2">到店未成交</label>
				</td>
			</tr>
		</table>
	</div>
<div style="display: none; width: 340px;" id="template2Id">
	<table id="noLine" border="0"  cellpadding="0" cellspacing="0" style="width: 320px;margin-top: 5px;text-align: left;margin-left: 5px;float: left;">
		<tr style="height: 60px;" height="60">
			<td class="formTableTdLeft" width="120">到店成交:&nbsp;</td>
			<td colspan="3">
				<label><input  type="radio"  id="comeShopeStatus" name="comeShopeStatus" value="1">到店成交</label>
				<label><input  type="radio"  id="comeShopeStatus" name="comeShopeStatus" value="2">到店未成交</label>
			</td>
		</tr>
	</table>
</div>
<script type="text/javascript">
	function vlidateCustomer(type,customerRecordId){
		$.post('${ctx}/customerRecord/vlidateCustomer?customerRecordId='+customerRecordId+'&dateTime='+new Date(),{},function(json){
			var data=json.state;
			if(data==1||data=="1"){
				window.location.href='${ctx }/custCustomer/validateMember?customerRecordId='+customerRecordId;
			}
			if(data==2||data=="2"){
				window.location.href='${ctx }/custCustomer/addShoppingRecord?customerRecordId='+customerRecordId;
			}
			if(data==3||data=="3"){
				window.top.art.dialog({
					content : json.message,
					icon : 'question',
					width:"320px",
					height:"120px",
					lock : true,
					cancel : true
				})
			}
			if(data==4||data=="4"){
				window.top.art.dialog({
					content : '系统已经存在【'+json.mobilePhone+'】客户，点击【确定】继续完成回访记录填写。',
					icon : 'question',
					width:"320px",
					height:"120px",
					lock : true,
					ok : function() {
						if(type==1){
							comeShopeRecord(json.dbid,customerRecordId);
						}else{
							$.utile.openDialog('${ctx}/customerTrack/add?customerId='+json.dbid+'&typeRedirect=5&customerRecordId='+customerRecordId,'添加跟进记录',900,500);
						}
					},
					cancel : true
				})
			}
			if(data==5||data=="5"){
				window.top.art.dialog({
					content : json.message,
					icon : 'question',
					width:"320px",
					height:"120px",
					lock : true,
					cancel : true
				})
			}
			if(data==6||data=="6"){
				window.top.art.dialog({
					content : "该电话号码销售顾问已登记，点击【确定】继续填网销邀约到店谈判记",
					icon : 'question',
					width:"320px",
					height:"120px",
					lock : true,
					ok : function() {
						customerRecordResult(customerRecordId,json.messageHtml);
					},
					cancel : true
				})
			}
		})
	}
	function selectAll(checkbox, domname) {
		var doms = document.getElementsByName(domname);
		for ( var i = 0; i < doms.length; i++) {
			if (doms[i].type == "checkbox") {
				if($(doms[i]).attr("disabled")!="disabled"){
					doms[i].checked = checkbox.checked;
				}
			}
		}
	}
	function getCheckBox() {
		var array = new Array();
		var arrayName = new Array();
		var checkeds = $("input[type='checkbox'][name='id']");
		$.each(checkeds, function(i, checkbox) {
			if (checkbox.checked) {
				array.push(checkbox.value);
				arrayName.push($(checkbox).attr("custName"));
			}
		});
		return array.toString()+"|"+arrayName.toString();
	}
	function customerFlowResult(){
		var checkBef = checkBefDel();
		if (checkBef == true) {
			var values=getCheckBox().split("|");
			$.utile.openDialog('${ctx }/customerRecord/invalid?dbids='+values[0]+"&names="+values[1]+"&type=2",'客户无效登记',760,400)
		}
	}
	function comeShopeRecord(customerId,customerRecordId){
		top.art.dialog({
		    title: '客户到店登记',
		    content: document.getElementById('templateId'),
		    lock : true,
			fixed : true,
		    ok: function () {
		    	var comeShopeStatus=window.parent.document.getElementsByName("comeShopeStatus");
		    	var selectvalue="";   //  selectvalue为radio中选中的值
	            for(var i=0;i<comeShopeStatus.length;i++){
                    if(comeShopeStatus[i].checked==true) {
                    	selectvalue=comeShopeStatus[i].value; 
                   }
	            }
		    	if(null==selectvalue||selectvalue==''){
		    		alert("请选择到店成交状态！");
		    		return false;
		    	}
	    		var url='${ctx}/custCustomer/comeShopRecord?customerId='+customerId+'&comeShopeStatus='+selectvalue+"&redirectType=1&customerRecordId="+customerRecordId;
	    		window.location.href=url;
				return true;
		    },
		    cancel:function(){
				return true;
		    }
		});
	}
	function customerRecordResult(customerRecordId,content){
		art.dialog({
		    title: '谈判结果',
		    content: content,
		    width:550,
		    height:240,
			fixed : true,
		    ok: function () {
		    	var doms = document.getElementsByName("customerIdValue");
		    	var customerId=0;
		    	var j=0;
		    	for ( var i = 0; i < doms.length; i++) {
	    			if(doms[i].checked){
	        			j=i;
	        			customerId=doms[i].value;
	    			}
		    	}
		    	var customerName=window.document.getElementsByName("customerName")[j].value;
		    	if(customerName==undefined||customerName==''){
			    	alert("请选择要登记客户");
			    	return false;
			    }
			    if(confirm("确定登记【"+customerName+"】客户客户谈判记录吗？")){
			    	$("#customerName2").val(customerName);
			    	comeShopeRecord2(customerId,customerRecordId,1);
				}
				return true;
		    },
		    cancel:function(){
				return true;
		    }
		});
	}
	function comeShopeRecord2(customerId,customerRecordId,type){
		if(type==undefined||type==''){
			$("#infor").hide();
		}else{
			$("#infor").show();
		}
		top.art.dialog({
		    title: '客户到店登记',
		    content: document.getElementById('template2Id'),
		    lock : true,
		    width:460,
		    height:200,
			fixed : true,
		    ok: function () {
		    	var comeShopeStatus=window.parent.document.getElementsByName("comeShopeStatus");
		    	var selectvalue="";   //  selectvalue为radio中选中的值
	            for(var i=0;i<comeShopeStatus.length;i++){
	                if(comeShopeStatus[i].checked==true) {
	                	selectvalue=comeShopeStatus[i].value; 
	               }
	            }
		    	if(null==selectvalue||selectvalue==''){
		    		alert("请选择到店成交状态！");
		    		return false;
		    	}
	    		var url='${ctx}/custCustomer/comeShopRecord?customerId='+customerId+'&comeShopeStatus='+selectvalue+"&redirectType=2&customerRecordId="+customerRecordId;
	    		window.location.href=url;
				return true;
		    },
		    cancel:function(){
				return true;
		    }
		});
	}
</script>
</body>
</html>
