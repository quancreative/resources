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
package org.libspark.betweenas3.tweens
{
	import flash.events.Event;
	import org.libspark.as3unit.assert.*;
	import org.libspark.as3unit.before;
	import org.libspark.as3unit.after;
	import org.libspark.as3unit.test;
	import org.libspark.betweenas3.events.BetweenEvent;
	
	use namespace before;
	use namespace after;
	use namespace test;
	
	/**
	 * @author	yossy:beinteractive
	 */
	public class StandardTweenTest
	{
		private var _ticker:TestTicker;
		private var _target:TestTweenTarget;
		private var _tween:StandardTween;
		
		before function initialize():void
		{
			_ticker = new TestTicker();
			_ticker.t = 1000;
			_target = new TestTweenTarget();
			_target.d = 3000;
			_target.t = 9999;
			_tween = new StandardTween(_target, _ticker, 0);
			_tween.addEventListener(BetweenEvent.PLAY, playHandler);
			_tween.addEventListener(BetweenEvent.STOP, stopHandler);
			_tween.addEventListener(BetweenEvent.UPDATE, updateHandler);
			_tween.addEventListener(BetweenEvent.COMPLETE, completeHandler);
			
			Static.log = '';
		}
		
		private function playHandler(e:Event):void
		{
			Static.log += 'play ';
		}
		
		private function stopHandler(e:Event):void
		{
			Static.log += 'stop ';
		}
		
		private function updateHandler(e:Event):void
		{
			Static.log += 'update ';
		}
		
		private function completeHandler(e:Event):void
		{
			Static.log += 'complete ';
		}
		
		after function finalize():void
		{
			_tween = null;
			_target = null;
			_ticker = null;
		}
		
		test function duration():void
		{
			assertEquals(3000, _tween.duration);
		}
		
		test function play():void
		{
			assertFalse(_tween.isPlaying);
			assertEquals(9999, _target.t);
			
			_tween.play();
			
			assertTrue(_tween.isPlaying);
			assertEquals('play update ', Static.log);
			assertSame(_tween, _ticker.listener);
			assertEquals(0, _target.t);
			
			_ticker.listener.tick(2500);
			
			assertEquals(1500, _target.t);
			assertEquals('play update update ', Static.log);
		}
		
		test function playStop():void
		{
			_tween.play();
			_ticker.listener.tick(2500);
			_tween.stop();
			
			assertFalse(_tween.isPlaying);
			assertEquals('play update update stop ', Static.log);
			assertNull(_ticker.listener);
		}
		
		test function playComplete():void
		{
			_tween.play();
			var b1:Boolean = _ticker.listener.tick(2500);
			var b2:Boolean = _ticker.listener.tick(4500);
			
			assertFalse(b1);
			assertTrue(b2);
			assertFalse(_tween.isPlaying);
			assertEquals('play update update update complete ', Static.log);
			assertEquals(3500, _target.t);
		}
		
		test function gotoAndPlay():void
		{
			assertFalse(_tween.isPlaying);
			assertEquals(9999, _target.t);
			
			_tween.gotoAndPlay(1000);
			
			assertTrue(_tween.isPlaying);
			assertEquals('play update ', Static.log);
			assertSame(_tween, _ticker.listener);
			assertEquals(1000, _target.t);
			
			_ticker.listener.tick(2500);
			
			assertEquals(2500, _target.t);
			assertEquals('play update update ', Static.log);
		}
		
		test function gotoAndStop():void
		{
			assertFalse(_tween.isPlaying);
			assertEquals(9999, _target.t);
			
			_tween.gotoAndStop(2000);
			
			assertFalse(_tween.isPlaying);
			assertEquals('update ', Static.log);
			assertNull(_ticker.listener);
			assertEquals(2000, _target.t);
		}
		
		test function playGotoAndStop():void
		{
			_tween.play();
			_ticker.listener.tick(2500);
			_tween.gotoAndStop(2500);
			
			assertFalse(_tween.isPlaying);
			assertEquals('play update update update stop ', Static.log);
			assertNull(_ticker.listener);
			assertEquals(2500, _target.t);
		}
		
		test function stopOnComplete():void
		{
			_tween.stopOnComplete = false;
			
			_tween.play();
			var b1:Boolean = _ticker.listener.tick(2500);
			var b2:Boolean = _ticker.listener.tick(4500);
			
			assertFalse(b1);
			assertFalse(b2);
			assertTrue(_tween.isPlaying);
			assertEquals('play update update update complete update ', Static.log);
			assertEquals(500, _target.t);
		}
	}
}

import org.libspark.betweenas3.targets.ITweenTarget;
import org.libspark.betweenas3.tickers.ITicker;
import org.libspark.betweenas3.tickers.TickerListener;

internal class Static
{
	public static var log:String;
}

internal class TestTicker implements ITicker
{
	public var t:Number;
	public var listener:TickerListener;
	
	public function get time():Number
	{
		return t;
	}
	
	public function addTickerListener(listener:TickerListener):void
	{
		this.listener = listener;
	}
	
	public function removeTickerListener(listener:TickerListener):void
	{
		if (this.listener == listener) {
			this.listener = null;
		}
	}
	
	public function start():void
	{
		
	}
	
	public function stop():void
	{
		
	}
}

internal class TestTweenTarget implements ITweenTarget
{
	public var d:Number;
	public var t:Number;
	
	public function get duration():Number
	{
		return d;
	}
	
	public function update(time:Number):void
	{
		t = time;
	}
}