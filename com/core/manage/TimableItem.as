package com.core.manage
{
	import flash.events.TimerEvent;
	import flash.utils.Timer;

	/**
	 * 集体控制计时器，暂不用于倒计时
	 * @author Ado
	 */
	public class TimableItem
	{
		public var timer:Timer;
		public var delay:int;
		public var timables:Vector.<ITimable>;
		public function TimableItem(defaultDelay:int=1000)
		{
			this.delay = defaultDelay;
			timer = new Timer(defaultDelay);
			timables = new Vector.<ITimable>();
		}
		private function onTimer(e:TimerEvent):void
		{
			for each(var i:ITimable in timables)
			{
				i.onTimer(timer.currentCount*timer.delay);
			}
		}
		/**
		 * 添加时间控制 
		 * @param value
		 * 
		 */		
		public function addTimer(value:ITimable):void
		{
			if(timables.indexOf(value) > -1)
			{
				return;
			}else
			{
				timables.push(value);
				value.stamp=timer.delay.toString();
				if(!timer.running)
				{
					timer.start();
					timer.addEventListener(TimerEvent.TIMER, onTimer);
				}
			}
		}
		/**
		 * 移除时间控制 
		 * @param value
		 * 
		 */		
		public function removeTimer(value:ITimable):void
		{
			var index:int = timables.indexOf(value);
			if(index > -1)
			{
				timables.splice(index,1);
			}
			if(timables.length==0)
			{
				stop();
			}
		}
		/**
		 * 停止 
		 * 
		 */		
		public function stop():void
		{
			timer.stop();
			timer.removeEventListener(TimerEvent.TIMER, onTimer);
		}
		/**
		 * 释放 
		 * 
		 */		
		public function dispose():void
		{
			timables = new Vector.<ITimable>();
			stop();
		}
	}
}