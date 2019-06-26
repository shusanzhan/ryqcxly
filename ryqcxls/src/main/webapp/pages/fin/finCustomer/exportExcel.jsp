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
<title>金融客户</title>
<style type="text/css">
	#finProductItemId{
		width: 120px;
	}
</style>
</head>
<body class="bodycolor">
<div class="location">
     	<img src="${ctx}/images/homeIcon.png"/> &nbsp;
     	<a href="javascript:void(-1);" onclick="window.parent.location.href='${ctx}/main/index'">首页</a>-
<a href="javascript:void(-1);" onclick="window.location.href='${ctx}/finCustomer/queryList'">金融客户</a>-
<a href="javascript:void(-1);">
	导出金融客户
</a>
</div>
<div class="line"></div>
<div class="frmContent" >
	<form name="searchPageForm2" id="searchPageForm2"   method="post" >
			<table border="0" align="center" cellpadding="0" cellspacing="0" style="width: 100%;">
				<tr>
					<td><label>客户状态：</label></td>
	  				<td>
	  					<select class="text midea" id="customerStatus" name="customerStatus"  >
							<option value="0" >请选择...</option>
							<option value="1" ${param.customerType==1?'selected="selected"':'' } >创建</option>
							<option value="2" ${param.customerType==2?'selected="selected"':'' } >成交</option>
							<option value="3" ${param.customerType==3?'selected="selected"':'' } >流失</option>
						</select>
	  				</td>
					<td><label>客户类型：</label></td>
	  				<td>
	  					<select class="text midea" id="customerType" name="customerType"  >
							<option value="0" >请选择...</option>
							<option value="1" ${param.customerType==1?'selected="selected"':'' } >保有</option>
							<option value="2" ${param.customerType==2?'selected="selected"':'' } >多品牌</option>
						</select>
	  				</td>
	  				<td><label>申请结果：</label></td>
	  				<td>
	  					<select class="midea text" id="applyStatus" name="applyStatus"  >
							<option value="">请选择...</option>
							<option value="1" ${param.applyStatus==1?'selected="selected"':'' } >创建</option>
							<option value="2" ${param.applyStatus==2?'selected="selected"':'' } >通过</option>
							<option value="3" ${param.applyStatus==3?'selected="selected"':'' } >失败</option>
						</select>
					</td>
	  				<td><label>放款状态：</label></td>
	  				<td>
	  					<select class="midea text" id="loanStatus" name="loanStatus"  >
							<option value="">请选择...</option>
							<option value="1" ${param.loanStatus==1?'selected="selected"':'' } >待放款</option>
							<option value="2" ${param.loanStatus==2?'selected="selected"':'' } >已放款</option>
						</select>
					</td>
				</tr>
				<tr>
					<td><label>物流出库状态：</label></td>
	  				<td>
	  					<select class="midea text" id="fileStatus" name="fileStatus"  >
							<option value="">请选择...</option>
							<option value="1" ${param.fileStatus==1?'selected="selected"':'' } >待出库</option>
							<option value="2" ${param.fileStatus==2?'selected="selected"':'' } >已出库</option>
						</select>
					</td>
					<td><label>上户状态：</label></td>
	  				<td>
	  					<select class="midea text" id="householdRegStatus" name="householdRegStatus"  >
							<option value="">请选择...</option>
							<option value="1" ${param.householdRegStatus==1?'selected="selected"':'' } >待上户</option>
							<option value="2" ${param.householdRegStatus==2?'selected="selected"':'' } >已上户</option>
						</select>
					</td>
	  				<td><label>邮寄状态：</label></td>
	  				<td>
	  					<select class="midea text" id="mailStatus" name="mailStatus"  >
							<option value="">请选择...</option>
							<option value="1" ${param.mailStatus==1?'selected="selected"':'' } >待邮寄</option>
							<option value="2" ${param.mailStatus==2?'selected="selected"':'' } >已邮寄</option>
						</select>
					</td>
	  			
	  				<td><label>贷款产品：</label></td>
	  				<td>
	  					<select id="finProductId" name="finProductId" class="text midea" onchange="ajaxFinProductItem(this.value)">
	  						<option value="-1">请选择...</option>
	  						<c:forEach var="finProduct" items="${finProducts }">
	  							<option value="${finProduct.dbid }" ${param.finProductId==finProduct.dbid?'selected="selected"':'' } >${finProduct.name }</option>
	  						</c:forEach>
	  					</select>
	  				</td>
					</tr>
					<tr>
						<td><label>贷款周期：</label></td>
		  				<td id="finProductItemTr">
		  					<select id="finProductItemId" name="finProductItemId" class="text midea" >
		  						<option value="-1">请选择...</option>
		  						<c:forEach var="finProductItem" items="${finProductItems }">
		  							<option value="${finProductItem.dbid }" ${param.finProductItemId==finProductItem.dbid?'selected="selected"':'' } >${finProductItem.name }</option>
		  						</c:forEach>
		  					</select>
		  				</td>
		  				<td><label>申请时间：</label></td>
		  				<td>
		  					<input type="text" id="startDate" name="startDate" class="text midea" value="${param.startDate}" onfocus="WdatePicker()"></input>
		  				</td>
		  				<td style="text-align:center; "><label>~</label></td>
		  				<td>
		  					<input type="text" id="endDate" name="endDate" class="text midea" value="${param.endDate}" onfocus="WdatePicker()"></input>
						</td> 
						<td><label>车型：</label></td>
		  				<td>
		  					<input type="text" id="carSeriyName" name="carSeriyName" class="text midea" value="${param.carSeriyName}"></input>
		  				</td>
		  			</tr>
		  			<tr>
						<td><label>申请人：</label></td>
		  				<td>
		  					<input type="text" id="name" name="name" class="text midea" value="${param.name}"></input></td>
		  				<td>
		  					<label>联系电话：</label></td>
		  				<td>
		  					<input type="text" id="mobilePhone" name="mobilePhone" class="text midea" value="${param.mobilePhone}"></input></td>
						<td><label>部门：</label></td>
		  				<td>
		  					<input type="text" id="dep" name="dep" class="text midea" value="${param.dep}"></input></td>
						<td><label>销售顾问：</label></td>
		  				<td>
		  					<input type="text" id="salerName" name="salerName" class="text midea" value="${param.salerName}"></input>
		  				</td>
	   			</tr>
	   			<tr>
		  				<td><label>通过日期：</label></td>
		  				<td>
		  					<input type="text" id="applyStartDate" name="applyStartDate" class="text midea" value="${param.applyStartDate}" onfocus="WdatePicker()"></input>
		  				</td>
		  				<td style="text-align:center; "><label>~</label></td>
		  				<td>
		  					<input type="text" id="applyEndDate" name="applyEndDate" class="text midea" value="${param.applyEndDate}" onfocus="WdatePicker()"></input>
						</td> 
		  				<td><label>放款日期：</label></td>
		  				<td>
		  					<input type="text" id="loanStartDate" name="loanStartDate" class="text midea" value="${param.loanStartDate}" onfocus="WdatePicker()"></input>
		  				</td>
		  				<td style="text-align:center; "><label>~</label></td>
		  				<td>
		  					<input type="text" id="loanEndDate" name="loanEndDate" class="text midea" value="${param.loanEndDate}" onfocus="WdatePicker()"></input>
						</td> 
		  			</tr>
	   			<tr>
		  				<td><label>物流归档：</label></td>
		  				<td>
		  					<input type="text" id="fileStartDate" name="fileStartDate" class="text midea" value="${param.fileStartDate}" onfocus="WdatePicker()"></input>
		  				</td>
		  				<td style="text-align:center; "><label>~</label></td>
		  				<td>
		  					<input type="text" id="fileEndDate" name="fileEndDate" class="text midea" value="${param.fileEndDate}" onfocus="WdatePicker()"></input>
						</td> 
		  				<td><label>上户日期：</label></td>
		  				<td>
		  					<input type="text" id="householdRegStartDate" name="householdRegStartDate" class="text midea" value="${param.householdRegStartDate}" onfocus="WdatePicker()"></input>
		  				</td>
		  				<td style="text-align:center; "><label>~</label></td>
		  				<td>
		  					<input type="text" id="householdRegEndDate" name="householdRegEndDate" class="text midea" value="${param.householdRegEndDate}" onfocus="WdatePicker()"></input>
						</td> 
		  			</tr>
	   			<tr>
		  				<td><label>邮寄日期：</label></td>
		  				<td>
		  					<input type="text" id="mailStartDate" name="mailStartDate" class="text midea" value="${param.mailStartDate}" onfocus="WdatePicker()"></input>
		  				</td>
		  				<td style="text-align:center; "><label>~</label></td>
		  				<td>
		  					<input type="text" id="mailEndDate" name="mailEndDate" class="text midea" value="${param.mailEndDate}" onfocus="WdatePicker()"></input>
						</td> 
		  				<td><label>核查日期：</label></td>
		  				<td>
		  					<input type="text" id="checkStartDate" name="checkStartDate" class="text midea" value="${param.checkStartDate}" onfocus="WdatePicker()"></input>
		  				</td>
		  				<td style="text-align:center; "><label>~</label></td>
		  				<td>
		  					<input type="text" id="checkEndDate" name="checkEndDate" class="text midea" value="${param.checkEndDate}" onfocus="WdatePicker()"></input>
						</td> 
		  			</tr>
	   			<tr>
		  				<td><label>归档时间：</label></td>
		  				<td>
		  					<input type="text" id="finCustomerFileStartDate" name="finCustomerFileStartDate" class="text midea" value="${param.finCustomerFileStartDate}" onfocus="WdatePicker()"></input>
		  				</td>
		  				<td style="text-align:center; "><label>~</label></td>
		  				<td>
		  					<input type="text" id="finCustomerFileEndDate" name="finCustomerFileEndDate" class="text midea" value="${param.finCustomerFileEndDate}" onfocus="WdatePicker()"></input>
						</td> 
		  			</tr>
	   		</table>
	   	</form>
	<div class="formButton">
		<a href="javascript:void(-1)"	onclick="exportExcel('searchPageForm2')"	class="but butSave">导出EXCEL</a> 
	    <a href="javascript:void(-1)"	onclick="window.history.go(-1)" class="but butCancle">取&nbsp;&nbsp;消</a>
	</div>
	</div>
</body>
<script type="text/javascript">
function exportExcel(searchFrm){
 	var params;
 	if(null!=searchFrm&&searchFrm!=undefined&&searchFrm!=''){
 		params=$("#"+searchFrm).serialize();
 	}
 	window.location.href='${ctx}/finCustomer/dowonExportExcel?'+params;
 }
function ajaxFinProductItem(val){
	if(null==val||val==''){
		alert("请选产品");
		return false;
	}
	$("#finProductItemTr").text("");
	$.post("${ctx}/finCustomer/ajaxFinProductItem?finProductId="+val+"&dateTime="+new Date(),{},function (data){
		if(data!="error"){
			$("#finProductItemTr").append(data);
		}
	});
}
</script>
</html>