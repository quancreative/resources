/*
 * BetweenAS3
 * 
 * Licensed under the MIT License
 * 
 * Copyright (c) 2009 BeInteractive! (www.be-interactive.org) and
 *                    Spark project  (www.libspark.org)
 * 
 * Permission is hereby granted, free of charge, to any person obtaining a copy
 * of this software and associated documentation files (the "Software"), to deal
 * in the Software without restriction, including without limitation the rights
 * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 * copies of the Software, and to permit persons to whom the Software is
 * furnished to do so, subject to the following conditions:
 * 
 * The above copyright notice and this permission notice shall be included in
 * all copies or substantial portions of the Software.
 * 
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 * AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
 * THE SOFTWARE.
 * 
 */
package org.libspark.betweenas3.factories.classes
{
	import flash.utils.Dictionary;
	import org.libspark.betweenas3.easing.IEasing;
	import org.libspark.betweenas3.registries.ClassRegistry;
	import org.libspark.betweenas3.targets.ITweenTarget;
	import org.libspark.betweenas3.targets.single.ISingleTweenTarget;
	
	/**
	 * .
	 * 
	 * @author	yossy:beinteractive
	 */
	public class SingleTweenTargetBuilder
	{
		private var _registry:ClassRegistry;
		private var _target:Object;
		private var _targetClass:Class;
		private var _time:Number;
		private var _delay:Number;
		private var _easing:IEasing;
		private var _tweenTargetMap:Dictionary = new Dictionary();
		private var _tweenTargets:Vector.<ISingleTweenTarget> = new Vector.<ISingleTweenTarget>();
		
		public function get tweenTargetClassRegistry():ClassRegistry
		{
			return _registry;
		}
		
		public function set tweenTargetClassRegistry(value:ClassRegistry):void
		{
			_registry = value;
		}
		
		public function reset(target:Object, time:Number, delay:Number, easing:IEasing):void
		{
			_target = target;
			_targetClass = target != null ? target.constructor : null;
			_time = time;
			_delay = delay;
			_easing = easing;
			for (var p:* in _tweenTargetMap) {
				delete _tweenTargetMap[p];
			}
			_tweenTargets.length = 0;
		}
		
		public function createTweenTarget(propertyName:String):ISingleTweenTarget
		{
			var tweenTargetClass:Class = _registry.getClassByTargetClassAndPropertyName(_targetClass, propertyName);
			if (tweenTargetClass != null) {
				var t:ISingleTweenTarget = _tweenTargetMap[tweenTargetClass] as ISingleTweenTarget;
				if (t == null) {
					t = new tweenTargetClass();
					t.target = _target;
					t.delay = _delay;
					t.time = _time;
					t.easing = _easing;
					_tweenTargetMap[tweenTargetClass] = t;
					_tweenTargets.push(t);
				}
				return t;
			}
			return null;
		}
		
		public function addTweenTarget(target:ITweenTarget):void
		{
			_tweenTargets.push(target);
		}
		
		public function getCreatedTweenTargets():Vector.<ISingleTweenTarget>
		{
			return _tweenTargets;
		}
	}
}