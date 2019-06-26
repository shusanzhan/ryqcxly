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
input[disabled], select[disabled], textarea[disabled], input[readonly], select[readonly], textarea[readonly] {
    background-color: #F9F9F9;
    cursor: not-allowed;
}
</style>
</head>
<body>
<div id="breadcrumb">
	<a href="${ctx }/main/index" title="微商城中心" class="tip-bottom"><i
		class="icon-home"></i>微商城中心</a>
		<a href="javascript:void(-1)" class="current">
			<c:if test="${product.dbid>0 }" var="status">编辑商品</c:if>
			<c:if test="${status==false }">添加商品</c:if>
		</a>
</div>
<form action="" id="frmId" name="frmId" target="_self">
<div class="container-fluid">
	<div style="width: 100%;">
		<div style="float: left;margin-top: 10px;">
			 <table  cellpadding="0" cellspacing="0" >
				<tr>
					<td>
						<input type="text" class="input-large" placeholder="请输入会有电话号码" id="mobilePhone" name="mobilePhone" value="${param.name}" onFocus="queryByPhone('mobilePhone');" style="margin-bottom: 0;"></input>
						<input type="hidden" id="memberId" value="" name="memberId" > 
					</td>
					<td>
						<a class="btn btn-success" onclick="queryByPhone('mobilePhone');" style="margin-left: 20px;">
						<i	class="icon-search  icon-white"></i>查询</a>
					</td>
				</tr>
			 </table>
		</div>
		<div style="float: right;margin-top: 10px;line-height: 30px;margin-right: 12px;">
			<p>
				<a class="btn btn-warning" href="${ctx }/consumptionRecord/queryList">
					<i	class="icon-list icon-white"></i>历史单据</a>
			</p>
		</div>
		<div  style="clear: both;"></div>
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
										<c:forEach var="i" begin="0" step="1" end="7">
											<tr id="tr${i+1 }">
												<td style="text-align: center;">
													${i+1 }
												</td>
												<td >
													<input type="text" name="productName" id="productName${i+1 }" onFocus="autoProductByName('productName${i+1 }');create(this)"  style="width: 100%;">
													<input type="hidden" name="productDbid" id="productDbid${i+1}" onblur="create(this)" style="width: 100%;">
												</td>
												<td id="unit${i+1 }" style="text-align: center;">
													<span></span>
												</td>
												<td id="productType${i+1 }" style="text-align: center;"></td>
												<td id="cbj${i+1 }" style="text-align: center;"></td>
												<td style="text-align: center;">
													<input type="text" readonly="readonly"  name="price" id="price${i+1 }" style="width: 92%;" onfocus="count()">
												</td>
												<td>
													<input type="text" name="num" id="num${i+1 }" style="width: 92%;" onfocus="count()" onchange="count()" checkType="integer" canEmpty="Y" tip="请输入商品数量，必须为数字">
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
											<th style="width: 200px;text-align: right;" id="costPriceText">成本总价：￥0.00</th>
											<th style="width: 200px;text-align: right;" id="totalPriceText">销售总价：￥0.00</th>
											<th style="width: 80px;text-align: right;" id="totalNumText">数量：0</th>
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
											<td>无会员信息</td>
										</tr>
									</tbody>
								</table>
							</div>
						</div>
						<div class="widget-box">
							<div class="widget-title">
								<span class="icon">
									<i class="icon-file"></i>
								</span>
								<h5>消费历史记录</h5>
							</div>
							<div id="consumption" class="widget-content nopadding">
								<table class="table table-bordered">
									<thead>
										<tr>
											<th style="width: 100px;text-align: center;">消费时间</th>
											<th style="width: 80px;text-align: center;">消费金额</th>
											<th style="width: 80px;text-align: center;">商品数量</th>
										</tr>
									</thead>
									<tbody>
									<tr>
										<td colspan="3">无消费记录</td>
									</tr>
									</tbody>
								</table>
							</div>
						</div>
					</div>
				</div>
	</div>
<div class="container-fluid" style="margin-top: 0;">
	<table style="width: 100%"  >
			<tr>
				<td width="80">优惠金额</td>
				<td width="400">
					<input type="hidden" id="totalPrice" name="consumptionRecord.totalPrice" value="">
					<input type="hidden" id="totalNum" name="consumptionRecord.totalNum" value="">
					<input style="width: 80px;" type="text" id="discountAmount" name="consumptionRecord.discountAmount" value="0.00" onblur="disc()" onchange="disc()">
					<span  style="color: red;">如实收金额溢出销售总价，请在优惠金额栏填写负值。</span>
				</td>
				<td width="80">实收金额</td>
				<td width="120">
					<input type="text" style="width: 80px;" readonly="readonly" id="payInAmount" name="consumptionRecord.payInAmount" value="0.00" >
				</td>
				<td width="80">折扣率</td>
				<td width="120">
					<input readonly="readonly" style="width: 80px;" type="text" id="rateDiscount" name="consumptionRecord.rateDiscount" value="100">%
				</td>
			</tr>
			<tr>
				<td>备注</td>
				<td colspan="5">
					<textarea style="width: 92%;height: 30px;"  id="note" name="consumptionRecord.note" ></textarea>
				</td>
			</tr>
			<tr>
				<td colspan="6" align="right" style="padding-right: 12px;padding-top: 12px;">
					<a id="submit" class="btn btn-primary" href="javascript:void(-1)" onclick="submitAjaxForm('frmId','${ctx}/consumptionRecord/save')">
					<i	class="icon-ok-sign icon-white"></i>保存</a>
					<a id="submiting" class="btn btn-primary" style="display: none;" href="javascript:void(-1)">
					<i	class="icon-ok-sign icon-white"></i>正在提交...</a>
					<a id="beforePrint" class="btn"  onclick="alert('请先保存数据后打印')">
					<i	class="icon-print  icon-black"></i>打印</a>
					<a id="printButt" class="btn" style="display: none;" href="javascript:void(-1)">
					<i	class="icon-print  icon-black"></i>打印</a>
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
				+ '<input type="text"  name="price" id="price'+size+'" style="width: 92%;" onfocus="count()">'
			+ '</td>'
			+ '<td style="text-align: center;">'
			+ '<input type="text" name="num" id="num'+size+'" style="width: 92%;" onfocus="count()" checkType="integer" canEmpty="Y" tip="请输入商品数量，必须为数字">'
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
//统计成本价格\销售价格
function count(){
	var totalNum=0;
	var costPrice=0;
	var totalPrice=0;
	 $("#shopNumber").find("tr").each(function(i){
		 if(i>=1){
			 var cost=$("#cbj"+i).text();
			 var price=$("#price"+i).val();
			 var num=$("#num"+i).val();
			 if(null!=price&&price!=undefined&&price!=''&&num!=undefined&&num!=''){
				 var pric=parseFloat(price)*parseInt(num);
				 var crice=parseFloat(cost)*parseInt(num);
				 totalPrice=totalPrice+pric;
				 totalNum=totalNum+1;
				 costPrice=costPrice+crice;
			}
	 	}
	});
	$("#totalNum").val(totalNum);
	$("#totalPrice").val(totalPrice);
	$("#totalNumText").text('').text("数量："+totalNum);
	$("#costPriceText").text('').text("成本总价：￥"+costPrice+".00");
	$("#totalPriceText").text('').text("销售总价：￥"+totalPrice+".00");	
}
//计算折扣率
function disc(){
	var totalPrice= parseFloat($("#totalPrice").val());
	var discountAmount=parseFloat($("#discountAmount").val());
	var payInAmount=totalPrice-discountAmount;
	$("#payInAmount").val(payInAmount);
	var rateDiscount=payInAmount/totalPrice;
	var rate=toDecimal(rateDiscount);
	$("#rateDiscount").val(rate*100);
}
//保留小数点两位
function toDecimal(x) {  
    var f = parseFloat(x);  
    if (isNaN(f)) {  
        return;  
    }  
    f = Math.round(x*100)/100;  
    return f;  
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
							$("#submit").hide();
							$("#submiting").hide();
							$("#beforePrint").hide();
							$("#printButt").show();
							$("#printButt").bind("click",function(){
								window.location.href=data[0].url;
							})
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
