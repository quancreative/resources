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
package
{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.PixelSnapping;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.geom.ColorTransform;
	import flash.geom.Point;
	import org.libspark.betweenas3.BetweenAS3;
	import org.libspark.betweenas3.easing.Back;
	import org.libspark.betweenas3.tweens.ITween;
	
	/**
	 * @author	yossy:beinteractive
	 */
	[SWF(width = 400, height = 300, frameRate = 30, backgroundColor = 0x000000)]
	public class PointTweenTest extends Sprite
	{
		private static const FADE:ColorTransform = new ColorTransform(1, 1, 1, 1, -32, -16, -16);
		
		public function PointTweenTest()
		{
			_p = new Point(100, 150);
			
			var t:ITween = BetweenAS3.tween(_p, {x: 300}, null, 1.5, Back.easeInOut);
			t = BetweenAS3.serial(t, BetweenAS3.reverse(t));
			t.stopOnComplete = false;
			t.play();
			
			_bitmapData = new BitmapData(400, 300, false, 0x000000);
			
			addChild(new Bitmap(_bitmapData, PixelSnapping.NEVER, false));
			
			addEventListener(Event.ENTER_FRAME, enterFrameHandler);
		}
		
		private var _bitmapData:BitmapData;
		private var _p:Point;
		
		private function enterFrameHandler(e:Event):void
		{
			_bitmapData.lock();
			_bitmapData.colorTransform(_bitmapData.rect, FADE);
			_bitmapData.setPixel(_p.x, _p.y, 0xffffff);
			_bitmapData.unlock();
		}
	}
}