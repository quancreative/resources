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
package org.libspark.betweenas3.tickers
{
	import flash.utils.getTimer;
	import org.libspark.as3unit.assert.*;
	import org.libspark.as3unit.test;
	
	use namespace test;
	
	/**
	 * @author	yossy:beinteractive
	 */
	public class EnterFrameTickerTest
	{
		test function update():void
		{
			var l01:MockTickerListener = new MockTickerListener(1);
			var l02:MockTickerListener = new MockTickerListener(1);
			var l03:MockTickerListener = new MockTickerListener(2);
			var l04:MockTickerListener = new MockTickerListener(3);
			var l05:MockTickerListener = new MockTickerListener(5);
			var l06:MockTickerListener = new MockTickerListener(8);
			var l07:MockTickerListener = new MockTickerListener(13);
			var l08:MockTickerListener = new MockTickerListener(21);
			var l09:MockTickerListener = new MockTickerListener(34);
			var l10:MockTickerListener = new MockTickerListener(55);
			var l11:MockTickerListener = new MockTickerListener(89);
			var l12:MockTickerListener = new MockTickerListener(144);
			var l13:MockTickerListener = new MockTickerListener(233);
			var l14:MockTickerListener = new MockTickerListener(377);
			var l15:MockTickerListener = new MockTickerListener(610);
			var l16:MockTickerListener = new MockTickerListener(987);
			var l17:MockTickerListener = new MockTickerListener(1597);
			var l18:MockTickerListener = new MockTickerListener(2584);
			var l19:MockTickerListener = new MockTickerListener(4181);
			var l20:MockTickerListener = new MockTickerListener(6765);
			var l21:MockTickerListener = new MockTickerListener(10946);
			var l22:MockTickerListener = new MockTickerListener(17711);
			var l23:MockTickerListener = new MockTickerListener(28657);
			var l24:MockTickerListener = new MockTickerListener(46368);
			
			var ticker:EnterFrameTicker = new EnterFrameTicker();
			
			ticker.addTickerListener(l01);
			ticker.addTickerListener(l02);
			ticker.addTickerListener(l03);
			ticker.addTickerListener(l04);
			ticker.addTickerListener(l05);
			ticker.addTickerListener(l06);
			ticker.addTickerListener(l07);
			ticker.addTickerListener(l08);
			ticker.addTickerListener(l09);
			ticker.addTickerListener(l10);
			ticker.addTickerListener(l11);
			ticker.addTickerListener(l12);
			ticker.addTickerListener(l13);
			ticker.addTickerListener(l14);
			ticker.addTickerListener(l15);
			ticker.addTickerListener(l16);
			ticker.addTickerListener(l17);
			ticker.addTickerListener(l18);
			ticker.addTickerListener(l19);
			ticker.addTickerListener(l20);
			ticker.addTickerListener(l21);
			ticker.addTickerListener(l22);
			ticker.addTickerListener(l23);
			ticker.addTickerListener(l24);
			
			for (var i:uint = 1; i < 50000; ++i) {
				ticker.update(null);
			}
			
			assertEquals(1, l01.c);
			assertEquals(1, l02.c);
			assertEquals(2, l03.c);
			assertEquals(3, l04.c);
			assertEquals(5, l05.c);
			assertEquals(8, l06.c);
			assertEquals(13, l07.c);
			assertEquals(21, l08.c);
			assertEquals(34, l09.c);
			assertEquals(55, l10.c);
			assertEquals(89, l11.c);
			assertEquals(144, l12.c);
			assertEquals(233, l13.c);
			assertEquals(377, l14.c);
			assertEquals(610, l15.c);
			assertEquals(987, l16.c);
			assertEquals(1597, l17.c);
			assertEquals(2584, l18.c);
			assertEquals(4181, l19.c);
			assertEquals(6765, l20.c);
			assertEquals(10946, l21.c);
			assertEquals(17711, l22.c);
			assertEquals(28657, l23.c);
			assertEquals(46368, l24.c);
		}
		
		/**
		test function speed():void
		{
			var i:uint;
			var ticker:EnterFrameTicker = new EnterFrameTicker();
			
			for (i = 0; i < 8000; ++i) {
				ticker.addTickerListener(new MockTickerListener(600));
			}
			
			var t:uint = getTimer();
			
			for (i = 0; i < 600; ++i) {
				ticker.update(null);
			}
			
			trace('time<' + (getTimer() - t) + '>');
		}
		/**/
		
		test function addListenerInTick():void
		{
			var ticker:EnterFrameTicker = new EnterFrameTicker();
			
			var l3:MockTickerListener = new MockTickerListener(5);
			var l2:MockTickerListener = new MockTickerListener(5);
			var l1:AddingListenerTickerListener = new AddingListenerTickerListener(5, ticker, l3);
			
			ticker.addTickerListener(l1);
			ticker.addTickerListener(l2);
			
			ticker.update(null);
			ticker.update(null);
			
			assertEquals(2, l1.c);
			assertEquals(2, l2.c);
			assertEquals(1, l3.c);
		}
	}
}

import org.libspark.betweenas3.tickers.TickerListener;
import org.libspark.betweenas3.tickers.ITicker;

internal class MockTickerListener extends TickerListener
{
	public function MockTickerListener(n:uint)
	{
		this.n = n;
		this.c = 0;
	}
	
	public var n:uint;
	public var c:uint;
	
	override public function tick(time:Number):Boolean
	{
		return ++c == n;
	}
}

internal class AddingListenerTickerListener extends MockTickerListener
{
	public function AddingListenerTickerListener(n:uint, ticker:ITicker, listener:TickerListener)
	{
		super(n);
		
		this.ticker = ticker;
		this.listener = listener;
	}
	
	public var ticker:ITicker;
	public var listener:TickerListener;
	
	override public function tick(time:Number):Boolean
	{
		if (c == 0) {
			ticker.addTickerListener(listener);
		}
		return super.tick(time);
	}
}