<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ include file="../../commons/taglib.jsp" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>奇瑞公司客户档案登记表（个人）</title>
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
    line-height: 25px;
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
	<a href="javascript:;"  class="btn btn-success " onclick="window.location.href='${ctx}/customer/customerFolder?dbid=${param.dbid }&type=2'" style="margin-left: 5px;">单位档案</a>
</div>
<div class="testDriverContent" style="width: 98%;margin-bottom: 40px;">
<table cellpadding="0" cellspacing="0" border="0" style="margin-top: 10px;">
	<tr height="50">
		<td class="noLine" style="border: 0px solid #000000;">
			<img src="${ctx }/images/xwqr/logo.png" width="80"></img>
		</td>
		<td class="noLine" style="text-align: center;font-size: 18px;font-weight: bold;border: 0px solid #000000;width: 160px;">表1—奇瑞公司客户档案登记表（私人） </td>
		<td style="border: 0px solid #000000;"></td>
	</tr>
</table>
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
<tr height="30">
	<td colspan="6" height="40"></td>
	<td colspan="2" height="40">填写时间 
					<fmt:formatDate value="${now }" pattern="yyyy  年 MM 月 dd 日"/>
	<td>编号：${customer.sn }</td>
</tr>
<tr>
    <td style="" colspan="2">
        销售服务商名称/盖章
    </td>
    <td colspan="5">
      *（如为二级销售，填写二级经销商名称）   *销售顾问： ${customer.bussiStaff }
   </td>
   <td rowspan="2"  class="labelTitle">
   	要求：
   </td>
    <td colspan="2" rowspan="3">
        <p>1、此表由销售服务商自行打印或印刷，由客户填写，销售顾问核对确认；</p>
    	<P>2、会员业务专员/客服专员根据此表将客户档案信息上传至DCS，此表自行留存、备查。</P>
    </td>
  </tr>
  <tr>
   	<td colspan="2"> 
   		销售服务商类型：
   	</td>
   	<td colspan="5">
        <label><input type="checkbox" name="checkboxGroup1" value="单选" id="checkboxGroup1_0" />一级销售服务商（本公司）</label>
        <label><input type="checkbox" name="checkboxGroup1" value="单选" id="checkboxGroup1_1" />二级销售服务商，名称：</label>
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
        <td colspan="6" style="border-bottom:solid 0px #000000;border-top:solid 0px #000000 ;border-right: 0px;">
	       <div style="float: left;min-width: 180px;"> *车辆底盘号：${customer.customerPidBookingRecord.vinCode }&#12288;</div>
	       <div style="float: left;min-width: 180px;"> *车型：${customer.customerLastBussi.carSeriy.name }  ${customer.customerLastBussi.carModel.name }${customer.carModelStr}&#12288;</div>
	       <div style="float: left;min-width: 180px;">  *颜色:${customer.customerLastBussi.carColor.name }&#12288;</div>
	       <div style="clear: both;"></div>
	     </td>
	     <td colspan="3" class="noLine" style="border-left: 0px;">
	     	*信息获取渠道（单选）：
	     </td>
      </tr>
      <tr>
        <td colspan="6" style="border-bottom:solid 0px #000000;border-top:solid 0px #000000;border-right: 0px; ">
        	<div style="float: left;min-width: 180px;">*开发票日期：</div>
        	<div style="float: left;min-width: 180px;">*发票号：</div>
        	<div style="float: left;min-width: 180px;">*车牌号：${customer.customerLastBussi.carPlateNo }</div>
        	<div style="clear: both;"></div>
        </td>
        <td colspan="3" rowspan="4" style="border-bottom:solid 0px #000000;border-top:solid 0px #000000 ;border-left: 0px;">
        	<c:forEach var="infoFrom" items="${infoFroms }" varStatus="i" end="16">
        		<div style="min-width: 90px;margin-right: 5px;float: left;height: 20px;">
					<label style="">
						<input type="checkbox" name="infoFrom" ${infoFrom.dbid==customer.infoFrom.dbid?'checked="checked"':'' }  value="${infoFrom.dbid }" id="infoFrom${i.index }" >${infoFrom.name }
					</label>
				</div>
				<c:if test="${(i.index+1)%4==0 }">
					<div style="clear: both;"></div>
				</c:if>
			</c:forEach> 
        </td>
      </tr>
      <tr>
        <td colspan="6" style="border-bottom:solid 0px #000000;border-top:solid 0px #000000;border-right: 0px; ">
        	<div style="float: left;min-width: 180px;">*交车日期：      年      月         日 </div>
        	<div style="clear: both;"></div>
        </td>
      </tr>
      <tr>
        <td colspan="6" style="border-bottom:solid 0px #000000;border-top:solid 0px #000000;border-right: 0px; ">
        	<div style="float: left;height: 20px;">*是否特销：
        	</div>
        		<div style="float: left;height: 25px;">
					<label style="">
						<input type="checkbox" name="infoFrom" >非特销车
					</label>
				</div>
        		<div style="float: left;height: 25px;">
					<label style="">
						<input type="checkbox" name="infoFrom" >出租
					</label>
				</div>
        		<div style="float: left;height: 25px;">
					<label style="">
						<input type="checkbox" name="infoFrom" >二手车
					</label>
				</div>
        		<div style="float: left;height: 25px;">
					<label style="">
						<input type="checkbox" name="infoFrom" >钢铁
					</label>
				</div>
        		<div style="float: left;height: 25px;">
					<label style="">
						<input type="checkbox" name="infoFrom" >公安
					</label>
				</div>
        		<div style="float: left;height: 25px;">
					<label style="">
						<input type="checkbox" name="infoFrom" >集团
					</label>
				</div>
        		<div style="margin-right: 3px;float: left;height: 25px;">
					<label style="">
						<input type="checkbox" name="infoFrom" >教师
					</label>
				</div>
        		<div style="float: left;height: 25px;">
					<label style="">
						<input type="checkbox" name="infoFrom" >企业
					</label>
				</div>
        		<div style="float: left;height: 25px;">
					<label style="">
						<input type="checkbox" name="infoFrom" >医院
					</label>
				</div>
        		<div style="float: left;height: 25px;">
					<label style="">
						<input type="checkbox" name="infoFrom" >政府
					</label>
				</div>
        		<div style="float: left;height: 25px;">
					<label style="">
						<input type="checkbox" name="infoFrom" >租赁
					</label>
				</div>
				<div style="clear: both;"></div>
        </td>
      </tr>
      <tr>
        <td colspan="6" class="noLine" style="border-right: 0px;">
        	<div style="float: left;min-width: 180px;">
        		*购车价格：&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;元（开票价格）
         		*付款方式：
            <label>
              <input type="checkbox" name="checkboxGroup3" value="单选" id="checkboxGroup3_0" /> 一次付清
             </label>
            <label>
              <input type="checkbox" name="checkboxGroup3" value="单选" id="checkboxGroup3_1" />分期付款
             </label>
           </div>
        </td>
      </tr>
      <tr>
        <td colspan="6" class="noLine" style="border-right: 0px;">
        	<div style="float: left;min-width: 180px;">
        		*初次级别：${customer.firstCustomerPhase.name}
            <label>
           </div>
        </td>
      </tr>

      <tr>
        <td colspan="9" class="noLineTitle" >二、客户联系方式</td>
      </tr>
      <tr>
      	<td colspan="9" class="noLine">
	        <div style="float: left;min-width: 180px;">*客户姓名：${customer.name }</div>
	        <div style="float: left;min-width: 260px;">*常用手机号：${customer.mobilePhone }</div>
	        <div style="float: left;min-width: 180px;">使用人：${customer.customerBussi.buyCarMainUse.name }</div>
	        <div style="float: left;min-width: 180px;">电话：${customer.phone }</div>
	        <div style="clear: both;"></div>
        </td>
      </tr>
  
      <tr>
      	<td colspan="9" class="noLine">
      		<div style="float: left;min-width: 180px;">*证件类型：${customer.paperwork.name }</div>
	        <div style="float: left;width: 260px;">*证件号码：${customer.icard }</div>
	        <div style="float: left;min-width: 180px;">*QQ号码：${customer.qq }</div>
	        <div style="float: left;min-width: 180px;">*爱好：${customer.interests }</div>
	         <div style="clear: both;"></div>
      	</td>
      </tr>
        <tr>
        <td colspan="9" class="noLine">
        	<div style="float: left;min-width: 280px;">*身份证地址：${customer.area.fullName }${customer.address }</div>
        	<div style="float: left;min-width: 280px;">
        		*现居住类型：<input type="checkbox" value=""  />城镇
        					<input type="checkbox" value="" />农村
        	</div>
      	    <div style="float: left;min-width: 180px;">电子邮件：${customer.email }</div>
      	    <div style="clear: both;"></div>
       </tr>
      <tr>
        <td colspan="9" class="noLineTitle">
          三、客户信息 
          	&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
          	&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
          私人购车客户</td>
        </tr>
    <tr>
        <td colspan="2" class="noLine" align="right" style="border-top: 0px ;border-right: 0px;">
        	*客户姓名：
        </td>
		<td colspan="2" style="border-top: 0px ;border-left: 0px;border-right: 0px">${customer.name }</td>
		<td colspan="2" style="border-top: 0px ;border-left: 0px;;border-right: 0px;">
        	<div style="float: left;min-width: 180px;margin-left: 120px;">*性别：
        		<input type="checkbox" value="" ${'男'==customer.sex?'checked="checked"':'' } />男
        		<input type="checkbox" value="" ${'女'==customer.sex?'checked="checked"':'' }/>女
        	</div>
		</td>
		<td colspan="3" style="border-top: 0px ;border-left: 0px;">
        	<div style="float: left;min-width: 180px;">*婚姻状况：
        		<input type="checkbox" value=""/>未婚
        		<input type="checkbox" value=""/>已婚
        	</div>
        	<div style="clear: both;"></div>
          </td>
      </tr>
    <tr>
	    <td colspan="2" align="right" style="border-bottom: 0px ;border-right: 0px;">*车辆信息：
	    </td>
	    <td colspan="4" style="border: 0px "></td>
	    <td colspan="3" style="border-bottom: 0px ;border-left: 0px;">
	    	*驾龄：
	    </td>
  </tr>
  <tr>
  	<td colspan="1" style="border-top: 0px ;border-right: 0px;" ></td>
  	<td colspan="5" style="border: 0px ;border-bottom: 1px solid #000;">
          <div style="float: left;min-width: 120px;" >
            <label >
              <input type="checkbox" name="checkboxGroup4" value="单选" id="checkboxGroup4_0" />
              “三包”车
             </label>
		  </div>
		  <div style="float: left;min-width: 120px;" >
            <label>
              <input type="checkbox" name="checkboxGroup4" value="单选" id="checkboxGroup4_1" />
              公务/商务车</label>
          </div>
          <div style="float: left;min-width: 120px;" >
            <label>
              <input type="checkbox" name="checkboxGroup4" value="单选" id="checkboxGroup4_2" />
              营运用车</label>
          </div>
         <div style="float: left;min-width: 120px;" >     
            <label>
              <input type="checkbox" name="checkboxGroup4" value="单选" id="checkboxGroup4_3" />
              非保修车
              </label>
         </div>
          <div style="float: left;min-width: 120px;" >
            <label>
              <input type="checkbox" name="checkboxGroup4" value="单选" id="checkboxGroup4_4" />
              特殊保修车
             </label>
          </div>
          <div style="float: left;min-width: 120px;" >
            <label>
              <input type="checkbox" name="checkboxGroup4" value="单选" id="checkboxGroup4_5" />
              家用（非三包车）
             </label>
          </div>
  	</td>
  	<td colspan="3" style="border-top: 0px ;border-left: 0px;">
  		<div style="float: left;min-width: 120px;" >
            <label >
              <input type="checkbox" name="checkboxGroup4" value="单选" id="checkboxGroup4_0" />
              尚未领证
             </label>
		  </div>
		  <div style="float: left;min-width: 120px;" >
            <label>
              <input type="checkbox" name="checkboxGroup4" value="单选" id="checkboxGroup4_1" />
              3～5年</label>
          </div>
          <div style="float: left;min-width: 120px;" >
            <label>
              <input type="checkbox" name="checkboxGroup4" value="单选" id="checkboxGroup4_2" />
             1年以内</label>
          </div>
         <div style="float: left;min-width: 120px;" >     
            <label>
              <input type="checkbox" name="checkboxGroup4" value="单选" id="checkboxGroup4_3" />
             5～10年
              </label>
         </div>
          <div style="float: left;min-width: 120px;" >
            <label>
              <input type="checkbox" name="checkboxGroup4" value="单选" id="checkboxGroup4_4" />
             1～3年
             </label>
          </div>
          <div style="float: left;min-width: 120px;" >
            <label>
              <input type="checkbox" name="checkboxGroup4" value="单选" id="checkboxGroup4_5" />
              10年以上
             </label>
          </div>
  	</td>
  </tr>     
  <tr>
     <td colspan="4" align="left" style="border-bottom: 0px ;border-right: 0px;">*行业：（请说明具体职业）
	    </td>
	    <td colspan="2" style="border: 0px "></td>
	    <td colspan="3" style="border-bottom: 0px ;border-left: 0px;">
	    	*驾龄：
	    </td>
  </tr>
  <tr>
   	<td style="border-right: 0px;border-top: 1px;"></td>
   	<td colspan="8" style="border-left: 0px;border-top: 0px;">
   		 <div style="min-width: 180px;line-height: 16px;">
    		<div style="float: left;min-width: 200px;">
            <label>
              <input type="checkbox" name="checkboxGroup4" value="单选" id="checkboxGroup4_0" />
              农/林/牧/渔</label>
              </div>
             <div style="float: left;min-width: 200px;">
            <label>
              <input type="checkbox" name="checkboxGroup4" value="单选" id="checkboxGroup4_1" />
              批发/零售业</label>
              </div>
              <div style="float: left;min-width: 200px;">
            <label>
              <input type="checkbox" name="checkboxGroup4" value="单选" id="checkboxGroup4_2" />
              居民服务/其他服务业</label>
             </div>
              <div style="float: left;min-width: 200px;">
            <label>
              <input type="checkbox" name="checkboxGroup4" value="单选" id="checkboxGroup4_3" />
              采矿业</label>
              </div>
              <div style="float: left;min-width: 200px;">
            <label>
              <input type="checkbox" name="checkboxGroup4" value="单选" id="checkboxGroup4_4" />
              住宿/餐饮业</label>
              </div>
              <div style="float: left;min-width: 200px;">
            <label>
              <input type="checkbox" name="checkboxGroup4" value="单选" id="checkboxGroup4_5" />
              电力/燃气/水的生产和供应业</label>
              </div>
              
               <div style="float: left;min-width: 200px;">
            <label>
              <input type="checkbox" name="checkboxGroup4" value="单选" id="checkboxGroup4_6" />
              制造业</label>
              </div>
               <div style="float: left;min-width: 200px;">
            <label>
              <input type="checkbox" name="checkboxGroup4" value="单选" id="checkboxGroup4_7" />
              交通运输/仓储/邮政业</label>
              </div>
               <div style="float: left;min-width: 200px;">
            <label>
              <input type="checkbox" name="checkboxGroup4" value="单选" id="checkboxGroup4_8" />
              卫生/社会保障/社会福利业</label>
              </div>
              
               <div style="float: left;min-width: 200px;">
            <label>
              <input type="checkbox" name="checkboxGroup4" value="单选" id="checkboxGroup4_6" />
              教育</label>
              </div>
               <div style="float: left;min-width: 200px;">
              <label>
              <input type="checkbox" name="checkboxGroup4" value="单选" id="checkboxGroup4_6" />
              房地产业</label>
              </div>
               <div style="float: left;min-width: 200px;">
              <label>
              <input type="checkbox" name="checkboxGroup4" value="单选" id="checkboxGroup4_6" />
              文化/体育/娱乐业</label>
              </div>
              
               <div style="float: left;min-width: 200px;">
              <label>
              <input type="checkbox" name="checkboxGroup4" value="单选" id="checkboxGroup4_6" />
              建筑业</label>
              </div>
               <div style="float: left;min-width: 200px;">
              <label>
              <input type="checkbox" name="checkboxGroup4" value="单选" id="checkboxGroup4_6" />
              租赁/商务服务业</label>
              </div>
               <div style="float: left;min-width: 200px;">
              <label>
              <input type="checkbox" name="checkboxGroup4" value="单选" id="checkboxGroup4_6" />
              公共管理/社会组织</label>
              </div>
              
               <div style="float: left;min-width: 200px;">
              <label>
              <input type="checkbox" name="checkboxGroup4" value="单选" id="checkboxGroup4_6" />
              金融业</label>
              </div>
               <div style="float: left;min-width: 200px;">
              <label>
              <input type="checkbox" name="checkboxGroup4" value="单选" id="checkboxGroup4_6" />
              科学研究/技术服务/地质勘查业</label>
              </div>
               <div style="float: left;min-width: 200px;">
              <label>
              <input type="checkbox" name="checkboxGroup4" value="单选" id="checkboxGroup4_6" />
              信息传输/计算机服务和软件业</label>
              </div> 
              <!--<c:forEach var="infoFrom" items="${infoFroms }" varStatus="i">
        		<div style="min-width: 90px;margin-right: 5px;float: left;height: 25px;">
					<label style="">
						<input type="checkbox" name="infoFrom" ${infoFrom.dbid==customer.infoFrom.dbid?'checked="checked"':'' }  value="${infoFrom.dbid }" id="infoFrom${i.index }" >${infoFrom.name }
					</label>
				</div>
				<c:if test="${(i.index+1)%4==0 }">
					<div style="clear: both;"></div>
				</c:if>
			</c:forEach> -->
   	</td>
   </tr>
    <tr>
  	<td colspan=""align="right" class="noLine" style="border-right: 0px;">
    	*学历：
    </td>
  	<td colspan="5"  class="noLine" style="border-right: 0px;border-left: 0px;">
  	</td>
  	<td colspan="3"  class="noLine" style="border-left: 0px;">
  		*税前年收入：
  	</td>
  </tr>
  <tr>
  	<td colspan="1" style="border-top: 0px ;border-right: 0px;" ></td>
  	<td colspan="5" style="border: 0px ;border-bottom: 1px solid #000;">
          <div style="float: left;min-width: 180px;" >
            <label >
              <input type="checkbox" name="checkboxGroup4" value="单选" id="checkboxGroup4_0" />
              博士后
             </label>
		  </div>
		  <div style="float: left;min-width: 180px;" >
            <label>
              <input type="checkbox" name="checkboxGroup4" value="单选" id="checkboxGroup4_1" />
              大专</label>
          </div>
          <div style="float: left;min-width: 180px;" >
            <label>
              <input type="checkbox" name="checkboxGroup4" value="单选" id="checkboxGroup4_2" />
              博士</label>
          </div>
         <div style="float: left;min-width: 180px;" >     
            <label>
              <input type="checkbox" name="checkboxGroup4" value="单选" id="checkboxGroup4_3" />
              高中/中专/技校/职高
              </label>
         </div>
          <div style="float: left;min-width: 180px;" >
            <label>
              <input type="checkbox" name="checkboxGroup4" value="单选" id="checkboxGroup4_4" />
              硕士
             </label>
          </div>
          <div style="float: left;min-width: 180px;" >
            <label>
              <input type="checkbox" name="checkboxGroup4" value="单选" id="checkboxGroup4_5" />
              初中及以下
             </label>
          </div>
          <div style="float: left;min-width: 180px;" >
            <label>
              <input type="checkbox" name="checkboxGroup4" value="单选" id="checkboxGroup4_5" />
              本科
             </label>
          </div>
  	</td>
  	<td colspan="3" style="border-top: 0px ;border-left: 0px;">
  		<div style="float: left;min-width: 160px;" >
            <label >
              <input type="checkbox" name="checkboxGroup4" value="单选" id="checkboxGroup4_0" />
              35万以上
             </label>
		  </div>
		  <div style="float: left;min-width: 160px;" >
            <label>
              <input type="checkbox" name="checkboxGroup4" value="单选" id="checkboxGroup4_1" />
              15-20万</label>
          </div>
          <div style="float: left;min-width: 160px;" >
            <label>
              <input type="checkbox" name="checkboxGroup4" value="单选" id="checkboxGroup4_2" />
             30-35万</label>
          </div>
         <div style="float: left;min-width: 160px;" >     
            <label>
              <input type="checkbox" name="checkboxGroup4" value="单选" id="checkboxGroup4_3" />
            10-15万
              </label>
         </div>
          <div style="float: left;min-width: 160px;" >
            <label>
              <input type="checkbox" name="checkboxGroup4" value="单选" id="checkboxGroup4_4" />
             25-30万
             </label>
          </div>
          <div style="float: left;min-width: 160px;" >
            <label>
              <input type="checkbox" name="checkboxGroup4" value="单选" id="checkboxGroup4_5" />
              5-10万
             </label>
          </div>
          <div style="float: left;min-width: 160px;" >
            <label>
              <input type="checkbox" name="checkboxGroup4" value="单选" id="checkboxGroup4_4" />
            20-25万
             </label>
          </div>
          <div style="float: left;min-width: 160px;" >
            <label>
              <input type="checkbox" name="checkboxGroup4" value="单选" id="checkboxGroup4_5" />
             5万以下
             </label>
          </div>
  	</td>
  </tr>  
  <tr>
  	<td colspan="4" align="left" class="noLine" style="border-right: 0px;">
    	*和您一起住的有几口人（含本人）：
    </td>
  	<td colspan="3"  class="noLine" style="border-right: 0px;border-left: 0px;" align="left">
  		*购车经历：
  	</td>
  	<td colspan="1"  class="noLine" style="border-right: 0px;border-left: 0px;" align="right">
  		*年龄：
  	</td>
  	<td class="noLine" style="border-left: 0px;"></td>
  </tr>   
  <tr>
  	<td colspan="1" style="border-top: 0px ;border-right: 0px;" ></td>
  	<td colspan="2" style="border: 0px ;border-bottom: 1px solid #000;">
          <div style="float: left;min-width: 140px;" >
            <label >
              <input type="checkbox" name="checkboxGroup4" value="单选" id="checkboxGroup4_0" />
              1人
             </label>
		  </div>
		  <div style="float: left;min-width: 140px;" >
            <label>
              <input type="checkbox" name="checkboxGroup4" value="单选" id="checkboxGroup4_1" />
              2人</label>
          </div>
          <div style="float: left;min-width: 140px;" >
            <label>
              <input type="checkbox" name="checkboxGroup4" value="单选" id="checkboxGroup4_2" />
              3人</label>
          </div>
         <div style="float: left;min-width: 140px;" >     
            <label>
              <input type="checkbox" name="checkboxGroup4" value="单选" id="checkboxGroup4_3" />
              4人
              </label>
         </div>
         <div style="float: left;min-width: 140px;" >     
            <label>
              <input type="checkbox" name="checkboxGroup4" value="单选" id="checkboxGroup4_3" />
              5人以上
              </label>
         </div>
         <div style="clear: both;"></div>
  	</td>
  	<td colspan="1" style="border:0;border-bottom: 1px solid #000;" ></td>
  	<td colspan="2" style="border:0;border-bottom: 1px solid #000;">
  		<div style="float: left;min-width: 140px;" >
            <label >
              <input type="checkbox" name="checkboxGroup4" value="单选" id="checkboxGroup4_0" />
              第一次购车
             </label>
		  </div>
		  <div style="float: left;min-width: 140px;" >
            <label>
              <input type="checkbox" name="checkboxGroup4" value="单选" id="checkboxGroup4_1" />
              增购车（非奇瑞老用户）</label>
          </div>
          <div style="float: left;min-width: 140px;" >
            <label>
              <input type="checkbox" name="checkboxGroup4" value="单选" id="checkboxGroup4_2" />
             增购车（奇瑞老用户）</label>
          </div>
         <div style="float: left;min-width: 140px;" >     
            <label>
              <input type="checkbox" name="checkboxGroup4" value="单选" id="checkboxGroup4_3" />
            替代原车（非奇瑞老用户）
              </label>
         </div>
          <div style="float: left;min-width: 140px;" >
            <label>
              <input type="checkbox" name="checkboxGroup4" value="单选" id="checkboxGroup4_4" />
            替代原车（奇瑞老用户）
             </label>
          </div>
          <div style="clear: both;"></div>
  	</td>
  	<!-- <td colspan="1" style="border:0;border-bottom: 1px solid #000;" ></td> -->
  	<td colspan="1" style="border:0;border-bottom: 1px solid #000;" align="right">
  		<div style="float: left;min-width: 140px;" >
  			<div style="float: left;">
              <input type="checkbox" name="checkboxGroup4" value="单选" id="checkboxGroup4_0" />
             </div>
              <div style="float:left;border-bottom: 1px solid #000;">
              &#12288;&#12288;&#12288;&#12288;
              </div>
           <div class="clear"></div>
		  </div>
  		<div style="float: left;min-width: 140px;" >
  			<div style="float: left;">
              <input type="checkbox" name="checkboxGroup4" value="单选" id="checkboxGroup4_0" />
             </div>
              <div style="float:left;border-bottom: 1px solid #000;">
              &#12288;&#12288;&#12288;&#12288;
              </div>
           <div class="clear"></div>
		  </div>
  		<div style="float: left;min-width: 140px;" >
  			<div style="float: left;">
              <input type="checkbox" name="checkboxGroup4" value="单选" id="checkboxGroup4_0" />
             </div>
              <div style="float:left;border-bottom: 1px solid #000;">
              &#12288;&#12288;&#12288;&#12288;
              </div>
           <div class="clear"></div>
		  </div>
  		<div style="float: left;min-width: 140px;" >
  			<div style="float: left;">
              <input type="checkbox" name="checkboxGroup4" value="单选" id="checkboxGroup4_0" />
             </div>
              <div style="float:left;border-bottom: 1px solid #000;">
              &#12288;&#12288;&#12288;&#12288;
              </div>
           <div class="clear"></div>
		  </div>
  	</td>
  	<td colspan="1" style="border:0;border-bottom: 1px solid #000;" ></td>
  	<td style="border:0;border-bottom: 1px solid #000;border-right: 1px solid #000;">
  		<div style="float: left;min-width: 140px;" >
            <label >
              <input type="checkbox" name="checkboxGroup4" value="单选" id="checkboxGroup4_0" />
              20岁以下
             </label>
		  </div>
		  <div style="float: left;min-width: 140px;" >
            <label>
              <input type="checkbox" name="checkboxGroup4" value="单选" id="checkboxGroup4_1" />
              21-25岁</label>
          </div>
          <div style="float: left;min-width: 140px;" >
            <label>
              <input type="checkbox" name="checkboxGroup4" value="单选" id="checkboxGroup4_2" />
             26-30岁</label>
          </div>
         <div style="float: left;min-width: 140px;" >     
            <label>
              <input type="checkbox" name="checkboxGroup4" value="单选" id="checkboxGroup4_3" />
            31-35岁
              </label>
         </div>
          <div style="float: left;min-width: 140px;" >
            <label>
              <input type="checkbox" name="checkboxGroup4" value="单选" id="checkboxGroup4_4" />
            36-40岁
             </label>
          </div>
          <div style="float: left;min-width: 140px;" >
            <label>
              <input type="checkbox" name="checkboxGroup4" value="单选" id="checkboxGroup4_4" />
            41-45岁
             </label>
          </div>
          <div style="float: left;min-width: 140px;" >
            <label>
              <input type="checkbox" name="checkboxGroup4" value="单选" id="checkboxGroup4_4" />
            45岁以上
             </label>
          </div>
          <div style="clear: both;"></div>
  	</td>
  </tr>     
  <tr>
    <td colspan="3" align="right" class="noLine" style="border-right: 0px;">
    	 销售顾问签字：
    </td>
    <td colspan="2" class="noLine" style="border-right: 0px;border-left: 0px;">
	    <div style="margin: 0 auto;width:200px;padding-bottom: 20px;border-bottom: 1px solid #000;">
	    </div>
    </td>
    <td colspan="2" class="noLine"  style="border-right: 0px;border-left: 0px;">
    	客户签字：
    </td>
    <td colspan="2" class="noLine"  style="border-left: 0px;">
    	<div style="margin: 0 auto;width:200px;padding-bottom: 20px;border-bottom: 1px solid #000;">
	    </div>
       
    </td>
  </tr>
  <tr>
  	<td class="noLine" colspan="9">&#12288;&#12288;&#12288;&#12288;</td>
  </tr>
  <tr>
  	<td colspan="9" style="border-top: 0px;">
  		<div style="margin: 0 auto;width: 600px;text-align: center;">
        	奇瑞汽车股份有限公司
       </div>
  	</td>
  </tr>
</table>
</div>
<%-- <div class="testDriverContent" style="width: 98%;margin-bottom: 40px;">
<table cellpadding="0" cellspacing="0" border="0" style="margin-top: 10px;">
	<tr height="50">
		<td class="noLine" style="border: 0px solid #000000;">
			<img src="${ctx }/images/xwqr/logo.png" width="80"></img>
		</td>
		<td class="noLine" style="text-align: center;font-size: 18px;font-weight: bold;border: 0px solid #000000;width: 160px;">表1—奇瑞公司客户档案登记表（私人）(续表) </td>
		<td style="border: 0px solid #000000;"></td>
	</tr>
</table>
<table width="100%" border="1" cellpadding="0" cellspacing="0" style="margin-bottom: 12px;" class="contentTable">
<tr >
	<td width="120" style="width: 170px;border: 0;">&#12288;</td>
	<td width="40" style="width: 30px;border: 0;">&#12288;</td>
	<td width="120" style="width: 170px; border: 0;">&#12288;</td>
	<td width="60" style="width: 60px; border: 0;">&#12288;</td>
	<td width="140" style="width: 180px;border: 0;">&#12288;</td>
	<td width="100" style="width: 110px;border: 0;">&#12288;</td>
	<td width="80" style="width: 86px;border: 0;">&#12288;</td>
	<td width="120" style="width: 170px;border:1px;">&#12288;</td>
	<td width="140" style="width: 260px;border: 0;">&#12288;</td>
</tr>
<tr>
	<td colspan="6" ></td>
	<td colspan="2">填写时间 <fmt:formatDate value="${now}" pattern="yyyy年MM月dd日"/></td>
	<td>编号：${customer.sn }</td>
</tr>
<tr>
    <td style="">
        销售服务商名称/盖章
    </td>
    <td colspan="5">
      *（如为二级销售，填写二级经销商名称）   *销售顾问： 
   </td>
   <td rowspan="3"  class="labelTitle">
   	要求：
   </td>
    <td colspan="2" rowspan="3">
        <p>1、此表由销售服务商自行打印或印刷，由客户填写，销售顾问核对确认；</p>
    	<P>2、会员业务专员/客服专员根据此表将客户档案信息上传至DCS，此表自行留存、备查。</P>
    </td>
  </tr>
  <tr>
   	<td> 
   		销售服务商类型：
   	</td>
   	<td colspan="5">
        <label><input type="checkbox" name="checkboxGroup1" value="单选" id="checkboxGroup1_0" />一级销售服务商（本公司）</label>
        <label><input type="checkbox" name="checkboxGroup1" value="单选" id="checkboxGroup1_1" />二级销售服务商，名称：</label>
     </td>
  </tr>
   <tr>
   		<td> 填表说明：
   		<td colspan="5" style="padding-left: 30px;">“*”为必填项</td>
   </tr>
  <tr>
  	<td colspan=""align="right" class="noLine" style="border-right: 0px;">
    	*学历：
    </td>
  	<td colspan="5"  class="noLine" style="border-right: 0px;border-left: 0px;">
  	</td>
  	<td colspan="3"  class="noLine" style="border-left: 0px;">
  		
  	</td>
  </tr>
  <tr>
  	<td colspan="1" style="border-top: 0px ;border-right: 0px;" ></td>
  	<td colspan="5" style="border: 0px ;border-bottom: 1px solid #000;">
          <div style="float: left;min-width: 180px;" >
            <label >
              <input type="checkbox" name="checkboxGroup4" value="单选" id="checkboxGroup4_0" />
              博士后
             </label>
		  </div>
		  <div style="float: left;min-width: 180px;" >
            <label>
              <input type="checkbox" name="checkboxGroup4" value="单选" id="checkboxGroup4_1" />
              大专</label>
          </div>
          <div style="float: left;min-width: 180px;" >
            <label>
              <input type="checkbox" name="checkboxGroup4" value="单选" id="checkboxGroup4_2" />
              博士</label>
          </div>
         <div style="float: left;min-width: 180px;" >     
            <label>
              <input type="checkbox" name="checkboxGroup4" value="单选" id="checkboxGroup4_3" />
              高中/中专/技校/职高
              </label>
         </div>
          <div style="float: left;min-width: 180px;" >
            <label>
              <input type="checkbox" name="checkboxGroup4" value="单选" id="checkboxGroup4_4" />
              硕士
             </label>
          </div>
          <div style="float: left;min-width: 180px;" >
            <label>
              <input type="checkbox" name="checkboxGroup4" value="单选" id="checkboxGroup4_5" />
              初中及以下
             </label>
          </div>
          <div style="float: left;min-width: 180px;" >
            <label>
              <input type="checkbox" name="checkboxGroup4" value="单选" id="checkboxGroup4_5" />
              本科
             </label>
          </div>
  	</td>
  	<td colspan="3" style="border-top: 0px ;border-left: 0px;">
  		<div style="float: left;min-width: 160px;" >
            <label >
              <input type="checkbox" name="checkboxGroup4" value="单选" id="checkboxGroup4_0" />
              35万以上
             </label>
		  </div>
		  <div style="float: left;min-width: 160px;" >
            <label>
              <input type="checkbox" name="checkboxGroup4" value="单选" id="checkboxGroup4_1" />
              15-20万</label>
          </div>
          <div style="float: left;min-width: 160px;" >
            <label>
              <input type="checkbox" name="checkboxGroup4" value="单选" id="checkboxGroup4_2" />
             30-35万</label>
          </div>
         <div style="float: left;min-width: 160px;" >     
            <label>
              <input type="checkbox" name="checkboxGroup4" value="单选" id="checkboxGroup4_3" />
            10-15万
              </label>
         </div>
          <div style="float: left;min-width: 160px;" >
            <label>
              <input type="checkbox" name="checkboxGroup4" value="单选" id="checkboxGroup4_4" />
             25-30万
             </label>
          </div>
          <div style="float: left;min-width: 160px;" >
            <label>
              <input type="checkbox" name="checkboxGroup4" value="单选" id="checkboxGroup4_5" />
              5-10万
             </label>
          </div>
          <div style="float: left;min-width: 160px;" >
            <label>
              <input type="checkbox" name="checkboxGroup4" value="单选" id="checkboxGroup4_4" />
            20-25万
             </label>
          </div>
          <div style="float: left;min-width: 160px;" >
            <label>
              <input type="checkbox" name="checkboxGroup4" value="单选" id="checkboxGroup4_5" />
             5万以下
             </label>
          </div>
  	</td>
  </tr>  
  <tr>
  	<td colspan="3"align="right" class="noLine" style="border-right: 0px;padding-right: 120px;">
    	*和您一起住的有几口人（含本人）：
    </td>
  	<td colspan="2"  class="noLine" style="border-right: 0px;border-left: 0px;" align="left">
  		*购车经历：
  	</td>
  	<td class="noLine" style="border-right: 0px;border-left: 0px;">
  	</td>
  	<td class="noLine" style="border-right: 0px;border-left: 0px;">
  	</td>
  	<td colspan="1"  class="noLine" style="border-right: 0px;border-left: 0px;" align="right">
  		*年龄：
  	</td>
  	<td class="noLine" style="border-left: 0px;"></td>
  </tr>   
  <tr>
  	<td colspan="1" style="border-top: 0px ;border-right: 0px;" ></td>
  	<td colspan="2" style="border: 0px ;border-bottom: 1px solid #000;">
          <div style="float: left;min-width: 180px;" >
            <label >
              <input type="checkbox" name="checkboxGroup4" value="单选" id="checkboxGroup4_0" />
              1人
             </label>
		  </div>
		  <div style="float: left;min-width: 180px;" >
            <label>
              <input type="checkbox" name="checkboxGroup4" value="单选" id="checkboxGroup4_1" />
              2人</label>
          </div>
          <div style="float: left;min-width: 180px;" >
            <label>
              <input type="checkbox" name="checkboxGroup4" value="单选" id="checkboxGroup4_2" />
              3人</label>
          </div>
         <div style="float: left;min-width: 180px;" >     
            <label>
              <input type="checkbox" name="checkboxGroup4" value="单选" id="checkboxGroup4_3" />
              4人
              </label>
         </div>
         <div style="float: left;min-width: 180px;" >     
            <label>
              <input type="checkbox" name="checkboxGroup4" value="单选" id="checkboxGroup4_3" />
              5人以上
              </label>
         </div>
         <div style="clear: both;"></div>
  	</td>
  	<td colspan="1" style="border:0;border-bottom: 1px solid #000;" ></td>
  	<td colspan="2" style="border:0;border-bottom: 1px solid #000;">
  		<div style="float: left;min-width: 160px;" >
            <label >
              <input type="checkbox" name="checkboxGroup4" value="单选" id="checkboxGroup4_0" />
              第一次购车
             </label>
		  </div>
		  <div style="float: left;min-width: 160px;" >
            <label>
              <input type="checkbox" name="checkboxGroup4" value="单选" id="checkboxGroup4_1" />
              增购车（非奇瑞老用户）</label>
          </div>
          <div style="float: left;min-width: 160px;" >
            <label>
              <input type="checkbox" name="checkboxGroup4" value="单选" id="checkboxGroup4_2" />
             增购车（奇瑞老用户）</label>
          </div>
         <div style="float: left;min-width: 160px;" >     
            <label>
              <input type="checkbox" name="checkboxGroup4" value="单选" id="checkboxGroup4_3" />
            替代原车（非奇瑞老用户）
              </label>
         </div>
          <div style="float: left;min-width: 160px;" >
            <label>
              <input type="checkbox" name="checkboxGroup4" value="单选" id="checkboxGroup4_4" />
            替代原车（奇瑞老用户）
             </label>
          </div>
          <div style="clear: both;"></div>
  	</td>
  	<!-- <td colspan="1" style="border:0;border-bottom: 1px solid #000;" ></td> -->
  	<td colspan="1" style="border:0;border-bottom: 1px solid #000;" align="right">
  		<div style="float: left;min-width: 160px;" >
  			<div style="float: left;">
              <input type="checkbox" name="checkboxGroup4" value="单选" id="checkboxGroup4_0" />
             </div>
              <div style="float:left;border-bottom: 1px solid #000;">
              &#12288;&#12288;&#12288;&#12288;
              </div>
           <div class="clear"></div>
		  </div>
  		<div style="float: left;min-width: 160px;" >
  			<div style="float: left;">
              <input type="checkbox" name="checkboxGroup4" value="单选" id="checkboxGroup4_0" />
             </div>
              <div style="float:left;border-bottom: 1px solid #000;">
              &#12288;&#12288;&#12288;&#12288;
              </div>
           <div class="clear"></div>
		  </div>
  		<div style="float: left;min-width: 160px;" >
  			<div style="float: left;">
              <input type="checkbox" name="checkboxGroup4" value="单选" id="checkboxGroup4_0" />
             </div>
              <div style="float:left;border-bottom: 1px solid #000;">
              &#12288;&#12288;&#12288;&#12288;
              </div>
           <div class="clear"></div>
		  </div>
  		<div style="float: left;min-width: 160px;" >
  			<div style="float: left;">
              <input type="checkbox" name="checkboxGroup4" value="单选" id="checkboxGroup4_0" />
             </div>
              <div style="float:left;border-bottom: 1px solid #000;">
              &#12288;&#12288;&#12288;&#12288;
              </div>
           <div class="clear"></div>
		  </div>
  	</td>
  	<td colspan="1" style="border:0;border-bottom: 1px solid #000;" ></td>
  	<td style="border:0;border-bottom: 1px solid #000;border-right: 1px solid #000;">
  		<div style="float: left;min-width: 160px;" >
            <label >
              <input type="checkbox" name="checkboxGroup4" value="单选" id="checkboxGroup4_0" />
              20岁以下
             </label>
		  </div>
		  <div style="float: left;min-width: 160px;" >
            <label>
              <input type="checkbox" name="checkboxGroup4" value="单选" id="checkboxGroup4_1" />
              21-25岁</label>
          </div>
          <div style="float: left;min-width: 160px;" >
            <label>
              <input type="checkbox" name="checkboxGroup4" value="单选" id="checkboxGroup4_2" />
             26-30岁</label>
          </div>
         <div style="float: left;min-width: 160px;" >     
            <label>
              <input type="checkbox" name="checkboxGroup4" value="单选" id="checkboxGroup4_3" />
            31-35岁
              </label>
         </div>
          <div style="float: left;min-width: 160px;" >
            <label>
              <input type="checkbox" name="checkboxGroup4" value="单选" id="checkboxGroup4_4" />
            36-40岁
             </label>
          </div>
          <div style="float: left;min-width: 160px;" >
            <label>
              <input type="checkbox" name="checkboxGroup4" value="单选" id="checkboxGroup4_4" />
            41-45岁
             </label>
          </div>
          <div style="float: left;min-width: 160px;" >
            <label>
              <input type="checkbox" name="checkboxGroup4" value="单选" id="checkboxGroup4_4" />
            45岁以上
             </label>
          </div>
          <div style="clear: both;"></div>
  	</td>
  </tr>     
  <tr>
    <td colspan="3" align="right" class="noLine" style="border-right: 0px;">
    	 销售顾问签字：
    </td>
    <td colspan="2" class="noLine" style="border-right: 0px;border-left: 0px;">
	    <div style="margin: 0 auto;width:200px;padding-bottom: 20px;border-bottom: 1px solid #000;">
	    </div>
    </td>
    <td colspan="2" class="noLine"  style="border-right: 0px;border-left: 0px;">
    	客户签字：
    </td>
    <td colspan="2" class="noLine"  style="border-left: 0px;">
    	<div style="margin: 0 auto;width:200px;padding-bottom: 20px;border-bottom: 1px solid #000;">
	    </div>
       
    </td>
  </tr>
  <tr>
  	<td class="noLine" colspan="9">&#12288;&#12288;&#12288;&#12288;</td>
  </tr>
  <tr>
  	<td colspan="9" style="border-top: 0px;">
  		<div style="margin: 0 auto;width: 600px;text-align: center;">
        	奇瑞汽车股份有限公司
       </div>
  	</td>
  </tr>
</table>
</div> --%>
</body>
</html>

