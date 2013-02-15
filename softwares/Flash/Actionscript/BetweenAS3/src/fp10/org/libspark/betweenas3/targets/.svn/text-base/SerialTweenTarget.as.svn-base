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
	 * 複数の ITweenTarget を順番に実行.
	 * 
	 * @author	yossy:beinteractive
	 */
	public class SerialTweenTarget implements ITweenTarget
	{
		public function SerialTweenTarget(targets:Vector.<ITweenTarget>)
		{
			var l:uint = targets.length;
			
			_duration = 0;
			
			if (l > 0) {
				_a = targets[0];
				_duration += _a.duration;
				if (l > 1) {
					_b = targets[1];
					_duration += _b.duration;
					if (l > 2) {
						_c = targets[2];
						_duration += _c.duration;
						if (l > 3) {
							_d = targets[3];
							_duration += _d.duration;
							if (l > 4) {
								_targets = targets.slice(4);
								for (var i:uint = 4; i < l; ++i) {
									_duration += targets[i].duration;
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
		private var _lastTime:Number = 0;
		
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
			var d:Number = 0, ld:Number = 0, lt:Number = _lastTime, l:uint, i:int, t:ITweenTarget;
			
			if ((time - lt) >= 0) {
				if (_a != null) {
					if (lt <= (d += _a.duration) && ld <= time) {
						_a.update(time - ld);
					}
					ld = d;
					if (_b != null) {
						if (lt <= (d += _b.duration) && ld <= time) {
							_b.update(time - ld);
						}
						ld = d;
						if (_c != null) {
							if (lt <= (d += _c.duration) && ld <= time) {
								_c.update(time - ld);
							}
							ld = d;
							if (_d != null) {
								if (lt <= (d += _d.duration) && ld <= time) {
									_d.update(time - ld);
								}
								ld = d;
								if (_targets != null) {
									l = _targets.length;
									for (i = 0; i < l; ++i) {
										t = _targets[i];
										if (lt <= (d += t.duration) && ld <= time) {
											t.update(time - ld);
										}
										ld = d;
									}
								}
							}
						}
					}
				}
			}
			else {
				d = _duration;
				ld = d;
				if (_targets != null) {
					for (i = _targets.length - 1; i >= 0; --i) {
						t = _targets[i];
						if (lt >= (d -= t.duration) && ld >= time) {
							t.update(time - d);
						}
						ld = d;
					}
				}
				if (_d != null) {
					if (lt >= (d -= _d.duration) && ld >= time) {
						_d.update(time - d);
					}
					ld = d;
				}
				if (_c != null) {
					if (lt >= (d -= _c.duration) && ld >= time) {
						_c.update(time - d);
					}
					ld = d;
				}
				if (_b != null) {
					if (lt >= (d -= _b.duration) && ld >= time) {
						_b.update(time - d);
					}
					ld = d;
				}
				if (_a != null) {
					if (lt >= (d -= _a.duration) && ld >= time) {
						_a.update(time - d);
					}
					ld = d;
				}
			}
			_lastTime = time;
		}
	}
}