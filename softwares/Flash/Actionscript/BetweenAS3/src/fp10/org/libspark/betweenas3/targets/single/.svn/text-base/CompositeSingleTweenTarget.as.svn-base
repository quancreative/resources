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
package org.libspark.betweenas3.targets.single
{
	import org.libspark.betweenas3.easing.IEasing;
	/**
	 * .
	 * 
	 * @author	yossy:beinteractive
	 */
	public class CompositeSingleTweenTarget extends AbstractSingleTweenTarget
	{
		public function CompositeSingleTweenTarget(target:Object, time:Number, delay:Number, easing:IEasing, targets:Vector.<ISingleTweenTarget>)
		{
			_target = target;
			this.time = time;
			this.delay = delay;
			this.easing = easing;
			
			var l:uint = targets.length;
			
			if (l >= 1) {
				_a = targets[0];
				if (l >= 2) {
					_b = targets[1];
					if (l >= 3) {
						_c = targets[2];
						if (l >= 4) {
							_d = targets[3];
							if (l >= 5) {
								_targets = new Vector.<ISingleTweenTarget>(l - 4, true);
								for (var i:uint = 4; i < l; ++i) {
									_targets[i - 4] = targets[i];
								}
							}
						}
					}
				}
			}
		}
		
		private var _target:Object = null;
		
		private var _a:ISingleTweenTarget;
		private var _b:ISingleTweenTarget;
		private var _c:ISingleTweenTarget;
		private var _d:ISingleTweenTarget;
		private var _targets:Vector.<ISingleTweenTarget>;
		
		/**
		 * @inheritDoc
		 */
		override public function get target():Object
		{
			return _target;
		}
		
		/**
		 * @private
		 */
		override public function set target(value:Object):void
		{
			_target = value;
		}
		
		public function getSingleTweenTargetAt(index:uint):ISingleTweenTarget
		{
			if (index == 0) {
				return _a;
			}
			if (index == 1) {
				return _b;
			}
			if (index == 2) {
				return _c;
			}
			if (index == 3) {
				return _d;
			}
			if (_targets != null) {
				return _targets[index - 4];
			}
			return null;
		}
		
		/**
		 * @inheritDoc
		 */
		override public function update(time:Number):void
		{
			if (_a != null) {
				_a.update(time);
				if (_b != null) {
					_b.update(time);
					if (_c != null) {
						_c.update(time);
						if (_d != null) {
							_d.update(time);
							if (_targets != null) {
								var targets:Vector.<ISingleTweenTarget> = _targets;
								var l:uint = targets.length;
								for (var i:uint = 0; i < l; ++i) {
									targets[i].update(time);
								}
							}
						}
					}
				}
			}
		}
	}
}