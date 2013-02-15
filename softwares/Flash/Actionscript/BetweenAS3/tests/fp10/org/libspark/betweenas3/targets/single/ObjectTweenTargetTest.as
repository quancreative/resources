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
	import org.libspark.as3unit.assert.*;
	import org.libspark.as3unit.test;
	import org.libspark.betweenas3.easing.classes.EaseNone;
	import org.libspark.betweenas3.easing.IEasing;
	
	use namespace test;
	
	/**
	 * @author	yossy:beinteractive
	 */
	public class ObjectTweenTargetTest
	{
		// AbstractTweenTarget のテストも兼ねる
		
		/**
		 * time の設定
		 */
		test function time():void
		{
			var t:ISingleTweenTarget = new ObjectTweenTarget();
			assertEquals(0, t.time);
			t.time = 3000;
			assertEquals(3000, t.time);
		}
		
		/**
		 * delay の設定
		 */
		test function delay():void
		{
			var t:ISingleTweenTarget = new ObjectTweenTarget();
			assertEquals(0, t.delay);
			t.delay = 3000;
			assertEquals(3000, t.delay);
		}
		
		/**
		 * duration の値
		 */
		test function duration():void
		{
			var t:ISingleTweenTarget = new ObjectTweenTarget();
			assertEquals(0, t.duration);
			t.time = 3000;
			assertEquals(3000, t.duration);
			t.delay = 2000;
			assertEquals(5000, t.duration);
		}
		
		/**
		 * easing の設定
		 */
		test function easing():void
		{
			var t:ISingleTweenTarget = new ObjectTweenTarget();
			assertNull(t.easing);
			var e:IEasing = new EaseNone();
			t.easing = e;
			assertSame(e, t.easing);
		}
		
		/**
		 * target の設定
		 */
		test function target():void
		{
			var t:ISingleTweenTarget = new ObjectTweenTarget();
			assertNull(t.target);
			var o:Object = new Object();
			t.target = o;
			assertSame(o, t.target);
		}
		
		/**
		 * 終了値のみを設定しての update
		 */
		test function updateWithDestination():void
		{
			var o:Object = {
				a1: 1.0,
				a2: 1.0,
				b1: 8.0,
				b2: 8.0,
				c: 3.0
			};
			
			var t:ISingleTweenTarget = new ObjectTweenTarget();
			t.target = o;
			t.easing = new EaseNone();
			t.time = 4000;
			t.setDestinationValue('a1', 6.0, false);
			t.setDestinationValue('a2', 5.0, true);
			t.setDestinationValue('b1', 2.0, false);
			t.setDestinationValue('b2', -6.0, true);
			
			assertEquals(1.0, o.a1);
			assertEquals(1.0, o.a2);
			assertEquals(8.0, o.b1);
			assertEquals(8.0, o.b2);
			assertEquals(3.0, o.c);
			
			t.update(0);
			
			assertEquals(1.0, o.a1);
			assertEquals(1.0, o.a2);
			assertEquals(8.0, o.b1);
			assertEquals(8.0, o.b2);
			assertEquals(3.0, o.c);
			
			t.update(1000);
			
			assertEquals(2.25, o.a1);
			assertEquals(2.25, o.a2);
			assertEquals(6.5, o.b1);
			assertEquals(6.5, o.b2);
			assertEquals(3.0, o.c);
			
			t.update(2000);
			
			assertEquals(3.5, o.a1);
			assertEquals(3.5, o.a2);
			assertEquals(5.0, o.b1);
			assertEquals(5.0, o.b2);
			assertEquals(3.0, o.c);
			
			t.update(4000);
			
			assertEquals(6.0, o.a1);
			assertEquals(6.0, o.a2);
			assertEquals(2.0, o.b1);
			assertEquals(2.0, o.b2);
			assertEquals(3.0, o.c);
			
			t.update(6000);
			
			assertEquals(6.0, o.a1);
			assertEquals(6.0, o.a2);
			assertEquals(2.0, o.b1);
			assertEquals(2.0, o.b2);
			assertEquals(3.0, o.c);
		}
		
		/**
		 * 終了値のみと delay を設定しての update
		 */
		test function updateWithDestinationAndDelay():void
		{
			var o:Object = {
				a1: 1.0,
				a2: 1.0,
				b1: 8.0,
				b2: 8.0,
				c: 3.0
			};
			
			var t:ISingleTweenTarget = new ObjectTweenTarget();
			t.target = o;
			t.easing = new EaseNone();
			t.delay = 2000;
			t.time = 4000;
			t.setDestinationValue('a1', 6.0, false);
			t.setDestinationValue('a2', 5.0, true);
			t.setDestinationValue('b1', 2.0, false);
			t.setDestinationValue('b2', -6.0, true);
			
			assertEquals(1.0, o.a1);
			assertEquals(1.0, o.a2);
			assertEquals(8.0, o.b1);
			assertEquals(8.0, o.b2);
			assertEquals(3.0, o.c);
			
			t.update(0);
			
			assertEquals(1.0, o.a1);
			assertEquals(1.0, o.a2);
			assertEquals(8.0, o.b1);
			assertEquals(8.0, o.b2);
			assertEquals(3.0, o.c);
			
			t.update(1000);
			
			assertEquals(1.0, o.a1);
			assertEquals(1.0, o.a2);
			assertEquals(8.0, o.b1);
			assertEquals(8.0, o.b2);
			assertEquals(3.0, o.c);
			
			t.update(2000);
			
			assertEquals(1.0, o.a1);
			assertEquals(1.0, o.a2);
			assertEquals(8.0, o.b1);
			assertEquals(8.0, o.b2);
			assertEquals(3.0, o.c);
			
			t.update(3000);
			
			assertEquals(2.25, o.a1);
			assertEquals(2.25, o.a2);
			assertEquals(6.5, o.b1);
			assertEquals(6.5, o.b2);
			assertEquals(3.0, o.c);
			
			t.update(4000);
			
			assertEquals(3.5, o.a1);
			assertEquals(3.5, o.a2);
			assertEquals(5.0, o.b1);
			assertEquals(5.0, o.b2);
			assertEquals(3.0, o.c);
			
			t.update(6000);
			
			assertEquals(6.0, o.a1);
			assertEquals(6.0, o.a2);
			assertEquals(2.0, o.b1);
			assertEquals(2.0, o.b2);
			assertEquals(3.0, o.c);
			
			t.update(8000);
			
			assertEquals(6.0, o.a1);
			assertEquals(6.0, o.a2);
			assertEquals(2.0, o.b1);
			assertEquals(2.0, o.b2);
			assertEquals(3.0, o.c);
		}
		
		/**
		 * 開始値のみを設定しての update
		 */
		test function updateWithSource():void
		{
			var o:Object = {
				a1: 6.0,
				a2: 6.0,
				b1: 2.0,
				b2: 2.0,
				c: 3.0
			};
			
			var t:ISingleTweenTarget = new ObjectTweenTarget();
			t.target = o;
			t.easing = new EaseNone();
			t.time = 4000;
			t.setSourceValue('a1', 1.0, false);
			t.setSourceValue('a2', -5.0, true);
			t.setSourceValue('b1', 8.0, false);
			t.setSourceValue('b2', 6.0, true);
			
			assertEquals(6.0, o.a1);
			assertEquals(6.0, o.a2);
			assertEquals(2.0, o.b1);
			assertEquals(2.0, o.b2);
			assertEquals(3.0, o.c);
			
			t.update(0);
			
			assertEquals(1.0, o.a1);
			assertEquals(1.0, o.a2);
			assertEquals(8.0, o.b1);
			assertEquals(8.0, o.b2);
			assertEquals(3.0, o.c);
			
			t.update(1000);
			
			assertEquals(2.25, o.a1);
			assertEquals(2.25, o.a2);
			assertEquals(6.5, o.b1);
			assertEquals(6.5, o.b2);
			assertEquals(3.0, o.c);
			
			t.update(2000);
			
			assertEquals(3.5, o.a1);
			assertEquals(3.5, o.a2);
			assertEquals(5.0, o.b1);
			assertEquals(5.0, o.b2);
			assertEquals(3.0, o.c);
			
			t.update(4000);
			
			assertEquals(6.0, o.a1);
			assertEquals(6.0, o.a2);
			assertEquals(2.0, o.b1);
			assertEquals(2.0, o.b2);
			assertEquals(3.0, o.c);
			
			t.update(6000);
			
			assertEquals(6.0, o.a1);
			assertEquals(6.0, o.a2);
			assertEquals(2.0, o.b1);
			assertEquals(2.0, o.b2);
			assertEquals(3.0, o.c);
		}
		
		/**
		 * 開始値のみと delay を設定しての update
		 */
		test function updateWithSourceAndDelay():void
		{
			var o:Object = {
				a1: 6.0,
				a2: 6.0,
				b1: 2.0,
				b2: 2.0,
				c: 3.0
			};
			
			var t:ISingleTweenTarget = new ObjectTweenTarget();
			t.target = o;
			t.easing = new EaseNone();
			t.delay = 2000;
			t.time = 4000;
			t.setSourceValue('a1', 1.0, false);
			t.setSourceValue('a2', -5.0, true);
			t.setSourceValue('b1', 8.0, false);
			t.setSourceValue('b2', 6.0, true);
			
			assertEquals(6.0, o.a1);
			assertEquals(6.0, o.a2);
			assertEquals(2.0, o.b1);
			assertEquals(2.0, o.b2);
			assertEquals(3.0, o.c);
			
			t.update(0);
			
			assertEquals(1.0, o.a1);
			assertEquals(1.0, o.a2);
			assertEquals(8.0, o.b1);
			assertEquals(8.0, o.b2);
			assertEquals(3.0, o.c);
			
			t.update(1000);
			
			assertEquals(1.0, o.a1);
			assertEquals(1.0, o.a2);
			assertEquals(8.0, o.b1);
			assertEquals(8.0, o.b2);
			assertEquals(3.0, o.c);
			
			t.update(2000);
			
			assertEquals(1.0, o.a1);
			assertEquals(1.0, o.a2);
			assertEquals(8.0, o.b1);
			assertEquals(8.0, o.b2);
			assertEquals(3.0, o.c);
			
			t.update(3000);
			
			assertEquals(2.25, o.a1);
			assertEquals(2.25, o.a2);
			assertEquals(6.5, o.b1);
			assertEquals(6.5, o.b2);
			assertEquals(3.0, o.c);
			
			t.update(4000);
			
			assertEquals(3.5, o.a1);
			assertEquals(3.5, o.a2);
			assertEquals(5.0, o.b1);
			assertEquals(5.0, o.b2);
			assertEquals(3.0, o.c);
			
			t.update(6000);
			
			assertEquals(6.0, o.a1);
			assertEquals(6.0, o.a2);
			assertEquals(2.0, o.b1);
			assertEquals(2.0, o.b2);
			assertEquals(3.0, o.c);
			
			t.update(8000);
			
			assertEquals(6.0, o.a1);
			assertEquals(6.0, o.a2);
			assertEquals(2.0, o.b1);
			assertEquals(2.0, o.b2);
			assertEquals(3.0, o.c);
		}
		
		/**
		 * 開始値と終了値を設定しての update
		 */
		test function updateWithSourceAndDestination():void
		{
			var o:Object = {
				a1: 5.0,
				a2: 5.0,
				b1: 4.0,
				b2: 4.0,
				c: 3.0
			};
			
			var t:ISingleTweenTarget = new ObjectTweenTarget();
			t.target = o;
			t.easing = new EaseNone();
			t.time = 4000;
			t.setSourceValue('a1', 1.0, false);
			t.setSourceValue('a2', -4.0, true);
			t.setSourceValue('b1', 8.0, false);
			t.setSourceValue('b2', 4.0, true);
			t.setDestinationValue('a1', 6.0, false);
			t.setDestinationValue('a2', 1.0, true);
			t.setDestinationValue('b1', 2.0, false);
			t.setDestinationValue('b2', -2.0, true);
			
			assertEquals(5.0, o.a1);
			assertEquals(5.0, o.a2);
			assertEquals(4.0, o.b1);
			assertEquals(4.0, o.b2);
			assertEquals(3.0, o.c);
			
			t.update(0);
			
			assertEquals(1.0, o.a1);
			assertEquals(1.0, o.a2);
			assertEquals(8.0, o.b1);
			assertEquals(8.0, o.b2);
			assertEquals(3.0, o.c);
			
			t.update(1000);
			
			assertEquals(2.25, o.a1);
			assertEquals(2.25, o.a2);
			assertEquals(6.5, o.b1);
			assertEquals(6.5, o.b2);
			assertEquals(3.0, o.c);
			
			t.update(2000);
			
			assertEquals(3.5, o.a1);
			assertEquals(3.5, o.a2);
			assertEquals(5.0, o.b1);
			assertEquals(5.0, o.b2);
			assertEquals(3.0, o.c);
			
			t.update(4000);
			
			assertEquals(6.0, o.a1);
			assertEquals(6.0, o.a2);
			assertEquals(2.0, o.b1);
			assertEquals(2.0, o.b2);
			assertEquals(3.0, o.c);
			
			t.update(6000);
			
			assertEquals(6.0, o.a1);
			assertEquals(6.0, o.a2);
			assertEquals(2.0, o.b1);
			assertEquals(2.0, o.b2);
			assertEquals(3.0, o.c);
		}
		
		/**
		 * 開始値と終了値と delay を設定しての update
		 */
		test function updateWithSourceAndDestinationAndDelay():void
		{
			var o:Object = {
				a1: 5.0,
				a2: 5.0,
				b1: 4.0,
				b2: 4.0,
				c: 3.0
			};
			
			var t:ISingleTweenTarget = new ObjectTweenTarget();
			t.target = o;
			t.easing = new EaseNone();
			t.delay = 2000;
			t.time = 4000;
			t.setSourceValue('a1', 1.0, false);
			t.setSourceValue('a2', -4.0, true);
			t.setSourceValue('b1', 8.0, false);
			t.setSourceValue('b2', 4.0, true);
			t.setDestinationValue('a1', 6.0, false);
			t.setDestinationValue('a2', 1.0, true);
			t.setDestinationValue('b1', 2.0, false);
			t.setDestinationValue('b2', -2.0, true);
			
			assertEquals(5.0, o.a1);
			assertEquals(5.0, o.a2);
			assertEquals(4.0, o.b1);
			assertEquals(4.0, o.b2);
			assertEquals(3.0, o.c);
			
			t.update(0);
			
			assertEquals(1.0, o.a1);
			assertEquals(1.0, o.a2);
			assertEquals(8.0, o.b1);
			assertEquals(8.0, o.b2);
			assertEquals(3.0, o.c);
			
			t.update(1000);
			
			assertEquals(1.0, o.a1);
			assertEquals(1.0, o.a2);
			assertEquals(8.0, o.b1);
			assertEquals(8.0, o.b2);
			assertEquals(3.0, o.c);
			
			t.update(2000);
			
			assertEquals(1.0, o.a1);
			assertEquals(1.0, o.a2);
			assertEquals(8.0, o.b1);
			assertEquals(8.0, o.b2);
			assertEquals(3.0, o.c);
			
			t.update(3000);
			
			assertEquals(2.25, o.a1);
			assertEquals(2.25, o.a2);
			assertEquals(6.5, o.b1);
			assertEquals(6.5, o.b2);
			assertEquals(3.0, o.c);
			
			t.update(4000);
			
			assertEquals(3.5, o.a1);
			assertEquals(3.5, o.a2);
			assertEquals(5.0, o.b1);
			assertEquals(5.0, o.b2);
			assertEquals(3.0, o.c);
			
			t.update(6000);
			
			assertEquals(6.0, o.a1);
			assertEquals(6.0, o.a2);
			assertEquals(2.0, o.b1);
			assertEquals(2.0, o.b2);
			assertEquals(3.0, o.c);
			
			t.update(8000);
			
			assertEquals(6.0, o.a1);
			assertEquals(6.0, o.a2);
			assertEquals(2.0, o.b1);
			assertEquals(2.0, o.b2);
			assertEquals(3.0, o.c);
		}
		
		/**
		 * オブジェクトの取得
		 */
		test function getObject():void
		{
			var obj1:Object = new Object();
			var obj2:Object = new Object();
			var o:Object = {
				o1: obj1,
				o2: obj2
			};
			
			var t:ISingleTweenTarget = new ObjectTweenTarget();
			t.target = o;
			
			assertSame(obj1, t.getObject('o1'));
			assertSame(obj2, t.getObject('o2'));
		}
		
		/**
		 * オブジェクトの設定
		 */
		test function setObject():void
		{
			var o:Object = {
				o1: new Object(),
				o2: new Object()
			};
			
			var t:ISingleTweenTarget = new ObjectTweenTarget();
			t.target = o;
			
			var obj1:Object = new Object();
			var obj2:Object = new Object();
			t.setObject('o1', obj1);
			t.setObject('o2', obj2);
			
			assertSame(obj1, o.o1);
			assertSame(obj2, o.o2);
		}
	}
}