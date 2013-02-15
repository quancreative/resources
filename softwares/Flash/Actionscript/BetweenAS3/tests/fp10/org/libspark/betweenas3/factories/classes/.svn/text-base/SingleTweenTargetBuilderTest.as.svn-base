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
package org.libspark.betweenas3.factories.classes
{
	import org.libspark.as3unit.assert.*;
	import org.libspark.as3unit.before;
	import org.libspark.as3unit.after;
	import org.libspark.as3unit.test;
	import org.libspark.betweenas3.easing.classes.EaseNone;
	import org.libspark.betweenas3.easing.IEasing;
	import org.libspark.betweenas3.factories.ClassA;
	import org.libspark.betweenas3.factories.ClassB;
	import org.libspark.betweenas3.registries.ClassRegistry;
	import org.libspark.betweenas3.targets.single.ISingleTweenTarget;
	
	use namespace before;
	use namespace after;
	use namespace test;
	
	/**
	 * @author	yossy:beinteractive
	 */
	public class SingleTweenTargetBuilderTest
	{
		private var _b:SingleTweenTargetBuilder = new SingleTweenTargetBuilder();
		
		before function initialize():void
		{
			var r:ClassRegistry = new ClassRegistry();
			r.registerClassWithTargetClassAndPropertyName(TestTweenTargetA, ClassA, 'a1');
			r.registerClassWithTargetClassAndPropertyName(TestTweenTargetA, ClassA, 'a2');
			r.registerClassWithTargetClassAndPropertyName(TestTweenTargetB, ClassB, 'a1');
			r.registerClassWithTargetClassAndPropertyName(TestTweenTargetB, ClassB, 'b');
			_b.tweenTargetClassRegistry = r;
		}
		
		after function finalize():void
		{
			_b.tweenTargetClassRegistry = null;
			_b = null;
		}
		
		test function createA():void
		{
			var obj:Object = new ClassA();
			var easing:IEasing = new EaseNone();
			_b.reset(obj, 100, 200, easing);
			var t1:ISingleTweenTarget = _b.createTweenTarget('a1');
			var t2:ISingleTweenTarget = _b.createTweenTarget('a1');
			var t3:ISingleTweenTarget = _b.createTweenTarget('a2');
			var t4:ISingleTweenTarget = _b.createTweenTarget('b');
			var t:Vector.<ISingleTweenTarget> = _b.getCreatedTweenTargets();
			assertTrue(t1 is TestTweenTargetA);
			assertSame(obj, t1.target);
			assertEquals(100, t1.time);
			assertEquals(200, t1.delay);
			assertSame(easing, t1.easing);
			assertSame(t1, t2);
			assertSame(t1, t3);
			assertNull(t4);
			assertEquals(1, t.length);
			assertSame(t1, t[0]);
		}
		
		test function createB():void
		{
			var obj:Object = new ClassB();
			var easing:IEasing = new EaseNone();
			_b.reset(obj, 100, 200, easing);
			var t1:ISingleTweenTarget = _b.createTweenTarget('a1');
			var t2:ISingleTweenTarget = _b.createTweenTarget('a1');
			var t3:ISingleTweenTarget = _b.createTweenTarget('a2');
			var t4:ISingleTweenTarget = _b.createTweenTarget('b');
			var t:Vector.<ISingleTweenTarget> = _b.getCreatedTweenTargets();
			assertTrue(t1 is TestTweenTargetB);
			assertSame(obj, t1.target);
			assertEquals(100, t1.time);
			assertEquals(200, t1.delay);
			assertSame(easing, t1.easing);
			assertSame(t1, t2);
			assertTrue(t3 is TestTweenTargetA);
			assertSame(obj, t3.target);
			assertEquals(100, t3.time);
			assertEquals(200, t3.delay);
			assertSame(easing, t3.easing);
			assertSame(t1, t4);
			assertEquals(2, t.length);
			assertSame(t1, t[0]);
			assertSame(t3, t[1]);
		}
	}
}

import org.libspark.betweenas3.targets.single.AbstractSingleTweenTarget;

internal class TestTweenTarget extends AbstractSingleTweenTarget
{
	private var _target:Object;
	
	override public function get target():Object
	{
		return _target;
	}
	
	override public function set target(value:Object):void
	{
		_target = value;
	}
}

internal class TestTweenTargetA extends TestTweenTarget
{
	
}

internal class TestTweenTargetB extends TestTweenTarget
{
	
}