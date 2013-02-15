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
	 * ITweenTarget を指定回数繰り返して実行.
	 * 
	 * @author	yossy:beinteractive
	 */
	public class RepeatedTweenTarget implements ITweenTarget
	{
		public function RepeatedTweenTarget(baseTweenTarget:ITweenTarget, repeatCount:uint)
		{
			_baseTweenTarget = baseTweenTarget;
			_baseDuration = baseTweenTarget.duration;
			_repeatCount = repeatCount;
			_duration = _baseDuration * repeatCount;
		}
		
		private var _baseTweenTarget:ITweenTarget;
		private var _baseDuration:Number;
		private var _duration:Number;
		private var _repeatCount:uint;
		
		public function get baseTweenTarget():ITweenTarget
		{
			return _baseTweenTarget;
		}
		
		public function get repeatCount():uint
		{
			return _repeatCount;
		}
		
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
			if (time >= 0) {
				time -= time < _duration ? _baseDuration * int(time / _baseDuration) : _duration - _baseDuration;
			}
			_baseTweenTarget.update(time);
		}
	}
}