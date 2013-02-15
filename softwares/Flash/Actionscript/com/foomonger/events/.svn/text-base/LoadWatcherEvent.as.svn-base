/*
**********************************************************************************************
* www.foomonger.com
* Copyright 2007 Foomonger Development
*
* LoadWatcherEvent.as
* Description:	Event object for LoadWatcher events.
**********************************************************************************************
*/

package com.foomonger.events {
	
	import flash.events.Event;

	public class LoadWatcherEvent extends Event {

		// --------------------------------------------------
		//	events
		// --------------------------------------------------
		
		/**
		 *	Dispatched on enterFrame during loading.
		 */
		public static const PROGRESS:String = "progress";
		
		/**
		 *	Dispatched when everything is loaded.
		 */
		public static const COMPLETE:String = "complete";
		
		/**
		 *	Dispatched 1 frame after everything is loaded.
		 */
		public static const COMPLETE_INIT:String = "completeInit";

		public var bytesLoaded:uint;	// PROGRESS
		public var bytesTotal:uint;		// PROGRESS
		public var percent:Number;		// PROGRESS
		
		public var isTimedOut:Boolean;	// COMPLETE, true if load progress stuck for the timeout duration
		
		public function LoadWatcherEvent(type:String, bubbles:Boolean = false, cancelable:Boolean = false) {
			super(type, bubbles, cancelable);
		}
	
		public override function clone():Event {
			var event:LoadWatcherEvent = new LoadWatcherEvent(type, bubbles, cancelable);
			event.bytesLoaded = bytesLoaded;
			event.bytesTotal = bytesTotal;
			event.percent = percent;
			return event;
		}
     
		public override function toString():String {
			return "LoadWatcherEvent{type:" + type 
						+ ", bytesLoaded: " + bytesLoaded.toString()
						+ ", bytesTotal: " + bytesTotal.toString()
						+ ", percent: " + percent.toString() 
						+ "}";
		}
				
	}
}