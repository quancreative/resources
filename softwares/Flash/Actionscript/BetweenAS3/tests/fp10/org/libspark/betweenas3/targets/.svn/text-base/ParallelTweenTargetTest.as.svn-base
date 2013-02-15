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
	public class ParallelTweenTargetTest
	{
		test function parallel():void
		{
			var t1:TestTweenTarget = new TestTweenTarget(1.0);
			var t2:TestTweenTarget = new TestTweenTarget(2.0);
			var t3:TestTweenTarget = new TestTweenTarget(3.0);
			var t4:TestTweenTarget = new TestTweenTarget(4.0);
			var t5:TestTweenTarget = new TestTweenTarget(5.0);
			var t6:TestTweenTarget = new TestTweenTarget(6.0);
			
			var v:Vector.<ITweenTarget> = new Vector.<ITweenTarget>(6, true);
			v[0] = t1;
			v[1] = t2;
			v[2] = t3;
			v[3] = t4;
			v[4] = t5;
			v[5] = t6;
			
			var parallel:ParallelTweenTarget = new ParallelTweenTarget(v);
			
			assertEquals(6, parallel.duration);
			
			parallel.update(0);
			
			assertEquals(0, t1.t);
			assertEquals(0, t2.t);
			assertEquals(0, t3.t);
			assertEquals(0, t4.t);
			assertEquals(0, t5.t);
			assertEquals(0, t6.t);
			
			parallel.update(3);
			
			assertEquals(3, t1.t);
			assertEquals(3, t2.t);
			assertEquals(3, t3.t);
			assertEquals(3, t4.t);
			assertEquals(3, t5.t);
			assertEquals(3, t6.t);
			
			parallel.update(6);
			
			assertEquals(6, t1.t);
			assertEquals(6, t2.t);
			assertEquals(6, t3.t);
			assertEquals(6, t4.t);
			assertEquals(6, t5.t);
			assertEquals(6, t6.t);
		}
	}
}