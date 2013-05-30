package com.core.storage
{
	import flash.events.EventDispatcher;
	import flash.events.IEventDispatcher;
	import flash.net.SharedObject;
	import flash.net.SharedObjectFlushStatus;
	
	import org.ds.HashMap;
	
	/**
	 * 本地存储管理
	 * @author Ado
	 */
	public class LocalStorage extends EventDispatcher
	{
		/**
		 * 本地存储对象 
		 */		
		private var so:SharedObject;
		/**
		 * 是否初始化的标示 
		 */		
		private var flag:Boolean;
		/**
		 * MB 
		 */		
		public static const MB:int = 1024*1024;
		/**
		 * 版本管理map 
		 */		
		private var versionMap:HashMap;
		
		public function LocalStorage(target:IEventDispatcher=null)
		{
			super(target);
		}
		/**
		 * 建立本地缓存系统 
		 * @param label	缓存标签，默认 sanjie
		 * @param size	缓存空间，默认为100 * MB
		 * 
		 */		
		public function initStorage(label:String="sanjie",size:int=0):void
		{
			so = SharedObject.getLocal(label);
			
			if(size == 0)
			{
				size = 100 * MB;
			}
			try
			{
				var status:String = so.flush(size);
			}catch(e:Error)
			{
				trace("Cannot write data to local storage...");
			}
			if(status == SharedObjectFlushStatus.FLUSHED)
			{
				trace("Request sucess...");
				flag = true;
			}else
			{
				trace("Request failed...");
			}
		}
		/**
		 * 存放数据到本地 
		 * @param key	存放的键值
		 * @param data	存放的数据
		 * 
		 */		
		public function save(key:String, data:Object, version:int=0):void
		{
			if(flag)
			{
				var item:LocalStorageItem = new LocalStorageItem();
				item.data = data;
				item.version = version;
				so.data[key] = item.binary;
				var status:String = so.flush();
				if(status == SharedObjectFlushStatus.FLUSHED)
				{
					trace("Request sucess...");
					flag = true;
				}else
				{
					trace("Request failed...");
				}
			}else
			{
				trace("本地存储未成功建立");
			}
		}
		/**
		 * 取得本地存储的数据 
		 * @param key
		 * @return 
		 * 
		 */		
		public function get(key:String):Object
		{
			if(flag)
			{
				if(so.data.hasOwnProperty(key))
				{
					var item:LocalStorageItem = new LocalStorageItem();
					item.parseObj(so.data[key]);
					return item.data;
				}else 
				{
					trace("找不到本地存储的"+key);
				}
			}else
			{
				trace("本地存储建立失败...");
			}
			return null;
		}
		/**
		 * 设置版本配置 
		 * @param xml
		 * 
		 */		
		public function setVersionConfig(xml:XML):void
		{
			versionMap = new HashMap();
			var list:XMLList = xml.elements("item");
			for each(var i:XML in list)
			{
				versionMap.add(i.@name, new VersionItem(i));
			}
		}
		private static var instance:LocalStorage;
		public static function getInstance():LocalStorage
		{
			if(null == instance)
			{
				instance =  new LocalStorage();
			}
			return instance;
		}
	}
}