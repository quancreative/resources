﻿package pdh.events {	import flash.events.Event;	public class ZoomEvent extends Event {		public static const ZOOM_OUT:String = "zoom out";				public static const ZOOM_IN:String = "zoom in";				public static const ZOOM_TO:String = "zoom to";			public static const ZOOMED:String = "zoomed!"		public static const CHANGE:String = "changed!"		public var parameters:Object		public function ZoomEvent( _type:String, _value:Object = null ) {			super( _type, true );  // bubbles			parameters = _value;		}	}}