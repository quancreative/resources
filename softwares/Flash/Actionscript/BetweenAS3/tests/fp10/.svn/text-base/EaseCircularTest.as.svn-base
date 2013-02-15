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
	import flash.display.Shape;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import org.libspark.betweenas3.BetweenAS3;
	import org.libspark.betweenas3.easing.*;
	import org.libspark.betweenas3.tweens.ITween;
	
	/**
	 * @author	yossy:beinteractive
	 */
	[SWF(width = 800, height = 600, frameRate = 30, backgroundColor = 0xffffff)]
	public class EaseCircularTest extends Sprite
	{
		public function EaseCircularTest()
		{
			setupBackground();
			
			var box1:Box = addChild(new Box()) as Box;
			var box2:Box = addChild(new Box()) as Box;
			var box3:Box = addChild(new Box()) as Box;
			var box4:Box = addChild(new Box()) as Box;
			
			_t = BetweenAS3.parallel(
				BetweenAS3.tween(box1, {x: 700, y: 120}, {x: 100, y: 120}, 1.0, Circular.easeIn),
				BetweenAS3.tween(box2, {x: 700, y: 240}, {x: 100, y: 240}, 1.0, Circular.easeOut),
				BetweenAS3.tween(box3, {x: 700, y: 360}, {x: 100, y: 360}, 1.0, Circular.easeInOut),
				BetweenAS3.tween(box4, {x: 700, y: 480}, {x: 100, y: 480}, 1.0, Circular.easeOutIn)
			);
			
			_t.play();
			
			stage.addEventListener(MouseEvent.MOUSE_DOWN, mouseDownHandler)
		}
		
		private var _t:ITween;
		
		private function setupBackground():void
		{
			var bg:Shape = new Shape();
			bg.graphics.beginFill(0xffffff);
			bg.graphics.drawRect(0, 0, 800, 600);
			bg.graphics.endFill();
			bg.graphics.beginFill(0xcccccc);
			bg.graphics.drawRect(100, 0, 1, 600);
			bg.graphics.drawRect(700, 0, 1, 600);
			bg.graphics.endFill();
			addChild(bg);
		}
		
		private function mouseDownHandler(e:MouseEvent):void
		{
			if (_t.isPlaying) {
				_t.stop();
			}
			else {
				if (_t.position == _t.duration) {
					_t.gotoAndPlay(0);
				}
				else {
					_t.play();
				}
			}
		}
	}
}

import flash.display.Shape;

internal class Box extends Shape
{
	public function Box()
	{
		graphics.beginFill(0x000000);
		graphics.drawRect(-10, -10, 20, 20);
		graphics.endFill();
	}
}