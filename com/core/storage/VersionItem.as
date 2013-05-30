package com.core.storage
{
	public class VersionItem
	{
		public var key:String;
		public var version:Number;
		public function VersionItem(xml:XML)
		{
			key = xml.@name;
			version = Number(xml.@ver);
		}
	}
}