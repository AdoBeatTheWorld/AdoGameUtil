package com.core.manage
{
	import flash.events.Event;

	/**
	 * 需要用到帧事件的对象
	 * @author Ado
	 * 
	 */
	public interface IFramable
	{
		/**
		 * 帧事件 
		 * @param e
		 * 
		 */		
		function onFrame(e:Event):void;
	}
}