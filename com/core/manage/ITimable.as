package com.core.manage
{
	/**
	 * 可记时的对象
	 * @author Ado
	 */
	public interface ITimable
	{
		/**
		 * 管理驱动
		 * @param value
		 * 
		 */		
		function onTimer(value:int):void;
		/**
		 * 对于的TimeItem的标签戳
		 * @return 
		 * 
		 */		
		function set stamp(value:String):void;
		
		function get stamp():String;
		
		function getDelay():int;
	}
}