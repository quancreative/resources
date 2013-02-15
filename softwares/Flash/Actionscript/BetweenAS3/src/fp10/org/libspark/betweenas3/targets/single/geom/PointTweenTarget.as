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
package org.libspark.betweenas3.targets.single.geom
{
	import flash.geom.Point;
	import org.libspark.betweenas3.targets.single.AbstractSingleTweenTarget;
	
	/**
	 * Point を対象とした ISignelTweenTarget の実装です.
	 * 
	 * @author	yossy:beinteractive
	 */
	public class PointTweenTarget extends AbstractSingleTweenTarget
	{
		public static const TARGET_PROPERTIES:Array = [
			'x',
			'y',
		];
		
		protected var _target:Point = null;
		protected var _fx:Boolean = false;
		protected var _sx:Number;
		protected var _dx:Number;
		protected var _fy:Boolean = false;
		protected var _sy:Number;
		protected var _dy:Number;
		
		/**
		 * @inheritDoc
		 */
		override public function get target():Object
		{
			return _target;
		}
		
		/**
		 * @private
		 */
		override public function set target(value:Object):void
		{
			_target = value as Point;
		}
		
		/**
		 * @inheritDoc
		 */
		override public function setSourceValue(propertyName:String, value:Number, isRelative:Boolean = false):void
		{
			if (propertyName == 'x') {
				if (!_fx) {
					_dx = _target.x;
					_fx = true;
				}
				_sx = isRelative ? _target.x + value : value;
			}
			else if (propertyName == 'y') {
				if (!_fy) {
					_dy = _target.y;
					_fy = true;
				}
				_sy = isRelative ? _target.y + value : value;
			}
		}
		
		/**
		 * @inheritDoc
		 */
		override public function setDestinationValue(propertyName:String, value:Number, isRelative:Boolean = false):void
		{
			if (propertyName == 'x') {
				if (!_fx) {
					_sx = _target.x;
					_fx = true;
				}
				_dx = isRelative ? _target.x + value : value;
			}
			else if (propertyName == 'y') {
				if (!_fy) {
					_sy = _target.y;
					_fy = true;
				}
				_dy = isRelative ? _target.y + value : value;
			}
		}
		
		/**
		 * @inheritDoc
		 */
		override public function update(time:Number):void
		{
			var factor:Number = 0, t:Point = _target;
			
			if (time >= _delay) {
				if ((time -= _delay) < _time) {
					factor = _easing.calculate(time, 0.0, 1.0, _time);
				}
				else {
					factor = 1.0;
				}
			}
			
			var invert:Number = 1.0 - factor;
			
			if (_fx) {
				t.x = _sx * invert + _dx * factor;
			}
			if (_fy) {
				t.y = _sy * invert + _dy * factor;
			}
		}
	}
}