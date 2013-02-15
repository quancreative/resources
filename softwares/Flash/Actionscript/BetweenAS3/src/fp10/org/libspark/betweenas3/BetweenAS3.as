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
package org.libspark.betweenas3
{
	import flash.display.DisplayObject;
	import flash.display.DisplayObjectContainer;
	import flash.geom.Point;
	import org.libspark.betweenas3.easing.IEasing;
	import org.libspark.betweenas3.easing.Linear;
	import org.libspark.betweenas3.factories.ISingleTweenTargetFactory;
	import org.libspark.betweenas3.factories.StandardSingleTweenTargetFactory;
	import org.libspark.betweenas3.registries.ClassRegistry;
	import org.libspark.betweenas3.targets.extra.AddChild;
	import org.libspark.betweenas3.targets.extra.Func;
	import org.libspark.betweenas3.targets.extra.RemoveFromParent;
	import org.libspark.betweenas3.targets.ITweenTarget;
	import org.libspark.betweenas3.targets.ParallelTweenTarget;
	import org.libspark.betweenas3.targets.RepeatedTweenTarget;
	import org.libspark.betweenas3.targets.ReversedTweenTarget;
	import org.libspark.betweenas3.targets.ScaledTweenTarget;
	import org.libspark.betweenas3.targets.SerialTweenTarget;
	import org.libspark.betweenas3.targets.single.display.DisplayObjectTweenTarget;
	import org.libspark.betweenas3.targets.single.geom.PointTweenTarget;
	import org.libspark.betweenas3.targets.single.ObjectTweenTarget;
	import org.libspark.betweenas3.targets.SlicedTweenTarget;
	import org.libspark.betweenas3.tickers.EnterFrameTicker;
	import org.libspark.betweenas3.tickers.ITicker;
	import org.libspark.betweenas3.tweens.ITween;
	import org.libspark.betweenas3.tweens.StandardTween;
	
	// 新しい ITween, ITweenTarget 実装クラスを作った場合、BetweenAS3 クラスにメソッド追加するのは無理なので、
	// HogeTween.hoge(t).play(); という形でそのクラス自体にファクトリメソッドを用意してもらう感じにする (暫定)。
	// そのとき必要になりそうなユーティリティメソッドは BetweenAS3 側で用意する。
	
	// SmartRotation は smartRotation という特殊プロパティを用意する。
	
	/**
	 * @author	yossy:beinteractive
	 */
	public class BetweenAS3
	{
		public static const VERSION:String = '0.00 (Preview)';
		
		// 超とりあえず
		
		private static var _ticker:ITicker;
		private static var _singleTweenTargetFactory:ISingleTweenTargetFactory;
		private static var _tweenTargetClassRegistry:ClassRegistry;
		
		{
			_ticker = new EnterFrameTicker();
			_ticker.start();
			_tweenTargetClassRegistry = new ClassRegistry();
			_singleTweenTargetFactory = new StandardSingleTweenTargetFactory();
			_singleTweenTargetFactory.tweenTargetClassRegistry = _tweenTargetClassRegistry;
			
			registerTweenTarget(Object, ['*'], ObjectTweenTarget);
			registerTweenTarget(DisplayObject, DisplayObjectTweenTarget.TARGET_PROPERTIES, DisplayObjectTweenTarget);
			registerTweenTarget(Point, PointTweenTarget.TARGET_PROPERTIES, PointTweenTarget);
		}
		
		public static function registerTweenTarget(targetClass:Class, properties:Array, tweenTargetClass:Class):void
		{
			var registry:ClassRegistry = _tweenTargetClassRegistry;
			var l:uint = properties.length;
			for (var i:uint = 0; i < l; ++i) {
				registry.registerClassWithTargetClassAndPropertyName(tweenTargetClass, targetClass, properties[i]);
			}
		}
		
		/**
		 * 新しいトゥイーンを作成します.
		 * 
		 * @param	target	トゥイーンの対象となるオブジェクト
		 * @param	to	トゥイーンのパラメータ (終了値)
		 * @param	from	トゥイーンのパラメータ (開始値)
		 * @return
		 */
		public static function tween(target:Object, to:Object, from:Object = null, time:Number = 1.0, easing:IEasing = null, delay:Number = 0.0):ITween
		{
			return new StandardTween(_singleTweenTargetFactory.create(target, to, from, time, easing || Linear.easeNone, delay), _ticker, 0);
		}
		
		public static function apply(target:Object, to:Object, from:Object = null, time:Number = 1.0, applyTime:Number = 1.0, easing:IEasing = null):void
		{
			_singleTweenTargetFactory.create(target, to, from, time, easing || Linear.easeNone, 0.0).update(applyTime);
		}
		
		public static function parallel(...tweens:Array):ITween
		{
			var l:uint = tweens.length;
			var targets:Vector.<ITweenTarget> = new Vector.<ITweenTarget>(l, true);
			for (var i:uint = 0; i < l; ++i) {
				targets[i] = (tweens[i] as ITween).tweenTarget;
			}
			return new StandardTween(new ParallelTweenTarget(targets), _ticker, 0);
		}
		
		public static function serial(...tweens:Array):ITween
		{
			var l:uint = tweens.length;
			var targets:Vector.<ITweenTarget> = new Vector.<ITweenTarget>(l, true);
			for (var i:uint = 0; i < l; ++i) {
				targets[i] = (tweens[i] as ITween).tweenTarget;
			}
			return new StandardTween(new SerialTweenTarget(targets), _ticker, 0);
		}
		
		public static function reverse(tween:ITween, reversePosition:Boolean = true):ITween
		{
			var target:ITweenTarget = tween.tweenTarget;
			if (target is ReversedTweenTarget) {
				target = (target as ReversedTweenTarget).baseTweenTarget;
			}
			else {
				target = new ReversedTweenTarget(target);
			}
			var p:Number = 0;
			if (reversePosition) {
				if ((p = tween.position) != 0) {
					p = tween.duration - p;
				}
			}
			return new StandardTween(target, _ticker, p);
		}
		
		public static function repeat(tween:ITween, repeatCount:uint):ITween
		{
			return new StandardTween(new RepeatedTweenTarget(tween.tweenTarget, repeatCount), _ticker, 0);
		}
		
		public static function scale(tween:ITween, scale:Number):ITween
		{
			return new StandardTween(new ScaledTweenTarget(tween.tweenTarget, scale), _ticker, 0);
		}
		
		public static function slice(tween:ITween, begin:Number, end:Number, isPercent:Boolean = false):ITween
		{
			if (isPercent) {
				begin = tween.duration * begin;
				end = tween.duration * end;
			}
			if (begin > end) {
				return new StandardTween(new ReversedTweenTarget(new SlicedTweenTarget(tween.tweenTarget, end, begin)), _ticker, 0);
			}
			return new StandardTween(new SlicedTweenTarget(tween.tweenTarget, begin, end), _ticker, 0);
		}
		
		public static function addChild(target:DisplayObject, parent:DisplayObjectContainer, delay:Number = 0.0):ITween
		{
			return new StandardTween(new AddChild(target, parent, delay), _ticker, 0);
		}
		
		public static function removeFromParent(target:DisplayObject, delay:Number = 0.0):ITween
		{
			return new StandardTween(new RemoveFromParent(target, delay), _ticker, 0);
		}
		
		public static function func(func:Function, params:Array = null, delay:Number = 0.0, useFunc2:Boolean = false, func2:Function = null, params2:Array = null):ITween
		{
			return new StandardTween(new Func(func, params, delay, useFunc2, func2, params2), _ticker, 0);
		}
	}
}