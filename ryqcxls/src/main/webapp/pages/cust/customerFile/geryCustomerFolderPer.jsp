<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ include file="../../commons/taglib.jsp" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>${customer.customerPidBookingRecord.brand.name }公司客户档案登记表(私人)</title>
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
    line-height:35px;
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
		<a href="javascript:;"  class="btn btn-success " onclick="window.location.href='${ctx}/customerFile/edit?customerId=${customer.dbid}&custType=1'" style="margin-left: 5px;">编辑档案</a>
	</c:if>
	<a href="javascript:void(-1)"	onclick="window.history.go(-1)" class="but butCancle">返回</a>
</div>
<div class="testDriverContent" style="width: 98%;margin-bottom: 40px;">
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
<tr height="40">
	<td colspan="9" class="noLineTitle" style="text-align: center;font-size: 18px;font-weight: bold;background-color: #FFF;position: static;height: 25px;line-height: 25px;">
		<img src="${ctx }/images/xwqr/logo.png" width="175" style="position: absolute;left: 0px;padding-left: 26px;"></img>
		${customer.customerPidBookingRecord.brand.name }公司客户档案登记表(私人)
	</td>
</tr>
<tr>
	<td colspan="9" class="noLineTitle" style="text-align: center;font-size: 18px;font-weight: bold;width: 160px;background-color: #FFF;border-bottom: none;border-top:none;position: static;">
		<div style="width: 100%;font-size: 14px;line-height: 30px;font-weight: normal;">
			<span>填写时间:</span>
			<span style="font-size: 12px;"><fmt:formatDate value="${customerFile.createDate }" pattern="yyyy  年 MM 月 dd 日"/></span>
			 &#12288;&#12288;
			<span>编号：</span>${customer.sn }
		</div>	
	</td>
</tr>
<tr >
    <td style="border-bottom: none;" colspan="9" >
       <div style="width: 45%;float: left;">
       	<p>
       		销售服务商名称/盖章
        	<u>&#12288;&#12288;&#12288;&#12288;&#12288;&#12288;&#12288;&#12288;&#12288;&#12288;&#12288;&#12288;&#12288;&#12288;</u>
         </p>
       	<p>
        	*销售顾问：<u>${customer.user.realName }&#12288;&#12288;&#12288;&#12288;&#12288;</u>
         </p>
         <p>
         	*销售服务商类型：
	   		<c:if test="${!empty(customer.distributor) }">
	        	<label><input type="checkbox"  />一级</label>
	        	<label><input type="checkbox" checked="checked" />二级销售服务商，名称：<u> ${customer.distributor.distributorType.name }&#12288;</u></label>
	        </c:if>
	        <c:if test="${empty(customer.distributor) }">
	        	<label><input type="checkbox"  checked="checked"/>一级</label>
	        	<label><input type="checkbox" />二级，名称：<u> ${customer.department.name }&#12288;</u></label>
	        </c:if>
         </p>
       </div>
       <div style="width: 3%;float: left;line-height: 30px;padding-top: 20px;">
   		要求：
   	  </div>
   	  <div style="width: 52%;float: right;line-height: 20px;height: 60px;padding-top: 30px;">
        <p>1、此表由销售服务商自行打印或印刷，由客户填写，销售顾问核对确认；</p>
    	<P>2、信息员根据此表将客户信息上传至系统，此表自行留存、备查。</P>
    	</div>
    </td>
  </tr>
    <tr>
      <td colspan="9" class="noLineTitle" style="border-top: none;">一、车辆及购车信息</td>
    </tr>
      <c:set value="${customer.customerPidBookingRecord }" var="customerPidBookingRecord"></c:set>
     <tr>
        <td colspan="9" style="border-bottom:solid 0px #000000;border-top:solid 0px #000000 ;border-right: top:solid 0px #000000;">
	       <div style="float: left;min-width: 240px;width: 260px;"> *车辆底盘号：<u>${customer.customerPidBookingRecord.vinCode }&#12288;</u></div>
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
        <td colspan="9" style="border-bottom:solid 0px #000000;border-top:solid 0px #000000;border-right: solid 1px #000000;; ">
        <div style="float: left;min-width: 70px;" >*购车用途：</div>
           <c:forEach var="buyCarTarget" items="${buyCarTargets }" varStatus="i">
        		<div style="float: left;min-width: 30px;margin-right: 2px;float: left;height: 25px;">
						<input type="checkbox" name="infoFrom" ${buyCarTarget.dbid==customerFile.buyCaruse?'checked="checked"':'' }  value="${buyCarTarget.dbid }" id="infoFrom${i.index }" >${buyCarTarget.name }
				</div>
			</c:forEach> 
         <div style="float: left;min-width: 70px;" >&#12288;*车辆性质：</div>
           <c:forEach var="carNatrue" items="${carNatrues }" varStatus="i">
        		<div style="float: left;min-width: 30px;margin-right: 2px;float: left;height: 25px;">
						<input type="checkbox" name="infoFrom" ${carNatrue.dbid==customerFile.carNature.dbid?'checked="checked"':'' }  value="${carNatrue.dbid }" id="infoFrom${i.index }" >${carNatrue.name }
				</div>
			</c:forEach> 
        </td>
      </tr>
    <tr>
    	<td colspan="9" style="border: 0px ;border-left: 1px solid #000;border-right: 1px solid #000;">
    		<div style="float: left;min-width: 30px;margin-right: 5px;float: left;height: 25px;">
    		*购车经历：
    		</div>
    		<c:forEach var="buyCarEmperise" items="${buyCarEmperises }" varStatus="i">
        		<div style="float: left;min-width: 30px;margin-right: 5px;float: left;height: 25px;">
        			<c:if test="${i.index==0 }" var="status">
        				<p>
							<input type="checkbox" name="infoFrom" ${buyCarEmperise.dbid==customerFile.buyCarExperise.dbid?'checked="checked"':'' }  value="${buyCarTarget.dbid }" id="infoFrom${i.index }" >${buyCarEmperise.name }</input>
						</p>
        			</c:if>
        			<c:if test="${status==false }">
        				<label style="">
							<input type="checkbox" name="infoFrom" ${buyCarEmperise.dbid==customerFile.buyCarExperise.dbid?'checked="checked"':'' }  value="${buyCarTarget.dbid }" id="infoFrom${i.index }" >${buyCarEmperise.name }</input>
						</label>
        			</c:if>
				</div>
			</c:forEach>
    	</td>
    </tr>
    <tr>
    	<td colspan="4" style="border: 0px ;border-left: 1px solid #000;">
			<p>*曾购车品牌：<u>&#12288;${customerFile.yetBuyBrand }&#12288;&#12288;&#12288;&#12288;&#12288;&#12288;</u> 
			*车型：<u>&#12288;${customerFile.yetBuyCarModel }&#12288;&#12288;&#12288;&#12288;&#12288;&#12288;&#12288;</u>  </p>                             			
    	</td>
    	<td colspan="5"  style="border: 0px ;border-right: 1px solid #000;">
    		<div style="float: left;min-width: 80px;" >置换原因：</div>
    		<c:forEach var="replacementReason" items="${replacementReasons }" varStatus="i">
	    		<div style="float: left;min-width: 80px;" ><input type="checkbox" name="checkboxGroup4" value="单选" id="checkboxGroup4_3" ${customerFile.replacementReason.dbid==replacementReason.dbid?'checked="checked"':'' }/>${replacementReason.name }</div>
    		</c:forEach>		
    	</td>
    </tr>
    <%-- <tr>
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
        <td colspan="9" class="noLineTitle" style="border-top: none;">二、客户联系方式</td>
      </tr>
      <tr>
      	<td colspan="9" class="noLine">
	        <div style="float: left;min-width: 180px;">*客户姓名：<u>${customer.name }</u></div>
	        <div style="float: left;min-width: 150px;">
	        	性别：
	        		<label><input type="checkbox" name="infoFrom" ${customer.sex=='男'?'checked="checked"':'' }>男</label>
	        		&#12288;
	        		<label><input type="checkbox" name="infoFrom" ${customer.sex=='女'?'checked="checked"':'' }>女</label>
	        </div>
	        <div style="float: left;min-width: 150px;">
	        	<p>
		        	婚姻情况：
		       		<input type="checkbox" value="" ${2==customerFile.marryStatus?'checked="checked"':'' }>未婚</input>
		       		<input type="checkbox" value="" ${1==customerFile.marryStatus?'checked="checked"':'' }>已婚</input>
        		</p>
	        </div>
	        <div style="float: left;min-width: 260px;">&#12288;*常用手机号：<u>${customer.mobilePhone }</u></div>
	        <div style="float: left;min-width: 180px;">&#12288;家庭电话：<u>&#12288;&#12288;${customer.phone }&#12288;&#12288;</u></div>
	        <div style="clear: both;"></div>
        </td>
      </tr>
     <tr>
      	<td colspan="9" class="noLine">
      		<div style="float: left;height: 25px;width: 80px;">*证件类型：</div>
      		<c:forEach var="paperwork" items="${paperworks }">
      			<div style="float: left;height: 25px;">
					<label style="">
						<input type="checkbox" name="specialPans" ${paperwork.dbid==customer.paperwork.dbid?'checked="checked"':'' } >${paperwork.name }
					</label>
				</div>
      		</c:forEach>
	        <div style="float: left;width: 260px;">&#12288;*证件号码：<u>${customer.icard }</u></div>
	        <div style="float: left;min-width: 180px;">&#12288;QQ号码：<u>&#12288;&#12288;${customer.qq }&#12288;&#12288;</u></div>
	        <div style="float: left;min-width: 180px;">&#12288;爱好：<u>&#12288;&#12288;${customer.interest.name }&#12288;&#12288;</u></div>
	         <div style="clear: both;"></div>
      	</td>
     </tr>
        <tr>
        <td colspan="9" class="noLine">
        	<div style="float: left;">
        		*通讯地址：<u>${customer.area.fullName}${customer.address }</u>
        	</div>
        	<div style="float: left;min-width: 280px;">
        		&#12288;*现居住类型：<input type="checkbox" id="nowJuzuType1" name="customerFile.nowJuzuType" value=""  ${customerFile.nowJuzuType==1?'checked="checked"':'' }/>城镇
        					<input type="checkbox" id="nowJuzuType1" name="customerFile.nowJuzuType" value="" ${customerFile.nowJuzuType==2?'checked="checked"':'' }/>农村
        	</div>
      	    <div style="float: left;min-width: 180px;">电子邮件：<u>&#12288;&#12288;${customer.email }&#12288;&#12288;&#12288;</u></div>
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
		<td colspan="9" style="border:none;border-left: 1px solid #000;;border-right:1px solid #000;">
			<div style="float: left;min-width: 40px;" >*家庭人数：</div>
			<c:forEach var="familyNumber" items="${familyNumbers }">
      			<div style="float: left;min-width: 140px;" >
		            <label >
		              <input type="checkbox" name="checkboxGroup4" value="单选" id="checkboxGroup4_0" ${familyNumber.dbid==customerFile.familyNumber.dbid?'checked="checked"':'' }/>
		              ${familyNumber.name }
		             </label>
				  </div>
      		</c:forEach>
         <div style="clear: both;"></div>
		</td>
	</tr>
  	<tr>
		<td colspan="9" style="border:none;border-left: 1px solid #000;;border-right:1px solid #000;">
			<div style="float: left;min-width: 40px;" >*学历：</div>
			<c:forEach var="educational" items="${educationals }" varStatus="i">
        		<div style="float: left;margin-right: 5px;float: left;height: 25px;min-width: 140px;">
					<label style="">
						<input type="checkbox" name="infoFrom" ${educational.dbid==customer.educational.dbid?'checked="checked"':'' }  value="${educational.dbid }" id="infoFrom${i.index }" >${educational.name }
					</label>
				</div>
			</c:forEach> 
         <div style="clear: both;"></div>
		</td>
	</tr>
  	<tr>
		<td colspan="9" style="border:none;border-left: 1px solid #000;;border-right:1px solid #000;">
			<div style="float: left;min-width: 40px;" >*驾龄：</div>
			<c:forEach var="drivingAge" items="${drivingAges }">
      			<div style="float: left;min-width: 140px;" >
		            <label >
		              <input type="checkbox" name="checkboxGroup4" value="单选" id="checkboxGroup4_0" ${drivingAge.dbid==customerFile.drivingAge.dbid?'checked="checked"':'' }/>
		              ${drivingAge.name }
		             </label>
				  </div>
      		</c:forEach>
         <div style="clear: both;"></div>
		</td>
	</tr>
   <tr>
   		<td colspan="9" style="border:none;border-left: 1px solid #000;;border-right:1px solid #000;">
   			<div style="float: left;min-width: 100px;border:none;" >*家庭税前年收入：</div>
	   		<c:forEach var="yearFamilyIncome" items="${yearFamilyIncomes }">
	   			<div style="float: left;min-width: 100px;" >
	              <input type="checkbox" name="checkboxGroup4" value="单选" id="checkboxGroup4_0" ${yearFamilyIncome.dbid==customerFile.yearFamilyIncome.dbid?'checked="checked"':'' }/>
	              ${yearFamilyIncome.name }
			  </div>
			</c:forEach>
   		</td>
   </tr>
    <tr>
     <td colspan="5" align="left" class="noLineTitle" style="border: solid 0px #000000;border-left: 1px solid #000;border-bottom: 0px ;border-right: 0px;">
     		*行业：（请说明具体职业）
     		<u>&#12288;${customerFile.industryNote }&#12288;</u>
	    </td>
	    <td colspan="4" class="noLineTitle" style="border: solid 0px #000000;border-right: 1px solid #000;border-bottom: 0px ;">
	    	*信息获取渠道(单选)：
	    </td>
  </tr>
   <tr>
   	<td colspan="5" style="border: 0px;border-left:1px solid #000;">
             <c:forEach var="industry" items="${industries }" varStatus="i">
       		<div style="float: left;min-width: 160px;margin-right: 5px;float: left;height: 25px;">
				<label style="">
					<input type="checkbox" name="infoFrom" ${industry.dbid==customer.industry.dbid?'checked="checked"':'' }  value="${industry.dbid }" id="infoFrom${i.index }" >${industry.name }
				</label>
			</div>
			<c:if test="${(i.index+1)%3==0 }">
				<div style="clear: both;"></div>
			</c:if>
		</c:forEach> 
   	</td>
   	<td colspan="4" style="border: 0px;border-right:1px solid #000;">
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
   <%--  <tr>
        <td colspan="9" class="noLineTitle" >客户爱好：</td>
     </tr>
  <tr>
  	<td colspan="9">
  	  	<c:forEach var="interest" items="${interests }" varStatus="i">
       		<div style="float: left;margin-right: 5px;min-width:0px;;float: left;height: 35px;">
				<label style="">
					<input type="checkbox" name="infoFrom" ${interest.dbid==customer.interest.dbid?'checked="checked"':'' }  value="${industry.dbid }" id="infoFrom${i.index }" >${interest.name }
				</label>
			</div>
		</c:forEach> 
	</td>
  </tr> --%>
  <%--  <tr>
        <td colspan="5" class="noLineTitle" style="border: 0px ;border-left: 1px solid #000;">紧急联系人：<u>${customerFile.emergencyName }</u></td>
        <td colspan="4" class="noLineTitle" style="border: 0px ;border-right: 1px solid #000;">紧急联系方式：<u>${customerFile.emergencyContactWay }</u></td>
     </tr> --%>
 <tr>
    <td colspan="5" align="left" class="noLine" style="border-right: 0px;border-bottom: 1px solid #000;height: 80px;">
    	销售顾问签字：${customer.user.realName}
    </td>
    <td colspan="4" class="noLine" align="left" style="border-left: 0px;height: 80px;">
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

