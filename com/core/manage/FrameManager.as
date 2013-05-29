package com.core.manage
{
	import flash.display.Stage;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.IEventDispatcher;
	import flash.utils.*;
	
	import org.manager.RootManager;
	
	/**
	 * 帧事件管理器
	 * @author Ado
	 * @see IFramable
	 */
	public class FrameManager extends EventDispatcher
	{
		/**
		 * 在管辖范围内的元素 
		 */		
		private var framables:Vector.<IFramable>;
		/**
		 * 舞台，用来监听帧事件 
		 */		
		private var stage:Stage;
		/**
		 * 帧控制器是否已经启动 
		 */		
		private var startFlag:Boolean;
		private var startTime:int;
		
		public function FrameManager(target:IEventDispatcher=null)
		{
			super(target);
			stage = RootManager.stage;
			framables = new Vector.<IFramable>();
		}
		/**
		 * 控制 
		 * @param framable
		 * @see IFramable
		 * @see ITimable
		 * 
		 */		
		public function control(obj:IFramable):void
		{
			if(!has(obj))
			{
				framables.push(obj as IFramable);
				if(!startFlag)
				{
					start();
				}
			}
		}
		/**
		 * 释放 
		 * @param framable
		 * 
		 */		
		public function release(target:IFramable):void
		{
			var index:int = framables.indexOf(target);
			if(index > - 1)
			{
				framables.splice(index, 1);
			}
			
			if(framables.length == 0 )
			{
				stop();
			}
		}
		/**
		 * 启动 
		 * 
		 */		
		public function start():void
		{
			stage.addEventListener(Event.ENTER_FRAME, onEnter);
			startFlag = true;
			startTime = getTimer();
		}
		/**
		 * 停止 
		 * 
		 */		
		public function stop():void
		{
			stage.removeEventListener(Event.ENTER_FRAME, onEnter);
			while(framables.length)
			{
				framables.splice(framables.length-1,1);
			}
			startFlag = false;
		}
		/**
		 * 是否控制了此对象 
		 * @param framable
		 * @return 
		 * 
		 */		
		public function has(obj:IFramable):Boolean
		{
			return framables.indexOf(obj as IFramable) > -1;
		}
		
		private function onEnter(e:Event):void
		{
			for each(var i:IFramable in framables)
			{
				i.onFrame(e);
			}
		}
		
		private static var _instance:FrameManager;
		public static function getInstance():FrameManager
		{
			if(_instance == null)
			{
				_instance = new FrameManager();
			}
			return _instance;
		}
	}
}