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
package org.libspark.betweenas3.targets.extra
{
	/**
	 * 指定された関数の実行動作を行うトゥイーンターゲットです.
	 * 
	 * @author	yossy:beinteractive
	 */
	public class Func extends AbstractActionTweenTarget
	{
		public function Func(func:Function, params:Array = null, delay:Number = 0, useFunc2:Boolean = false, func2:Function = null, params2:Array = null)
		{
			super(delay);
			
			_func = func;
			_params = params;
			
			if (useFunc2) {
				_func2 = func2;
				_params2 = params2;
			}
			else {
				_func2 = func;
				_params2 = params;
			}
		}
		
		private var _func:Function;
		private var _params:Array;
		private var _func2:Function;
		private var _params2:Array;
		
		override protected function action():void 
		{
			if (_func != null) {
				_func.apply(null, _params);
			}
		}
		
		override protected function rollback():void 
		{
			if (_func2 != null) {
				_func2.apply(null, _params2);
			}
		}
	}
}