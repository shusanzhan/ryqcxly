<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ include file="../../commons/taglib.jsp" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>成都瑞一汽车有限公司销售合同书</title>
<link href="${ctx }/css/common.css" type="text/css" rel="stylesheet">
<link  href="${ctx }/widgets/easyvalidator/css/validate.css" rel="stylesheet" type="text/css" />
<script type="text/javascript" src="${ctx }/widgets/bootstrap3/jquery.min.js"></script>
<script type="text/javascript" src="${ctx }/widgets/utile/utile.js"></script>
<script type="text/javascript" src="${ctx }/widgets/easyvalidator/js/jquery.bgiframe.min.js"></script>
<script type="text/javascript" src="${ctx }/widgets/easyvalidator/js/easy_validator.pack.js"></script>
<script src="${ctx }/widgets/jqueryui/jquery.ui.core.js"></script>
<script src="${ctx }/widgets/jqueryui/jquery.ui.widget.js"></script>
<script src="${ctx }/widgets/jqueryui/jquery.ui.tabs.js"></script>
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
</style>
</head>
<body>
<div class="location">
   	<img src="${ctx}/images/homeIcon.png"/> &nbsp;
   	<a href="javascript:void(-1);" onclick="window.parent.location.href='${ctx}/main/index'">首页</a>-
   	<a href="javascript:void(-1);" onclick="window.parent.location.href='${ctx}/orderContract/queryList'">登记记录</a>-
   	<a href="javascript:void(-1)" class="current">填写订单信息</a>
</div>
<div class="line"></div>
<div class="frmContent">
	<form class="form-horizontal" method="post" action="" 	name="frmId" id="frmId">
		<input type="hidden" value="${orderContract.dbid }" id="dbid" name="orderContract.dbid">
		<input type="hidden" value="${orderContract.createTime }" id="createTime" name="orderContract.createTime">
		<table border="0" align="center" cellpadding="0" cellspacing="0" style="width: 92%;">
		<c:if test="${empty(orderContract) }">
			<tr height="42">
				<td class="formTableTdLeft" >需方：</td>
				<td>
				<input type="text" class="largeX text" name="orderContract.name"	id="name" value="${customer.name }" checkType="string,1,20"  tip="请输需方名称！"  />
				</td>
				<td>联系电话：</td>
				<td>
					<input class="largeX text" type="text" name="orderContract.contactPhone" id="contactPhone"  value="${customer.mobilePhone}" />
				</td>
			</tr>
			<tr height="42">
				<td>身份证地址：</td>
				<td>
					<input class="largeX text" type="text" name="orderContract.address" id="address"  value="${customer.address}" checkType="string,1,100"  tip="请输身份证地址！"/>
				</td>
				<td>邮政编码：</td>
				<td>
					<input class="largeX text" type="text" name="orderContract.zipCode" id="zipCode"  value="${customer.zipCode}" checkType="zipCode"  tip="请输入正邮政编码！"/>
				</td>
			</tr>
			<tr>
				<td>开户银行：</td>
				<td>
					<input type="text" class="largeX text" name="orderContract.bank" id="bank"  value="${orderContract.bank }" checkType="string,1,100"  tip="请输入开户银行！"/>
				</td>
				<td>银行账号：</td>
				<td>
					<input type="text" class="largeX text" name="orderContract.bankNo" id="bankNo"  value="${orderContract.bankNo }" checkType="string,1,20"  tip="请输银行账号！"/>
				</td>
			</tr>
			<tr>
				<td>购车定金：</td>
				<td>
					<input type="text" class="largeX text" name="orderContract.orderMoney" id="orderMoney"  value="${orderContract.orderMoney }" checkType="float" canEmpty="Y" tip="请输购车定金！"/>
				</td>
				<td>大写：</td>
				<td>
					<input type="text" class="largeX text" name="orderContract.bigOrderMoney " id="bigOrderMoney "  value="${orderContract.bigOrderMoney }" />
				</td>
			</tr>
		</c:if>
		<c:if test="${!empty(orderContract) }">
			<tr height="42">
				<td class="formTableTdLeft" >需方：</td>
				<td>
				<input type="text" class="largeX text" name="orderContract.name"	id="name" value="${orderContract.name }" checkType="string,1,20"  tip="请输需方名称！"  />
				</td>
				<td>联系电话：</td>
				<td>
					<input class="largeX text" type="text" name="orderContract.contactPhone" id="contactPhone"  value="${orderContract.contactPhone}" />
				</td>
			</tr>
			<tr height="42">
				<td>身份证地址：</td>
				<td>
					<input class="largeX text" type="text" name="orderContract.address" id="address"  value="${orderContract.address}" checkType="string,1,100"  tip="请输身份证地址！"/>
				</td>
				<td>邮政编码：</td>
				<td>
					<input class="largeX text" type="text" name="orderContract.zipCode" id="zipCode"  value="${orderContract.zipCode}" checkType="zipCode"  tip="请输入正邮政编码！"/>
				</td>
			</tr>
			<tr>
				<td>开户银行：</td>
				<td>
					<input type="text" class="largeX text" name="orderContract.bank" id="bank"  value="${orderContract.bank }" checkType="string,1,100"  tip="请输入开户银行！"/>
				</td>
				<td>银行账号：</td>
				<td>
					<input type="text" class="largeX text" name="orderContract.bankNo" id="bankNo"  value="${orderContract.bankNo }" checkType="string,1,20"  tip="请输银行账号！"/>
				</td>
			</tr>
			<tr>
				<td>购车定金：</td>
				<td>
					<input type="text" class="largeX text" name="orderContract.orderMoney" id="orderMoney"  value="${orderContract.orderMoney }" checkType="float" canEmpty="Y" tip="请输购车定金！"/>
				</td>
				<td>大写：</td>
				<td>
					<input type="text" class="largeX text" name="orderContract.bigOrderMoney " id="bigOrderMoney "  value="${orderContract.bigOrderMoney }" />
				</td>
			</tr>
		</c:if>
		<tr>
			<td colspan="4">
				<table width="92%"  cellpadding="0" cellspacing="0"  class="contentTable">
				  <tr>
				    <th style="width: 40px;">序号</th>
				    <th style="width: 150px;" width="150">产品系列</th>
				    <th style="width: 150px;" width="150">车型代码</th>
				    <th style="width: 120px;" width="150">油漆颜色</th>
				    <th style="width: 140px;" width="120">单价（人民币：元）</th>
				    <th style="width: 80px;" width="60">数量（台）</th>
				    <th style="width: 300px;" width="300">
				   	 备注
				    	<%-- <div style="float: left;padding-left: 100px;">备注</div>
				    	<div style="float: right;cursor: pointer;" title="点击添加商品信息" onclick="createTr(1)">
							<img alt="点击添加商品信息" src="${ctx }/images/table/tableInsert.gif" >
						</div> --%>
				    </th>
				  </tr>
				  <tr>
				    <td>
				    	1
					</td>
				    <td>
				    	<select id="carseriyId" name="carseriyId" class="midea text">
							<option value="">请选择...</option>
							<c:forEach var="carseriy" items="${carSeriys }">
								<option value="${carseriy.dbid }"  >${carseriy.name }</option>
							</c:forEach>
						</select>
					</td>
				    <td>
				    	<select id="carModelId" name="carModelId" class="midea text">
							<option value="">请选择...</option>
							<c:forEach var="carModel" items="${carModels }">
								<option value="${carModel.dbid }" ${customer.customerBussi.carModel.dbid==carModel.dbid?'selected="selected"':'' } >${carModel.name }</option>
							</c:forEach>
						</select>
					</td>
				    <td>
				    	<input type="text" class="small text" name="color" id="color"  value="" />
				    </td>
				    <td>
				    	 <input type="text" class="small text" name="price" id="price"  value="" />
				    </td>
				    <td>
				    	<input type="text" class="small text" style="width: 40px;" name="num" id="num"  value="" />
				    </td>
				    <td>
				   		<input type="text" class="large text" name="cnote" id="cnote"  value="" />		    	 
				    </td>
				  </tr>
				  <tr>
				    <td>
				    	2
					</td>
				    <td>
				    	<select id="carseriyId" name="carseriyId" class="midea text">
							<option value="">请选择...</option>
							<c:forEach var="carseriy" items="${carSeriys }">
								<option value="${carseriy.dbid }"  >${carseriy.name }</option>
							</c:forEach>
						</select>
					</td>
				    <td>
				    	<select id="carModelId" name="carModelId" class="midea text">
							<option value="">请选择...</option>
							<c:forEach var="carModel" items="${carModels }">
								<option value="${carModel.dbid }"  >${carModel.name }</option>
							</c:forEach>
						</select>
					</td>
				    <td>
				    	<input type="text" class="small text" name="color" id="color"  value="" />
				    </td>
				    <td>
				    	 <input type="text" class="small text" name="price" id="price"  value="" />
				    </td>
				    <td>
				    	<input type="text" class="small text" style="width: 40px;" name="num" id="num"  value="" />
				    </td>
				    <td>
				   		<input type="text" class="large text" name="cnote" id="cnote"  value="" />		    	 
				    </td>
				  </tr>
			</table>
			</td>
		</tr>
		<tr style="height: 60px;">
			<td>交货日期：</td>
			<td colspan="3">
				<textarea  class="largeXXX text" style="height: 50px;" id="handerOverCarDate" name="orderContract.handerOverCarDate"   >${orderContract.handerOverCarDate }</textarea>
			</td>
		</tr>
		<tr style="height: 60px;">
			<td>备注：</td>
			<td colspan="3">
				<textarea  class="largeXXX text" style="height: 50px;"  name="orderContract.note"  id="note" >${orderContract.note }</textarea>
			</td>
		</tr>
		<c:if test="${empty(orderContract) }">
			<tr>
				<td>需方：</td>
				<td>
					<input type="text" class="largeX text" name="" id=""  value="${customer.name}" />
				</td>
				<td>销售代表：</td>
				<td>
					<input type="text" class="largeX text" name="orderContract.salesRepresentative" id="salesRepresentative"  value="${sessionScope.user.realName}" />
				</td>
			</tr>
		</c:if>
		<c:if test="${!empty(orderContract) }">
			<tr>
				<td>需方：</td>
				<td>
					<input type="text" class="largeX text" name="" id=""  value="${orderContract.name }" />
				</td>
				<td>销售代表：</td>
				<td>
					<input type="text" class="largeX text" name="orderContract.salesRepresentative" id="salesRepresentative"  value="${orderContract.salesRepresentative }" />
				</td>
			</tr>
		</c:if>
			<tr>
			<td>需方代表：</td>
			<td>
				<input type="text" class="largeX text" name="orderContract.needRepresentative" id="needRepresentative"  value="${orderContract.needRepresentative }" />
			</td>
			<td>展厅经理：</td>
			<td>
				<input type="text" class="largeX text" name="orderContract.showRoomManager" id="showRoomManager"  value="${orderContract.showRoomManager }" />
			</td>
		</tr>
		</table>
	</form>
	<div class="formButton">
			<a href="javascript:void()"	onclick="$.utile.submitAjaxForm('frmId','${ctx}/orderContract/save')"	class="but butSave">保&nbsp;&nbsp;存</a> 
	    <a href="javascript:void(-1)"	onclick="goBack()" class="but butCancle">取&nbsp;&nbsp;消</a>
	</div>
</div>
</body>
</html>

