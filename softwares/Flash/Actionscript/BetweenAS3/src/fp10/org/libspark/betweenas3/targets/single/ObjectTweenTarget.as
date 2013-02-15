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
package org.libspark.betweenas3.targets.single
{
	/**
	 * 全てのオブジェクトを対象とした ISignelTweenTarget の実装です.
	 * 
	 * @author	yossy:beinteractive
	 */
	public class ObjectTweenTarget extends AbstractSingleTweenTarget
	{
		protected var _target:Object = null;
		protected var _source:Object = new Object();
		protected var _destination:Object = new Object();
		
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
			_target = value;
		}
		
		/**
		 * @inheritDoc
		 */
		override public function setSourceValue(propertyName:String, value:Number, isRelative:Boolean = false):void
		{
			if (!(propertyName in _destination)) {
				_destination[propertyName] = _target[propertyName];
			}
			if (isRelative) {
				_source[propertyName] = _target[propertyName] + value;
			}
			else {
				_source[propertyName] = value;
			}
		}
		
		/**
		 * @inheritDoc
		 */
		override public function setDestinationValue(propertyName:String, value:Number, isRelative:Boolean = false):void
		{
			if (!(propertyName in _source)) {
				_source[propertyName] = _target[propertyName];
			}
			if (isRelative) {
				_destination[propertyName] = _target[propertyName] + value;
			}
			else {
				_destination[propertyName] = value;
			}
		}
		
		/**
		 * @inheritDoc
		 */
		override public function getObject(propertyName:String):Object
		{
			return _target[propertyName];
		}
		
		/**
		 * @inheritDoc
		 */
		override public function setObject(propertyName:String, value:Object):void
		{
			_target[propertyName] = value;
		}
		
		/**
		 * @inheritDoc
		 */
		override public function update(time:Number):void
		{
			if (time < _delay) {
				time = 0;
			}
			else {
				time -= _delay;
			}
			
			var factor:Number = _easing.calculate(time < _time ? time : _time, 0.0, 1.0, _time);
			var invert:Number = 1.0 - factor;
			var t:Object = _target;
			var d:Object = _destination;
			var s:Object = _source;
			var name:String;
			
			for (name in d) {
				t[name] = s[name] * invert + d[name] * factor;
			}
		}
	}
}