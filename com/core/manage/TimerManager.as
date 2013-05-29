package com.core.manage
{
	import com.core.CommonLanguage;
	
	import org.utils.StringUtil;

	public class TimerManager{
		/**
		 * 获取时间格式
		 * @param t 秒
		 * @param type 1(00:00:00); 2(00小时00分00秒);
		 * @return 
		 * 
		 */		
		public static function getTimerSt(t:int, type:int = 1):String{
			var xsSt:String="00"
			var fSt:String="00"
			var mSt:String="00"
			var f:int=0;
			var m:int=0;
			if(t < 0){
				t = 0;
			}
			
			if(t>=3600)
			{
				var xs:int=t/3600
				if(xs>9)
				{
					xsSt=xs+""
				}else
				{
					xsSt="0"+xs+""
				}
				f=(t%3600)/60
				m=(t%3600)%60;
				
				
			}else if(t>=60)
			{
				f=t/60;
				m=t%60;
			}else
			{
				m=t;
			}
			
			
			if(f>9)
			{
				fSt=f+""
			}else
			{
				fSt="0"+f+""
			}
			
			if(m>9)
			{
				mSt=m+""
			}else
			{
				mSt="0"+m+""
			}
			if(xsSt == "00"){
				if(type == 1){
					return fSt+":"+mSt
				}else{
					return fSt+"分"+mSt+"秒";
				}
			}else{
				if(type == 1){
					return xsSt+":"+fSt+":"+mSt
				}else{
					return xsSt+"小时"+fSt+"分"+mSt+"秒";
				}
			}
		}
		/**
		 * 获取登陆时间   
		 * @param time
		 * @return 
		 * 
		 */		
		public static function getLandTime(time:int):String{
			var result:String = "";
			if(time <= 0){
				result = 1 + CommonLanguage.TIP_1;
			}
			else if(time < 24)
			{
				result = time + CommonLanguage.TIP_1;
			}
			else if(time < 24 * 10){
				result = Math.ceil(time / 24) + CommonLanguage.TIP_2;
			}
			return result;
		}
		/**
		 * 获得日期 
		 * @param time
		 * @return Object
		 *  obj.year 年
		 *  obj.month 月
		 *  obj.day 天
		 *  obj.hours 小时
		 *  obj.minutes 分
		 *  ojb.seconds 秒
		 */		
		public static function getDate(time:Number):Object{
			var date:Date = new Date(time);
			var obj:Object = {};
			obj.year = date.getFullYear();
			obj.month = date.getMonth() + 1;//月是从0开始
			obj.day = date.getDate();
			obj.hours = StringUtil.renewZero(String(date.getHours()), 2);
			obj.minutes = StringUtil.renewZero(String(date.getMinutes()), 2);
			obj.seconds = StringUtil.renewZero(String(date.getSeconds()), 2);
			return obj;
		}
	}
}