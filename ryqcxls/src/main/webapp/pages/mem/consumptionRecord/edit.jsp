<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="../../commons/taglib.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html lang="en">
<head>
<title>商品添加</title>
<meta charset="UTF-8" />
<meta name="viewport" content="width=device-width, initial-scale=1.0" />
<link rel="stylesheet" href="${ctx}/css/bootstrap.min.css" />
<link href="${ctx }/widgets/easyvalidator/css/validate.css" rel="stylesheet" type="text/css" />
<link rel="stylesheet" href="${ctx}/css/bootstrap-responsive.min.css" />
<link rel="stylesheet" href="${ctx }/widgets/auto/jquery.autocomplete.css" />
<link rel="stylesheet" href="${ctx}/css/uniform.css" />
<link rel="stylesheet" href="${ctx}/css/select2.css" />
<link rel="stylesheet" href="${ctx}/css/unicorn.main.css" />
<link rel="stylesheet" href="${ctx}/css/unicorn.grey.css"	class="skin-color" />
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<style type="text/css">
textarea, input[type="text"], input[type="password"], input[type="datetime"], input[type="datetime-local"], input[type="date"], input[type="month"], input[type="time"], input[type="week"], input[type="number"], input[type="email"], input[type="url"], input[type="search"], input[type="tel"], input[type="color"], .uneditable-input {
    background-color: #F9F9F9;
    border: 1px solid #ccc;
    box-shadow: 0 0px 0px rgba(0, 0, 0, 0) inset;
    transition: border 0s linear 0s, box-shadow 0s linear 0s;
}
select, textarea, input[type="text"], input[type="password"], input[type="datetime"], input[type="datetime-local"], input[type="date"], input[type="month"], input[type="time"], input[type="week"], input[type="number"], input[type="email"], input[type="url"], input[type="search"], input[type="tel"], input[type="color"], .uneditable-input {
    border-radius: 4px;
    color: #555;
    display: inline-block;
    font-size: 14px;
    height: 20px;
    line-height: 20px;
    margin-bottom: 10px;
}
.table th, .table td {
    border-top: 0;
    border-bottom: 1px solid #ddd;
    line-height: 20px;
    padding: 2px 5px;
    text-align: left;
    vertical-align: top;
}

select, textarea, input[type="text"], input[type="password"], input[type="datetime"], input[type="datetime-local"], input[type="date"], input[type="month"], input[type="time"], input[type="week"], input[type="number"], input[type="email"], input[type="url"], input[type="search"], input[type="tel"], input[type="color"], .uneditable-input {
    border-radius: 4px;
    color: #555;
    display: inline-block;
    font-size: 14px;
    height: 24px;
    line-height: 20px;
    margin-bottom: 0;
}
textarea, input[type="text"], input[type="password"], input[type="datetime"], input[type="datetime-local"], input[type="date"], input[type="month"], input[type="time"], input[type="week"], input[type="number"], input[type="email"], input[type="url"], input[type="search"], input[type="tel"], input[type="color"], .uneditable-input {
    background-color: #f9f9f9;
    border: 1px solid #ccc;
    box-shadow: 0 0 0 rgba(0, 0, 0, 0) inset;
    transition: border 0s linear 0s, box-shadow 0s linear 0s;
}
textarea, input[type="text"], input[type="password"], input[type="datetime"], input[type="datetime-local"], input[type="date"], input[type="month"], input[type="time"], input[type="week"], input[type="number"], input[type="email"], input[type="url"], input[type="search"], input[type="tel"], input[type="color"], .uneditable-input {
    background-color: #fff;
    border: 1px solid #ccc;
    box-shadow: 0 1px 1px rgba(0, 0, 0, 0.075) inset;
    transition: border 0.2s linear 0s, box-shadow 0.2s linear 0s;
}
select, textarea, input[type="text"], input[type="password"], input[type="datetime"], input[type="datetime-local"], input[type="date"], input[type="month"], input[type="time"], input[type="week"], input[type="number"], input[type="email"], input[type="url"], input[type="search"], input[type="tel"], input[type="color"], .uneditable-input {
    border-radius: 0;
    color: #555;
    display: inline-block;
    font-size: 14px;
    height: 20px;
    line-height: 20px;
    margin-bottom: 0;
    padding:2px 0 2px 2px;
    vertical-align: middle;
}
</style>
</head>
<body>
<div id="breadcrumb">
	<a href="${ctx }/main/index" title="微商城中心" class="tip-bottom"><i
		class="icon-home"></i>微商城中心</a>
		<a href="javascript:void(-1)" class="tip-bottom">
			编辑订单
		</a>
</div>
<form action="" id="frmId" name="frmId" target="_self">
<div class="container-fluid">
	<div style="width: 100%;">
		<div style="float: left;margin-top: 10px;">
			<p>
				<a class="btn btn-danger" href="javascript:void(-1)" onclick="window.history.go(-1)">
					<i class="icon-arrow-left icon-white"></i>返回
				</a>
			</p>
		</div>
	</div>
</div>
<div class="container-fluid" style="margin-top: 0;">
		<div class="row-fluid" style="margin-top: 0;">
					<div class="span8">
						<div class="widget-box">
							<div id='te' class="widget-content nopadding" style="height: 300px;overflow: scroll;padding-bottom: 20px;">
								<table id="shopNumber" class="table table-bordered" >
									<thead>
										<tr>
											<th style="width: 30px;text-align: center;">序号</th>
											<th style="width: 200px;text-align: center;">商品名称</th>
											<th style="width: 80px;text-align: center;">单位</th>
											<th style="width: 100px;text-align: center;">类型</th>
											<th style="width: 80px;text-align: center;">成本价格</th>
											<th style="width: 60px;text-align: center;">销售价格</th>
											<th style="width: 60px;text-align: center;">数量</th>
											<th style="width: 40px;text-align: center;">操作</th>
										</tr>
									</thead>
									<tbody style="overflow: scroll;">
										<c:forEach var="consumptionProduct" items="${consumptionProducts }" varStatus="i">
											<tr id="tr${i.index+1 }">
												<td style="text-align: center;">
													${i.index+1 }
												</td>
												<td >
													<input type="text" name="productName" id="productName${i.index+1 }" onFocus="autoProductByName('productName${i.index+1 }');create(this)"  value="${consumptionProduct.nProduct.name }" style="width: 100%;">
													<input type="hidden" name="productDbid" id="productDbid${i.index+1}" onblur="create(this)" style="width: 100%;" value="${consumptionProduct.nProduct.dbid }">
												</td>
												<td id="unit${i.index+1 }" style="text-align: center;">
													<span>${consumptionProduct.nProduct.unit }</span>
												</td>
												<td id="productType${i.index+1 }" style="text-align: center;">
													${consumptionProduct.nProduct.nProductType.name }
												</td>
												<td id="cbj${i.index+1 }" style="text-align: center;">
													${consumptionProduct.nProduct.costPrice }
												</td>
												<td style="text-align: center;">
													<input type="text"  name="price" id="price${i.index+1 }" value="${consumptionProduct.price }" style="width: 92%;">
												</td>
												<td>
													<input type="text" name="num" id="num${i.index+1 }" value="${consumptionProduct.quality }" style="width: 92%;">
												</td>
												<td style="text-align: center;padding-top: 8px;">
													<a class="aedit" href="javascript:void(-1)" onclick="deleteTr(this)" >
														<i class="icon-remove icon-black" > </i>
													</a>
												</td>
											</tr>
										</c:forEach>
									</tbody>
								</table>
							</div>
							<table class="table table-bordered">
									<thead>
										<tr>
											<th style="width: 200px;text-align: center;text-align: left;" colspan="4">合计</th>
											<th style="width: 200px;text-align: right;" id="totalPriceText">总金额：$1000.00</th>
											<th style="width: 80px;text-align: right;" id="totalNumText">数量：100</th>
										</tr>
									</thead>
								</table>
						</div>
					</div>
					<div class="span4" style="margin-left: 18px;">
						<div class="widget-box">
							<div class="widget-title">
								<span class="icon">
									<i class="icon-file"></i>
								</span>
								<h5>会员信息</h5>
							</div>
							<div id="memberInfo" class="widget-content nopadding">
								<table class="table table-bordered">
									<tbody>
										<tr>
											<td>姓名:${member.name }</td>
											<td>电话:${member.mobilePhone }</td>
										</tr>
										<tr>
											<td>余额:<ystech:urlEncrypt enCode="${member.balance }"/> </td>
											<td>积分:${member.overagePiont }</td>
										</tr>
									</tbody>
								</table>
							</div>
						</div>
				</div>
	</div>
</div>
<div class="container-fluid" style="margin-top: 0;">
	<table style="width: 100%">
			<tr>
				<td>优惠金额</td>
				<td>
					<input type="hidden" id="totalPrice" name="consumptionRecord.totalPrice" value="${consumptionRecord.totalPrice }">
					<input type="hidden" id="totalNum" name="consumptionRecord.totalNum" value="${consumptionRecord.totalNum }">
					<input type="text" id="discountAmount" name="consumptionRecord.discountAmount" value="${consumptionRecord.discountAmount }">
				</td>
				<td>实收金额</td>
				<td>
					<input type="text" id="payInAmount" name="consumptionRecord.payInAmount" value="${consumptionRecord.payInAmount }" checkType="float,1" tip="请输入折扣金额">
				</td>
				<td>折扣率</td>
				<td>
					<input readonly="readonly" type="text" id=rateDiscount" name="consumptionRecord.rateDiscount" value="${consumptionRecord.rateDiscount }">%
				</td>
			</tr>
			<tr>
				<td>备注</td>
				<td colspan="5">
					<textarea style="width: 92%;height: 30px;"  id="note" name="consumptionRecord.note" >${consumptionRecord.note }</textarea>
				</td>
			</tr>
			<tr>
				<td colspan="6" align="left" style="padding-right: 12px;padding-top: 12px;">
					<a id="submit" class="btn btn-primary" href="javascript:void(-1)" onclick="submitAjaxForm('frmId','${ctx}/consumptionRecord/save')">
					<i	class="icon-ok-sign icon-white"></i>保存</a>
					<a id="submiting" class="btn btn-primary" style="display: none;" href="javascript:void(-1)">
					<i	class="icon-ok-sign icon-white"></i>正在提交...</a>
				</td>
			</tr>
	</table>
</div>
</form>
</body>
<script src="${ctx }/widgets/bootstrap3/jquery.min.js"></script>
<script src="${ctx }/widgets/bootstrap3/jquery.ui.custom.js"></script>
<script src="${ctx }/widgets/bootstrap3/bootstrap.min.js"></script>
<script src="${ctx }/widgets/bootstrap3/jquery.uniform.js"></script>
<script src="${ctx }/widgets/bootstrap3/select2.min.js"></script>
<script src="${ctx }/widgets/bootstrap3/unicorn.js"></script>
<script type="text/javascript" src="${ctx }/widgets/easyvalidator/js/jquery.bgiframe.min.js"></script>
<script type="text/javascript" src="${ctx }/widgets/easyvalidator/js/easy_validator.pack2.js"></script>
<script type="text/javascript" src="${ctx }/widgets/artDialog/artDialog.js?skin=default"></script>
<script type="text/javascript" src="${ctx }/widgets/artDialog/plugins/iframeTools.source.js"></script>
<script type="text/javascript" src="${ctx }/widgets/utile/utile.js"></script>
<script type="text/javascript"	src="${ctx}/widgets/auto/jquery.autocomplete.js"></script>
<script type="text/javascript">
/**功能描述：客户资料查询**/
function queryByPhone(val){
	$("#"+val).autocomplete("${ctx}/member/ajaxQueryByMobile",{
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
	       return "<span>姓名："+row.name+"&nbsp;&nbsp;电话号码： "+row.mobilePhone+"&nbsp;&nbsp; 余额："+row.balance+"&nbsp;&nbsp; </span>";   
	    },   
	    formatMatch: function(row, i, total) {   
	       return row.name;    
	    },   
	    formatResult: function(row) {   
	       return row.name;   
	    }		
	});
	$("#"+val).result(getReuslt);
}
function getReuslt(event, data, formatted) {
	$("#memberId").val(data.dbid);
	$("#mobilePhone").val(data.mobilePhone);
	$("#memberInfo").text("");
	$("#memberInfo").append(data.memberInfo);
	$.post("${ctx}/consumptionRecord/ajaxByMemberId?memberId="+data.dbid,{},function(data2){
		$("#consumption").text("");
		$("#consumption").append(data2);
	})
}

//商品表格编辑部分
function create(v){
	var value=$(v).val();
	if(null==value||value.length<=0){
		return ;
	}
	var id=$(v).parent().parent().attr("id");
	if(id==$("#shopNumber tr").last().attr("id")){
		crateTr();
		$("#te").scrollTop($("#shopNumber")[0].scrollHeight);
	}
}
function deleteTr(tr) {
	// 删除规格值
	if ($("#shopNumber").find("tr").size() <= 2) {
		$.utile.tips("必须至少保留一个规格值", 1);
		return;
	} else {
		var dd = $(tr).parent().parent();
		$(dd).remove();
		 $("#shopNumber").find("tr").each(function(i){
			 if(i>=1){
				 $(this).find(':first').text('').text(i);
		 	}
		});
		//计算总金额、总数量
		count();
	}
}
function crateTr() {
	var size = $("#shopNumber").find("tr").size();
	size = size;
	var str = ' <tr id="tr'+size+'">'
			+'<td style="text-align: center;">'+size+'</td>'
			+ '<td style="text-align: left;">'
			+ '<input type="text"  name="productName" id="productName'+size+'" value="" style="width: 100%;" onFocus=\'autoProductByName("productName'+size+'");create(this)\'/>'
			+ '<input type="hidden" name="productDbid" id="productDbid'+size+'" value="">'
			+ '</td>'
			+'<td id="unit'+size+'" style="text-align: center;">'
			+'<span></span>'
			+'</td>'
			+ '<td id="productType'+size+'" style="text-align: center;">'
			+ '</td>'
			+ '<td id="cbj'+size+'" style="text-align: center;">'
			+ '</td>'
			+ '<td  style="text-align: center;">'
				+ '<input type="text"  name="price" id="price'+size+'" style="width: 92%;">'
			+ '</td>'
			+ '<td style="text-align: center;">'
			+ '<input type="text" name="num" id="num'+size+'" style="width: 92%;">'
			+ '</td>'
			+ '<td align="center" style="text-align: center;padding-top:8px;">'
			+ '<a class="aedit" href="javascript:void(-1)" onclick="deleteTr(this)"><i class="icon-remove icon-black"></i></a>'
			+ '</td>' + '</tr>';
	$("#shopNumber").append(str);
}

function autoProductByName(id){
	var id1 = "#"+id;
		$(id1).autocomplete("${ctx}/nProduct/autoProduct",{
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
		       return "<span>名称："+row.name+"&nbsp;&nbsp;序号： "+row.sn+"&nbsp;&nbsp;价格："+row.price+"&nbsp;&nbsp; 单位："+row.unit+"&nbsp;&nbsp; </span>";   
		    },   
		    formatMatch: function(row, i, total) {   
		       return row.name;   
		    },   
		    formatResult: function(row) {   
		       return row.name;   
		    }		
		});
	$(id1).result(onRecordSelect);
	//计算总金额
	count()
}
function onRecordSelect(event, data, formatted) {
		var id=$(event.currentTarget).attr("id");
		var sn=id.substring(11,id.length);
		$("#productName"+sn).val(data.name);
		$("#productDbid"+sn).val(data.dbid);
		$("#unit"+sn).text("");
		$("#unit"+sn).append("<span>"+data.unit+"</span>");
		$("#productType"+sn).text("");
		$("#productType"+sn).text(data.typeName);
		$("#cbj"+sn).text("");
		$("#cbj"+sn).text(data.costPrice);
		$("#price"+sn).val(data.price);
		$("#num"+sn).val(1);
		//decorePrice();
		
	}

function count(){
	var totalNum=0;
	var totalPrice=0;
	 $("#shopNumber").find("tr").each(function(i){
		 if(i>=1){
			 var price=$("#price"+i).val();
			 if(null!=price&&price!=undefined&&price!=''){
				 totalPrice=totalPrice+parseInt(price);
				 totalNum=totalNum+1;
			}
	 	}
	});
	$("#totalNum").val(totalNum);
	$("#totalPrice").val(totalPrice);
	
	$("#totalNumText").text('').text("数量："+totalNum);
	$("#totalPriceText").text('').text("总金额：$"+totalPrice+".00");	
}

 function submitAjaxForm(frmId, url, state) {
	var target = $("#" + frmId).attr("target") || "_self";
	try {
		if (undefined != frmId && frmId != "") {
			var validata = validateForm(frmId);
			if (validata == true) {
				var params = getParam(frmId, state);
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
							$.utile.tips(obj[0].message);
							$("#submit").show();
							$("#submiting").hide();
							return ;
						}else if(obj[0].mark==0){
							$.utile.tips(data[0].message);
							if (target == "_self") {
								setTimeout(
										function() {
											window.location.href = obj[0].url
										}, 1000);
							}
							if (target == "_parent") {
								// 同时关闭弹出窗口
								var parent = window.parent;
								window.parent.frames["contentUrl"].location=obj[0].url;
							}
							// 保存数据成功时页面需跳转到列表页面
						}
					},
					complete : function(jqXHR, textStatus){
						$("#submit").show();
						var jqXHR=jqXHR;
						var textStatus=textStatus;
					}, 
					beforeSend : function(jqXHR, configs){
						$("#submit").hide();
						$("#submiting").show();
						var jqXHR=jqXHR;
						var configs=configs;
					}, 
					error : function(jqXHR, textStatus, errorThrown){
							$.utile.tips("系统请求超时");
							$("#submit").show();
							$("#submiting").hide();
					}
				});
			} else {
				return;
			}
		} else {
			return;
		}
	} catch (e) {
		$.utile.tips(e);
		return;
	}
}

</script>
</html>
