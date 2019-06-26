<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="../../commons/taglib.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html lang="en">
<head>
<title>经销商添加</title>
<meta charset="UTF-8" />
<meta name="viewport" content="width=device-width, initial-scale=1.0" />
<link href="${ctx }/css/common.css" type="text/css" rel="stylesheet">
<link  href="${ctx }/widgets/easyvalidator/css/validate.css" rel="stylesheet" type="text/css" />
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
</head>
<body>
<div class="location">
   	<img src="${ctx}/images/homeIcon.png"/> &nbsp;
   	<a href="javascript:void(-1);" onclick="window.parent.location.href='${ctx}/main/index'">首页</a>-
   	<a href="javascript:void(-1);" onclick="window.parent.location.href='${ctx}/distributor/queryList'">经销商管理</a>-
   	<a href="javascript:void(-1)" class="current">
		<c:if test="${distributor.dbid>0 }" var="status">编辑非合作经销商</c:if>
		<c:if test="${status==false }">添加非合作经销商</c:if>
	</a>
</div>
<div class="line"></div>
<div class="frmContent">
	<form class="form-horizontal" method="post" action="" 	name="frmId" id="frmId">
		<input type="hidden" value="${distributor.dbid }" id="dbid" name="distributor.dbid">
		<input type="hidden" value="${distributor.createTime }" id="createTime" name="distributor.createTime">
		<input type="hidden" value="2" id="type" name="distributor.type">
		<div class="frmTitle" onclick="showOrHiden('contactTable')">基本信息</div>
		<table border="0" align="center" cellpadding="0" cellspacing="0" style="width: 92%;">
				<tr>
					<td class="formTableTdLeft">经销商名称：</td>
					<td>
						<input type="text" class="largeX text" name="distributor.name" onchange="pinYin.value=getCharsCode(this.value);"	id="name" value="${distributor.name }" checkType="string,1,20"  tip="请输入经销商名称！"  />
						<input type="hidden" class="largeX text" name="distributor.pinYin"	id="pinYin" value="${distributor.pinYin }"  />
					</td>
					<td class="formTableTdLeft">经销商简称：</td>
					<td>
						<input type="text" class="largeX text" name="distributor.shortName"	id="shortName" value="${distributor.shortName }" checkType="string,1,20"  tip="请输入经销商简称！"  />
					</td>
				</tr>
				<%-- <tr>
					<td class="formTableTdLeft">法人代表：</td>
					<td>
						<input type="text" class="largeX text" name="distributor.legalRep"	id="legalRep" value="${distributor.legalRep }" checkType="string,1,20"  tip="请输入法人代表！"  />
					</td>
					<td class="formTableTdLeft">证件号码：</td>
					<td>
						<input type="hidden" class="largeX text" name="distributor.birthday"	id="birthday" value="${distributor.birthday }" />
						<input type="text" class="largeX text" name="distributor.icard"	id="icard" value="${distributor.icard }" checkType="IDCard"  tip="请输入法人证件号码！"  />
					</td>
				</tr> --%>
				<tr>
					<td class="formTableTdLeft">区域：</td>
					<td id="areaLabel">
						<input type="hidden" name="legalAreaId" value="${distributor.legalArea.dbid }" id="legalAreaId">
						<c:if test="${empty(areaSelect) }">
							<select id="areoD" name="areoD" class="small text" onchange="ajaxArea('areaLabel',this,'legalAreaId')">
								<option>请选择...</option>
								<c:forEach items="${areas }" var="area">
									<option  value="${area.dbid }">${area.name }</option>
								</c:forEach>
							</select>
						</c:if>
						<c:if test="${!empty(areaSelect) }">
							${areaSelect }
						</c:if>
					</td>
					<td class="formTableTdLeft">详细地址：</td>
					<td colspan="1">
						<input type="text" class="largeX text" name="distributor.address"	id="address" value="${distributor.address }" checkType="string,1,120"  tip="请输法人身份证地址！"  />
						<span style="color: red;">*</span>
					</td>
				</tr>
				<tr>
					<td class="formTableTdLeft">手机号码：</td>
					<td>
						<input type="text" class="largeX text" name="distributor.mobilePhone"	id="mobilePhone" value="${distributor.mobilePhone }" checkType="mobilePhone"  tip="请输入手机号码！"  />
						<span style="color: red;">*</span>
					</td>
					<td class="formTableTdLeft">座机号码：</td>
					<td>
						<input type="text" class="largeX text" name="distributor.phone"	id="phone" value="${distributor.phone }" checkType="phone"  tip="请输入座机号号码！可为空" canEmpty="Y" />
					</td>
				</tr>
				<tr>
					<%-- <td class="formTableTdLeft">保证金：</td>
					<td>
						<input type="text" class="largeX text" name="distributor.bond"	id="bond" value="${distributor.bond }" checkType="string,1,20"  tip="请输入保证金！" canEmpty="Y" />
					</td> --%>
					<td class="formTableTdLeft">经销商类型：</td>
					<td colspan="1">
						<select id="distributorTypeId" name="distributorTypeId" class="largeX text" checkType="integer,1"  tip="请选择经销商类型！"  >
							<option>请选择...</option>
							<c:forEach items="${distributorTypes }" var="distributorType">
								<option  value="${distributorType.dbid }" ${distributorType.dbid==distributor.distributorType.dbid?'selected="selected"':'' } >${distributorType.name }</option>
							</c:forEach>
						</select>
					</td>
					<td class="formTableTdLeft">场地性质：</td>
					<td>
						<select id="companyAttr" class="largeX text" name="distributor.companyAttr" checkType="integer,1" tip="请选择场地性质">
							<option>请选择...</option>
							<option value="1" ${distributor.companyAttr==1?'selected="selected"':'' } >自有</option>
							<option value="2" ${distributor.companyAttr==2?'selected="selected"':'' }>租赁</option>
						</select>
						<span style="color: red;">*</span>
					</td>
				</tr>
			<%-- 	<tr>
					<td class="formTableTdLeft">公司区域：</td>
					<td id="companyAreaLabel">
						<input type="hidden" name="companyAreaId" value="${distributor.companyArea.dbid }" id="companyAreaId">
						<c:if test="${empty(companyAreaSelect) }">
							<select id="projectCompanyConta" name="projectCompanyConta" class="small text" onchange="ajaxArea('companyAreaLabel',this,'companyAreaId')">
								<option>请选择...</option>
								<c:forEach items="${areas }" var="area">
									<option  value="${area.dbid }">${area.name }</option>
								</c:forEach>
							</select>
						</c:if>
						<c:if test="${!empty(companyAreaSelect) }">
							${companyAreaSelect }
						</c:if>
					</td>
					<td class="formTableTdLeft">公司详细地址：</td>
					<td colspan="1">
						<input type="text" class="largeX text" name="distributor.companyAddress"	id="companyAddress" value="${distributor.companyAddress }" checkType="string,1,20"  tip="请输入公司详细地址！"  />
					</td>
				</tr> --%>
				<tr>
					<td class="formTableTdLeft">起始合作时间：</td>
					<td colspan="1">
						<input type="text" class="largeX text" name="distributor.startCooperation"	id="startCooperation" value='<fmt:formatDate value="${distributor.startCooperation }"/>' onFocus="WdatePicker({isShowClear:false,readOnly:true})" checkType="string,1,20"  tip="请输入起始合作时间！"  />
					</td>
				</tr>
				<tr>
					<td class="formTableTdLeft">备注：</td>
					<td colspan="3">
						<textarea  class="largeXX text" name="distributor.note"	id="note" style="height: 92px;width: 600px;"  >${distributor.note }</textarea>
					</td>
				</tr>
			</table>
			<div class="frmTitle" onclick="showOrHiden('contactTable')">发票信息</div>
			<table border="0" align="center" cellpadding="0" cellspacing="0" style="width: 92%;">
				
				<tr>
					<td class="formTableTdLeft">发票名称：</td>
					<td colspan="1">
						<input type="text" class="largeX text" name="distributor.billingName"	id="billingName" value='${distributor.billingName }'  checkType="string,1,250"  tip="请输入发票名称！" canEmpty="Y" />
						<span style="color: red;">*</span>
					</td>
					<td class="formTableTdLeft">纳税人识别号：</td>
					<td colspan="1">
						<input type="text" class="largeX text" name="distributor.taxtpaperIdentifactionNumber"	id=taxtpaperIdentifactionNumber value='${distributor.taxtpaperIdentifactionNumber }'  checkType="string,1,250"  tip="请输入纳税人识别号！" canEmpty="Y"  />
						<span style="color: red;">*</span>
					</td>
				</tr>
				<tr>
					<td class="formTableTdLeft">地址、电话：</td>
					<td colspan="1">
						<input type="text" class="largeX text" name="distributor.addressPhone"	id="addressPhone" value='${distributor.addressPhone }'  checkType="string,1,250"  tip="请输入地址、电话！" canEmpty="Y"  />
						<span style="color: red;">*</span>
					</td>
					<td class="formTableTdLeft">开户行及账号：</td>
					<td colspan="1">
						<input type="text" class="largeX text" name="distributor.bankAccountNo"	id="bankAccountNo" value='${distributor.bankAccountNo }'  checkType="string,1,250"  tip="请输入开户行及账号！" canEmpty="Y"  />
						<span style="color: red;">*</span>
					</td>
				</tr>
				
		</table>
	</form>
	<div class="formButton">
		<a href="javascript:void()"	onclick="$.utile.submitForm('frmId','${ctx}/distributor/save')"	class="but butSave">保&nbsp;&nbsp;存</a>
	    <a href="${ctx }/distributor/queryList"	 class="but butCancle">取&nbsp;&nbsp;消</a>
	</div>
</div>
</body>
<script type="text/javascript" src="${ctx }/widgets/bootstrap3/jquery.min.js"></script>
<script type="text/javascript" src="${ctx }/widgets/utile/utile.js"></script>
<script type="text/javascript" src="${ctx }/widgets/easyvalidator/js/easy_validator.pack.js"></script>
<script type="text/javascript" src="${ctx }/widgets/artDialog/artDialog.js?skin=default"></script>
<script type="text/javascript" src="${ctx }/widgets/artDialog/plugins/iframeTools.source.js"></script>
<script type="text/javascript" src="${ctx }/widgets/My97DatePicker/WdatePicker.js"></script>
<script type="text/javascript" src="${ctx }/widgets/charscode.js"></script>
<script type="text/javascript" src="${ctx }/widgets/utile/utile.js"></script>
<script type="text/javascript">
function ajaxArea(areaLabel,sel,areaId){
	var value=$(sel).val();
	$("#"+areaId).val(value);
	var sle= $(sel).nextAll();
	$(sle).remove();
	$.post("${ctx}/area/ajaxAreaDistributor?parentId="+value+"&dateTime="+new Date()+"&areaLabel="+areaLabel+"&areaId="+areaId,{},function (data){
		if(data!="error"){
			$("#"+areaLabel).append(data);
		}
	});
}
</script>
</html>
