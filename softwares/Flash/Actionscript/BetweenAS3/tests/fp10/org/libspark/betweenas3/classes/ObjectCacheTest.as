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
	import org.libspark.as3unit.assert.*;
	import org.libspark.as3unit.before;
	import org.libspark.as3unit.after;
	import org.libspark.as3unit.test;
	import org.libspark.betweenas3.classes.ObjectCache;
	
	use namespace before;
	use namespace after;
	use namespace test;
	
	/**
	 * @author	yossy:beinteractive
	 */
	public class ObjectCacheTest
	{
		private var _cache:ObjectCache;
		
		before function initialize():void
		{
			_cache = new ObjectCache(3, create);
		}
		
		private function create():Object
		{
			return new Object();
		}
		
		after function finalize():void
		{
			_cache = null;
		}
		
		test function popAndPush():void
		{
			var obj1:Object = _cache.pop();
			var obj2:Object = _cache.pop();
			var obj3:Object = _cache.pop();
			var obj4:Object = _cache.pop();
			
			assertNotNull(obj1);
			assertNotNull(obj2);
			assertNotNull(obj3);
			assertNotNull(obj4);
			
			_cache.push(obj1);
			_cache.push(obj2);
			_cache.push(obj3);
			_cache.push(obj4);
			
			var objA:Object = _cache.pop();
			var objB:Object = _cache.pop();
			var objC:Object = _cache.pop();
			var objD:Object = _cache.pop();
			
			assertSame(obj3, objA);
			assertSame(obj2, objB);
			assertSame(obj1, objC);
			assertNotNull(objD);
		}
	}
}