package com.core.manage
{
	/**
	 * 可回收之对象
	 * @author Ado
	 */
	public interface IRecyclable
	{
		/**
		 * 回收 
		 * 
		 */		
		function recycle():void;
		/**
		 * 清理 
		 * 
		 */		
		function clean():void;
	}
}