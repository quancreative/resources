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
package org.libspark.betweenas3.targets.single.display
{
	import flash.display.BitmapData;
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	import flash.filters.BevelFilter;
	import flash.filters.BitmapFilter;
	import flash.filters.BlurFilter;
	import flash.filters.ColorMatrixFilter;
	import flash.filters.ConvolutionFilter;
	import flash.filters.DisplacementMapFilter;
	import flash.filters.DropShadowFilter;
	import flash.filters.GlowFilter;
	import flash.filters.GradientBevelFilter;
	import flash.filters.GradientGlowFilter;
	import org.libspark.as3unit.assert.*;
	import org.libspark.as3unit.test;
	import org.libspark.betweenas3.easing.classes.EaseNone;
	import org.libspark.betweenas3.easing.IEasing;
	import org.libspark.betweenas3.targets.single.ISingleTweenTarget;
	
	use namespace test;
	
	/**
	 * @author	yossy:beinteractive
	 */
	public class DisplayObjectTweenTargetTest
	{
		/**
		 * 終了値のみを設定しての update
		 */
		test function updateWithDestination():void
		{
			var d:DisplayObject = new Sprite();
			d.x = 10.0;
			d.y = 20.0;
			d.z = 30.0;
			d.scaleX = 40.0;
			d.scaleY = 50.0;
			d.scaleZ = 60.0;
			d.rotationX = 70.0;
			d.rotationY = 80.0;
			d.rotationZ = 90.0;
			d.alpha = 0.5;
			
			var t:ISingleTweenTarget = new DisplayObjectTweenTarget();
			t.target = d;
			t.easing = new EaseNone();
			t.time = 4000;
			t.setDestinationValue('x', 60.0, false);
			t.setDestinationValue('y', 70.0, false);
			t.setDestinationValue('z', 80.0, false);
			t.setDestinationValue('scaleX', 90.0, false);
			t.setDestinationValue('scaleY', 100.0, false);
			t.setDestinationValue('scaleZ', 110.0, false);
			t.setDestinationValue('rotationX', 120.0, false);
			t.setDestinationValue('rotationY', 130.0, false);
			t.setDestinationValue('rotationZ', 140.0, false);
			t.setDestinationValue('alpha', 1.0, false);
			
			assertEquals(10.0, d.x);
			assertEquals(20.0, d.y);
			assertEquals(30.0, d.z);
			assertEquals(40.0, d.scaleX);
			assertEquals(50.0, d.scaleY);
			assertEquals(60.0, d.scaleZ);
			assertEquals(70.0, d.rotationX);
			assertEquals(80.0, d.rotationY);
			assertEquals(90.0, d.rotationZ);
			assertEquals(0.5, d.alpha);
			
			t.update(0);
			
			assertEquals(10.0, d.x);
			assertEquals(20.0, d.y);
			assertEquals(30.0, d.z);
			assertEquals(40.0, d.scaleX);
			assertEquals(50.0, d.scaleY);
			assertEquals(60.0, d.scaleZ);
			assertEquals(70.0, d.rotationX);
			assertEquals(80.0, d.rotationY);
			assertEquals(90.0, d.rotationZ);
			assertEquals(0.5, d.alpha);
			
			t.update(1000);
			
			assertEquals(22.5, d.x);
			assertEquals(32.5, d.y);
			assertEquals(42.5, d.z);
			assertEquals(52.5, d.scaleX);
			assertEquals(62.5, d.scaleY);
			assertEquals(72.5, d.scaleZ);
			assertEquals(82.5, d.rotationX);
			assertEquals(92.5, d.rotationY);
			assertEquals(102.5, d.rotationZ);
			assertEquals(0.625, d.alpha);
			
			t.update(2000);
			
			assertEquals(35.0, d.x);
			assertEquals(45.0, d.y);
			assertEquals(55.0, d.z);
			assertEquals(65.0, d.scaleX);
			assertEquals(75.0, d.scaleY);
			assertEquals(85.0, d.scaleZ);
			assertEquals(95.0, d.rotationX);
			assertEquals(105.0, d.rotationY);
			assertEquals(115.0, d.rotationZ);
			assertEquals(0.75, d.alpha);
			
			t.update(4000);
			
			assertEquals(60.0, d.x);
			assertEquals(70.0, d.y);
			assertEquals(80.0, d.z);
			assertEquals(90.0, d.scaleX);
			assertEquals(100.0, d.scaleY);
			assertEquals(110.0, d.scaleZ);
			assertEquals(120.0, d.rotationX);
			assertEquals(130.0, d.rotationY);
			assertEquals(140.0, d.rotationZ);
			assertEquals(1.0, d.alpha);
			
			t.update(6000);
			
			assertEquals(60.0, d.x);
			assertEquals(70.0, d.y);
			assertEquals(80.0, d.z);
			assertEquals(90.0, d.scaleX);
			assertEquals(100.0, d.scaleY);
			assertEquals(110.0, d.scaleZ);
			assertEquals(120.0, d.rotationX);
			assertEquals(130.0, d.rotationY);
			assertEquals(140.0, d.rotationZ);
			assertEquals(1.0, d.alpha);
		}
		
		/**
		 * 終了値 (相対) のみを設定しての update
		 */
		test function updateWithRelativeDestination():void
		{
			var d:DisplayObject = new Sprite();
			d.x = 10.0;
			d.y = 20.0;
			d.z = 30.0;
			d.scaleX = 40.0;
			d.scaleY = 50.0;
			d.scaleZ = 60.0;
			d.rotationX = 70.0;
			d.rotationY = 80.0;
			d.rotationZ = 90.0;
			d.alpha = 0.5;
			
			var t:ISingleTweenTarget = new DisplayObjectTweenTarget();
			t.target = d;
			t.easing = new EaseNone();
			t.time = 4000;
			t.setDestinationValue('x', 50.0, true);
			t.setDestinationValue('y', 50.0, true);
			t.setDestinationValue('z', 50.0, true);
			t.setDestinationValue('rotationX', 50.0, true);
			t.setDestinationValue('rotationY', 50.0, true);
			t.setDestinationValue('rotationZ', 50.0, true);
			t.setDestinationValue('scaleX', 50.0, true);
			t.setDestinationValue('scaleY', 50.0, true);
			t.setDestinationValue('scaleZ', 50.0, true);
			t.setDestinationValue('alpha', 0.5, true);
			
			assertEquals(10.0, d.x);
			assertEquals(20.0, d.y);
			assertEquals(30.0, d.z);
			assertEquals(40.0, d.scaleX);
			assertEquals(50.0, d.scaleY);
			assertEquals(60.0, d.scaleZ);
			assertEquals(70.0, d.rotationX);
			assertEquals(80.0, d.rotationY);
			assertEquals(90.0, d.rotationZ);
			assertEquals(0.5, d.alpha);
			
			t.update(0);
			
			assertEquals(10.0, d.x);
			assertEquals(20.0, d.y);
			assertEquals(30.0, d.z);
			assertEquals(40.0, d.scaleX);
			assertEquals(50.0, d.scaleY);
			assertEquals(60.0, d.scaleZ);
			assertEquals(70.0, d.rotationX);
			assertEquals(80.0, d.rotationY);
			assertEquals(90.0, d.rotationZ);
			assertEquals(0.5, d.alpha);
			
			t.update(1000);
			
			assertEquals(22.5, d.x);
			assertEquals(32.5, d.y);
			assertEquals(42.5, d.z);
			assertEquals(52.5, d.scaleX);
			assertEquals(62.5, d.scaleY);
			assertEquals(72.5, d.scaleZ);
			assertEquals(82.5, d.rotationX);
			assertEquals(92.5, d.rotationY);
			assertEquals(102.5, d.rotationZ);
			assertEquals(0.625, d.alpha);
			
			t.update(2000);
			
			assertEquals(35.0, d.x);
			assertEquals(45.0, d.y);
			assertEquals(55.0, d.z);
			assertEquals(65.0, d.scaleX);
			assertEquals(75.0, d.scaleY);
			assertEquals(85.0, d.scaleZ);
			assertEquals(95.0, d.rotationX);
			assertEquals(105.0, d.rotationY);
			assertEquals(115.0, d.rotationZ);
			assertEquals(0.75, d.alpha);
			
			t.update(4000);
			
			assertEquals(60.0, d.x);
			assertEquals(70.0, d.y);
			assertEquals(80.0, d.z);
			assertEquals(90.0, d.scaleX);
			assertEquals(100.0, d.scaleY);
			assertEquals(110.0, d.scaleZ);
			assertEquals(120.0, d.rotationX);
			assertEquals(130.0, d.rotationY);
			assertEquals(140.0, d.rotationZ);
			assertEquals(1.0, d.alpha);
			
			t.update(6000);
			
			assertEquals(60.0, d.x);
			assertEquals(70.0, d.y);
			assertEquals(80.0, d.z);
			assertEquals(90.0, d.scaleX);
			assertEquals(100.0, d.scaleY);
			assertEquals(110.0, d.scaleZ);
			assertEquals(120.0, d.rotationX);
			assertEquals(130.0, d.rotationY);
			assertEquals(140.0, d.rotationZ);
			assertEquals(1.0, d.alpha);
		}
		
		/**
		 * 開始値のみを設定しての update
		 */
		test function updateWithSource():void
		{
			var d:DisplayObject = new Sprite();
			d.x = 60.0;
			d.y = 70.0;
			d.z = 80.0;
			d.scaleX = 90.0;
			d.scaleY = 100.0;
			d.scaleZ = 110.0;
			d.rotationX = 120.0;
			d.rotationY = 130.0;
			d.rotationZ = 140.0;
			d.alpha = 1.0;
			
			var t:ISingleTweenTarget = new DisplayObjectTweenTarget();
			t.target = d;
			t.easing = new EaseNone();
			t.time = 4000;
			t.setSourceValue('x', 10.0, false);
			t.setSourceValue('y', 20.0, false);
			t.setSourceValue('z', 30.0, false);
			t.setSourceValue('scaleX', 40.0, false);
			t.setSourceValue('scaleY', 50.0, false);
			t.setSourceValue('scaleZ', 60.0, false);
			t.setSourceValue('rotationX', 70.0, false);
			t.setSourceValue('rotationY', 80.0, false);
			t.setSourceValue('rotationZ', 90.0, false);
			t.setSourceValue('alpha', 0.5, false);
			
			assertEquals(60.0, d.x);
			assertEquals(70.0, d.y);
			assertEquals(80.0, d.z);
			assertEquals(90.0, d.scaleX);
			assertEquals(100.0, d.scaleY);
			assertEquals(110.0, d.scaleZ);
			assertEquals(120.0, d.rotationX);
			assertEquals(130.0, d.rotationY);
			assertEquals(140.0, d.rotationZ);
			assertEquals(1.0, d.alpha);
			
			t.update(0);
			
			assertEquals(10.0, d.x);
			assertEquals(20.0, d.y);
			assertEquals(30.0, d.z);
			assertEquals(40.0, d.scaleX);
			assertEquals(50.0, d.scaleY);
			assertEquals(60.0, d.scaleZ);
			assertEquals(70.0, d.rotationX);
			assertEquals(80.0, d.rotationY);
			assertEquals(90.0, d.rotationZ);
			assertEquals(0.5, d.alpha);
			
			t.update(1000);
			
			assertEquals(22.5, d.x);
			assertEquals(32.5, d.y);
			assertEquals(42.5, d.z);
			assertEquals(52.5, d.scaleX);
			assertEquals(62.5, d.scaleY);
			assertEquals(72.5, d.scaleZ);
			assertEquals(82.5, d.rotationX);
			assertEquals(92.5, d.rotationY);
			assertEquals(102.5, d.rotationZ);
			assertEquals(0.625, d.alpha);
			
			t.update(2000);
			
			assertEquals(35.0, d.x);
			assertEquals(45.0, d.y);
			assertEquals(55.0, d.z);
			assertEquals(65.0, d.scaleX);
			assertEquals(75.0, d.scaleY);
			assertEquals(85.0, d.scaleZ);
			assertEquals(95.0, d.rotationX);
			assertEquals(105.0, d.rotationY);
			assertEquals(115.0, d.rotationZ);
			assertEquals(0.75, d.alpha);
			
			t.update(4000);
			
			assertEquals(60.0, d.x);
			assertEquals(70.0, d.y);
			assertEquals(80.0, d.z);
			assertEquals(90.0, d.scaleX);
			assertEquals(100.0, d.scaleY);
			assertEquals(110.0, d.scaleZ);
			assertEquals(120.0, d.rotationX);
			assertEquals(130.0, d.rotationY);
			assertEquals(140.0, d.rotationZ);
			assertEquals(1.0, d.alpha);
			
			t.update(6000);
			
			assertEquals(60.0, d.x);
			assertEquals(70.0, d.y);
			assertEquals(80.0, d.z);
			assertEquals(90.0, d.scaleX);
			assertEquals(100.0, d.scaleY);
			assertEquals(110.0, d.scaleZ);
			assertEquals(120.0, d.rotationX);
			assertEquals(130.0, d.rotationY);
			assertEquals(140.0, d.rotationZ);
			assertEquals(1.0, d.alpha);
		}
		
		/**
		 * 開始値のみを設定しての update
		 */
		test function updateWithRelativeSource():void
		{
			var d:DisplayObject = new Sprite();
			d.x = 60.0;
			d.y = 70.0;
			d.z = 80.0;
			d.scaleX = 90.0;
			d.scaleY = 100.0;
			d.scaleZ = 110.0;
			d.rotationX = 120.0;
			d.rotationY = 130.0;
			d.rotationZ = 140.0;
			d.alpha = 1.0;
			
			var t:ISingleTweenTarget = new DisplayObjectTweenTarget();
			t.target = d;
			t.easing = new EaseNone();
			t.time = 4000;
			t.setSourceValue('x', -50.0, true);
			t.setSourceValue('y', -50.0, true);
			t.setSourceValue('z', -50.0, true);
			t.setSourceValue('scaleX', -50.0, true);
			t.setSourceValue('scaleY', -50.0, true);
			t.setSourceValue('scaleZ', -50.0, true);
			t.setSourceValue('rotationX', -50.0, true);
			t.setSourceValue('rotationY', -50.0, true);
			t.setSourceValue('rotationZ', -50.0, true);
			t.setSourceValue('alpha', -0.5, true);
			
			assertEquals(60.0, d.x);
			assertEquals(70.0, d.y);
			assertEquals(80.0, d.z);
			assertEquals(90.0, d.scaleX);
			assertEquals(100.0, d.scaleY);
			assertEquals(110.0, d.scaleZ);
			assertEquals(120.0, d.rotationX);
			assertEquals(130.0, d.rotationY);
			assertEquals(140.0, d.rotationZ);
			assertEquals(1.0, d.alpha);
			
			t.update(0);
			
			assertEquals(10.0, d.x);
			assertEquals(20.0, d.y);
			assertEquals(30.0, d.z);
			assertEquals(40.0, d.scaleX);
			assertEquals(50.0, d.scaleY);
			assertEquals(60.0, d.scaleZ);
			assertEquals(70.0, d.rotationX);
			assertEquals(80.0, d.rotationY);
			assertEquals(90.0, d.rotationZ);
			assertEquals(0.5, d.alpha);
			
			t.update(1000);
			
			assertEquals(22.5, d.x);
			assertEquals(32.5, d.y);
			assertEquals(42.5, d.z);
			assertEquals(52.5, d.scaleX);
			assertEquals(62.5, d.scaleY);
			assertEquals(72.5, d.scaleZ);
			assertEquals(82.5, d.rotationX);
			assertEquals(92.5, d.rotationY);
			assertEquals(102.5, d.rotationZ);
			assertEquals(0.625, d.alpha);
			
			t.update(2000);
			
			assertEquals(35.0, d.x);
			assertEquals(45.0, d.y);
			assertEquals(55.0, d.z);
			assertEquals(65.0, d.scaleX);
			assertEquals(75.0, d.scaleY);
			assertEquals(85.0, d.scaleZ);
			assertEquals(95.0, d.rotationX);
			assertEquals(105.0, d.rotationY);
			assertEquals(115.0, d.rotationZ);
			assertEquals(0.75, d.alpha);
			
			t.update(4000);
			
			assertEquals(60.0, d.x);
			assertEquals(70.0, d.y);
			assertEquals(80.0, d.z);
			assertEquals(90.0, d.scaleX);
			assertEquals(100.0, d.scaleY);
			assertEquals(110.0, d.scaleZ);
			assertEquals(120.0, d.rotationX);
			assertEquals(130.0, d.rotationY);
			assertEquals(140.0, d.rotationZ);
			assertEquals(1.0, d.alpha);
			
			t.update(6000);
			
			assertEquals(60.0, d.x);
			assertEquals(70.0, d.y);
			assertEquals(80.0, d.z);
			assertEquals(90.0, d.scaleX);
			assertEquals(100.0, d.scaleY);
			assertEquals(110.0, d.scaleZ);
			assertEquals(120.0, d.rotationX);
			assertEquals(130.0, d.rotationY);
			assertEquals(140.0, d.rotationZ);
			assertEquals(1.0, d.alpha);
		}
		
		/**
		 * 開始値と終了値を設定しての update
		 */
		test function updateWithSourceAndDestination():void
		{
			var d:DisplayObject = new Sprite();
			d.x = 100.0;
			d.y = 100.0;
			d.z = 100.0;
			d.scaleX = 100.0;
			d.scaleY = 100.0;
			d.scaleZ = 100.0;
			d.rotationX = 100.0;
			d.rotationY = 100.0;
			d.rotationZ = 100.0;
			d.alpha = 0.0;
			
			var t:ISingleTweenTarget = new DisplayObjectTweenTarget();
			t.target = d;
			t.easing = new EaseNone();
			t.time = 4000;
			t.setSourceValue('x', 10.0, false);
			t.setSourceValue('y', 20.0, false);
			t.setSourceValue('z', 30.0, false);
			t.setSourceValue('scaleX', 40.0, false);
			t.setSourceValue('scaleY', 50.0, false);
			t.setSourceValue('scaleZ', 60.0, false);
			t.setSourceValue('rotationX', 70.0, false);
			t.setSourceValue('rotationY', 80.0, false);
			t.setSourceValue('rotationZ', 90.0, false);
			t.setSourceValue('alpha', 0.5, false);
			t.setDestinationValue('x', 60.0, false);
			t.setDestinationValue('y', 70.0, false);
			t.setDestinationValue('z', 80.0, false);
			t.setDestinationValue('scaleX', 90.0, false);
			t.setDestinationValue('scaleY', 100.0, false);
			t.setDestinationValue('scaleZ', 110.0, false);
			t.setDestinationValue('rotationX', 120.0, false);
			t.setDestinationValue('rotationY', 130.0, false);
			t.setDestinationValue('rotationZ', 140.0, false);
			t.setDestinationValue('alpha', 1.0, false);
			
			assertEquals(100.0, d.x);
			assertEquals(100.0, d.y);
			assertEquals(100.0, d.z);
			assertEquals(100.0, d.scaleX);
			assertEquals(100.0, d.scaleY);
			assertEquals(100.0, d.scaleZ);
			assertEquals(100.0, d.rotationX);
			assertEquals(100.0, d.rotationY);
			assertEquals(100.0, d.rotationZ);
			assertEquals(0.0, d.alpha);
			
			t.update(0);
			
			assertEquals(10.0, d.x);
			assertEquals(20.0, d.y);
			assertEquals(30.0, d.z);
			assertEquals(40.0, d.scaleX);
			assertEquals(50.0, d.scaleY);
			assertEquals(60.0, d.scaleZ);
			assertEquals(70.0, d.rotationX);
			assertEquals(80.0, d.rotationY);
			assertEquals(90.0, d.rotationZ);
			assertEquals(0.5, d.alpha);
			
			t.update(1000);
			
			assertEquals(22.5, d.x);
			assertEquals(32.5, d.y);
			assertEquals(42.5, d.z);
			assertEquals(52.5, d.scaleX);
			assertEquals(62.5, d.scaleY);
			assertEquals(72.5, d.scaleZ);
			assertEquals(82.5, d.rotationX);
			assertEquals(92.5, d.rotationY);
			assertEquals(102.5, d.rotationZ);
			assertEquals(0.625, d.alpha);
			
			t.update(2000);
			
			assertEquals(35.0, d.x);
			assertEquals(45.0, d.y);
			assertEquals(55.0, d.z);
			assertEquals(65.0, d.scaleX);
			assertEquals(75.0, d.scaleY);
			assertEquals(85.0, d.scaleZ);
			assertEquals(95.0, d.rotationX);
			assertEquals(105.0, d.rotationY);
			assertEquals(115.0, d.rotationZ);
			assertEquals(0.75, d.alpha);
			
			t.update(4000);
			
			assertEquals(60.0, d.x);
			assertEquals(70.0, d.y);
			assertEquals(80.0, d.z);
			assertEquals(90.0, d.scaleX);
			assertEquals(100.0, d.scaleY);
			assertEquals(110.0, d.scaleZ);
			assertEquals(120.0, d.rotationX);
			assertEquals(130.0, d.rotationY);
			assertEquals(140.0, d.rotationZ);
			assertEquals(1.0, d.alpha);
			
			t.update(6000);
			
			assertEquals(60.0, d.x);
			assertEquals(70.0, d.y);
			assertEquals(80.0, d.z);
			assertEquals(90.0, d.scaleX);
			assertEquals(100.0, d.scaleY);
			assertEquals(110.0, d.scaleZ);
			assertEquals(120.0, d.rotationX);
			assertEquals(130.0, d.rotationY);
			assertEquals(140.0, d.rotationZ);
			assertEquals(1.0, d.alpha);
		}
		
		/**
		 * 開始値 (相対) と終了値を設定しての update
		 */
		test function updateWithRelativeSourceAndDestination():void
		{
			var d:DisplayObject = new Sprite();
			d.x = 100.0;
			d.y = 100.0;
			d.z = 100.0;
			d.scaleX = 100.0;
			d.scaleY = 100.0;
			d.scaleZ = 100.0;
			d.rotationX = 100.0;
			d.rotationY = 100.0;
			d.rotationZ = 100.0;
			d.alpha = 1.0;
			
			var t:ISingleTweenTarget = new DisplayObjectTweenTarget();
			t.target = d;
			t.easing = new EaseNone();
			t.time = 4000;
			t.setSourceValue('x', -90.0, true);
			t.setSourceValue('y', -80.0, true);
			t.setSourceValue('z', -70.0, true);
			t.setSourceValue('scaleX', -60.0, true);
			t.setSourceValue('scaleY', -50.0, true);
			t.setSourceValue('scaleZ', -40.0, true);
			t.setSourceValue('rotationX', -30.0, true);
			t.setSourceValue('rotationY', -20.0, true);
			t.setSourceValue('rotationZ', -10.0, true);
			t.setSourceValue('alpha', -0.5, true);
			t.setDestinationValue('x', 60.0, false);
			t.setDestinationValue('y', 70.0, false);
			t.setDestinationValue('z', 80.0, false);
			t.setDestinationValue('scaleX', 90.0, false);
			t.setDestinationValue('scaleY', 100.0, false);
			t.setDestinationValue('scaleZ', 110.0, false);
			t.setDestinationValue('rotationX', 120.0, false);
			t.setDestinationValue('rotationY', 130.0, false);
			t.setDestinationValue('rotationZ', 140.0, false);
			t.setDestinationValue('alpha', 1.0, false);
			
			assertEquals(100.0, d.x);
			assertEquals(100.0, d.y);
			assertEquals(100.0, d.z);
			assertEquals(100.0, d.scaleX);
			assertEquals(100.0, d.scaleY);
			assertEquals(100.0, d.scaleZ);
			assertEquals(100.0, d.rotationX);
			assertEquals(100.0, d.rotationY);
			assertEquals(100.0, d.rotationZ);
			assertEquals(1.0, d.alpha);
			
			t.update(0);
			
			assertEquals(10.0, d.x);
			assertEquals(20.0, d.y);
			assertEquals(30.0, d.z);
			assertEquals(40.0, d.scaleX);
			assertEquals(50.0, d.scaleY);
			assertEquals(60.0, d.scaleZ);
			assertEquals(70.0, d.rotationX);
			assertEquals(80.0, d.rotationY);
			assertEquals(90.0, d.rotationZ);
			assertEquals(0.5, d.alpha);
			
			t.update(1000);
			
			assertEquals(22.5, d.x);
			assertEquals(32.5, d.y);
			assertEquals(42.5, d.z);
			assertEquals(52.5, d.scaleX);
			assertEquals(62.5, d.scaleY);
			assertEquals(72.5, d.scaleZ);
			assertEquals(82.5, d.rotationX);
			assertEquals(92.5, d.rotationY);
			assertEquals(102.5, d.rotationZ);
			assertEquals(0.625, d.alpha);
			
			t.update(2000);
			
			assertEquals(35.0, d.x);
			assertEquals(45.0, d.y);
			assertEquals(55.0, d.z);
			assertEquals(65.0, d.scaleX);
			assertEquals(75.0, d.scaleY);
			assertEquals(85.0, d.scaleZ);
			assertEquals(95.0, d.rotationX);
			assertEquals(105.0, d.rotationY);
			assertEquals(115.0, d.rotationZ);
			assertEquals(0.75, d.alpha);
			
			t.update(4000);
			
			assertEquals(60.0, d.x);
			assertEquals(70.0, d.y);
			assertEquals(80.0, d.z);
			assertEquals(90.0, d.scaleX);
			assertEquals(100.0, d.scaleY);
			assertEquals(110.0, d.scaleZ);
			assertEquals(120.0, d.rotationX);
			assertEquals(130.0, d.rotationY);
			assertEquals(140.0, d.rotationZ);
			assertEquals(1.0, d.alpha);
			
			t.update(6000);
			
			assertEquals(60.0, d.x);
			assertEquals(70.0, d.y);
			assertEquals(80.0, d.z);
			assertEquals(90.0, d.scaleX);
			assertEquals(100.0, d.scaleY);
			assertEquals(110.0, d.scaleZ);
			assertEquals(120.0, d.rotationX);
			assertEquals(130.0, d.rotationY);
			assertEquals(140.0, d.rotationZ);
			assertEquals(1.0, d.alpha);
		}
		
		/**
		 * 開始値と終了値 (相対) を設定しての update
		 */
		test function updateWithSourceAndRelativeDestination():void
		{
			var d:DisplayObject = new Sprite();
			d.x = 100.0;
			d.y = 100.0;
			d.z = 100.0;
			d.scaleX = 100.0;
			d.scaleY = 100.0;
			d.scaleZ = 100.0;
			d.rotationX = 100.0;
			d.rotationY = 100.0;
			d.rotationZ = 100.0;
			d.alpha = 1.0;
			
			var t:ISingleTweenTarget = new DisplayObjectTweenTarget();
			t.target = d;
			t.easing = new EaseNone();
			t.time = 4000;
			t.setSourceValue('x', 10.0, false);
			t.setSourceValue('y', 20.0, false);
			t.setSourceValue('z', 30.0, false);
			t.setSourceValue('scaleX', 40.0, false);
			t.setSourceValue('scaleY', 50.0, false);
			t.setSourceValue('scaleZ', 60.0, false);
			t.setSourceValue('rotationX', 70.0, false);
			t.setSourceValue('rotationY', 80.0, false);
			t.setSourceValue('rotationZ', 90.0, false);
			t.setSourceValue('alpha', 0.5, false);
			t.setDestinationValue('x', -40.0, true);
			t.setDestinationValue('y', -30.0, true);
			t.setDestinationValue('z', -20.0, true);
			t.setDestinationValue('scaleX', -10.0, true);
			t.setDestinationValue('scaleY', 0.0, true);
			t.setDestinationValue('scaleZ', 10.0, true);
			t.setDestinationValue('rotationX', 20.0, true);
			t.setDestinationValue('rotationY', 30.0, true);
			t.setDestinationValue('rotationZ', 40.0, true);
			t.setDestinationValue('alpha', 0.0, true);
			
			assertEquals(100.0, d.x);
			assertEquals(100.0, d.y);
			assertEquals(100.0, d.z);
			assertEquals(100.0, d.scaleX);
			assertEquals(100.0, d.scaleY);
			assertEquals(100.0, d.scaleZ);
			assertEquals(100.0, d.rotationX);
			assertEquals(100.0, d.rotationY);
			assertEquals(100.0, d.rotationZ);
			assertEquals(1.0, d.alpha);
			
			t.update(0);
			
			assertEquals(10.0, d.x);
			assertEquals(20.0, d.y);
			assertEquals(30.0, d.z);
			assertEquals(40.0, d.scaleX);
			assertEquals(50.0, d.scaleY);
			assertEquals(60.0, d.scaleZ);
			assertEquals(70.0, d.rotationX);
			assertEquals(80.0, d.rotationY);
			assertEquals(90.0, d.rotationZ);
			assertEquals(0.5, d.alpha);
			
			t.update(1000);
			
			assertEquals(22.5, d.x);
			assertEquals(32.5, d.y);
			assertEquals(42.5, d.z);
			assertEquals(52.5, d.scaleX);
			assertEquals(62.5, d.scaleY);
			assertEquals(72.5, d.scaleZ);
			assertEquals(82.5, d.rotationX);
			assertEquals(92.5, d.rotationY);
			assertEquals(102.5, d.rotationZ);
			assertEquals(0.625, d.alpha);
			
			t.update(2000);
			
			assertEquals(35.0, d.x);
			assertEquals(45.0, d.y);
			assertEquals(55.0, d.z);
			assertEquals(65.0, d.scaleX);
			assertEquals(75.0, d.scaleY);
			assertEquals(85.0, d.scaleZ);
			assertEquals(95.0, d.rotationX);
			assertEquals(105.0, d.rotationY);
			assertEquals(115.0, d.rotationZ);
			assertEquals(0.75, d.alpha);
			
			t.update(4000);
			
			assertEquals(60.0, d.x);
			assertEquals(70.0, d.y);
			assertEquals(80.0, d.z);
			assertEquals(90.0, d.scaleX);
			assertEquals(100.0, d.scaleY);
			assertEquals(110.0, d.scaleZ);
			assertEquals(120.0, d.rotationX);
			assertEquals(130.0, d.rotationY);
			assertEquals(140.0, d.rotationZ);
			assertEquals(1.0, d.alpha);
			
			t.update(6000);
			
			assertEquals(60.0, d.x);
			assertEquals(70.0, d.y);
			assertEquals(80.0, d.z);
			assertEquals(90.0, d.scaleX);
			assertEquals(100.0, d.scaleY);
			assertEquals(110.0, d.scaleZ);
			assertEquals(120.0, d.rotationX);
			assertEquals(130.0, d.rotationY);
			assertEquals(140.0, d.rotationZ);
			assertEquals(1.0, d.alpha);
		}
		
		/**
		 * 開始値 (相対) と終了値 (相対) を設定しての update
		 */
		test function updateWithRelativeSourceAndRelativeDestination():void
		{
			var d:DisplayObject = new Sprite();
			d.x = 100.0;
			d.y = 100.0;
			d.z = 100.0;
			d.scaleX = 100.0;
			d.scaleY = 100.0;
			d.scaleZ = 100.0;
			d.rotationX = 100.0;
			d.rotationY = 100.0;
			d.rotationZ = 100.0;
			d.alpha = 1.0;
			
			var t:ISingleTweenTarget = new DisplayObjectTweenTarget();
			t.target = d;
			t.easing = new EaseNone();
			t.time = 4000;
			t.setSourceValue('x', -90.0, true);
			t.setSourceValue('y', -80.0, true);
			t.setSourceValue('z', -70.0, true);
			t.setSourceValue('scaleX', -60.0, true);
			t.setSourceValue('scaleY', -50.0, true);
			t.setSourceValue('scaleZ', -40.0, true);
			t.setSourceValue('rotationX', -30.0, true);
			t.setSourceValue('rotationY', -20.0, true);
			t.setSourceValue('rotationZ', -10.0, true);
			t.setSourceValue('alpha', -0.5, true);
			t.setDestinationValue('x', -40.0, true);
			t.setDestinationValue('y', -30.0, true);
			t.setDestinationValue('z', -20.0, true);
			t.setDestinationValue('scaleX', -10.0, true);
			t.setDestinationValue('scaleY', 0.0, true);
			t.setDestinationValue('scaleZ', 10.0, true);
			t.setDestinationValue('rotationX', 20.0, true);
			t.setDestinationValue('rotationY', 30.0, true);
			t.setDestinationValue('rotationZ', 40.0, true);
			t.setDestinationValue('alpha', 0.0, true);
			
			assertEquals(100.0, d.x);
			assertEquals(100.0, d.y);
			assertEquals(100.0, d.z);
			assertEquals(100.0, d.scaleX);
			assertEquals(100.0, d.scaleY);
			assertEquals(100.0, d.scaleZ);
			assertEquals(100.0, d.rotationX);
			assertEquals(100.0, d.rotationY);
			assertEquals(100.0, d.rotationZ);
			assertEquals(1.0, d.alpha);
			
			t.update(0);
			
			assertEquals(10.0, d.x);
			assertEquals(20.0, d.y);
			assertEquals(30.0, d.z);
			assertEquals(40.0, d.scaleX);
			assertEquals(50.0, d.scaleY);
			assertEquals(60.0, d.scaleZ);
			assertEquals(70.0, d.rotationX);
			assertEquals(80.0, d.rotationY);
			assertEquals(90.0, d.rotationZ);
			assertEquals(0.5, d.alpha);
			
			t.update(1000);
			
			assertEquals(22.5, d.x);
			assertEquals(32.5, d.y);
			assertEquals(42.5, d.z);
			assertEquals(52.5, d.scaleX);
			assertEquals(62.5, d.scaleY);
			assertEquals(72.5, d.scaleZ);
			assertEquals(82.5, d.rotationX);
			assertEquals(92.5, d.rotationY);
			assertEquals(102.5, d.rotationZ);
			assertEquals(0.625, d.alpha);
			
			t.update(2000);
			
			assertEquals(35.0, d.x);
			assertEquals(45.0, d.y);
			assertEquals(55.0, d.z);
			assertEquals(65.0, d.scaleX);
			assertEquals(75.0, d.scaleY);
			assertEquals(85.0, d.scaleZ);
			assertEquals(95.0, d.rotationX);
			assertEquals(105.0, d.rotationY);
			assertEquals(115.0, d.rotationZ);
			assertEquals(0.75, d.alpha);
			
			t.update(4000);
			
			assertEquals(60.0, d.x);
			assertEquals(70.0, d.y);
			assertEquals(80.0, d.z);
			assertEquals(90.0, d.scaleX);
			assertEquals(100.0, d.scaleY);
			assertEquals(110.0, d.scaleZ);
			assertEquals(120.0, d.rotationX);
			assertEquals(130.0, d.rotationY);
			assertEquals(140.0, d.rotationZ);
			assertEquals(1.0, d.alpha);
			
			t.update(6000);
			
			assertEquals(60.0, d.x);
			assertEquals(70.0, d.y);
			assertEquals(80.0, d.z);
			assertEquals(90.0, d.scaleX);
			assertEquals(100.0, d.scaleY);
			assertEquals(110.0, d.scaleZ);
			assertEquals(120.0, d.rotationX);
			assertEquals(130.0, d.rotationY);
			assertEquals(140.0, d.rotationZ);
			assertEquals(1.0, d.alpha);
		}
		
		test function getFilters():void
		{
			var d:DisplayObject = new Sprite();
			
			var t:ISingleTweenTarget = new DisplayObjectTweenTarget();
			t.target = d;
			
			assertNotNull(t.getObject('_bevelFilter') as BevelFilter);
			assertNotNull(t.getObject('_blurFilter') as BlurFilter);
			assertNotNull(t.getObject('_colorMatrixFilter') as ColorMatrixFilter);
			assertNotNull(t.getObject('_convolutionFilter') as ConvolutionFilter);
			assertNotNull(t.getObject('_displacementMapFilter') as DisplacementMapFilter);
			assertNotNull(t.getObject('_dropShadowFilter') as DropShadowFilter);
			assertNotNull(t.getObject('_glowFilter') as GlowFilter);
			assertNotNull(t.getObject('_gradientBevelFilter') as GradientBevelFilter);
			assertNotNull(t.getObject('_gradientGlowFilter') as GradientGlowFilter);
			
			assertEquals(9, d.filters.length);
			
			assertNotNull(d.filters[0] as BevelFilter);
			assertNotNull(d.filters[1] as BlurFilter);
			assertNotNull(d.filters[2] as ColorMatrixFilter);
			assertNotNull(d.filters[3] as ConvolutionFilter);
			assertNotNull(d.filters[4] as DisplacementMapFilter);
			assertNotNull(d.filters[5] as DropShadowFilter);
			assertNotNull(d.filters[6] as GlowFilter);
			assertNotNull(d.filters[7] as GradientBevelFilter);
			assertNotNull(d.filters[8] as GradientGlowFilter);
		}
		
		test function getExistingFilters():void
		{
			var d:DisplayObject = new Sprite();
			var b:BitmapData = new BitmapData(1, 1, false);
			
			d.filters = [
				new BevelFilter(8),
				new BlurFilter(8),
				new ColorMatrixFilter([1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0.5, 0]),
				new ConvolutionFilter(1, 1, [2]),
				new DisplacementMapFilter(b),
				new DropShadowFilter(8),
				new GlowFilter(0xffff00),
				new GradientBevelFilter(8),
				new GradientGlowFilter(8),
			];
			
			var t:ISingleTweenTarget = new DisplayObjectTweenTarget();
			t.target = d;
			
			assertEquals(8, (t.getObject('_bevelFilter') as BevelFilter).distance);
			assertEquals(8, (t.getObject('_blurFilter') as BlurFilter).blurX);
			assertEquals(0.5, (t.getObject('_colorMatrixFilter') as ColorMatrixFilter).matrix[18]);
			assertEquals(2, (t.getObject('_convolutionFilter') as ConvolutionFilter).matrix[0]);
			assertEquals(1, (t.getObject('_displacementMapFilter') as DisplacementMapFilter).mapBitmap.width);
			assertEquals(8, (t.getObject('_dropShadowFilter') as DropShadowFilter).distance);
			assertEquals(0xffff00, (t.getObject('_glowFilter') as GlowFilter).color);
			assertEquals(8, (t.getObject('_gradientBevelFilter') as GradientBevelFilter).distance);
			assertEquals(8, (t.getObject('_gradientGlowFilter') as GradientGlowFilter).distance);
		}
		
		test function setFilters():void
		{
			var d:DisplayObject = new Sprite();
			var b:BitmapData = new BitmapData(1, 1, false);
			
			var t:ISingleTweenTarget = new DisplayObjectTweenTarget();
			t.target = d;
			
			t.setObject('_bevelFilter', new BevelFilter(16));
			t.setObject('_blurFilter', new BlurFilter(16));
			t.setObject('_colorMatrixFilter', new ColorMatrixFilter([1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0.5, 0]));
			t.setObject('_convolutionFilter', new ConvolutionFilter(1, 1, [4]));
			t.setObject('_displacementMapFilter', new DisplacementMapFilter(b));
			t.setObject('_dropShadowFilter', new DropShadowFilter(16));
			t.setObject('_glowFilter', new GlowFilter(0x0000ff));
			t.setObject('_gradientBevelFilter', new GradientBevelFilter(16));
			t.setObject('_gradientGlowFilter', new GradientGlowFilter(16));
			
			assertEquals(9, d.filters.length);
			
			assertEquals(16, (d.filters[0] as BevelFilter).distance);
			assertEquals(16, (d.filters[1] as BlurFilter).blurX);
			assertEquals(0.5, (d.filters[2] as ColorMatrixFilter).matrix[18]);
			assertEquals(4, (d.filters[3] as ConvolutionFilter).matrix[0]);
			assertEquals(1, (d.filters[4] as DisplacementMapFilter).mapBitmap.width);
			assertEquals(16, (d.filters[5] as DropShadowFilter).distance);
			assertEquals(0x0000ff, (d.filters[6] as GlowFilter).color);
			assertEquals(16, (d.filters[7] as GradientBevelFilter).distance);
			assertEquals(16, (d.filters[8] as GradientGlowFilter).distance);
		}
		
		test function overrideFilters():void
		{
			var d:DisplayObject = new Sprite();
			var b:BitmapData = new BitmapData(1, 1, false);
			var b2:BitmapData = new BitmapData(1, 1, false);
			
			d.filters = [
				new BevelFilter(8),
				new BlurFilter(8),
				new ColorMatrixFilter([1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0.3, 0]),
				new ConvolutionFilter(1, 1, [2]),
				new DisplacementMapFilter(b2),
				new DropShadowFilter(8),
				new GlowFilter(0xffff00),
				new GradientBevelFilter(8),
				new GradientGlowFilter(8),
			];
			
			var t:ISingleTweenTarget = new DisplayObjectTweenTarget();
			t.target = d;
			
			t.setObject('_bevelFilter', new BevelFilter(16));
			t.setObject('_blurFilter', new BlurFilter(16));
			t.setObject('_colorMatrixFilter', new ColorMatrixFilter([1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0.5, 0]));
			t.setObject('_convolutionFilter', new ConvolutionFilter(1, 1, [4]));
			t.setObject('_displacementMapFilter', new DisplacementMapFilter(b));
			t.setObject('_dropShadowFilter', new DropShadowFilter(16));
			t.setObject('_glowFilter', new GlowFilter(0x0000ff));
			t.setObject('_gradientBevelFilter', new GradientBevelFilter(16));
			t.setObject('_gradientGlowFilter', new GradientGlowFilter(16));
			
			assertEquals(9, d.filters.length);
			
			assertEquals(16, (d.filters[0] as BevelFilter).distance);
			assertEquals(16, (d.filters[1] as BlurFilter).blurX);
			assertEquals(0.5, (d.filters[2] as ColorMatrixFilter).matrix[18]);
			assertEquals(4, (d.filters[3] as ConvolutionFilter).matrix[0]);
			assertEquals(1, (d.filters[4] as DisplacementMapFilter).mapBitmap.width);
			assertEquals(16, (d.filters[5] as DropShadowFilter).distance);
			assertEquals(0x0000ff, (d.filters[6] as GlowFilter).color);
			assertEquals(16, (d.filters[7] as GradientBevelFilter).distance);
			assertEquals(16, (d.filters[8] as GradientGlowFilter).distance);
		}
	}
}