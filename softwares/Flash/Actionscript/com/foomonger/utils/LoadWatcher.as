/*
**********************************************************************************************
* www.foomonger.com
* Copyright 2007 Foomonger Development
*
* LoadWatcher.as
* Description:	Watches the consolidated loading progress of the given objects.
**********************************************************************************************

Example (requires an images folder with jpgs):

import com.foomonger.events.LoadWatcherEvent;
import com.foomonger.utils.LoadWatcher;

import flash.display.Loader;
import flash.net.URLRequest;

var loadWatcher:LoadWatcher = new LoadWatcher();
var images:Array = new Array();

loadWatcher.addEventListener(LoadWatcherEvent.PROGRESS, onLoadProgress);
loadWatcher.addEventListener(LoadWatcherEvent.COMPLETE, onLoadComplete);
loadWatcher.addEventListener(LoadWatcherEvent.COMPLETE_INIT, onLoadCompleteInit);

for (var i:uint = 1088; i < 1111; i++) {		
	var loader:Loader = new Loader();
	loader.load(new URLRequest("images/CIMG" + i.toString() + ".JPG"));
	loader.x = i - 1088 + (10 * (i - 1088));
	loader.y = loader.x;
	
	addChild(loader);
	images.push(loader.contentLoaderInfo);
}

loadWatcher.start.apply(loadWatcher, images);

function onLoadProgress(evt:LoadWatcherEvent):void {
	var loaded:uint = evt.bytesLoaded;
	var total:uint = evt.bytesTotal;
	var percent:Number = Math.round(evt.percent * 100); 
	trace(loaded + "/" + total + " = " + percent);
}

function onLoadComplete(evt:LoadWatcherEvent):void {
	trace("complete");
	trace("isTimedOut: " + evt.isTimedOut);
}

function onLoadCompleteInit(evt:LoadWatcherEvent):void {
	trace("complete init");
}

*/

package com.foomonger.utils {

	import com.foomonger.events.LoadWatcherEvent;
	import com.foomonger.utils.Later;

	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.EventDispatcher;

	public class LoadWatcher extends EventDispatcher {
	
		private static var __mc:MovieClip = new MovieClip();
		private var __content:Array;
		private var __lastTotals:Array;
		private var __lastOverallLoaded:uint;
		private var __timeout:uint = 30000;	// default 30 seconds
		private var __isTimeoutRunning:Boolean = false;
		private var __timeoutCaller:Object;
		private var __progressEvent:LoadWatcherEvent;
		private var __completeEvent:LoadWatcherEvent;
		private var __completeInitEvent:LoadWatcherEvent;
			
		public function LoadWatcher() {
			__content = new Array();
			__lastTotals = new Array();
			__progressEvent = new LoadWatcherEvent(LoadWatcherEvent.PROGRESS);
			__completeEvent = new LoadWatcherEvent(LoadWatcherEvent.COMPLETE);
			__completeInitEvent = new LoadWatcherEvent(LoadWatcherEvent.COMPLETE_INIT);

		}
		
		// --------------------------------------------------
		//	public functions
		// --------------------------------------------------
		 
		/**
		 *	Watches the load on the given objects.  Pass any objects that have bytesLoaded and bytesTotal properties.
		 *	@param 		args		Object to watch.
		 */
		public function start(... args):void {
			cleanContent(args);
			__lastOverallLoaded = 0;
			__isTimeoutRunning = false;
			startEnterFrame();
		}
		
		/**
		 *	Stops the watching.
		 */
		public function stop():void {
			stopEnterFrame();
			
			// stop the timeout just in case it's running
			if (__isTimeoutRunning) {
				Later.abort(__timeoutCaller);
			}
		}
		
		/**
		 * Setter for timeout.
		 * @param	value	Timeout value in milliseconds.		 */
		public function set timeout(value:uint):void {
			__timeout = value;
		}
		
		/**
		 * Getter for timeout.
		 * @returns	uint	Current timeout value.
		 */
		public function get timeout():uint {
			return __timeout;
		}
		
		private function startEnterFrame():void {
			__mc.addEventListener(Event.ENTER_FRAME, onEnterFrame, false, 0, true);
		}
		
		private function stopEnterFrame():void {
			__mc.removeEventListener(Event.ENTER_FRAME, onEnterFrame);
		}
	
		/**
		 *	Discards any objects that are undefined or do not have a getBytesLoaded() function.
		 */
		private function cleanContent(content:Array):void {
			__content.splice(0);
			__lastTotals.splice(0);
			
			var badCount:uint = 0;
			var i:uint;
			var ilen:uint;
			var temp:uint;
			ilen = content.length;
			for (i = 0; i < ilen; i++) {
				try {
					temp = content[i].bytesLoaded + content[i].bytesTotal;
					__content.push(content[i]);
					__lastTotals.push(0);
				} catch (err:Error) {
					badCount++;
				}
			}
			
			if (__content.length > 0) {
				if (badCount > 0) {
					trace("**** WARNING **** LoadWatcher.start(): Found " + badCount.toString() + " bad objects.");
				}
			} else {
				trace("**** ERROR **** LoadWatcher.start(): Attempted to watch all bad content");
			}
			
		}
	
		/**
		 *	Calculates the load progress of the given objects. 
		 */
		private function onEnterFrame(event:Event):void {
			var bytesTotal:uint = 0;
			var bytesLoaded:uint = 0;
			
			var partBytesTotal:uint = 0;
			var partBytesLoaded:uint = 0;
		
			var validObjects:uint = __content.length;
	
			var isValidTotal:Boolean = true;
			
			var i:uint;
			var ilen:uint;
			var part:Object;
			ilen = __content.length;
			
			for (i = 0; i < ilen; i++) {
				part = __content[i];
			
				partBytesLoaded = part.bytesLoaded;
				if (isNaN(partBytesLoaded)) {
					partBytesLoaded = 0;
				}
				partBytesTotal = part.bytesTotal;
				if (isNaN(partBytesTotal)) {
					partBytesTotal = 0;
				}	
				// total will be invalid if a part has 0 for total bytes
				if (partBytesTotal == 0) {
					isValidTotal = false;
					validObjects--;		// 1 less valid object
				}
				
				// total will be invalid if a part's total bytes changes
				if (__lastTotals[i] != partBytesTotal) {
					isValidTotal = false;
				}
				__lastTotals[i] = partBytesTotal;
				
				bytesTotal += partBytesTotal;
				bytesLoaded += partBytesLoaded;
			}
			
			__progressEvent.bytesLoaded = bytesLoaded;
			__progressEvent.bytesTotal = bytesTotal;
			__progressEvent.percent = ((validObjects / __content.length) * (bytesLoaded / bytesTotal));
			__progressEvent.percent = isNaN(__progressEvent.percent) ? 0 : __progressEvent.percent;
			
			dispatchEvent(__progressEvent);

			checkTimeout(bytesLoaded);
	
			if (isValidTotal) {
				if (bytesLoaded == bytesTotal) {
					__completeEvent.isTimedOut = false;
					dispatchEvent(__completeEvent);
					stop();
					Later.call(this, dispatchEvent, 1, false, __completeInitEvent);
				}
			}
		}
		
		/**
		 *	Checks and sets the timeout time if necessary.  The watching times out if the load progress is stuck for the timeout duration.
		 *	@param	bytesLoaded		The current bytes loaded.
		 */
		private function checkTimeout(bytesLoaded:uint):void {
			// if bytes loaded hasn't changed
			if (__lastOverallLoaded == bytesLoaded) {
				// if timeout timer is running
				if (__isTimeoutRunning) {
					// do nothing
				} else {
					// set the timer
					__isTimeoutRunning = true;
					__timeoutCaller	= Later.call(this, callTimeout, __timeout, true);
				}
			// if bytes loaded has changed
			} else {
				if (__isTimeoutRunning) {
					// clear the timer
					__isTimeoutRunning = false;
					Later.abort(__timeoutCaller);
				}
			}
			__lastOverallLoaded = bytesLoaded;
		}

		/**
		 *	Stops the watching and sends the COMPLETE event with the isTimedOut flag set to true.
		 *	Called if the load progress is stuck for the timeout duration.
		 */
		private function callTimeout():void {
			stop();		
			__completeEvent.isTimedOut = true;
			dispatchEvent(__completeEvent);
		}	
	}
}