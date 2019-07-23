package com.ystech.qywx.model;

/**
 * User: rizenguo
 * Date: 2014/10/22
 * Time: 21:29
 */


import java.lang.reflect.Field;
import java.util.HashMap;
import java.util.Map;

import com.thoughtworks.xstream.annotations.XStreamAlias;
import com.ystech.qywx.core.Configure;
import com.ystech.qywx.core.RandomStringGenerator;
import com.ystech.qywx.core.Signature;
import com.ystech.qywx.core.XStreamCDATA;

/**
 * 请求被扫支付API需要提交的数据
 */
@XStreamAlias("xml")
public class ScanPayReqData implements java.io.Serializable{
	private Integer dbid;
	@XStreamCDATA
	private String nonce_str = "";//随机字符串
	 
	@XStreamCDATA
	private String sign = "";//签名
	
	@XStreamCDATA
	private String mch_billno = "";//商户订单号
	
	@XStreamCDATA
	private String mch_id = "";//商户号
	
	@XStreamAlias("wxappid")
	@XStreamCDATA
    private String wxappid = "";//公众账号ID
	
	@XStreamCDATA
    private String send_name = "";//天虹百货
	
	@XStreamCDATA
    private String re_openid = "";//用户openid
	
	@XStreamCDATA
    private int total_amount = 0;//付款金额，单位分
	
	@XStreamCDATA
    private int total_num = 0;//红包发放总人数
	
	@XStreamCDATA
    private String wishing = "";//红包祝福语
	
	@XStreamCDATA
    private String client_ip = "";//终端IP APP和网页支付提交用户端ip，Native支付填调用微信支付API的机器IP 
	
	@XStreamCDATA
    private String act_name = "";//活动名称
	
	@XStreamAlias("remark")
	@XStreamCDATA
    private String remark = "";//备注信息
	
	private Integer redBagId;

	public ScanPayReqData(){
		
	}
    public ScanPayReqData(RedBag redBag){

        //随机字符串，不长于32 位
        setNonce_str(RandomStringGenerator.getRandomStringByLength(32));
        //商户订单
        String mch_billno=Configure.getMchid()+""+redBag.getBillno();
        setMch_billno(mch_billno);
        //微信支付分配的商户号ID（开通公众号的微信支付功能之后可以获取到）
        setMch_id(Configure.getMchid());
        //微信分配的公众号ID（开通公众号之后可以获取到）
        setWxappid(redBag.getAppId());
        
        //商户名称
        setSend_name(redBag.getEnterprise().getName());
        
        //接受红包openID
        setRe_openid(redBag.getOpenId());
        
        //红包金额
        Double redBagMoney = redBag.getRedBagMoney()*100;
        int total_amount=redBagMoney.intValue();
        setTotal_amount(total_amount);
        
        //红包总数
        setTotal_num(1);
        
        //红包祝福语
        String wishing=redBag.getWishing();
        setWishing(wishing);
        
        //调用接口的机器Ip地址
        setClient_ip(redBag.getIp());
        
        //活动名称
        setAct_name(redBag.getActName());
        
        //备注信息
        setRemark(redBag.getRemark());
        //根据API给的签名规则进行签名
        String sign = Signature.getSign(toMap(),Configure.getPaySignKey());
        setSign(sign);//把签名数据设置到Sign这个属性中
        setRedBagId(redBag.getDbid());
    }

    public String getMch_id() {
        return mch_id;
    }

    public void setMch_id(String mch_id) {
        this.mch_id = mch_id;
    }


    public String getNonce_str() {
        return nonce_str;
    }

    public void setNonce_str(String nonce_str) {
        this.nonce_str = nonce_str;
    }

    public String getSign() {
        return sign;
    }

    public void setSign(String sign) {
        this.sign = sign;
    }


    public Map<String,Object> toMap(){
        Map<String,Object> map = new HashMap<String, Object>();
        Field[] fields = this.getClass().getDeclaredFields();
        for (Field field : fields) {
            Object obj;
            try {
                obj = field.get(this);
                if(obj!=null){
                    map.put(field.getName(), obj);
                }
            } catch (IllegalArgumentException e) {
                e.printStackTrace();
            } catch (IllegalAccessException e) {
                e.printStackTrace();
            }
        }
        return map;
    }


	public String getWxappid() {
		return wxappid;
	}


	public void setWxappid(String wxappid) {
		this.wxappid = wxappid;
	}


	public String getSend_name() {
		return send_name;
	}


	public void setSend_name(String send_name) {
		this.send_name = send_name;
	}


	public String getRe_openid() {
		return re_openid;
	}


	public void setRe_openid(String re_openid) {
		this.re_openid = re_openid;
	}


	public String getMch_billno() {
		return mch_billno;
	}


	public void setMch_billno(String mch_billno) {
		this.mch_billno = mch_billno;
	}


	public int getTotal_amount() {
		return total_amount;
	}


	public void setTotal_amount(int total_amount) {
		this.total_amount = total_amount;
	}


	public int getTotal_num() {
		return total_num;
	}


	public void setTotal_num(int total_num) {
		this.total_num = total_num;
	}


	public String getWishing() {
		return wishing;
	}


	public void setWishing(String wishing) {
		this.wishing = wishing;
	}


	public String getClient_ip() {
		return client_ip;
	}


	public void setClient_ip(String client_ip) {
		this.client_ip = client_ip;
	}


	public String getAct_name() {
		return act_name;
	}


	public void setAct_name(String act_name) {
		this.act_name = act_name;
	}


	public String getRemark() {
		return remark;
	}


	public void setRemark(String remark) {
		this.remark = remark;
	}

	public Integer getDbid() {
		return dbid;
	}

	public void setDbid(Integer dbid) {
		this.dbid = dbid;
	}

	public Integer getRedBagId() {
		return redBagId;
	}

	public void setRedBagId(Integer redBagId) {
		this.redBagId = redBagId;
	}
	/* (non-Javadoc)
	 * @see java.lang.Object#toString()
	 */
	@Override
	public String toString() {
		return "ScanPayReqData [dbid=" + dbid + ", nonce_str=" + nonce_str
				+ ", sign=" + sign + ", mch_billno=" + mch_billno + ", mch_id="
				+ mch_id + ", wxappid=" + wxappid + ", send_name=" + send_name
				+ ", re_openid=" + re_openid + ", total_amount=" + total_amount
				+ ", total_num=" + total_num + ", wishing=" + wishing
				+ ", client_ip=" + client_ip + ", act_name=" + act_name
				+ ", remark=" + remark + ", redBagId=" + redBagId + "]";
	}


}
