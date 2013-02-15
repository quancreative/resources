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
	public class RepeatedTweenTargetTest
	{
		test function repeat():void
		{
			var t:TestTweenTarget = new TestTweenTarget(2);
			var r:RepeatedTweenTarget = new RepeatedTweenTarget(t, 3);
			
			assertEquals(6, r.duration);
			
			r.update(0);
			
			assertEquals(0, t.t);
			
			r.update(1);
			
			assertEquals(1, t.t);
			
			r.update(2);
			
			assertEquals(0, t.t);
			
			r.update(3);
			
			assertEquals(1, t.t);
			
			r.update(4);
			
			assertEquals(0, t.t);
			
			r.update(5);
			
			assertEquals(1, t.t);
			
			r.update(5.5);
			
			assertEquals(1.5, t.t);
			
			r.update(6);
			
			assertEquals(2, t.t);
			
			r.update(7);
			
			assertEquals(3, t.t);
		}
	}
}