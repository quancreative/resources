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
	import org.libspark.as3unit.assert.*;
	import org.libspark.as3unit.test;
	
	use namespace test;
	
	/**
	 * @author	yossy:beinteractive
	 */
	public class SerialTweenTargetTest
	{
		test function serial():void
		{
			var t1:TestTweenTarget = new TestTweenTarget(1.0);
			var t2:TestTweenTarget = new TestTweenTarget(1.0);
			var t3:TestTweenTarget = new TestTweenTarget(1.0);
			var t4:TestTweenTarget = new TestTweenTarget(1.0);
			var t5:TestTweenTarget = new TestTweenTarget(1.0);
			var t6:TestTweenTarget = new TestTweenTarget(1.0);
			
			var v:Vector.<ITweenTarget> = new Vector.<ITweenTarget>(6, true);
			v[0] = t1;
			v[1] = t2;
			v[2] = t3;
			v[3] = t4;
			v[4] = t5;
			v[5] = t6;
			
			var serial:SerialTweenTarget = new SerialTweenTarget(v);
			
			assertEquals(6, serial.duration);
			
			serial.update(0);
			
			assertEquals(0, t1.t);
			assertTrue(isNaN(t2.t));
			assertTrue(isNaN(t3.t));
			assertTrue(isNaN(t4.t));
			assertTrue(isNaN(t5.t));
			assertTrue(isNaN(t6.t));
			
			serial.update(0.5);
			
			assertEquals(0.5, t1.t);
			assertTrue(isNaN(t2.t));
			assertTrue(isNaN(t3.t));
			assertTrue(isNaN(t4.t));
			assertTrue(isNaN(t5.t));
			assertTrue(isNaN(t6.t));
			
			serial.update(1);
			
			assertEquals(1, t1.t);
			assertEquals(0, t2.t);
			assertTrue(isNaN(t3.t));
			assertTrue(isNaN(t4.t));
			assertTrue(isNaN(t5.t));
			assertTrue(isNaN(t6.t));
			
			t1.t = NaN;
			
			serial.update(1.5);
			
			assertEquals(1.5, t1.t);
			assertEquals(0.5, t2.t);
			assertTrue(isNaN(t3.t));
			assertTrue(isNaN(t4.t));
			assertTrue(isNaN(t5.t));
			assertTrue(isNaN(t6.t));
			
			t1.t = NaN;
			
			serial.update(3);
			
			assertTrue(isNaN(t1.t));
			assertEquals(2, t2.t);
			assertEquals(1, t3.t);
			assertEquals(0, t4.t);
			assertTrue(isNaN(t5.t));
			assertTrue(isNaN(t6.t));
			
			t2.t = NaN;
			t3.t = NaN;
			
			serial.update(6);
			
			assertTrue(isNaN(t1.t));
			assertTrue(isNaN(t2.t));
			assertEquals(4, t3.t);
			assertEquals(3, t4.t);
			assertEquals(2, t5.t);
			assertEquals(1, t6.t);
			
			t3.t = NaN;
			t4.t = NaN;
			t5.t = NaN;
			t6.t = NaN;
			
			serial.update(3);
			
			assertTrue(isNaN(t1.t));
			assertTrue(isNaN(t2.t));
			assertEquals(1, t3.t);
			assertEquals(0, t4.t);
			assertEquals(-1, t5.t);
			assertEquals(-2, t6.t);
			
			t4.t = NaN;
			t5.t = NaN;
			t6.t = NaN;
			
			serial.update(0);
			
			assertEquals(0, t1.t);
			assertEquals(-1, t2.t);
			assertEquals(-2, t3.t);
			assertEquals(-3, t4.t);
			assertTrue(isNaN(t5.t));
			assertTrue(isNaN(t6.t));
		}
	}
}