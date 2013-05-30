package com.core.storage
{
	import flash.utils.ByteArray;

	/**
	 * 本地存储对象
	 * @author Ado
	 */
	public class LocalStorageItem
	{
		/**
		 * 版本号 
		 */		
		public var version:int;
		/**
		 * 数据 
		 */		
		private var value:ByteArray;
		
		private var _data:Object;
		public function LocalStorageItem()
		{
			version = 0;
		}

		/**
		 * 最终存入本地的二进制数据 
		 * @return 
		 * 
		 */		
		public function get binary():ByteArray
		{
			var ba:ByteArray = new ByteArray();
			ba.position = 0;
			ba.writeUnsignedInt(version);//先写入版本号
			value.position = 0;
			ba.writeBytes(value);
			ba.compress();
			return ba;
		}
		/**
		 * 解析数据 
		 * @param data
		 * 
		 */		
		public function parseObj(bytes:ByteArray):void
		{
			bytes.uncompress();
			bytes.position = 0;
			version =  bytes.readUnsignedInt();
			_data = bytes.readObject();
		}
		/**
		 * 需要存入本地的数据 
		 * @return 
		 * 
		 */		
		public function get data():Object
		{
			return _data;
		}
		
		public function set data(obj:Object):void
		{
			value =  new ByteArray();
			value.writeObject(obj);
		}
	}
}