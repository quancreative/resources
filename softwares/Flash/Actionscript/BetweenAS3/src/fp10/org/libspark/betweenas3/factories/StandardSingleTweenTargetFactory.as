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
package org.libspark.betweenas3.factories
{
	import org.libspark.betweenas3.classes.ObjectCache;
	import org.libspark.betweenas3.easing.IEasing;
	import org.libspark.betweenas3.factories.classes.SingleTweenTargetBuilder;
	import org.libspark.betweenas3.registries.ClassRegistry;
	import org.libspark.betweenas3.targets.single.CompositeSingleTweenTarget;
	import org.libspark.betweenas3.targets.single.ISingleTweenTarget;
	import org.libspark.betweenas3.targets.single.SingleTweenTargetLadder;
	
	/**
	 * ISingleTweenTargetFactory の実装.
	 * 
	 * @author	yossy:beinteractive
	 */
	public class StandardSingleTweenTargetFactory implements ISingleTweenTargetFactory
	{
		private var _tweenTargetClassRegistry:ClassRegistry;
		
		private var _builderCache:Vector.<SingleTweenTargetBuilder> = new Vector.<SingleTweenTargetBuilder>();
		private var _builderCacheIndex:uint = 0;
		
		/**
		 * 
		 */
		public function get tweenTargetClassRegistry():ClassRegistry
		{
			return _tweenTargetClassRegistry;
		}
		
		/**
		 * @private
		 */
		public function set tweenTargetClassRegistry(value:ClassRegistry):void
		{
			_tweenTargetClassRegistry = value;
		}
		
		protected function newSingleTweenTargetBuilder():SingleTweenTargetBuilder
		{
			var builder:SingleTweenTargetBuilder = new SingleTweenTargetBuilder();
			builder.tweenTargetClassRegistry = _tweenTargetClassRegistry;
			return builder;
		}
		
		/**
		 * @inheritDoc
		 */
		public function create(target:Object, dest:Object, source:Object, time:Number, easing:IEasing, delay:Number):ISingleTweenTarget
		{
			// TODO: Value filter
			
			var tweenTargetBuilder:SingleTweenTargetBuilder = _builderCacheIndex > 0 ? _builderCache[--_builderCacheIndex] : newSingleTweenTargetBuilder(), name:String, value:Object, isRelative:Boolean, parentTarget:ISingleTweenTarget, childTarget:ISingleTweenTarget, tweenTargets:Vector.<ISingleTweenTarget>, tweenTarget:ISingleTweenTarget;
			
			tweenTargetBuilder.reset(target, time, delay, easing);
			
			// TODO: Tween targets with factory
			
			if (source != null) {
				for (name in source) {
					if ((value = source[name]) is Number) {
						if ((isRelative = /^\$/.test(name))) {
							name = name.substr(1);
						}
						tweenTargetBuilder.createTweenTarget(name).setSourceValue(name, Number(value), isRelative);
					}
					else {
						parentTarget = tweenTargetBuilder.createTweenTarget(name);
						childTarget = create(parentTarget.getObject(name), dest != null ? dest[name] : null, value, time, easing, delay);
						tweenTargetBuilder.addTweenTarget(childTarget);
						tweenTargetBuilder.addTweenTarget(new SingleTweenTargetLadder(parentTarget, childTarget, name));
					}
				}
			}
			if (dest != null) {
				for (name in dest) {
					if ((value = dest[name]) is Number) {
						if ((isRelative = /^\$/.test(name))) {
							name = name.substr(1);
						}
						tweenTargetBuilder.createTweenTarget(name).setDestinationValue(name, Number(value), isRelative);
					}
					else {
						if (!(source != null && name in source)) {
							parentTarget = tweenTargetBuilder.createTweenTarget(name);
							childTarget = create(parentTarget.getObject(name), value, source != null ? source[name] : null, time, easing, delay);
							tweenTargetBuilder.addTweenTarget(childTarget);
							tweenTargetBuilder.addTweenTarget(new SingleTweenTargetLadder(parentTarget, childTarget, name));
						}
					}
				}
			}
			
			
			if ((tweenTargets = tweenTargetBuilder.getCreatedTweenTargets()).length == 1) {
				tweenTarget = tweenTargets[0];
			}
			else if (tweenTargets.length > 1) {
				tweenTarget = new CompositeSingleTweenTarget(target, time, delay, easing, tweenTargets);
			}
			
			tweenTargetBuilder.reset(null, 0, 0, null);
			
			_builderCache[_builderCacheIndex++] = tweenTargetBuilder;
			
			return tweenTarget;
		}
		
		private function cloneObject(obj:Object):Object
		{
			if (obj == null) {
				return null;
			}
			var cloned:Object = {};
			for (var p:* in obj) {
				cloned[p] = obj[p];
			}
			return cloned;
		}
		
		private function getObjectProperty(name:String, primary:Object, secondary:Object, defaultValue:Object):Object
		{
			var value:Object = defaultValue;
			if (secondary != null && name in secondary) {
				value = secondary[name];
				delete secondary[name];
			}
			if (primary != null && name in primary) {
				value = primary[name];
				delete primary[name];
			}
			return value;
		}
	}
}