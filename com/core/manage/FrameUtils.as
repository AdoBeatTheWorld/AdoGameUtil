package com.core.manage
{
	public class FrameUtils
	{
		/**
		 * 添加帧事件控制 
		 * @param fun
		 * @param frames
		 * 
		 */		
		public static function putFrame(fun:Function, frames:Vector.<Function>):void
		{
			if(frames.indexOf(fun) > -1)
			{
				return;
			}else
			{
				frames.push(fun);
			}
		}
		/**
		 * 释放帧事件 
		 * @param fun
		 * @param frames
		 * @return  返回帧事件容器里面所剩的个数
		 * 
		 */		
		public static function releaseFrame(fun:Function, frames:Vector.<Function>):int
		{
			var index:int = frames.indexOf(fun);
			if(index > -1)
			{
				frames.splice(index,1);
			}
			return frames.length;
		}
	}
}