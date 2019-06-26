<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../../commons/taglib.jsp" %>
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
<title>发放红包</title>
<style type="text/css">
	.form-controlSe{
		margin-top: 5px;
	}
	.form-group{
		margin-bottom: 10px;
	}
</style>
</head>
<body>
<div class="views content_title">
    <span id="page_title">发红包</span>
    	<img src="${ctx }/images/jm/go_home.png" alt="">
</div>
<div style="margin: 0 auto;width: 92%;margin-top: 20px;">
<form class="form-inline" action="" name="frmId" id="frmId" method="post" >
	<input type="hidden" id="userDbid" name="userDbid" value="">
	<div class="form-group">
	  <label class="control-label" for="name">userId</label>
	  <input type="text" class="form-control" id="userId" name="userId" checkType="string,2,20" style="height: 50px;" onfocus="autoUser('userId')" placeholder="请输入姓名全拼音"></input> 
	</div>
	<div class="form-group" >
	  <label class="control-label" for="inputWarning1">接收人</label  >
	  <input type="text" class="form-control" readonly="readonly" id="userName" name="userName" checkType="string,2,20" style="height: 50px;">
	</div>
	<div class="form-group" >
	  <label class="control-label" for="inputWarning1">发放金额</label  >
	  <input type="text" class="form-control" id="money" name="money" checkType="integer" style="height: 50px;">
	</div>
	<div class="form-group" >
	  <label class="control-label" for="inputWarning1">备注</label  >
	  <input type="text" class="form-control" id="remark" name="remark" checkType="string,2,20"  placeholder="继续努力" value="继续努力" style="height: 50px;">
	</div>
</form>
</div>
<div class="buttomBar">
    <input type="button" name="mobileCommit" value="发送红包" id="tele_register" class="addbutton" onclick="submitFrm('frmId','${ctx}/qywxRedBag/saveSendBag')">
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
			$(id1).autocomplete("${ctx}/user/ajaxSendUser",{
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
			$("#userName").val(data.name);
			$("#userId").val(data.userId);
			$("#userDbid").val(data.dbid);
	}
</script>
</html>