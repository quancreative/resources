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
	import flash.display.MovieClip;
	import flash.display.Shape;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import org.libspark.betweenas3.BetweenAS3;
	import org.libspark.betweenas3.easing.Cubic;
	import org.libspark.betweenas3.easing.Exponential;
	import org.libspark.betweenas3.easing.Linear;
	import org.libspark.betweenas3.tweens.ITween;
	
	/**
	 * @author	yossy:beinteractive
	 */
	public class ApplyTest extends Sprite
	{
		public function ApplyTest()
		{
			var mc1:MovieClip = new MovieClip();
			mc1.graphics.beginFill(0);
			mc1.graphics.drawRect(-10, -10, 20, 20);
			mc1.graphics.endFill();
			addChild(mc1);
			
			var mc2:MovieClip = new MovieClip();
			mc2.graphics.beginFill(0x666666);
			mc2.graphics.drawRect(-10, -10, 20, 20);
			mc2.graphics.endFill();
			addChild(mc2);
			
			// その場で適用
			BetweenAS3.apply(mc1, {x: 100, y: 200});
			
			// 指定した時間の値 (0.5/1.0) をその場で適用
			BetweenAS3.apply(mc2, {x: 300, y: 240}, {x: 100, y: 240}, 1.0, 0.5);
		}
	}
}