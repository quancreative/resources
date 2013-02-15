package com.cortinaproductions.util 
{
	import flash.events.Event;

	/**
	 * @author dominictran
	 * 
	 * Used by AssetLoader class
	 */
	public class AssetLoaderEvent extends Event
	{	public var parameters: Object;
		public static const ALL_COMPLETE_LOADING : String = "ALL_COMPLETE_LOADING";
		public static const COMPLETE_LOADING : String = "COMPLETE_LOADING";

		public function AssetLoaderEvent(val:String, _parameters:Array = null)
		{
			super(val, false); // bubbles
			parameters = _parameters;
		}
	}
}