/**
 * 通过生日 获取 年龄
 * @param strBirthday
 * @returns
 */
function getBirthdayAge(strBirthday,targetValue)
{       
    var returnAge;
    strBirthday =  strBirthday.replace(/-/g,"/");
	var oDate1 = new Date(strBirthday);
    var birthYear = oDate1.getYear();
    var birthMonth = oDate1.getMonth() + 1;
    var birthDay = oDate1.getDate();
    
    nowDate = new Date();
    var nowYear = nowDate.getYear();
    var nowMonth = nowDate.getMonth() + 1;
    var nowDay = nowDate.getDate();
    if(nowYear == birthYear)
    {
        returnAge = 0;//同年 则为0岁
    }
    else
    {
        var ageDiff = nowYear - birthYear ; //年之差
        if(ageDiff > 0)
        {
            if(nowMonth == birthMonth)
            {
                var dayDiff = nowDay - birthDay;//日之差
                if(dayDiff < 0)
                {
                    returnAge = ageDiff - 1;
                }
                else
                {
                    returnAge = ageDiff ;
                }
            }
            else
            {
                var monthDiff = nowMonth - birthMonth;//月之差
                if(monthDiff < 0)
                {
                    returnAge = ageDiff - 1;
                }
                else
                {
                    returnAge = ageDiff ;
                }
            }
        }
        else
        {
            returnAge = -1;//返回-1 表示出生日期输入错误 晚于今天
        }
    }
    $("#"+targetValue).val(returnAge);
}
function getBirthday(icard,birthdayInput){
	if(icard.length>=14){
		var birhday=icard.substring(6,10)+"-"+icard.substring(10,12)+"-"+icard.substring(12,14); 
		$("#"+birthdayInput).val("");
		$("#"+birthdayInput).val(birhday);
		getBirthdayAge(birhday,'age');
	}
}
function addDate(value){
    var d=new Date(); 
    var mm="";
    var dd="";
    $.post("${ctx}/customerPhase/ajax?dbid="+value+"&date="+new Date(),{},function(data){
    	if(0==data||data=='0'){
    		data=30;
    	}
    	data=parseInt(data)
    	d.setDate(d.getDate()+data); 
        var m=d.getMonth()+1; 
        if(m<10){
        	mm="0"+m;
        }else{
        	mm=m;
        }
        if(d.getDate()<10){
        	dd="0"+d.getDate();
        }else{
        	dd=d.getDate();
        }
        $("#nextReservationTimeTr").show();
        $("#maxDay").val(d.getFullYear()+'-'+mm+'-'+dd+' '+d.getHours()+':'+d.getMinutes());
        
    })
  } 
function ajaxArea(sel){
	var value=$(sel).val();
	$("#areaId").val(value);
	var sle= $(sel).nextAll();
	$(sle).remove();
	$.post("${ctx}/area/ajaxArea?parentId="+value+"&dateTime="+new Date(),{},function (data){
		if(data!="error"){
			var data=data.replace(/midea text/g,'weui_select');
			$("#areaLabel").append(data);
		}
	});
}
function marketingAct(trackType){
	  if(trackType==3){
		  $("#marketing").show();
		  $("#custMarketingActId").attr("checkType","integer,1");
		  $("#turnBackResult").attr("checkType","integer,1");
	  }else{
		  $("#marketing").hide();
		  $("#custMarketingActId").removeAttr("checkType");
		  $("#turnBackResult").removeAttr("checkType");
	  }
}
