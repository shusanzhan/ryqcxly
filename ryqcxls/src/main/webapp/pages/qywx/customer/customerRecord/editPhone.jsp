<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../../../commons/taglib.jsp" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta content="width=device-width, initial-scale=1.0, minimum-scale=1.0, maximum-scale=1.0, user-scalable=no" name="viewport">
<!-- Mobile Devices Support @begin -->
<meta content="application/xhtml+xml;charset=UTF-8" http-equiv="Content-Type">
<meta content="no-cache,must-revalidate" http-equiv="Cache-Control">
<meta content="no-cache" http-equiv="pragma">
<meta content="0" http-equiv="expires">
<meta content="telephone=no, address=no" name="format-detection">
<meta name="apple-mobile-web-app-capable" content="yes" />
<!-- apple devices fullscreen -->
<meta name="apple-mobile-web-app-status-bar-style" content="black-translucent" />
<link href="${ctx }/css/qywx.css?da=${now}" type="text/css" rel="stylesheet"/>
<link rel="stylesheet" href="${ctx }/widgets/auto/jquery.autocomplete.css" />
<link href="${ctx }/widgets/bootstrap3/css/bootstrap.min.css?da=${now}" type="text/css" rel="stylesheet"/>
<link href="${ctx }/widgets/bootstrap3/css/bootstrap-theme.min.css" type="text/css" rel="stylesheet"/>
 <script type="text/javascript" src="${ctx }/widgets/My97DatePicker/WdatePicker.js"></script>
<title>
<c:if test="${empty(customerRecord) }">
	添加
</c:if>
<c:if test="${!empty(customerRecord) }">
	编辑
</c:if>
来电线索</title>
<style type="text/css">
	.form-controlSe{
		margin-top: 5px;
	}
	.form-group{
		margin-bottom: 10px;
	}
	.form-inline .form-group{
		width: 100%;
	}
	.form-inline .form-control{
		height: 40px;width: 100%;
	}
</style>
</head>
<body>
<div class="views content_title">
	 <a id="back" href="javascript:history.back()">
        <img src="${ctx }/images/jm/NavButtonBack.png" class="return">
    </a>
    <span id="page_title">
    	<c:if test="${empty(customerRecord) }">
			添加
		</c:if>
		<c:if test="${!empty(customerRecord) }">
			编辑
		</c:if>
   来电线索</span>
    <a class="go_home" href="${ctx }/qywxCustomerRecord/index">
    	<img src="${ctx }/images/jm/go_home.png" alt="">
    </a>
</div>
<div style="margin: 0 auto;width: 92%;margin-top: 20px;">
<form class="form-inline" action="" name="frmId" id="frmId" method="post" >
	 <input type="hidden" name="customerTypeId" id="customerTypeId" value="2">
   	<input type="hidden" name="red" id="red" value="1">
   	<c:if test="${empty(customerRecord) }">
   		<input type="hidden" name="customerRecord.status" id="statusValue" value="1">
   	</c:if>
   	<c:if test="${!empty(customerRecord) }">
   		<input type="hidden" name="customerRecord.status" id="statusValue" value="${customerRecord.status }">
   	</c:if>
   	<input type="hidden" name="customerRecord.dbid" id="customerRecordDbid" value="${customerRecord.dbid }">
	<div class="form-group">
	  <label class="control-label" for="name">来电时间</label>
		<c:if test="${empty(customerRecord) }">
			<input type="text" name="customerRecord.comeInTime" id="comeInTime" value='<fmt:formatDate value="${now }" pattern="HH:mm"/>' class="form-control" 	onfocus="WdatePicker({readOnly:true,dateFmt:'HH:mm'});" checkType="string,1" tip="请选择下次预约时间">
		</c:if>
		<c:if test="${!empty(customerRecord) }">
			<input type="text" name="customerRecord.comeInTime" id="comeInTime" value="${customerRecord.comeInTime }" class="form-control" 	onfocus="WdatePicker({readOnly:true,dateFmt:'HH:mm'});" checkType="string,1" tip="请选择下次预约时间">
		</c:if>
	</div>
	<div class="form-group" >
	  <label class="control-label" for="inputWarning1">来电目的</label  >
	 	<select id="customerRecordTargetId" name="customerRecordTargetId" class="form-control" checkType="integer,1" tip="请选择来店目的" onchange="changeTaget()">
			<option value="">请选择...</option>
			<c:forEach items="${customerRecordTargets }" var="customerRecordTarget">
				<c:if test="${empty(customerRecord) }">
					<option value="${customerRecordTarget.dbid }" ${customerRecordTarget.name=='咨询车型'?'selected="selected"':'' } >${customerRecordTarget.name }</option>
				</c:if>
				<c:if test="${!empty(customerRecord) }">
					<option value="${customerRecordTarget.dbid }" ${customerRecord.customerRecordTarget.dbid==customerRecordTarget.dbid?'selected="selected"':'' } >${customerRecordTarget.name }</option>
				</c:if>
			</c:forEach>
		</select>
	</div>
	<div id="showhide">
		<div class="form-group" >
		  <label class="control-label" for="inputWarning1">客户姓名</label  >
		  <input type="text" class="form-control" name="customerRecord.name" id="name"  value="${customerRecord.name }" checkType="string,1,20" placeholder="请输入客户姓名"   tip="客户姓名不能为空！请输入客户姓名！"/>
		</div>
		<div class="form-group" >
		  <label class="control-label" for="inputWarning1">称呼</label  >
		  	<select class="form-control" id="sex" name="customerRecord.sex" checkType="string,1" error="请选称呼">
		  		<option value="-1">请选择...</option>
		  		<c:if test="${!empty(customerRecord) }">
			  		<option value="男" ${customerRecord.sex=='男'?'selected="selected"':''} >先生</option>
			  		<option value="女" ${customerRecord.sex=='女'?'selected="selected"':''}>女士</option>
		  		</c:if>
		  		<c:if test="${empty(customerRecord) }">
			  		<option value="男" selected="selected" >先生</option>
			  		<option value="女" ${customerRecord.sex=='女'?'selected="selected"':''}>女士</option>
		  		</c:if>
			</select>
		</div>
		<div class="form-group" >
		  <label class="control-label" for="inputWarning1">电话</label  >
		  <input type="number" class="form-control" id="mobilePhone" name="customerRecord.mobilePhone" value="${customerRecord.mobilePhone }" checkType="mobilePhone" >
		</div>
		<div class="form-group" style="display: none;">
		  <label class="control-label" for="inputWarning1">信息来源</label  >
		  <select id="customerInfromId" name="customerInfromId" class="form-control" checkType="integer,1" tip="请选择信息来源">
				<option value="">请选择...</option>
					${customerInfromSelect }
			</select>
		</div>
		<div class="form-group" >
		  <label class="control-label" for="inputWarning1">销售顾问<span style="margin-left: 12px;color: red;" onclick="$('#salerId').val('');$('#saler').val('');">X清空</span></label  >
		  	<input  type="hidden"   id="salerId" name="salerId"   value="${customerRecord.saler.dbid }" >
			<input  type="text"  class="form-control" id="saler" name="saler"   value="${customerRecord.saler.realName }" onfocus="autoUser('saler')" placeholder="请输入输入销售顾问名字拼音">
		</div>
		<div class="form-group" >
		  <label class="control-label" for="inputWarning1">代办销售顾问<span style="margin-left: 12px;color: red;" onclick="$('#agentPersonId').val('');$('#agentPersonName').val('');">X清空</span></label  >
		  	<input  type="hidden"  class="form-control" id="agentPersonId" name="agentPersonId"   value="${customerRecord.agentUser.dbid }" >
			<input  type="text"  class="form-control" id="agentPersonName" name="agentPersonName"   value="${customerRecord.agentUser.realName }" onfocus="autoUser2('agentPersonName')" placeholder="请输入代办销售顾问名字拼音">
		</div>
	</div>
	<div class="form-group" >
	  	<label class="control-label" for="inputWarning1">备注</label>
	  	<textarea  name="customerRecord.note" id="note"	 class="form-control" style="height: 60px;"  title="" >${customerRecord.note }</textarea>
	</div>
</form>
</div>
<div class="buttomBar">
    <input type="button" name="mobileCommit" value="保存" id="tele_register" class="addbutton" onclick="$('#red').val(1);submitFrm('frmId','${ctx}/qywxCustomerRecord/save')">
    <input type="button" name="mobileCommit" value="保存并添加下一条" id="tele_register" class="addbutton" onclick="$('#red').val(3);submitFrm('frmId','${ctx}/qywxCustomerRecord/save')">
</div>	
</body>
<script src="${ctx }/widgets/bootstrap3/jquery.min.js"></script>
<script src="${ctx }/widgets/easyvalidator/js/easy_validator.pack3.js?n=${now}"></script>
<script src="${ctx }/widgets/bootstrap3/js/bootstrap.min.js"></script>
<script src="${ctx }/widgets/utile/wechat.js"></script>
<script type="text/javascript"	src="${ctx}/widgets/auto/jquery.autocomplete.js"></script>
<script type="text/javascript">
	function submitFrm(frmId,url){
		try {
			if(validateForm(frmId)){
			if (undefined != frmId && frmId != "") {
				var params = $("#" + frmId).serialize();
					var url2="";
					$.ajax({	
						url : url, 
						data : params, 
						async : false, 
						timeout : 20000, 
						dataType : "json",
						type:"post",
						success : function(data, textStatus, jqXHR){
							//alert(data.message);
							var obj;
							if(data.message!=undefined){
								obj=$.parseJSON(data.message);
							}else{
								obj=data;
							}
							if(obj[0].mark==1){
								//错误
								showMo(data[0].message,false);
								$(".addbutton").attr("onclick",url2);
								return ;
							}else if(obj[0].mark==0){
								showMo(data[0].message,true);
								setTimeout(
										function() {
											window.location.href = obj[0].url
										}, 1000);
							}
						},
						complete : function(jqXHR, textStatus){
							$(".addbutton").attr("onclick",url2);
							var jqXHR=jqXHR;
							var textStatus=textStatus;
						}, 
						beforeSend : function(jqXHR, configs){
							url2=$(".addbutton").attr("onclick");
							$(".addbutton").attr("onclick","");
							var jqXHR=jqXHR;
							var configs=configs;
						}, 
						error : function(jqXHR, textStatus, errorThrown){
									showMo(data[0].message);
								$(".addbutton").attr("onclick",url2);
						}
					});
				} else {
					return;
				}
			}
		} catch (e) {
			showMo(e,false);
			return;
		}
	}
	function autoUser(id){
		var id1 = "#"+id;
			$(id1).autocomplete("${ctx}/user/ajaxUser",{
				max: 20,      
		        width: 130,    
		        matchSubset:false,   
		        matchContains: true,  
				dataType: "json",
				parse: function(data) {   
			    	var rows = [];      
			        for(var i=0; i<data.length; i++){      
			           rows[rows.length] = {       
			               data:data[i]       
			           };       
			        }       
			   		return rows;   
			    }, 
				formatItem: function(row, i, total) {   
					return "<span>用户Id："+row.userId+"&nbsp;&nbsp;&nbsp;名称："+row.name+"&nbsp;&nbsp;</span>";
			          
			    },   
			    formatMatch: function(row, i, total) {   
			       return row.name;   
			    },   
			    formatResult: function(row) {   
			       return row.name;   
			    }		
			});
		$(id1).result(onRecordSelect2);
		//计算总金额
	}

	function onRecordSelect2(event, data, formatted) {
			$("#saler").val(data.name);
			$("#salerId").val(data.dbid);
	}
	
	function autoUser2(id){
		var id1 = "#"+id;
			$(id1).autocomplete("${ctx}/user/ajaxUser",{
				max: 20,      
		        width: 130,    
		        matchSubset:false,   
		        matchContains: true,  
				dataType: "json",
				parse: function(data) {   
			    	var rows = [];      
			        for(var i=0; i<data.length; i++){      
			           rows[rows.length] = {       
			               data:data[i]       
			           };       
			        }       
			   		return rows;   
			    }, 
				formatItem: function(row, i, total) {   
					return "<span>用户Id："+row.userId+"&nbsp;&nbsp;&nbsp;名称："+row.name+"&nbsp;&nbsp;</span>";
			          
			    },   
			    formatMatch: function(row, i, total) {   
			       return row.name;   
			    },   
			    formatResult: function(row) {   
			       return row.name;   
			    }		
			});
		$(id1).result(onRecordSelect3);
		//计算总金额
	}
	
	function onRecordSelect3(event, data, formatted) {
		$("#agentPersonName").val(data.name);
		$("#agentPersonId").val(data.dbid);
	}
	
	function changeTaget(){
		var targetValue=$("#customerRecordTargetId option:selected").text();
		if(targetValue=='咨询车型'){
			$("#statusValue").val(1);
			$("#showhide").show();
			$("#name").attr("disabled",false);
			$("#mobilePhone").attr("disabled",false);
			$("#saler").attr("disabled",false);
			$("#agentPersonName").attr("disabled",false);
		}else{
			$("#name").attr("disabled",true);
			$("#mobilePhone").attr("disabled",true);
			$("#saler").attr("disabled",true);
			$("#agentPersonName").attr("disabled",true);
			$("#statusValue").val(2);
			$("#showhide").hide();
		}
	}
</script>
</html>