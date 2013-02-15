﻿/*
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
	 * ITweenTarget を逆に実行.
	 * 
	 * @author	yossy:beinteractive
	 */
	public class ReversedTweenTarget implements ITweenTarget
	{
		public function ReversedTweenTarget(baseTweenTarget:ITweenTarget)
		{
			_baseTweenTarget = baseTweenTarget;
			_duration = baseTweenTarget.duration;
		}
		
		private var _baseTweenTarget:ITweenTarget;
		private var _duration:Number;
		
		public function get baseTweenTarget():ITweenTarget
		{
			return _baseTweenTarget;
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
			_baseTweenTarget.update(_duration - time);
		}
	}
}