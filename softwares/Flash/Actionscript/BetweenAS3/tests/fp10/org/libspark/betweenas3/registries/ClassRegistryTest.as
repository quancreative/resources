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
package org.libspark.betweenas3.registries
{
	import org.libspark.as3unit.assert.*;
	import org.libspark.as3unit.before;
	import org.libspark.as3unit.after;
	import org.libspark.as3unit.test;
	
	use namespace before;
	use namespace after;
	use namespace test;
	
	/**
	 * @author	yossy:beinteractive
	 */
	public class ClassRegistryTest
	{
		private var _r:ClassRegistry;
		
		before function initialize():void
		{
			_r = new ClassRegistry();
			_r.registerClassWithTargetClassAndPropertyName(D, Object, '*');
			_r.registerClassWithTargetClassAndPropertyName(C, ClassA, 'b');
			_r.registerClassWithTargetClassAndPropertyName(B, ClassA, 'a');
			_r.registerClassWithTargetClassAndPropertyName(A, ClassB, 'a');
		}
		
		after function finalize():void
		{
			_r = null;
		}
		
		test function getByClassBA():void
		{
			assertSame(A, _r.getClassByTargetClassAndPropertyName(ClassB, 'a'));
		}
		
		test function getByClassAA():void
		{
			assertSame(B, _r.getClassByTargetClassAndPropertyName(ClassA, 'a'));
		}
		
		test function getByClassAB():void
		{
			assertSame(C, _r.getClassByTargetClassAndPropertyName(ClassA, 'b'));
		}
		
		test function getByClassBB():void
		{
			assertSame(C, _r.getClassByTargetClassAndPropertyName(ClassB, 'b'));
		}
		
		test function getByClassBC():void
		{
			assertSame(D, _r.getClassByTargetClassAndPropertyName(ClassB, 'c'));
		}
		
		test function getByClassAC():void
		{
			assertSame(D, _r.getClassByTargetClassAndPropertyName(ClassA, 'c'));
		}
		
		test function getByObjectC():void
		{
			assertSame(D, _r.getClassByTargetClassAndPropertyName(Object, 'c'));
		}
		
		test function getByClassC():void
		{
			assertSame(A, _r.getClassByTargetClassAndPropertyName(ClassC, 'a'));
			assertSame(C, _r.getClassByTargetClassAndPropertyName(ClassC, 'b'));
			assertSame(D, _r.getClassByTargetClassAndPropertyName(ClassC, 'c'));
		}
		
		test function getByClassD():void
		{
			assertSame(A, _r.getClassByTargetClassAndPropertyName(ClassD, 'a'));
			assertSame(C, _r.getClassByTargetClassAndPropertyName(ClassD, 'b'));
			assertSame(D, _r.getClassByTargetClassAndPropertyName(ClassD, 'c'));
		}
		
		test function overrideRegister():void
		{
			_r.registerClassWithTargetClassAndPropertyName(E, ClassA, 'a');
			assertSame(E, _r.getClassByTargetClassAndPropertyName(ClassA, 'a'));
			assertSame(C, _r.getClassByTargetClassAndPropertyName(ClassA, 'b'));
		}
		
		test function overrideRegister2():void
		{
			_r.registerClassWithTargetClassAndPropertyName(E, Object, 'c');
			assertSame(E, _r.getClassByTargetClassAndPropertyName(ClassB, 'c'));
			_r.registerClassWithTargetClassAndPropertyName(F, ClassA, 'c');
			assertSame(F, _r.getClassByTargetClassAndPropertyName(ClassB, 'c'));
		}
	}
}

internal class A
{
}

internal class B
{
}

internal class C
{
}

internal class D
{
}

internal class E
{
}

internal class F
{
}