﻿package pdh.events{	import flash.events.Event;		public class SlideDragEvent extends Event 	{				public static const DRAG_LEFT		:String = "dragleft";		public static const DRAG_RIGHT		:String = "dragright";				public var parameters			:Object;				public function SlideDragEvent(command:String, _param:Object = null) {			super(command, true);					parameters = _param;		}	}}