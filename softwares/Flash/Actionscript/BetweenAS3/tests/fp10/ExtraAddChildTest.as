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
	import org.libspark.betweenas3.easing.Bounce;
	import org.libspark.betweenas3.tweens.ITween;
	
	/**
	 * @author	yossy:beinteractive
	 */
	public class ExtraAddChildTest extends Sprite
	{
		public function ExtraAddChildTest()
		{
			addEventListener(Event.ADDED_TO_STAGE, initialize);
		}
		
		private function initialize(e:Event):void
		{
			removeEventListener(Event.ADDED_TO_STAGE, initialize);
			
			setupBackground();
			
			var box1:Box = new Box();
			var box2:Box = new Box();
			var box3:Box = new Box();
			var box4:Box = new Box();
			
			box1.x = 100;
			box1.y = 100;
			box2.x = 700;
			box2.y = 100;
			box3.x = 100;
			box3.y = 500;
			box4.x = 700;
			box4.y = 500;
			
			_t = BetweenAS3.serial(
				BetweenAS3.addChild(box1, this),
				BetweenAS3.addChild(box2, this, 0.5),
				BetweenAS3.addChild(box3, this, 0.5),
				BetweenAS3.addChild(box4, this, 0.5),
				BetweenAS3.parallel(
					BetweenAS3.tween(box1, {x: 350, y: 250}, null, 1.2, Bounce.easeOut, 0.5),
					BetweenAS3.tween(box2, {x: 450, y: 250}, null, 1.2, Bounce.easeOut, 0.5),
					BetweenAS3.tween(box3, {x: 350, y: 350}, null, 1.2, Bounce.easeOut, 0.5),
					BetweenAS3.tween(box4, {x: 450, y: 350}, null, 1.2, Bounce.easeOut, 0.5)
				)
			);
			
			_t.play();
			
			stage.addEventListener(MouseEvent.MOUSE_DOWN, mouseDownHandler)
		}
		
		private var _t:ITween;
		
		private function setupBackground():void
		{
			var bg:Shape = new Shape();
			bg.graphics.beginFill(0xffffff);
			bg.graphics.drawRect(0, 0, stage.stageWidth, stage.stageHeight);
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