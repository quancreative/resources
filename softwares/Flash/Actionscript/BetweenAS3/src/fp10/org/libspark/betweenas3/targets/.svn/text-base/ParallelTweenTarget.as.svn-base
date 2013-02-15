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
package org.libspark.betweenas3.targets
{
	/**
	 * 複数の ITweenTarget を同時に実行.
	 * 
	 * @author	yossy:beinteractive
	 */
	public class ParallelTweenTarget implements ITweenTarget
	{
		public function ParallelTweenTarget(targets:Vector.<ITweenTarget>)
		{
			var l:uint = targets.length;
			
			_duration = 0;
			
			if (l > 0) {
				_a = targets[0];
				_duration = _a.duration > _duration ? _a.duration : _duration;
				if (l > 1) {
					_b = targets[1];
					_duration = _b.duration > _duration ? _b.duration : _duration;
					if (l > 2) {
						_c = targets[2];
						_duration = _c.duration > _duration ? _c.duration : _duration;
						if (l > 3) {
							_d = targets[3];
							_duration = _d.duration > _duration ? _d.duration : _duration;
							if (l > 4) {
								_targets = targets.slice(4);
								for (var i:uint = 4; i < l; ++i) {
									var t:ITweenTarget = targets[i];
									_duration = t.duration > _duration ? t.duration : _duration;
								}
							}
						}
					}
				}
			}
		}
		
		private var _duration:Number;
		private var _a:ITweenTarget;
		private var _b:ITweenTarget;
		private var _c:ITweenTarget;
		private var _d:ITweenTarget;
		private var _targets:Vector.<ITweenTarget>;
		
		/**
		 * @inheritDoc
		 */
		public function get duration():Number
		{
			return _duration;
		}
		
		/**
		 * @inheritDoc
		 */
		public function update(time:Number):void
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
								var targets:Vector.<ITweenTarget> = _targets;
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