<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="../../commons/taglib.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html lang="en">
<head>
<title>奇瑞私人档案信息填写页面</title>
<meta charset="UTF-8" />
<meta name="viewport" content="width=device-width, initial-scale=1.0" />
<link href="${ctx }/css/common.css" type="text/css" rel="stylesheet">
<link  href="${ctx }/widgets/easyvalidator/css/validate.css" rel="stylesheet" type="text/css" />
<script type="text/javascript" src="${ctx }/widgets/bootstrap3/jquery.min.js"></script>
<script type="text/javascript" src="${ctx }/widgets/utile/utile.js"></script>
<script type="text/javascript" src="${ctx }/widgets/easyvalidator/js/jquery.bgiframe.min.js"></script>
<script type="text/javascript" src="${ctx }/widgets/easyvalidator/js/easy_validator.pack.js"></script>
<script src="${ctx }/widgets/jqueryui/jquery.ui.core.js"></script>
<script src="${ctx }/widgets/jqueryui/jquery.ui.widget.js"></script>
<script src="${ctx }/widgets/jqueryui/jquery.ui.tabs.js"></script>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<style type="text/css">
	.butSave{
	}
	.butSave:VISITED {
		color: #FFF;
}
#areaLabel{
}
#areaLabel select{
	width: 80px;
}
#artBuyCarExperise{
	width: 100%;
}
#artBuyCarExperise tr{
	height: 40px;
}
.bar {
    background-color: #eff7ff;
    border-bottom: 1px solid #d7e8f8;
    height: 30px;
    line-height: 30px;
}
.bar a {
    color: #666666;
    text-decoration: none;
    font-size: 14px;
    font-family: '宋体';
}
</style>
</head>
<body class="bodycolor">
<c:if test="${!empty(customerFile) }">
	<div class="bar">
		<a href="${ctx }/customerFile/print?customerId=${customer.dbid}" id="print" class="btn btn-success " style="margin-left: 5px;">打 印</a>
		<a href="javascript:;" id="print" class="btn btn-success " onclick="window.history.go(-1)" style="margin-left: 5px;">返回</a>
	</div>
</c:if>
<table cellpadding="0" cellspacing="0" border="0" style="margin-top: 5px;width: 100%">
		<tr height="50">
			<td class="noLine" style="text-align: center;font-size: 18px;font-weight: bold;border: 0px solid #000000;width: 160px;">表1—奇瑞公司客户档案登记表（个人） </td>
		</tr>
	</table>
<div id="frmContent" class="frmContent">
   <form class="form-horizontal" method="post" action="" name="frmId" id="frmId">
   <input type="hidden" value="${ customerFile.dbid}" id="dbid" name="customerFile.dbid">
   <input type="hidden" value="${ customer.dbid}" id="customerId" name="customerId">
   <input type="hidden" value="1" id="custType" name="customerFile.custType">
   <div id="baseInfor">
   	 <div class="frmTitle" onclick="showOrHiden('contactTable')">基础档案</div>
   		<table border="0" align="center" cellpadding="0" cellspacing="0" style="width: 98%;">
			<tr>
				<td class="formTableTdLeft">编号 ：</td>
				<td>
					<input type="text" readonly="readonly"  class="largeX text" name="" id="sn"  value="${customer.sn}" checkType="string,1,20" canEmpty="Y"/>
					<span style="color: red;">*</span>
				</td>
				<td class="formTableTdLeft">填表时间：</td>
				<c:if test="${empty(customerFile) }">
					<td>
						<input type="text" readonly="readonly"  class="largeX text" name="customerFile.createDate" id="createDate" value="<fmt:formatDate value="${now }"/>"   checkType="string,1,20" tip="请选择填表时间" onFocus="WdatePicker({isShowClear:false,readOnly:true})"/>
						<span style="color: red;">*</span>
					</td>
				</c:if>
				<c:if test="${!empty(customerFile) }">
					<td>
						<input type="text" readonly="readonly"  class="largeX text" name="customerFile.createDate" id="createDate" value="<fmt:formatDate value="${customerFile.createDate }"/>"   checkType="string,1,20" tip="请选择填表时间" onFocus="WdatePicker({isShowClear:false,readOnly:true})"/>
						<span style="color: red;">*</span>
					</td>
				</c:if>
			</tr>
			<tr>
				<td class="formTableTdLeft" >车辆底盘号：</td>
				<td id="carModelLabel">	
					<input type="text" readonly="readonly" class="largeX text" name="" id=""  value="${customer.customerPidBookingRecord.vinCode }" checkType="string,1,20" tip="车辆底盘号不能为空" />
					<span style="color: red;">*</span>
				</td>
				<c:set value="${customer.customerBussi.brand.name }${customer.customerBussi.carSeriy.name}${ customer.customerBussi.carModel.name }" var="carModel"></c:set>
				<td class="formTableTdLeft">车型：</td>
				<td >
					<input type="text" readonly="readonly" class="largeX text" name="" id="carModel"  value="${carModel}  ${customer.carModelStr}" checkType="string,1" tip="车型不能为空" />
					<span style="color: red;">*</span>
				</td>
			</tr>
			<tr>
				<td class="formTableTdLeft">颜色：</td>
				<td>
					<input type="text" readonly="readonly"  class="largeX text"  id="color"  value="${customer.customerPidBookingRecord.carColor.name }" checkType="string,1" tip="颜色不能为空"/>
				    <span style="color: red;">*</span>
				</td>
				<td class="formTableTdLeft">销售员：</td>
				<td colspan="1">
					<input readonly="readonly" name="" class="largeX text" id=buffStaff title="" value="${customer.bussiStaff}" ></input>
				</td>
			</tr>
			<tr>
				<td class="formTableTdLeft">服务商类型：</td>
				<td>
					<c:if test="${empty(customer.distributor) }">
						<input type="text" readonly="readonly"  class="largeX text"  id=""  value="一级销售服务商"/>
					</c:if>
					<c:if test="${!empty(customer.distributor) }">
						<input type="text" readonly="readonly"  class="largeX text"  id=""  value="二级销售服务商" />
					</c:if>
				</td>
				<td class="formTableTdLeft">名称：</td>
				<td colspan="1">
					<input readonly="readonly" name="" class="largeX text" id=buffStaff title="" value="${customer.department.name}" ></input>
				</td>
			</tr>
		</table>
   	   <div class="frmTitle" onclick="showOrHiden('contactTable')">客户基本信息</div>
   	    <table border="0" align="center" cellpadding="0" cellspacing="0" style="width: 98%;">
			<tr>
				<td class="formTableTdLeft">姓名：</td>
				<td>
					<input  type="text" class="mideaX text" readonly="readonly" name="" id="name"  value="${customer.name }" checkType="string,1" tip="请输入客户姓名！"/>
						<label><input type="radio" name="customer.sex" id="sex" value="男" ${customer.sex=='男'?'checked="checked"':'' } >男</label>
						<label><input type="radio" name="customer.sex" id="sex" value="女" ${customer.sex=='女'?'checked="checked"':'' }>女</label>
					<span style="color: red;">*</span>
				</td>
				 <td class="formTableTdLeft">婚姻状况：</td>
				<td>
					<c:if test="${empty(customerFile) }">
						<label><input type="radio" name="customerFile.marryStatus" id="marryStatus" value="2" checked="checked">未婚</label>
						<label><input type="radio" name="customerFile.marryStatus" id="marryStatus" value="1" >已婚</label>
					</c:if>
					<c:if test="${!empty(customerFile)}">
						<label><input type="radio" name="customerFile.marryStatus" id="marryStatus" value="1" ${customerFile.marryStatus==1?'checked="checked"':'' }>已婚</label>
						<label><input type="radio" name="customerFile.marryStatus" id="marryStatus" value="2" ${customerFile.marryStatus==2?'checked="checked"':'' }>未婚</label>
					</c:if>
					<span style="color: red;">*</span>
				</td> 
		</tr>
		<tr>
				<td class="formTableTdLeft">年龄：</td>
				<td colspan="1">
						<select id="customerFileAge" name="age" class="largeX text" checkType="integer,1"  tip="请选择年龄">
						<option value="">请选择...</option>
							<option value="1" ${customerFile.age==1?'selected="selected"':'' } >20岁以下</option>
							<option value="2" ${customerFile.age==2?'selected="selected"':'' } >21-25岁</option>
							<option value="3" ${customerFile.age==3?'selected="selected"':'' } >26-30岁</option>
							<option value="4" ${customerFile.age==4?'selected="selected"':'' } >31-35岁</option>
							<option value="5" ${customerFile.age==5?'selected="selected"':'' } >36-40岁</option>
							<option value="6" ${customerFile.age==6?'selected="selected"':'' } >41-45岁</option>
							<option value="7" ${customerFile.age==7?'selected="selected"':'' } >45岁以上</option>
					</select>
					<span style="color: red;">*</span>
				</td>
				<td class="formTableTdLeft">家庭人数：</td>
				<td>
						<select id="familyNumberId" name="familyNumberId" class="largeX text" checkType="integer,1"  tip="请选择家庭人数">
						<option value="">请选择...</option>
							<c:forEach items="${familyNumbers }" var="familyNumber">
								<option value="${familyNumber.dbid }" ${customerFile.familyNumber.dbid==familyNumber.dbid?'selected="selected"':'' } >${familyNumber.name }</option>
							</c:forEach>
					</select>
					<span style="color: red;">*</span>
				</td>
		</tr>
		<tr>
				<td class="formTableTdLeft">学历：</td>
				<td>
						<select id="educationalId" name="educationalId" class="largeX text" checkType="integer,1"  tip="请选择学历">
						<option value="">请选择...</option>
						<c:forEach var="educational" items="${educationals }">
							<option value="${educational.dbid}" ${customer.educational.dbid==educational.dbid?'selected="selected"':'' } >${educational.name }</option>
						</c:forEach>
					</select>
					<span style="color: red;">*</span>
				</td>
				<td class="formTableTdLeft" style="width: 140px;">家庭税前年收入：</td>
				<td>
					<select id="yearFamilyIncomeId" name="yearFamilyIncomeId" class="largeX text" checkType="integer,1"  tip="请选择家庭税前年收入">
						<option value="">请选择...</option>
						<c:forEach var="yearFamilyIncome" items="${yearFamilyIncomes }">
							<option value="${yearFamilyIncome.dbid }" ${customerFile.yearFamilyIncome.dbid==yearFamilyIncome.dbid?'selected="selected"':'' } >${yearFamilyIncome.name }</option>
						</c:forEach>
					</select>
					<span style="color: red;">*</span>
				</td>
			</tr>
			<tr>
				<td class="formTableTdLeft">行业：</td>
				<td>
						<select id="industryId" name="industryId" class="largeX text" checkType="integer,1"  tip="请选择车辆类型">
						<option value="">请选择...</option>
						<c:forEach var="industry" items="${industries }">
							<option value="${industry.dbid }" ${customer.industry.dbid==industry.dbid?'selected="selected"':'' } >${industry.name }</option>
						</c:forEach>
					</select>
					<span style="color: red;">*</span>
				</td>
				<td class="formTableTdLeft">具体职业：</td>
				<td>
					<input name="customerFile.industryNote"  class="largeX text" id="industryNote" title="具体职业"  value="${customerFile.industryNote }" checkType="string,1,255" tip="请填写小于255字符"></input>
					<span style="color: red;">*</span>
				</td>
			</tr>
				<tr>
					<td>
						现居住地类型：
					</td>
					<td>
						<select name="customerFile.nowJuzuType" id="nowJuzuType" class="largeX text" checkType="integer,1" tip="请选择居住类型">
							<option value="">请选择...</option>
							<option value="1" ${customerFile.nowJuzuType==1?'selected="selected"':'' } >城镇  </option>
							<option value="2" ${customerFile.nowJuzuType==2?'selected="selected"':'' } >农村 </option>
						</select>
						<span style="color: red;">*</span>
					</td>
					
					<td class="formTableTdLeft">兴趣爱好：</td>
					<td  colspan="3">
						<select class="largeX text" name="interestId" id="interestId" checkType="integer,1"  tip="请选择车辆类型">
							<option value="0" >请选择</option>
							<c:forEach var="interest" items="${interests }">
								<option value="${interest.dbid }" ${customer.interest.dbid==interest.dbid?'selected="selected"':'' } >${interest.name }</option>
							</c:forEach>
						</select>
						<span style="color: red;">*</span>
					</td>
				</tr>
				<tr>
				<td class="formTableTdLeft" >驾龄：</td>
					<td>
							<select id="" class="largeX text" name="drivingAgeId" id="driverAgeId" checkType="integer,1"  tip="请选择车辆类型">
							<option value="0" >请选择</option>
							<c:forEach items="${drivingAges }" var="drivingAge">
								<option value="${drivingAge.dbid }" ${customerFile.drivingAge.dbid==drivingAge.dbid?'selected="selected"':'' } >${drivingAge.name }</option>
							</c:forEach>
						</select>
						<span style="color: red;">*</span>
					</td>
			</tr>
		</table>
   	   <div class="frmTitle" onclick="showOrHiden('contactTable')">联系方式</div>
	   <table border="0" align="center" cellpadding="0" cellspacing="0" style="width: 98%;">
	   		<tr>
				<td class="formTableTdLeft">证件信息：</td>
				<td>
						<input readonly="readonly" type="text" class="largeX text"   value="${customer.paperwork.name }" />
						<span style="color: red;">*</span>
				</td>
				<td class="formTableTdLeft">证件号码：</td>
				<td>
						<input type="text"  readonly="readonly" class="largeX text"  value="${customer.icard }" />
						<span style="color: red;">*</span>	
				</td>
			</tr>
			<tr>
				<td class="formTableTdLeft">身份证地址：</td>
					<td colspan="1">
						<input readonly="readonly"   class="largeX text" id=address title="" value="${customer.area.fullName}${customer.address }" ></input>
					</td>
				<td class="formTableTdLeft">居住证客户：</td>
				<td colspan="">
						<select name="customerFile.residencePermit" id="residencePermit" onchange="showOrHiden(this.value)" class="largeX text" checkType="integer,1" tip="请选择居住类型">
						 	<option value="0">请选择...</option>
							<option value="1" ${customerFile.residencePermit==1?'selected="selected"':'' } >是  </option>
							<option value="2" ${customerFile.residencePermit==2?'selected="selected"':'' } >否 </option>
						</select>
						<span style="color: red;">*</span>
					</td>
			</tr>
			<c:if test="${empty(customerFile) }">
				<tr id="residencePermitAddressTr"  style="display: none;">
					<td class="formTableTdLeft">居住证区域：</td>
					<td id="areaLabel">
							<input type="hidden" name="areaId" value="" id="areaId" >
								<select id="areoD" name="areoD" class="small text" onchange="ajaxArea(this)" checkType="integer,1" tip="请选择省份">
									<option>请选择...</option>
									<c:forEach items="${areas }" var="area">
										<option  value="${area.dbid }">${area.name }</option>
									</c:forEach>
								</select>
							<span style="color: red;">*</span>
						</td>
						<td class="formTableTdLeft">居住证地址：</td>
						<td>
							<input  name="customerFile.residencePermitAddress" class="largeX text" id=residencePermitAddress title="" value="" placeholder="请输入街道地址" checkType="string,1" tip="请输入街道地址"></input>
							<span style="color: red;">*</span>
						</td>
					</tr>
			</c:if>
			
			<c:if test="${customerFile.residencePermit==1 }">
				<tr id="residencePermitAddressTr"  >
					<td class="formTableTdLeft">居住证区域：</td>
					<td id="areaLabel">
							<input type="hidden" name="areaId" value="${customerFile.area.dbid }" id="areaId" >
							<c:if test="${empty(areaSelect) }">
								<select id="areoD" name="areoD" class="small text" onchange="ajaxArea(this)" checkType="integer,1" tip="请选择省份">
									<option>请选择...</option>
									<c:forEach items="${areas }" var="area">
										<option  value="${area.dbid }">${area.name }</option>
									</c:forEach>
								</select>
							</c:if>
							<c:if test="${!empty(areaSelect) }">
								${areaSelect }
							</c:if>
							<span style="color: red;">*</span>
						</td>
						<td class="formTableTdLeft">居住证地址：</td>
						<td>
							<input  name="customerFile.residencePermitAddress" class="largeX text" id=residencePermitAddress title="" value="${customerFile.residencePermitAddress }" placeholder="请输入街道地址" checkType="string,1" tip="请输入街道地址"></input>
							<span style="color: red;">*</span>
						</td>
					</tr>
			</c:if>
			<c:if test="${customerFile.residencePermit==2 }">
				<tr id="residencePermitAddressTr"  style="display: none;">
					<td class="formTableTdLeft">居住证区域：</td>
					<td id="areaLabel">
							<input type="hidden" name="areaId" value="" id="areaId" >
								<select id="areoD" name="areoD" class="small text" onchange="ajaxArea(this)" checkType="integer,1" tip="请选择省份">
									<option>请选择...</option>
									<c:forEach items="${areas }" var="area">
										<option  value="${area.dbid }">${area.name }</option>
									</c:forEach>
								</select>
							<span style="color: red;">*</span>
						</td>
						<td class="formTableTdLeft">居住证地址：</td>
						<td>
							<input  name="customerFile.residencePermitAddress" class="largeX text" id=residencePermitAddress title="" value="" placeholder="请输入街道地址" checkType="string,1" tip="请输入街道地址"></input>
							<span style="color: red;">*</span>
						</td>
					</tr>
			</c:if>
	   		<tr>
	   			<td class="formTableTdLeft">常用手机号：</td>
				<td>
						<input type="text" class="largeX text" readonly="readonly" name="customer.mobilePhone" id="mobilePhone"  value="${customer.mobilePhone }" checkType="mobilePhone"  tip="请输入常用手机号！常用手机号格式如：1870****883"/>
					<span style="color: red;">*</span>
				</td>
				<td class="formTableTdLeft">家用电话：</td>
				<td>
					<input type="text" class="largeX text" name="customer.phone" id="phone"  value="${customer.phone }" checkType="string,1,20" canEmpty="Y" tip="请输入家用电话或手机号码，可以为空家用电话格式如：028-62312332"/>
				</td>
	   		</tr>
	   		<tr>
	   			<td class="formTableTdLeft">紧急联系人：</td>
				<td>
						<input type="text" class="largeX text"  name="customerFile.emergencyName" id="emergencyName"  value="${customerFile.emergencyName }" />
					<span style="color: red;">*</span>
				</td>
				<td class="formTableTdLeft">紧急联系方式：</td>
				<td>
					<input type="text" class="largeX text" name="customerFile.emergencyContactWay" id="emergencyContactWay"  value="${customerFile.emergencyContactWay }" />
				</td>
	   		</tr>
	   		<tr>
					<td class="formTableTdLeft">email：</td>
					<td>
						<input type="text"   class="largeX text" name="email" id="email" value="${customer.email }" checkType="email" canEmpty="Y" tip="请输入email！可以为空">
					</td>
					
					<td class="formTableTdLeft">QQ：</td>
					<td>
						<input type="text"   class="largeX text" name="qq" id="qq" value="${customer.qq }" checkType="qq" canEmpty="Y" tip="请输入QQ！可以为空">
					</td>
			</tr>
			
	   	</table>
	  	<div class="frmTitle" onclick="showOrHiden('contactTable')">购车信息</div>
	   <table border="0" align="center" cellpadding="0" cellspacing="0" style="width: 98%;">
			<tr>
				<td class="formTableTdLeft">开发票日期：</td>
				<td >
						<c:if test="${empty(customerFile) }">
							<input type="text"  readonly="readonly" class="largeX text" name="customerFile.kpDate" id="kpDate" value="<fmt:formatDate value="${customer.customerPidBookingRecord.modifyTime }"/>" onFocus="WdatePicker({isShowClear:false,readOnly:true})"  checkType="string,1"  tip="请输入发票日期不能为空！">
						</c:if>
						<c:if test="${!empty(customerFile) }">
							<input type="text"  readonly="readonly" class="largeX text" name="customerFile.kpDate" id="kpDate" value="<fmt:formatDate value="${customerFile.kpDate }"/>" onFocus="WdatePicker({isShowClear:false,readOnly:true})"  checkType="string,1"  tip="请输入发票日期不能为空！">
						</c:if>
						<span style="color: red;">*</span>
				</td>
				<td class="formTableTdLeft">发票号：</td>
				<td>
						<input type="text" readonly="readonly" class="largeX text"  name="" id="" value="${outboundOrder.faPiaoHao }"  checkType="string,8,8"  placeholder="请输入发票号"  tip="请输入发票号不能为空！"/>
						<span style="color: red;">*</span>
				</td>
			</tr>
			<tr>
				<td class="formTableTdLeft">使用人：</td>
				<td>
					<select id="buyCarMainUseId" name="buyCarMainUseId" class="largeX text" checkType="integer,1">
						<option value="">请选择....</option>
						<c:forEach var="buyCarMainUse" items="${buyCarMainUses }">
							<option value="${buyCarMainUse.dbid }" ${buyCarMainUse.dbid==customer.customerBussi.buyCarMainUse.dbid?'selected="selected"':'' }>${buyCarMainUse.name }</option>
						</c:forEach>
					</select>
					<span style="color: red;">*</span>
				</td>
				<td class="formTableTdLeft">车牌号：</td>
				<td >
					<input type="text" class="largeX text"  name="carPlate" id="carPlate"  value="${customer.customerLastBussi.carPlateNo }" />
				</td>
			</tr>
			<tr>
				<td class="formTableTdLeft">交车日期：</td>
				<td>
					<c:if test="${empty(customerFile) }">
						<input type="text" readonly="readonly" class="largeX text"  name="customerFile.jcDate" id="jcDate" value="<fmt:formatDate value="${customer.customerPidBookingRecord.modifyTime }"/>" checkType="string,1"  onFocus="WdatePicker({isShowClear:false,readOnly:true})"/><span style="color: red;">*</span>
					</c:if>
					<c:if test="${!empty(customerFile) }">
						<input type="text" readonly="readonly" class="largeX text"  name="customerFile.jcDate" id="jcDate" value="<fmt:formatDate value="${customerFile.jcDate }"/>" checkType="string,1"  onFocus="WdatePicker({isShowClear:false,readOnly:true})"/><span style="color: red;">*</span>
					</c:if>
				</td>
				<td class="formTableTdLeft"    >是否特销：</td>
				<td >
					<select class="largeX text" name="specialPanId" id="specialPanId" checkType="integer,1" tip="请选择是否特销">
							<option value="0">请选择...</option>
							<c:forEach var="specialPan" items="${specialPans }">
								<option value="${specialPan.dbid }" ${customerFile.specialPlan.dbid==specialPan.dbid?'selected="selected"':'' } >${specialPan.name }</option>
							</c:forEach>
					</select>
					<span style="color: red;">*</span>
				</td>
			</tr>
			<tr>
				<td class="formTableTdLeft">购车价格：</td>
				<td>
						<input type="text" readonly="readonly" class="largeX text"  name="invoicePrice" id="price"  value="${outboundOrder.invoicePrice }" checkType="float,1" placeholder="请输入购车价格"  tip="购车价格不能为空,请输入购车价格！"/>
						<span style="color: red;">*</span>
				</td>
				<td class="formTableTdLeft">付款方式：</td>
				<td >
					<c:if test="${orderContractExpenses.buyCarType==1 }">
						<input type="text" readonly="readonly"  class="largeX text"  id=""  value="一次付清"/>
					</c:if>
					<c:if test="${orderContractExpenses.buyCarType==2 }">
						<input type="text" readonly="readonly"  class="largeX text"  id=""  value="分期付款" />
					</c:if>
					<span style="color: red;">*</span>
				</td>
			</tr>
			<!-- 为贷款购车时 ，显示如下明细 -->
			 <c:if test="${orderContractExpenses.buyCarType==2}">
				<tr>
						<td class="formTableTdLeft">贷款渠道：</td>
						<td >
							<select name="customerFile.loanInfrom" id="loanInfrom" class="largeX text" checkType="string,1" tip="请选择贷款渠道">
								<option value="0">请选择...</option>
								<option value="金融公司" ${customerFile.loanInfrom=='金融公司'?'selected="selected"':'' } >金融公司</option>
								<option value="工行" ${customerFile.loanInfrom=='工行'?'selected="selected"':'' } >工行</option>
								<option value="建行" ${customerFile.loanInfrom=='建行'?'selected="selected"':'' } >建行</option>
								<option value="农行" ${customerFile.loanInfrom=='金融公司'?'selected="selected"':'' } >农行</option>
								<option value="其他" ${customerFile.loanInfrom=='其他'?'selected="selected"':'' } >其他</option>
							</select>
							<span style="color: red;">*</span>
						</td>
						<td class="formTableTdLeft">贷款渠道备注：</td>
						<td >
							<input type="text" class="largeX text"  name="customerFile.loanNote" id="loanNote"  value="${customerFile.loanNote }" />
						</td>
				</tr>
				<tr>
						<td class="formTableTdLeft">贷款方案：</td>
						<td >
							<select name="customerFile.loanPlan" id="loanPlan" class="largeX text" checkType="string,1" tip="请选择贷款渠道">
								<option value="0">请选择...</option>
								<option value="1年0利率" ${customerFile.loanPlan=='1年0利率'?'selected="selected"':'' } >1年0利率</option>
								<option value="2年低利率" ${customerFile.loanPlan=='2年低利率'?'selected="selected"':'' } >2年低利率</option>
								<option value="其他" ${customerFile.loanPlan=='其他'?'selected="selected"':'' } >其他</option>
							</select>
							<span style="color: red;">*</span>
						</td>
						<td class="formTableTdLeft">贷款方案备注：</td>
						<td >
							<input type="text" class="largeX text"  name="customerFile.loanPlanNote" id="loanPlanNote"  value="${customerFile.loanPlanNote }" />
						</td>
				</tr>
			</c:if>
			  <tr>
				<td class="formTableTdLeft">初次级别：</td>
				<td>
						<input type="text" readonly="readonly" class="largeX text"  name="firstCustomerPhase" id="firstCustomerPhase"  value="${customer.firstCustomerPhase.name }" checkType="string,1,20" tip="请填写初次到店级别"/>
						<span style="color: red;">*</span>
				</td>
				<td class="formTableTdLeft">信息获取渠道：</td>
				<td >
					<select id="infoFromId" name="infoFromId" class="largeX text" checkType="integer,1" tip="请选择客户来源！">
						<option value="">请选择...</option>
						<c:forEach var="infoFrom" items="${infoFroms }">
								<option value="${infoFrom.dbid }" ${customerFile.infoFrom.dbid==infoFrom.dbid?'selected="selected"':''} >${infoFrom.name }(${infoFrom.type })</option>
						</c:forEach>
					</select>
					<span style="color: red;">*</span>
				</td>
			</tr> 
			
			<tr>
			    <td class="formTableTdLeft">车辆性质：</td>
				<td>
						<select class="largeX text" name="carNatureId" id="carNatureId" checkType="integer,1"  tip="请选择车辆性质">
							<option value="0" >请选择</option>
							<c:forEach var="carNatrue" items="${carNatrues }">
								<option value="${carNatrue.dbid }" ${customerFile.carNature.dbid==carNatrue.dbid?'selected="selected"':'' } >${carNatrue.name }</option>
							</c:forEach>
						</select>
						<span style="color: red;">*</span>
				</td>
				<td class="formTableTdLeft">购车经历：</td>
				<td>
					<select id="buyCarExperiseId" name="buyCarExperiseId" class="largeX text" checkType="integer,1"  tip="请选择购车经历" onchange="showBuyCarExp(this.value)">
						<option value="">请选择...</option>
							<c:forEach var="buyCarEmperise" items="${buyCarEmperises }">
								<option value="${buyCarEmperise.dbid }" ${customerFile.buyCarExperise.dbid==buyCarEmperise.dbid?'selected="selected"':'' } >${buyCarEmperise.name }</option>
							</c:forEach>
					</select>
					<span style="color: red;">*</span>
				</td>
			</tr>
			<tr>
				<td class="formTableTdLeft">购车用途：</td>
				<td>
					<select class="largeX text" name="buyCaruse" id="buyCaruse" checkType="integer,1"  tip="请选择车辆性质">
						<option value="0" >请选择</option>
						<c:forEach var="buyCarTarget" items="${buyCarTargets }">
							<option value="${buyCarTarget.dbid }" ${customerFile.buyCaruse==buyCarTarget.dbid?'selected="selected"':'' } >${buyCarTarget.name }</option>
						</c:forEach>
					</select>
				</td>
			</tr>
		</table>
		<table id="artBuyCarExperise" cellpadding="0" cellspacing="0" border="0" style="margin-top: 5px;width: 100%;display: none;">
			<tr>
					<td class="formTableTdLeft">置换原因：</td>
					<td>
							<select class="large text" name="replacementReasonId" id="replacementReasonId" >
								<option value="0" >请选择</option>
								<c:forEach var="replacementReason" items="${replacementReasons }">
									<option value="${replacementReason.dbid }" ${customerFile.replacementReason.dbid==replacementReason.dbid?'selected="selected"':'' } >${replacementReason.name }</option>
								</c:forEach>
							</select>
							<span style="color: red;">*</span>
					</td>
					<td class="formTableTdLeft">首次购车时间：</td>
					<td>
						<input name="customerFile.firstBuyCarDate"  class="large text" id="firstBuyCarDate" title="首次购车时间"  value="${customerFile.firstBuyCarDate }" onfocus="new WdatePicker()" ></input>
						<span style="color: red;">*</span>
					</td>
				</tr>
				<tr>
					<td class="formTableTdLeft">曾购车品牌：</td>
					<td>
						<input name="customerFile.yetBuyBrand"  class="large text" id="yetBuyBrand" title="曾购车品牌"  value="${customerFile.yetBuyBrand }" ></input>
						<span style="color: red;">*</span>
					</td>
					<td class="formTableTdLeft">车型：</td>
					<td>
						<input name="customerFile.yetBuyCarModel"  class="large text" id="yetBuyCarModel" title="车型"  value="${customerFile.yetBuyCarModel }" ></input>
						<span style="color: red;">*</span>
					</td>
				</tr>
				<tr>
					<td class="formTableTdLeft">原车VIN：</td>
					<td>
						<input name="customerFile.yetVinCode"  class="large text" id="yetVinCode" title="原车VIN"  value="${customerFile.yetVinCode }" ></input>
						<span style="color: red;">*</span>
					</td>
					<td class="formTableTdLeft">原车行驶公里：</td>
					<td>
						<input name="customerFile.yetMileAge"  class="large text" id="yetMileAge" title="原车行驶公里"  value="${customerFile.yetMileAge }" ></input>
						<span style="color: red;">*</span>
					</td>
				</tr> 
		</table>
	</div>
		
</form>                            
<div class="formButton">
		<a href="javascript:void(-1)" id="sbmId"	onclick="if(validateFrm()){$.utile.submitAjaxForm('frmId','${ctx}/customerFile/save')}"	class="but butSave">保&nbsp;&nbsp;存</a> 
	    <a href="javascript:void(-1)"	onclick="goBack()" class="but butCancle">取&nbsp;&nbsp;消</a>
	</div>
</div>
</body>
<script type="text/javascript" src="${ctx }/widgets/My97DatePicker/WdatePicker.js"></script>
<script type="text/javascript" src="${ctx }/widgets/artDialog/artDialog.js?skin=twitter"></script>
<script type="text/javascript" src="${ctx }/widgets/artDialog/plugins/iframeTools.source.js"></script>
<script type="text/javascript">
function showOrHiden(value){
	if(value==1){
		$("#residencePermitAddressTr").show();
	}else if(value==2){
		$("#residencePermitAddressTr").hide();
	}
}
function showBuyCarExp(value){
	if(value>1){
		writeResultShow();
	}
}
function validateFrmBeforeSmb(){
	var replacementReasonId=$("#replacementReasonId").val();
	var firstBuyCarDate=$("#firstBuyCarDate").val();
	var yetBuyBrand=$("#yetBuyBrand").val();
	var yetBuyCarModel=$("#yetBuyCarModel").val();
	var yetVinCode=$("#yetVinCode").val();
	var yetMileAge=$("#yetMileAge").val();
	if(null==replacementReasonId||replacementReasonId==''){
		alert("请选择置换原因!");
		$("#replacementReasonId").foucs();
		return false;
	}
	if(null==firstBuyCarDate||firstBuyCarDate==''){
		alert("请输入首次购车时间!");
		$("#firstBuyCarDate").foucs();
		return false;
	}
	if(null==yetBuyBrand||yetBuyBrand==''){
		alert("请输入曾购车品牌!");
		$("#yetBuyBrand").foucs();
		return false;
	}
	if(null==yetBuyCarModel||yetBuyCarModel==''){
		alert("请输入车型!");
		$("#yetBuyCarModel").foucs();
		return false;
	}
	if(null==yetVinCode||yetVinCode==''){
		alert("请输入原车VIN!");
		$("#yetVinCode").foucs();
		return false;
	}
	if(null==yetMileAge||yetMileAge==''){
		alert("请输入原车行驶公里!");
		$("#yetMileAge").foucs();
		return false;
	}
	return true;
	
}
function writeResultShow(){
	art.dialog({
		title:'填写购车经历',
	    content: document.getElementById('artBuyCarExperise'),
	    cancel:false,
	    id: 'EF893L',
	    width:'800px',
	    height:'320px',
	    ok: function () {
	    	var sta=validateFrmBeforeSmb()
	        return sta;
	    },
	    cancel:function(){
	    	return true;
	    },
		lock: true
	});
}
function ajaxArea(sel){
	var value=$(sel).val();
	$("#areaId").val(value);
	var sle= $(sel).nextAll();
	$(sle).remove();
	$.post("${ctx}/area/ajaxArea?parentId="+value+"&dateTime="+new Date(),{},function (data){
		if(data!="error"){
			$("#areaLabel").append(data);
		}
	});
}
function ajaxCarModel(sel){
	var options=$("#"+sel+" option:selected");
	var value=options[0].value;
	$("#carModelId").remove();
	if(value==''||value<=0){
		return;
	}
	$.post("${ctx}/carModel/ajaxCarModelBySeriy?carSeriyId="+value+"&dateTime="+new Date(),{},function (data){
		if(data!="error"){
			$("#carModelLabel").append(data);
		}
	});
}
function validateFrm(){
	var comeInTime=$("#comeInTime").val();
	var farwayTime=$("#farwayTime").val();
	var buyCarExperiseId=$("#buyCarExperiseId").val();
	if(buyCarExperiseId>1){
		if(validateFrmBeforeSmb()==false){
			writeResultShow();
			return false;
		}
	}
	if((comeInTime!=null&&comeInTime!="")&&(farwayTime!=null&&farwayTime!="")){
		var one=parseInt(comeInTime);
		var tow=parseInt(farwayTime);
		if(one>=tow){
			alert("离店时间必须大于进店时间！");
			return false;
		}
		return true;
	}
	return true;
	
}
</script>
</html>
