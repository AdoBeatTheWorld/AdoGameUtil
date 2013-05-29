package com.core.manage
{
	import flash.display.Stage;
	
	import org.ds.HashMap;
	import org.manager.RootManager;

	/**
	 * 计时器管理器
	 * @author Ado
	 */
	public class TickManager
	{
		private var currentTime:int;
		private var startFlag:Boolean;
		private var timerMap:HashMap;
		
		private static var MAX_DELAY:int = 2000;
		public function TickManager()
		{
			timerMap = new HashMap();
		}
		/**
		 * 控制时间对象 
		 * @param obj
		 * @param tickNumber
		 * 
		 */		
		public function control(obj:ITimable):void
		{
			var arr:Array = timerMap.getKeys();
			var found:Boolean;
			for each(var i:String in arr)
			{
				var temp:int = int(i);
				if(obj.getDelay()%temp==0 && obj.getDelay()/temp<5)
				{
					var target:TimableItem = timerMap.getValue(i);
					target.addTimer(obj);
					found = true;
					break;
				}
			}
			if(!found)
			{
				if(obj.getDelay() > MAX_DELAY)
				{
					if(!timerMap.containsKey(MAX_DELAY.toString()))
					{
						var item:TimableItem = new TimableItem(MAX_DELAY);
						timerMap.add(MAX_DELAY.toString(), item);
					}else
					{
						item = timerMap.getValue(MAX_DELAY.toString());
					}
				}else
				{
					item = new TimableItem(obj.getDelay());
					timerMap.add(obj.getDelay().toString(), item);
				}
				item.addTimer(obj);
			}
		}
		
		public function release(target:ITimable):void
		{
			var targetItem:TimableItem = timerMap.getValue(target.stamp);
			if(targetItem)
			{
				targetItem.removeTimer(target);
			}
		}
		
		private static var _instance:TickManager;
		public static function getInstance():TickManager
		{
			if(_instance == null)
			{
				_instance = new TickManager();
			}
			return _instance;
		}
	}
}