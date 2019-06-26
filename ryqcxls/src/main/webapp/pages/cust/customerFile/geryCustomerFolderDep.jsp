<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ include file="../../commons/taglib.jsp" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>${customer.customerPidBookingRecord.brand.name }公司客户档案登记表(单位) -DMS</title>
</head>
<link rel="stylesheet" href="${ctx }/css/print.css" />
<script src="${ctx }/widgets/bootstrap3/jquery.min.js"></script>
<style type="text/css" media="print">
.bar {
	display: none;
}
</style>
<style type="text/css" >
table{
}
table td, table th {
    border: 1px solid #000000;
    color: #000000;
    font-size: 14px;
    line-height:34px;
    width: 100px;
}
</style>
<script type="text/javascript">
$().ready(function() {
	var $print = $("#print");
	$print.click(function() {
		window.print();
		return false;
	});
});
</script>
<body>
<div class="bar">
	<a href="javascript:;" id="print" class="btn btn-success " style="margin-left: 5px;">打 印</a>
	<c:if test="${type!=2||empty(type) }" var="status">
		<a href="javascript:;"  class="btn btn-success " onclick="window.location.href='${ctx}/customerFile/edit?customerId=${customer.dbid}&custType=2'" style="margin-left: 5px;">编辑档案</a>
	</c:if>
	<a href="javascript:void(-1)"	onclick="window.history.go(-1)" class="but butCancle">返回</a>
</div>
<div class="testDriverContent" style="width: 98%;margin:0 auto;margin-bottom: 40px;">
<table width="100%" border="1" cellpadding="0" cellspacing="0" style="margin-bottom: 12px;" class="contentTable">
<tr >
	<td width="120" style="width: 170px;border: 0px;">&#12288;</td>
	<td width="40" style="width: 30px;border: 0px;">&#12288;</td>
	<td width="120" style="width: 170px; border: 0px;">&#12288;</td>
	<td width="80" style="width: 60px; border: 0px;">&#12288;</td>
	<td width="120" style="width: 180px;border: 0px;">&#12288;</td>
	<td width="120" style="width: 60px;border: 0px;">&#12288;</td>
	<td width="80" style="width: 86px;border: 0px;">&#12288;</td>
	<td width="120" style="width: 170px;border: 0px;">&#12288;</td>
	<td width="140" style="width: 260px;border: 0px;">&#12288;</td>
</tr>
<tr height="60">
	<td colspan="9" class="noLineTitle" style="text-align: center;font-size: 18px;font-weight: bold;background-color: #FFF;position: static;height: 25px;line-height: 25px;">
		<img src="${ctx }/images/xwqr/logo.png" width="175" style="position: absolute;left: 0px;padding-left: 26px;"></img>
		${customer.customerPidBookingRecord.brand.name }公司客户档案登记表(单位)
	</td>
</tr>
<tr height="60">
	<td colspan="9" class="noLineTitle" style="text-align: center;font-size: 18px;font-weight: bold;width: 160px;background-color: #FFF;border-bottom: none; position: static;">
		<div style="width: 100%;font-size: 14px;line-height: 30px;font-weight: normal;">
			<span>填写时间:</span>
			<span style="font-size: 12px;"><fmt:formatDate value="${customerFile.createDate }" pattern="yyyy  年 MM 月 dd 日"/></span>
			 &#12288;&#12288;
			<span>编号：</span>${customer.sn }
		</div>	
	</td>
</tr>
<tr>
    <td style="border-top: none;border-bottom: none;" colspan="9" >
       <div style="width: 40%;float: left;line-height: 23px;">
       	<p>
       		销售服务商名称/盖章
        	<u>&#12288;&#12288;&#12288;&#12288;&#12288;&#12288;&#12288;&#12288;&#12288;&#12288;&#12288;&#12288;&#12288;&#12288;</u>
         </p>
         <p>
         	*销售顾问：${customer.user.realName }
         </p>
         <p>
         	销售服务商类型：
	   		<c:if test="${!empty(customer.distributor) }">
	        	<label><input type="checkbox" checked="checked" />一级</label>
	        	<label><input type="checkbox"  />二级，名称：<u> ${customer.distributor.distributorType.name }&#12288;</u></label>
	        </c:if>
	        <c:if test="${empty(customer.distributor) }">
	        	<label><input type="checkbox" checked="checked"/>一级</label>
	        	<label><input type="checkbox"  />二级，名称：<u> ${customer.department.name }&#12288;</u></label>
	        </c:if>
         </p>
       </div>
       <div style="width: 5%;float: left;line-height: 66px;">
   		要求
   	  </div>
   	  <div style="width: 55%;float: right;line-height: 20px;padding-top: 10PX;">
        <p>1、此表由销售服务商自行打印或印刷，由客户填写，销售顾问核对确认；</p>
    	<P>2、信息员根据此表将客户信息上传至系统，此表自行留存、备查。</P>
    	</div>
    </td>
  </tr>
    <tr>
      <td colspan="9" class="noLineTitle" style="background-color: #fff;border-top:none;">一、车辆及购车信息</td>
    </tr>
      <c:set value="${customer.customerPidBookingRecord }" var="customerPidBookingRecord"></c:set>
     <tr>
        <td colspan="9" style="border-bottom:solid 0px #000000;border-top:solid 0px #000000 ;border-right: top:solid 0px #000000;">
	       <div style="float: left;min-width: 240px;width: 240px;"> *车辆底盘号：<u>${customer.customerPidBookingRecord.vinCode }&#12288;</u></div>
	       <div style="float: left;min-width: 180px;"> *车型：<u>
	       		${customer.customerPidBookingRecord.brand.name }
	       		${customer.customerPidBookingRecord.carSeriy.name }
	       		${customer.customerPidBookingRecord.carModel.name }
	       		${customer.customerPidBookingRecord.carColor.name }
	       		&#12288;</u></div>
	       <div style="clear: both;"></div>
	     </td>
      </tr>
     <tr>
        <td colspan="9" style="border-bottom:solid 0px #000000;border-top:solid 0px #000000 ;border-right: top:solid 0px #000000;">
	       <div style="float: left;min-width: 180px;">
        			*开发票日期：
        			<u><fmt:formatDate value="${customerFile.kpDate }" pattern="yyyy"/></u>年
        			<u><fmt:formatDate value="${customerFile.kpDate }" pattern="MM"/></u>月
        			<u><fmt:formatDate value="${customerFile.kpDate }" pattern="dd"/></u>日 
        	</div>
	       <%-- <div style="float: left;min-width: 180px;"> *车型：<u>${customerPidBookingRecord.carModel.name } &#12288;</u></div>
	       <div style="float: left;min-width: 180px;">  *颜色:<u>${customerPidBookingRecord.carColor.name }&#12288;</u></div> --%>
	       <div style="float: left;min-width: 180px;">&#12288;&#12288;*发票号：<u>${outboundOrder.faPiaoHao }</u></div>
	       <div style="float: left;min-width: 180px;">&#12288;&#12288;*价格：<u>${outboundOrder.invoicePrice }元</u>（开票价）</div>
	       <div style="float: left;min-width: 180px;">*交车日期：
        			<u><fmt:formatDate value="${customerFile.jcDate }" pattern="yyyy"/></u>年
        			<u><fmt:formatDate value="${customerFile.jcDate }" pattern="MM"/></u>月
        			<u><fmt:formatDate value="${customerFile.jcDate }" pattern="dd"/></u>日 
        	 </div>
	       <div style="clear: both;"></div>
	     </td>
      </tr>
       <tr>
        <td colspan="9" style="border-bottom:solid 0px #000000;border-top:solid 0px #000000;border-right: solid 1px #000000;; ">
        	<div style="float: left;min-width: 160px;">
         		*付款方式：
              <input type="checkbox" name="checkboxGroup3" value="单选" id="checkboxGroup3_0"  ${orderContractExpenses.buyCarType==1?'checked="checked"':'' }/> 一次付清
              <input type="checkbox" name="checkboxGroup3" value="单选" id="checkboxGroup3_1"  ${orderContractExpenses.buyCarType==2?'checked="checked"':'' }/>分期付款
           </div>
           (  *贷款渠道： 
             <input type="checkbox" name="checkboxGroup3" value="单选" id="checkboxGroup3_1"  ${customerFile.loanInfrom=='金融公司'?'checked="checked"':'' }/>金融公司
           	 <input type="checkbox" name="checkboxGroup3" value="单选" id="checkboxGroup3_1"  ${customerFile.loanInfrom=='工行'?'checked="checked"':'' }/>工行   
			 <input type="checkbox" name="checkboxGroup3" value="单选" id="checkboxGroup3_1"  ${customerFile.loanInfrom=='建行'?'checked="checked"':'' }/>建行   
			 <input type="checkbox" name="checkboxGroup3" value="单选" id="checkboxGroup3_1"  ${customerFile.loanInfrom=='农行'?'checked="checked"':'' }/>农行  
			 <input type="checkbox" name="checkboxGroup3" value="单选" id="checkboxGroup3_1"  ${customerFile.loanInfrom=='其他'?'checked="checked"':'' }/>其他
			 <u>${customerFile.loanNote }&#12288;</u>
			  *贷款方案：
			   <input type="checkbox" name="checkboxGroup3" value="单选" id="checkboxGroup3_1"  ${customerFile.loanPlan=='1年0利率'?'checked="checked"':'' }/>1年0利率    
			   <input type="checkbox" name="checkboxGroup3" value="单选" id="checkboxGroup3_1" ${customerFile.loanPlan=='2年低利率'?'checked="checked"':'' }/>2年低利率  
			   <input type="checkbox" name="checkboxGroup3" value="单选" id="checkboxGroup3_1"  ${customerFile.loanPlan=='其他'?'checked="checked"':'' }/>其他
			   <u>${customerFile.loanPlanNote }&#12288;</u>              
			)
        	<div style="clear: both;"></div>
        </td>
      </tr>
    <tr>
    	<td colspan="4" style="border: 0px ;border-left: 1px solid #000;line-height: 36px;height: 40px;">
    		<div style="float: left;min-width: 30px;margin-right: 2px;float: left;height: 25px;">*购车用途：</div>
    		 <c:forEach var="buyCarTarget" items="${buyCarTargets }" varStatus="i">
        		<div style="float: left;min-width: 30px;margin-right: 2px;float: left;height: 25px;">
						<input type="checkbox" name="infoFrom" ${buyCarTarget.dbid==customerFile.buyCaruse?'checked="checked"':'' }  value="${buyCarTarget.dbid }" id="infoFrom${i.index }" >${buyCarTarget.name }
				</div>
			</c:forEach> 
    	</td>
    	<td colspan="5" style="border: 0px ;line-height: 36px;border-right: 1px solid #000;height: 40px;">
    		<div style="float: left;min-width: 30px;margin-right: 2px;float: left;height: 25px;">*车辆性质：</div>
    		 <c:forEach var="carNatrue" items="${carNatrues }" varStatus="i">
        		<div style="float: left;min-width: 30px;margin-right: 2px;float: left;height: 25px;">
						<input type="checkbox" name="infoFrom" ${carNatrue.dbid==customerFile.carNature.dbid?'checked="checked"':'' }  value="${carNatrue.dbid }" id="infoFrom${i.index }" >${carNatrue.name }
				</div>
			</c:forEach> 
    	</td>
    </tr>
   <%--  <tr>
      <td colspan="9" class="noLineTitle" >*是否特销</td>
    </tr>
     <tr>
        <td colspan="9" style="border-bottom:solid 0px #000000;border-top:solid 0px #000000;border-right: solid 1px #000000; ">
        	<c:forEach var="specialPan" items="${specialPans }" varStatus="i">
        		<div style="float: left;height: 35px;width: 80px;">
					<label style="">
						<input type="checkbox" name="specialPans" ${specialPan.dbid==customerFile.specialPlan.dbid?'checked="checked"':'' } >${specialPan.name }
					</label>
				</div>
			</c:forEach>
			<div style="clear: both;"></div>
        </td>
      </tr> --%>
	 <tr>
        <td colspan="9" class="noLineTitle" style=";border-top: 0px;">二、客户联系方式</td>
      </tr>
      <tr>
      	<td colspan="9" class="noLine">
	        <div style="float: left;min-width: 180px;">*客户姓名：<u>${customer.name }&#12288;&#12288;&#12288;</u></div>
	        <div style="float: left;min-width: 260px;">&#12288;*常用手机号：<u>${customer.mobilePhone }&#12288;&#12288;&#12288;</u></div>
	        <div style="float: left;min-width: 180px;">&#12288;使用人：<u>${customer.customerBussi.buyCarMainUse.name }&#12288;&#12288;&#12288;</u></div>
	        <div style="float: left;min-width: 180px;">&#12288;电话：<u>&#12288;${customer.phone }&#12288;&#12288;&#12288;&#12288;</u></div>
	        <div style="clear: both;"></div>
        </td>
      </tr>
      <tr>
      	<td colspan="9" class="noLine">
	        <div style="float: left;min-width: 180px;">*单位名称：<u>&#12288;${customerFile.depName }&#12288;</u></div>
	        <div style="float: left;min-width: 260px;">&#12288;*企业代码证号码：<u>&#12288;${customerFile.depNo }&#12288;</u></div>
	        <div style="clear: both;"></div>
        </td>
      </tr>
        <tr>
        <td colspan="9" class="noLine">
        	<div style="float: left;">
        		*通讯地址：<u>${customer.area.fullName}${customer.address }</u>
        	</div>
        	<div style="float: left;min-width: 280px;">
        		&#12288;*现居住类型：<input type="checkbox" value=""  ${customerFile.nowJuzuType==1?'checked="checked"':'' }/>城镇
        					<input type="checkbox" value="" ${customerFile.nowJuzuType==2?'checked="checked"':'' }/>农村
        	</div>
      	    <div style="clear: both;"></div>
      	  </td>
       </tr>
       <tr>
        <td colspan="9" class="noLine">
        	<div style="float: left;min-width: 280px;">*居住证客户：
        		<c:if test="${customerFile.residencePermit==1 }">是</c:if>
        		<c:if test="${customerFile.residencePermit==2 }">否</c:if> 
        	</div>
        	<div style="float: left;min-width: 280px;">
        		<c:if test="${customerFile.residencePermit==1  }">
        			居住证地址：<u>${customerFile.area.fullName }${ customerFile.residencePermitAddress}</u>
        		</c:if>
        	</div>
      	    <div style="clear: both;"></div>
      	 </td>
       </tr>
   <tr>
        <td colspan="9" class="noLineTitle"  style=";border-top: 0px;">*单位性质：</td>
   </tr>
   <tr>
   		<td colspan="9" style="border-bottom: 0px;border-top: 0px;">
	   		<c:forEach var="depNature" items="${depNatures }">
	   			<div style="float: left;" >
	              <input type="checkbox" name="checkboxGroup4" value="单选" id="checkboxGroup4_0" ${depNature.dbid==customerFile.depNature.dbid?'checked="checked"':'' }/>
	              ${depNature.name }
			  </div>
			</c:forEach>
   		</td>
   </tr>
    <tr>
     	<td colspan="5" align="left" class="noLineTitle" style="border: solid 0px #000000;border-left: 1px solid #000;border-bottom: 0px;border-top: 0px;">
     		*行业：
	    </td>
     	<td colspan="4" align="left" class="noLineTitle" style="border: solid 0px #000000;border-bottom: 0px ;border-right: 1px solid #000;border-top: 0px;">
     		*信息获取渠道：（单选）
	    </td>
  </tr>
   <tr>
   	<td colspan="5" style="border: 0px;border-left:1px solid #000;">
             <c:forEach var="industry" items="${industries }" varStatus="i">
       		<div style="float: left;min-width: 120px;margin-right: 5px;float: left;height: 25px;">
				<label style="">
					<input type="checkbox" name="infoFrom" ${industry.dbid==customer.industry.dbid?'checked="checked"':'' }  value="${industry.dbid }" id="infoFrom${i.index }" >${industry.name }
				</label>
			</div>
			<c:if test="${(i.index+1)%6==0 }">
				<div style="clear: both;"></div>
			</c:if>
		</c:forEach> 
   	</td>
   	<td colspan="4"  style="border: 0px ;border-right: 1px solid #000;" >
    		<c:forEach var="infoFrom" items="${infoFroms }" varStatus="i" end="16">
        		<div style="min-width: 80px;margin-right: 5px;float: left;height: 25px;">
					<label style="">
						<input type="checkbox" name="infoFrom" ${infoFrom.dbid==customerFile.infoFrom.dbid?'checked="checked"':'' }  value="${infoFrom.dbid }" id="infoFrom${i.index }" >${infoFrom.name }
					</label>
				</div>
				<c:if test="${(i.index+1)%4==0 }">
					<div style="clear: both;"></div>
				</c:if>
			</c:forEach> 	
    	</td> 
   </tr> 
    <tr style="height: 80px;">
    	<td colspan="9" style="border: 0px;border-left: 1px solid #000;border-right: 1px solid #000;"></td>
   	</tr>
  <tr>
    <td colspan="5" align="left" class="noLine" style="border-right: 0px;border-bottom: 1px solid #000;height: 80px">
    	销售顾问签字：${customer.user.realName}
    </td>
    <td colspan="4" class="noLine" align="left" style="border-left: 0px;height: 80px">
    	客户签字：
    </td>
  </tr>
  <tr>
  	<td colspan="9" style="border-top: 0px">
  		<div style="margin: 0 auto;width: 600px;text-align: center;font-weight: ">
        	<i>${customer.customerPidBookingRecord.brand.name }汽车股份有限公司</i>
       </div>
  	</td>
  </tr>
</table>
</div>

</body>
</html>

