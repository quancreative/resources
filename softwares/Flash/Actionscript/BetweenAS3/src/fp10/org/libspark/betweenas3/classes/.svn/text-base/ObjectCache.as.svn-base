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
package org.libspark.betweenas3.classes
{
	/**
	 * オブジェクトのキャッシュ機構.
	 * 
	 * @author	yossy:beinteractive
	 */
	public class ObjectCache
	{
		public function ObjectCache(limit:uint, factory:Function)
		{
			_objects = new Vector.<Object>(limit, true);
			_cursor = 0;
			_limit = limit;
			_factory = factory;
		}
		
		private var _objects:Vector.<Object>;
		private var _limit:uint;
		private var _cursor:uint;
		private var _factory:Function;
		
		public function pop():Object
		{
			if (_cursor > 0) {
				--_cursor;
				var obj:Object = _objects[_cursor];
				_objects[_cursor] = null;
				return obj;
			}
			return _factory();
		}
		
		public function push(obj:Object):void
		{
			if (_cursor < _limit) {
				_objects[_cursor] = obj;
				++_cursor;
			}
		}
	}
}