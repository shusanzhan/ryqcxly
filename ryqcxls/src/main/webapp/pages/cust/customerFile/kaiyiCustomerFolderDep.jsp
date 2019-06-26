<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ include file="../../commons/taglib.jsp" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>${customer.customerPidBookingRecord.brand.name }公司客户档案登记表（个人）</title>
</head>
<link rel="stylesheet" href="${ctx }/css/print.css" />
<script src="${ctx }/widgets/bootstrap3/jquery.min.js"></script>
<style type="text/css" media="print">
.bar {
	display: none;
}
</style>
<style type="text/css" >
	table td, table th {
    border: 1px solid #000000;
    color: #000000;
    font-size: 14px;
    line-height: 35px;
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
<div class="testDriverContent" style="width: 98%;margin-bottom: 40px;">
<table width="100%" border="1" cellpadding="0" cellspacing="0" style="margin-bottom: 12px;" class="contentTable">
<tr >
	<td width="120" style="width: 170px;border: 0px;">&#12288;</td>
	<td width="40" style="width: 30px;border: 0px;">&#12288;</td>
	<td width="120" style="width: 170px; border: 0px;">&#12288;</td>
	<td width="60" style="width: 60px; border: 0px;">&#12288;</td>
	<td width="140" style="width: 180px;border: 0px;">&#12288;</td>
	<td width="100" style="width: 110px;border: 0px;">&#12288;</td>
	<td width="80" style="width: 86px;border: 0px;">&#12288;</td>
	<td width="120" style="width: 170px;border: 0px;">&#12288;</td>
	<td width="140" style="width: 260px;border: 0px;">&#12288;</td>
</tr>
<tr height="60">
	<td colspan="9" class="noLineTitle" style="text-align: center;font-size: 18px;font-weight: bold;width: 160px;background-color: #FFF;">
		<div style="width: 60%;float: left;text-align: right;line-height: 50px;">表1—${customer.customerPidBookingRecord.brand.name }公司客户档案登记表(单位) -DMS</div>
		<div style="width: 40%;float: right;font-size: 14px;line-height: 50px;font-weight: normal;">
			<span>填写时间:</span>
			<span style="font-size: 12px;"><fmt:formatDate value="${customerFile.createDate }" pattern="yyyy  年 MM 月 dd 日"/></span>
			 &#12288;&#12288;
			<span>编号：</span>${customer.sn }
		</div>	
	</td>
</tr>
<tr>
    <td style="" colspan="2">
        销售服务商名称/盖章
    </td>
    <td colspan="5">
      *（如为二级销售，填写二级经销商名称）   *销售顾问：${customer.user.realName }
   </td>
   <td rowspan="3"  class="labelTitle">
   	要求：
   </td>
    <td colspan="3" rowspan="3" style="line-height: 100%;">
        <p>1、此表由销售服务商自行打印或印刷，由客户填写，销售顾问核对确认；</p>
    	<P>2、会员业务专员/客服专员根据此表将客户档案信息上传至DCS，此表自行留存、备查。</P>
    </td>
  </tr>
  <tr>
   	<td colspan="2"> 
   		销售服务商类型：
   	</td>
   	<td colspan="5" style="font-size: 12px;">
        <p>
         	销售服务商类型：
	   		<c:if test="${!empty(customer.distributor) }">
	        	<label><input type="checkbox"  checked="checked"/>一级销售服务商</label>
	        	<label><input type="checkbox"  />二级销售服务商，名称：<u> ${customer.distributor.distributorType.name }&#12288;</u></label>
	        </c:if>
	        <c:if test="${empty(customer.distributor) }">
	        	<label><input type="checkbox" />一级销售服务商（本公司）</label>
	        	<label><input type="checkbox"  checked="checked"/>二级销售服务商，名称：<u> ${customer.department.name }&#12288;</u></label>
	        </c:if>
         </p>
     </td>
  </tr>
   <tr>
   		<td colspan="2"> 填表说明：</td>
   		<td colspan="5" style="padding-left: 30px;">“*”为必填项</td>
   </tr>
	
    <tr>
      <td colspan="9" class="noLineTitle" >一、车辆及购车信息</td>
    </tr>
      
      <tr>
        <td colspan="9" style="border-bottom:solid 0px #000000;border-top:solid 0px #000000 ;border-right: 1px solid #000;">
	       <div style="float: left;min-width: 180px;"> *车辆底盘号：<u>${customerPidBookingRecord.vinCode }&#12288;</u></div>
	       <div style="float: left;min-width: 180px;"> *车型：<u>${customerPidBookingRecord.carSeriy.name }${customerPidBookingRecord.carModel.name } &#12288;</u></div>
	       <div style="float: left;min-width: 180px;">  *颜色:<u>${customerPidBookingRecord.carColor.name }&#12288;</u></div>
	       <div style="clear: both;"></div>
	     </td>
      </tr>
       <tr>
        <td colspan="9" style="border-bottom:solid 0px #000000;border-top:solid 0px #000000;border-right: 1px solid #000; ">
        	<div style="float: left;min-width: 180px;">
        			*开发票日期：
        			<u><fmt:formatDate value="${customerFile.kpDate }" pattern="yyyy"/></u>年
        			<u><fmt:formatDate value="${customerFile.kpDate }" pattern="MM"/></u>月
        			<u><fmt:formatDate value="${customerFile.kpDate }" pattern="dd"/></u>日 
        	</div>
        	<div style="float: left;min-width: 180px;">*发票号：<u>${outboundOrder.faPiaoHao }</u></div>
        	
        	<div style="clear: both;"></div>
        </td>
      </tr>
      <tr>
        <td colspan="9" style="border-bottom:solid 0px #000000;border-top:solid 0px #000000;border-right: 1px solid #000; ">
        	<div style="float: left;min-width: 180px;">*上牌时间：<u>${customerFile.carNoDate }</u></div>
        	<div style="float: left;min-width: 180px;">*车牌号：<u>${customer.customerLastBussi.carPlateNo }</u></div>
        	<div style="float: left;min-width: 180px;">*交车日期：
        			<u><fmt:formatDate value="${customerFile.jcDate }" pattern="yyyy"/></u>年
        			<u><fmt:formatDate value="${customerFile.jcDate }" pattern="MM"/></u>月
        			<u><fmt:formatDate value="${customerFile.jcDate }" pattern="dd"/></u>日 
        	 </div>
        	<div style="clear: both;"></div>
        </td>
      </tr>
      <tr>
        <td colspan="9" style="border-bottom:solid 0px #000000;border-top:solid 0px #000000;border-right: 1px solid #000; ">
        	<div style="float: left;height: 20px;">*是否特销：
        	</div>
        		<c:forEach var="specialPan" items="${specialPans }" varStatus="i">
        		<div style="float: left;height: 35px;">
					<label style="">
							<input type="checkbox" name="specialPans" ${specialPan.dbid==customerFile.specialPlan.dbid?'checked="checked"':'' } >${specialPan.name }
						</label>
					</div>
				</c:forEach>
				<div style="clear: both;"></div>
        </td>
      </tr>
     <tr>
        <td colspan="9" class="noLine" style="border-right: 0px;border-right: 1px solid #000;">
        	<div style="float: left;min-width: 180px;">
        		*购车价格：<u>${outboundOrder.invoicePrice }</u>元（开票价格）
         		*付款方式：
             <input type="checkbox" name="checkboxGroup3" value="单选" id="checkboxGroup3_0"  ${orderContractExpenses.buyCarType==1?'checked="checked"':'' }/> 一次付清
              <input type="checkbox" name="checkboxGroup3" value="单选" id="checkboxGroup3_1"  ${orderContractExpenses.buyCarType==2?'checked="checked"':'' }/>分期付款
           </div>
        </td>
      </tr>
       <tr>
        <td colspan="9" class="noLine" style="border-right: 0px;border-right: 1px solid #000;">
        	<div style="float: left;min-width: 180px;">
        		*初次级别：${customer.firstCustomerPhase.name}
           </div>
        </td>
      </tr>

      <tr>
        <td colspan="9" class="noLineTitle" >二、客户联系方式</td>
      </tr>
      <tr>
      	<td colspan="9" class="noLine">
	        <div style="float: left;min-width: 180px;">*客户姓名：<u>${customer.name }</u></div>
	        <div style="float: left;min-width: 260px;">*常用手机号：<u>${customer.mobilePhone }</u></div>
	        <div style="float: left;min-width: 180px;">电话：<u>${customer.phone }</u></div>
	        <div style="float: left;min-width: 180px;">使用人：<u>${customer.customerBussi.buyCarMainUse.name }</u></div>
	        <div style="clear: both;"></div>
        </td>
      </tr>
  
  <%--     <tr>
      	<td colspan="9" class="noLine">
      		<div style="float: left;min-width: 180px;">*证件类型：${customer.paperwork.name }</div>
	        <div style="float: left;width: 260px;">*证件号码：<u>${customer.icard }</u></div>
	        <div style="float: left;min-width: 180px;">QQ号码：<u>${customer.qq }</u></div>
	        <div style="float: left;min-width: 180px;">*爱好：<u>${customer.interest.name }</u></div>
	         <div style="clear: both;"></div>
      	</td>
      </tr> --%>
       <tr>
        <td colspan="9" class="noLine">
        	<div style="float: left;min-width: 280px;">*通讯地址：<u>${customer.area.fullName }${customer.address }</u></div>
        	<div style="float: left;min-width: 280px;">
        		&#12288;*现居住类型：<input type="checkbox" value=""  ${customerFile.nowJuzuType==1?'checked="checked"':'' }/>城镇
        					<input type="checkbox" value="" ${customerFile.nowJuzuType==2?'checked="checked"':'' }/>农村
        	</div>
      	    <div style="float: left;min-width: 180px;">电子邮件：<u>${customer.email }</u></div>
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
        <td colspan="9" class="noLineTitle">
          三、客户信息 
          	&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
          	&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
          单位购车客户</td>
        </tr>
    <tr>
        <td colspan="2" class="noLine" align="right" style="border:0px;border-left: 1px solid #000;">
        	*单位名称：
        </td>
		<td colspan="4" style="border:0px;border-top: 0px ;border-left: 0px;border-right: 0px"><u>${customerFile.depName }</u></td>
		<td colspan="3" style="border:0px;border-right: 1px solid #000;">
        	<div style="float: left;min-width: 180px;">*联系人姓名：
        		<u>${customerFile.contactPerson }</u>
        	</div>
        	<div style="clear: both;"></div>
          </td>
      </tr>
  <tr>
  		<td colspan="2" class="noLine" align="right" style="border-top: 0px ;border-right: 0px;">
        	*单位性质：
        </td>
	    <td colspan="7" align="left" style="border: 0px ;border-right: 1px solid #000;">
	    </td>
  </tr>
  <tr>
  	<td colspan="1" style="border-top: 0px ;border-right: 0px;" ></td>
  	<td colspan="8" style="border: 0px ;;border-right: 1px solid #000;">
	   		<c:forEach var="depNature" items="${depNatures }" varStatus="i">
	   			<div style="float: left;min-width: 200px;" >
	              <input type="checkbox" name="checkboxGroup4" value="单选" id="checkboxGroup4_0" ${depNature.dbid==customerFile.depNature.dbid?'checked="checked"':'' }/>
	              	${depNature.name }
			 	 </div>
			 	 <c:if test="${(i.index+1)%3==0 }">
					<div style="clear: both;"></div>
				</c:if>
			</c:forEach>
  	</td>
  </tr>     
     <tr>
     <td colspan="6" align="left" style="border-bottom: 0px ;border-right: 0px;">*行业：（请说明具体职业）
	    </td>
	    <td colspan="3" style="border-bottom: 0px ;border-left: 0px;">
	    </td>
  </tr>
 <tr>
   	<td style="border-right: 0px;border-top: 1px;"></td>
   	<td colspan="8" style="border-left: 0px;border-top: 0px;">
   		 <div style="min-width: 180px;line-height: 16px;">
    		<div style="float: left;min-width: 200px;">
              <c:forEach var="industry" items="${industries }" varStatus="i">
        		<div style="float: left;min-width: 200px;margin-right: 5px;float: left;height: 25px;">
					<label style="">
						<input type="checkbox" name="infoFrom" ${industry.dbid==customer.industry.dbid?'checked="checked"':'' }  value="${industry.dbid }" id="infoFrom${i.index }" >${industry.name }
					</label>
				</div>
				<c:if test="${(i.index+1)%3==0 }">
					<div style="clear: both;"></div>
				</c:if>
			</c:forEach> 
   	</td>
   </tr>
 <tr>
	    <td colspan="2" align="right" style="border-bottom: 0px ;border-right: 0px;">*车辆性质：
	    </td>
	    <td colspan="4" style="border: 0px "></td>
	    <td colspan="3" style="border: 0px ;border-right: 1px solid #000;">
	    </td>
  </tr>
  <tr>
  	<td colspan="1" style="border: 0px ;border-left: 1px solid #000;" ></td>
  	<td colspan="8" style="border: 0px ;border-right: 1px solid #000;">
           <c:forEach var="carNatrue" items="${carNatrues }" varStatus="i">
	       		<div style="float: left;min-width: 200px;margin-right: 2px;float: left;height: 25px;">
						<input type="checkbox" name="infoFrom" ${carNatrue.dbid==customerFile.carNature.dbid?'checked="checked"':'' }  value="${carNatrue.dbid }" id="infoFrom${i.index }" >${carNatrue.name }</input>
				</div>
				<c:if test="${(i.index+1)%3==0 }">
					<div style="clear: both;"></div>
				</c:if>
		</c:forEach> 
  	</td>
  </tr>     
   <tr>
	    <td colspan="9" align="right"  style="border: 1px solid #000;height: 80px;border-top: 0px solid #000;">
	   </td>
  </tr>
 <tr>
    <td colspan="9" align="right" class="noLine" style="border-right: 1px solid #000;height: 160px;">
    	<div style="margin: 0 auto;width:200px;border-bottom: 1px solid #000;float: right;padding-bottom: 28px;">
	    </div>
    	<div style="float: right;">客户签字：</div>
    	<div style="margin: 0 auto;width:200px;border-bottom: 1px solid #000;float: right;padding-bottom: 1px;text-align: left;">
    		 ${ customer.user.realName}
	    </div>
    	 <div style="float: right;">销售顾问签字：</div>
       <div style="clear: both;"></div>
    </td>
  </tr>
  <tr>
  	<td colspan="9" style="border-top: 0px;">
  		<div style="margin: 0 auto;width: 600px;text-align: center;">
        	${customer.customerPidBookingRecord.brand.name }汽车股份有限公司
       </div>
  	</td>
  </tr> 
</table>
</div>
</body>
</html>
