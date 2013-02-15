/*
**********************************************************************************************
* www.foomonger.com
* Copyright 2007 Foomonger Development
*
* Later.as
* Description:	Static class used to call functions after a given amount of time.
**********************************************************************************************

Normal use:
	import com.foomonger.utils.Later;
	
	function foo(bar:String):void {
		trace("foo = " + bar);
	}
	Later.call(this, foo, 12, false, "hello 12 frames later");
	Later.call(this, foo, 2000, true, "hello 2000 milliseconds later");

Simplest use:
	import com.foomonger.utils.Later;
	
	function foobar():void {
		trace("foobar");
	}
	
	Later.call(this, foobar);	// runs foobar 1 frame later
	
Property setting use:
	import com.foomonger.utils.Later;
	
	function traceBar():void {
		trace("bar: " + bar);
	}

	var bar:Number = 100;
	trace("bar: " + bar);						// outputs "bar: 100"
	Later.set(this, "bar", 50, 5, false);		// sets this.bar to 50 after 5 frames
	Later.call(this, traceBar, 10, false);		// outputs "bar: 50"
	
To immediately call all functions sent to Later.call() do this:
	Later.finishAll();

To immediately abort all functions sent to Later.call() do this:
	Later.abortAll();

You can also control individual calls to Later.call() by saving the returned object:
	var laterObj:Object = Later.call(this, foo, 12, false, "hello 12 frames later");
	
You can then pass the object to the following functions:
	Later.abort(laterObj);
	Later.finish(later.Obj);

You can abort and finish Later calls by groups by using Later.gcall() and Later.gset().
	The 5th argument in Later.gcall() is a uint that assigns a group to the Later object.
	Use Later.getUniqueGroup() to ensure unique group numbers.

	import com.foomonger.utils.Later;
	
	function foo(bar:String):void {
	        trace(bar);
	}
	
	var myGroup:uint = Later.getUniqueGroup();
	Later.gcall(this, foo, 12, false, myGroup, "hello world");
	Later.gcall(this, foo, 13, false, myGroup, "hello world");
	Later.call(this, foo, 14, false, "hello moon");
	Later.abortGroup(myGroup);
	
	This traces out only "hello moon".
	
*/

package com.foomonger.utils {

	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.utils.setInterval;
	import flash.utils.clearInterval;
	
	public class Later {
		
		// class data vars
		
		private static var __mc:MovieClip = new MovieClip();
		private static var __secondsData:Object = new Object();				// associative array to keep track of functions that use seconds
		private static var __framesData:Array = new Array();				// array to keep track of functions that use frames
		private static var __isEnterFrameRunning:Boolean = false;			// true if there are frame based calls in progress
		private static var __groupCounter:uint = 1;							// counter of group numbers; 0 reserved for default
		
		// --------------------------------------------------
		//	private functions
		// --------------------------------------------------
		
		
		/**
		 *	Executes the later object function.
		 */
		private static function executeFunction(laterObj:Object):void {
			var obj:Object = laterObj.obj;
			var func:Function = laterObj.func;
			var args:Array = laterObj.args;
			
			if (func != null) {
				try { 
					func.apply(obj, args);
				} catch(error:ArgumentError) {
					trace(error);
				}
			}
			
			laterObj = null;
		}
		
		/**
		 *	Clears the later object that uses seconds.
		 */
		private static function clearSecondsFunction(laterObj:Object):void {
			clearInterval(laterObj.intervalId);
			var key:String = "id" + laterObj.intervalId.toString();
			delete __secondsData[key];
			laterObj = null;
		}
	
		/**
		 *	Clears the later object that uses frames.
		 */
		private static function clearFramesFunction(laterObj:Object):void {
			laterObj.duration = 0;
			laterObj.func = null;
		}
		
		/**
		 *	Runs the given later object function and clears it.  Called by setInterval in Later.call() for functions that use seconds.
		 */
		private static function onInterval(laterObj:Object):void {
			executeFunction(laterObj);
			clearSecondsFunction(laterObj);
		}
		
		/**
		 *	Loops through the functions that use frames and execute them as neccessary.  Called by the enterFrame beacon.
		 */
		private static function onEnterFrame(event:Event):void {
			var i:Number;
			var ilen:Number;
			var laterObj:Object;
			
			i = 0;
			while (i < __framesData.length) {
				laterObj = __framesData[i];
				
				if (laterObj.duration > 1) {
					laterObj.duration--;
					i++;
				} else {
					executeFunction(laterObj);
					__framesData.splice(i, 1);
				}
			}		
			
			if (__framesData.length == 0) {
				__isEnterFrameRunning = false;
				__mc.removeEventListener(Event.ENTER_FRAME, onEnterFrame);
			}
		}
		
		/**
		 *	Used by Later.set to set the property of an object.
		 *	@param 		obj			Object where the property lives.
		 *	@param 		prop		Property to set.
		 *	@param		value		Value to set the property too.
		 */
		private static function setObjectProperty(obj:Object, prop:String, value:Object):void {
			obj[prop] = value;
		}
		
		// --------------------------------------------------
		//	public functions
		// --------------------------------------------------
		
		/**
		 *	Main Later class function.  Executes the given function after a given amount of time.  Arguments can also be passed.
		 *	@param 		obj			Object where the function lives.
		 *	@param 		func		Function to call.
		 *	@param		duration	Number of frames or milliseconds after which to call the given function.
		 *	@param		useSeconds	true = seconds, false = frames
		 *	@param		args		Array of arguments to pass to the given function.
		 *	@returns	Object		An object that represents the given function.  Can be saved and passed to finish() and abort()
		 */
		public static function call(obj:Object, func:Function, duration:uint = 1, useSeconds:Boolean = false, ... args):Object {
			var gcallArgs:Array = [obj, func, duration, useSeconds, 0].concat(args);
			return Later.gcall.apply(Later, gcallArgs);
		}

		/**
		 *	Same as Later.call(), except that you can pass a group number.
		 *	@param 		obj			Object where the function lives.
		 *	@param 		func		Function to call.
		 *	@param		duration	Number of frames or milliseconds after which to call the given function.
		 *	@param		useSeconds	true = seconds, false = frames
		 *	@param		group		Group number to assign to the call.  Default = 0.		
		 *	@param		args		Array of arguments to pass to the given function.
		 *	@returns	Object		An object that represents the given function.  Can be saved and passed to finish() and abort()
		 */
		public static function gcall(obj:Object, func:Function, duration:uint = 1, useSeconds:Boolean = false, group:uint = 0, ... args):Object {

			duration = Math.max(duration, 1);
			
			var laterObj:Object = new Object();
			laterObj.useSeconds = useSeconds;
			laterObj.obj = obj;
			laterObj.func = func;
			laterObj.group = group;
			laterObj.args = args;
			
			if (useSeconds) {
				laterObj.intervalId  = setInterval(Later.onInterval, duration, laterObj);
				var key:String = "id" + laterObj.intervalId.toString();
				__secondsData[key] = laterObj;
			} else {
				if (!__isEnterFrameRunning) {
					__isEnterFrameRunning = true;
					__mc.addEventListener(Event.ENTER_FRAME, onEnterFrame, false, 0, true);
				}
				laterObj.duration = duration;
				__framesData.push(laterObj);
			}
			
			return laterObj;
		}
		
		/**
		 *	@deprecated  Use Later.call() and Later.gcall() instead.
		 *	Main Later class function.  Executes the given function after a given amount of time.  Arguments can also be passed.
		 *	@param 		obj			Object where the function lives.
		 *	@param 		func		Function to call.
		 *	@param		duration	Number of frames or milliseconds after which to call the given function.
		 *	@param		useSeconds	true = seconds, false = frames
		 *	@param		group		Group number to assign to the call.  Default = 0.
		 *	@param		args		Array of arguments to pass to the given function.
		 *	@returns	Object		An object that represents the given function.  Can be saved and passed to finish() and abort()
		 */
		public static function exec(obj:Object, func:Function, duration:uint = 1, useSeconds:Boolean = false, group:uint = 0, ... args):Object {
			return Later.gcall.apply(Later, [obj, func, duration, useSeconds, group].concat(args));
		}
			
		/**
		 *	Set the given property with the given value after a given amount of time.
		 *	@param 		obj			Object where the property lives.
		 *	@param 		prop		Property to set.
		 *	@param		value		Value to set the property too.
		 *	@param		duration	Number of frames or milliseconds after which to call the given function.
		 *	@param		useSeconds	true = seconds, false = frames
		 *	@returns	laterObj	An object that represents the given function.  Can be saved and passed to finish() and abort()
		 */
		public static function set(obj:Object, prop:String, value:Object, duration:uint = 1, useSeconds:Boolean = false):Object {
			return Later.gset(obj, prop, value, duration, useSeconds, 0);
		}
		
		/**
		 *	Same as Later.set(), except that you can pass a group number.
		 *	@param 		obj			Object where the property lives.
		 *	@param 		prop		Property to set.
		 *	@param		value		Value to set the property too.
		 *	@param		duration	Number of frames or milliseconds after which to call the given function.
		 *	@param		useSeconds	true = seconds, false = frames
		 *	@param		group		Group number to assign to the call.  Default = 0.
		 *	@returns	laterObj	An object that represents the given function.  Can be saved and passed to finish() and abort()
		 */
		public static function gset(obj:Object, prop:String, value:Object, duration:uint = 1, useSeconds:Boolean = false, group:uint = 0):Object {
			return Later.gcall(Later, Later.setObjectProperty, duration, useSeconds, group, obj, prop, value);
		}
		
		/**
		 *	Immediately call the given later object.
		 *	@param	laterObj	An object representing a function sent to Later.call().
		 *	@param	caller		Pass arguments.callee from the calling function to prevent recursion.
		 */
		public static function finish(laterObj:Object, caller:Function = null):void {
			// if finish's caller was called by Later.call()
			if (caller == laterObj.func) {
				// avoid recursion, no need to do anything
			} else {
				executeFunction(laterObj);
			}
			abort(laterObj);
		}
	
		/**
		 *	Immediately calls all functions sent to Later.call().
		 *	@param	caller		Pass arguments.callee from the calling function to prevent recursion.
		 */
		public static function finishAll(caller:Function = null):void {
			var laterObj:Object;
	
			// seconds
			var name:String;
			for (name in __secondsData) {
				laterObj = __secondsData[name];
				finish(laterObj, caller);
			}
	
			// frames
			var i:Number;
			var ilen:Number = __framesData.length;
			for (i = 0; i < ilen; i++) {
				laterObj = __framesData[i];
				finish(laterObj, caller);
			}
		}
		
		/**
		 *	Immediately calls all functions sent to Later.gcall() in the given group.
		 *	@param	group		The number of the group to finish.
		 *	@param	caller		Pass arguments.callee from the calling function to prevent recursion.
		 */
		public static function finishGroup(group:uint, caller:Function = null):void {
			var laterObj:Object;
	
			// seconds
			var name:String;
			for (name in __secondsData) {
				laterObj = __secondsData[name];
				if (laterObj.group == group) {
					finish(laterObj, caller);
				}
			}
	
			// frames
			var i:Number;
			var ilen:Number = __framesData.length;
			for (i = 0; i < ilen; i++) {
				laterObj = __framesData[i];
				if (laterObj.group == group) {
					finish(laterObj, caller);
				}
			}
		}
		
		/**
		 *	Aborts the given later object.
		 *	@param	laterObj	An object representing a function sent to Later.call().
		 */
		public static function abort(laterObj:Object):void {
			if (laterObj.useSeconds) {
				clearSecondsFunction(laterObj);
			} else {
				clearFramesFunction(laterObj);
			}
		}
		
		/**
		 *	Immediately aborts all functions sent to Later.call().
		 */
		public static function abortAll():void {		
			var laterObj:Object;
	
			// seconds
			var name:String;
			for (name in __secondsData) {
				laterObj = __secondsData[name];
				abort(laterObj);
			}
			
			// frames
			__framesData.splice(0);	// dont need to loop and abort individually
		}
		
		/**
		 *	Immediately aborts all functions sent to Later.gcall() in the given group.
		 *	@param	group		The number of the group to abort.
		 */
		public static function abortGroup(group:uint):void {		
			var laterObj:Object;
	
			// seconds
			var name:String;
			for (name in __secondsData) {
				laterObj = __secondsData[name];
				if (laterObj.group == group) {
					abort(laterObj);
				}
			}
	
			// frames
			var i:Number;
			var ilen:Number = __framesData.length;
			for (i = 0; i < ilen; i++) {
				laterObj = __framesData[i];
				if (laterObj.group == group) {
					abort(laterObj);
				}
			}
		}
		
		/**
		 *	Returns a unique group number.
		 */
		public static function getUniqueGroup():uint {
			return __groupCounter++;
		}
	}
}