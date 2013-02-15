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
	import com.flashdynamix.utils.SWFProfiler;
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.PixelSnapping;
	import flash.display.Sprite;
	import flash.display.StageAlign;
	import flash.display.StageQuality;
	import flash.display.StageScaleMode;
	import flash.events.Event;
	import flash.geom.ColorTransform;
	import flash.geom.Point;
	import org.libspark.betweenas3.BetweenAS3;
	import org.libspark.betweenas3.easing.Back;
	import org.libspark.betweenas3.easing.Quart;
	import org.libspark.betweenas3.tweens.ITween;
	
	/**
	 * @author	yossy:beinteractive
	 */
	[SWF(width = 800, height = 600, frameRate = 30, backgroundColor = 0x000000)]
	public class Particles extends Sprite
	{
		private static const NUM_PARTICLES:uint = 24000;
		private static const FADE:ColorTransform = new ColorTransform(1, 1, 1, 1, -32, -16, -16);
		
		public function Particles()
		{
			setupParticles();
			setupScreen();
			setupStage();
			
			SWFProfiler.init(this);
			
			addEventListener(Event.ENTER_FRAME, enterFrameHandler);
		}
		
		private var _bitmapData:BitmapData;
		private var _bitmap:Bitmap;
		private var _particles:Particle;
		
		private function setupParticles():void
		{
			var prev:Particle = _particles = new Particle();
			var p:Particle = null;
			var a:Number, dx:Number, dy:Number;
			var t:ITween;
			var i:int = NUM_PARTICLES;
			while (--i >= 0) {
				
				a = Math.random() * Math.PI * 2;
				dx = Math.cos(a) * 550 + 400;
				dy = Math.sin(a) * 450 + 300;
				
				p = new Particle();
				p.p.x = 400;
				p.p.y = 300;
				
				t = BetweenAS3.tween(p.p, {x: dx, y: dy}, null, 1.5 + Math.random() * 4.5, Quart.easeIn);
				t.stopOnComplete = false;
				t.play();
				
				prev.next = p;
				prev = p;
			}
		}
		
		private function setupScreen():void
		{
			_bitmapData = new BitmapData(800, 600, false, 0x000000);
			_bitmap = addChild(new Bitmap(_bitmapData, PixelSnapping.NEVER, false)) as Bitmap;
		}
		
		private function setupStage():void
		{
			stage.quality = StageQuality.LOW;
			stage.scaleMode = StageScaleMode.NO_SCALE;
			stage.align = StageAlign.TOP_LEFT;
			stage.addEventListener(Event.RESIZE, resizeHandler);
			resizeHandler(null);
		}
		
		private function resizeHandler(e:Event):void
		{
			_bitmap.x = Math.floor((stage.stageWidth - 800) / 2);
			_bitmap.y = Math.floor((stage.stageHeight - 600) / 2);
		}
		
		private function enterFrameHandler(e:Event):void
		{
			var bitmapData:BitmapData = _bitmapData;
			
			bitmapData.lock();
			bitmapData.colorTransform(_bitmapData.rect, FADE);
			
			var p:Particle = _particles;
			var pos:Point;
			while ((p = p.next) != null) {
				pos = p.p;
				bitmapData.setPixel(pos.x >> 0, pos.y >> 0, 0xffffff);
			}
			
			bitmapData.unlock();
		}
	}
}

import flash.geom.Point;

internal class Particle
{
	public var p:Point = new Point();
	public var next:Particle;
}