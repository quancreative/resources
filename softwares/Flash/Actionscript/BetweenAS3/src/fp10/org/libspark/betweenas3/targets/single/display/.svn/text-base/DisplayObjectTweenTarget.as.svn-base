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
	import flash.display.DisplayObject;
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
	import flash.filters.ShaderFilter;
	import org.libspark.betweenas3.targets.single.AbstractSingleTweenTarget;
	
	/**
	 * DisplayObject を対象とした ISignelTweenTarget の実装です.
	 * 
	 * @author	yossy:beinteractive
	 */
	public class DisplayObjectTweenTarget extends AbstractSingleTweenTarget
	{
		public static const TARGET_PROPERTIES:Array = [
			'x',
			'y',
			'z',
			'scaleX',
			'scaleY',
			'scaleZ',
			'rotation',
			'rotationX',
			'rotationY',
			'rotationZ',
			'alpha',
			'width',
			'height',
			'_bevelFilter',
			'_blurFilter',
			'_colorMatrixFilter',
			'_convolutionFilter',
			'_displacementMapFilter',
			'_dropShadowFilter',
			'_glowFilter',
			'_gradientBevelFilter',
			'_gradientGlowFilter',
			'_shaderFilter',
		];
		
		protected var _target:DisplayObject = null;
		protected var _source:DisplayObjectParameter = new DisplayObjectParameter();
		protected var _destination:DisplayObjectParameter = new DisplayObjectParameter();
		protected var _flags:uint = 0;
		
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
			_target = value as DisplayObject;
		}
		
		/**
		 * @inheritDoc
		 */
		override public function setSourceValue(propertyName:String, value:Number, isRelative:Boolean = false):void
		{
			if (propertyName == 'x') {
				if ((_flags & 0x0001) == 0) {
					_destination.x = _target.x;
					_flags |= 0x0001;
				}
				_source.x = isRelative ? _target.x + value : value;
			}
			else if (propertyName == 'y') {
				if ((_flags & 0x0002) == 0) {
					_destination.y = _target.y;
					_flags |= 0x0002;
				}
				_source.y = isRelative ? _target.y + value : value;
			}
			else if (propertyName == 'z') {
				if ((_flags & 0x0004) == 0) {
					_destination.z = _target.z;
					_flags |= 0x0004;
				}
				_source.z = isRelative ? _target.z + value : value;
			}
			else if (propertyName == 'scaleX') {
				if ((_flags & 0x0008) == 0) {
					_destination.scaleX = _target.scaleX;
					_flags |= 0x0008;
				}
				_source.scaleX = isRelative ? _target.scaleX + value : value;
			}
			else if (propertyName == 'scaleY') {
				if ((_flags & 0x0010) == 0) {
					_destination.scaleY = _target.scaleY;
					_flags |= 0x0010;
				}
				_source.scaleY = isRelative ? _target.scaleY + value : value;
			}
			else if (propertyName == 'scaleZ') {
				if ((_flags & 0x0020) == 0) {
					_destination.scaleZ = _target.scaleZ;
					_flags |= 0x0020;
				}
				_source.scaleZ = isRelative ? _target.scaleZ + value : value;
			}
			else if (propertyName == 'rotation') {
				if ((_flags & 0x0040) == 0) {
					_destination.rotation = _target.rotation;
					_flags |= 0x0040;
				}
				_source.rotation = isRelative ? _target.rotation + value : value;
			}
			else if (propertyName == 'rotationX') {
				if ((_flags & 0x0080) == 0) {
					_destination.rotationX = _target.rotationX;
					_flags |= 0x0080;
				}
				_source.rotationX = isRelative ? _target.rotationX + value : value;
			}
			else if (propertyName == 'rotationY') {
				if ((_flags & 0x0100) == 0) {
					_destination.rotationY = _target.rotationY;
					_flags |= 0x0100;
				}
				_source.rotationY = isRelative ? _target.rotationY + value : value;
			}
			else if (propertyName == 'rotationZ') {
				if ((_flags & 0x0200) == 0) {
					_destination.rotationZ = _target.rotationZ;
					_flags |= 0x0200;
				}
				_source.rotationZ = isRelative ? _target.rotationZ + value : value;
			}
			else if (propertyName == 'alpha') {
				if ((_flags & 0x0400) == 0) {
					_destination.alpha = _target.alpha;
					_flags |= 0x0400;
				}
				_source.alpha = isRelative ? _target.alpha + value : value;
			}
			else if (propertyName == 'width') {
				if ((_flags & 0x0800) == 0) {
					_destination.width = _target.width;
					_flags |= 0x0800;
				}
				_source.width = isRelative ? _target.width + value : value;
			}
			else if (propertyName == 'height') {
				if ((_flags & 0x1000) == 0) {
					_destination.height = _target.height;
					_flags |= 0x1000;
				}
				_source.height = isRelative ? _target.height + value : value;
			}
		}
		
		/**
		 * @inheritDoc
		 */
		override public function setDestinationValue(propertyName:String, value:Number, isRelative:Boolean = false):void
		{
			if (propertyName == 'x') {
				if ((_flags & 0x0001) == 0) {
					_source.x = _target.x;
					_flags |= 0x0001;
				}
				_destination.x = isRelative ? _target.x + value : value;
			}
			else if (propertyName == 'y') {
				if ((_flags & 0x0002) == 0) {
					_source.y = _target.y;
					_flags |= 0x0002;
				}
				_destination.y = isRelative ? _target.y + value : value;
			}
			else if (propertyName == 'z') {
				if ((_flags & 0x0004) == 0) {
					_source.z = _target.z;
					_flags |= 0x0004;
				}
				_destination.z = isRelative ? _target.z + value : value;
			}
			else if (propertyName == 'scaleX') {
				if ((_flags & 0x0008) == 0) {
					_source.scaleX = _target.scaleX;
					_flags |= 0x0008;
				}
				_destination.scaleX = isRelative ? _target.scaleX + value : value;
			}
			else if (propertyName == 'scaleY') {
				if ((_flags & 0x0010) == 0) {
					_source.scaleY = _target.scaleY;
					_flags |= 0x0010;
				}
				_destination.scaleY = isRelative ? _target.scaleY + value : value;
			}
			else if (propertyName == 'scaleZ') {
				if ((_flags & 0x0020) == 0) {
					_source.scaleZ = _target.scaleZ;
					_flags |= 0x0020;
				}
				_destination.scaleZ = isRelative ? _target.scaleZ + value : value;
			}
			else if (propertyName == 'rotation') {
				if ((_flags & 0x0040) == 0) {
					_source.rotation = _target.rotation;
					_flags |= 0x0040;
				}
				_destination.rotation = isRelative ? _target.rotation + value : value;
			}
			else if (propertyName == 'rotationX') {
				if ((_flags & 0x0080) == 0) {
					_source.rotationX = _target.rotationX;
					_flags |= 0x0080;
				}
				_destination.rotationX = isRelative ? _target.rotationX + value : value;
			}
			else if (propertyName == 'rotationY') {
				if ((_flags & 0x0100) == 0) {
					_source.rotationY = _target.rotationY;
					_flags |= 0x0100;
				}
				_destination.rotationY = isRelative ? _target.rotationY + value : value;
			}
			else if (propertyName == 'rotationZ') {
				if ((_flags & 0x0200) == 0) {
					_source.rotationZ = _target.rotationZ;
					_flags |= 0x0200;
				}
				_destination.rotationZ = isRelative ? _target.rotationZ + value : value;
			}
			else if (propertyName == 'alpha') {
				if ((_flags & 0x0400) == 0) {
					_source.alpha = _target.alpha;
					_flags |= 0x0400;
				}
				_destination.alpha = isRelative ? _target.alpha + value : value;
			}
			else if (propertyName == 'width') {
				if ((_flags & 0x0800) == 0) {
					_source.width = _target.width;
					_flags |= 0x0800;
				}
				_destination.width = isRelative ? _target.width + value : value;
			}
			else if (propertyName == 'height') {
				if ((_flags & 0x1000) == 0) {
					_source.height = _target.height;
					_flags |= 0x1000;
				}
				_destination.height = isRelative ? _target.height + value : value;
			}
		}
		
		/**
		 * @inheritDoc
		 */
		override public function getObject(propertyName:String):Object
		{
			if (propertyName == '_blurFilter') {
				return getFilterByClass(BlurFilter);
			}
			if (propertyName == '_glowFilter') {
				return getFilterByClass(GlowFilter);
			}
			if (propertyName == '_dropShadowFilter') {
				return getFilterByClass(DropShadowFilter);
			}
			if (propertyName == '_colorMatrixFilter') {
				return getFilterByClass(ColorMatrixFilter);
			}
			if (propertyName == '_bevelFilter') {
				return getFilterByClass(BevelFilter);
			}
			if (propertyName == '_gradientGlowFilter') {
				return getFilterByClass(GradientGlowFilter);
			}
			if (propertyName == '_gradientBevelFilter') {
				return getFilterByClass(GradientBevelFilter);
			}
			if (propertyName == '_convolutionFilter') {
				return getFilterByClass(ConvolutionFilter);
			}
			if (propertyName == '_displacementMapFilter') {
				return getFilterByClass(DisplacementMapFilter);
			}
			if (propertyName == '_shaderFilter') {
				return getFilterByClass(ShaderFilter);
			}
			return null;
		}
		
		protected function getFilterByClass(klass:Class):BitmapFilter
		{
			var filter:BitmapFilter = null;
			var filters:Array = _target.filters;
			var l:uint = filters.length;
			for (var i:uint = 0; i < l; ++i) {
				if ((filter = filters[i] as BitmapFilter) is klass) {
					return filter;
				}
			}
			filter = new klass();
			filters.push(filter);
			_target.filters = filters;
			return filter;
		}
		
		/**
		 * @inheritDoc
		 */
		override public function setObject(propertyName:String, value:Object):void
		{
			if (propertyName == '_blurFilter') {
				setFilterByClass(value as BitmapFilter, BlurFilter);
				return;
			}
			if (propertyName == '_glowFilter') {
				setFilterByClass(value as BitmapFilter, GlowFilter);
				return;
			}
			if (propertyName == '_dropShadowFilter') {
				setFilterByClass(value as BitmapFilter, DropShadowFilter);
				return;
			}
			if (propertyName == '_colorMatrixFilter') {
				setFilterByClass(value as BitmapFilter, ColorMatrixFilter);
				return;
			}
			if (propertyName == '_bevelFilter') {
				setFilterByClass(value as BitmapFilter, BevelFilter);
				return;
			}
			if (propertyName == '_gradientGlowFilter') {
				setFilterByClass(value as BitmapFilter, GradientGlowFilter);
				return;
			}
			if (propertyName == '_gradientBevelFilter') {
				setFilterByClass(value as BitmapFilter, GradientBevelFilter);
				return;
			}
			if (propertyName == '_convolutionFilter') {
				setFilterByClass(value as BitmapFilter, ConvolutionFilter);
				return;
			}
			if (propertyName == '_displacementMapFilter') {
				setFilterByClass(value as BitmapFilter, DisplacementMapFilter);
				return;
			}
			if (propertyName == '_shaderFilter') {
				setFilterByClass(value as BitmapFilter, ShaderFilter);
				return;
			}
		}
		
		protected function setFilterByClass(filter:BitmapFilter, klass:Class):void
		{
			var filters:Array = _target.filters;
			var l:uint = filters.length;
			for (var i:uint = 0; i < l; ++i) {
				if (filters[i] is klass) {
					filters[i] = filter;
					_target.filters = filters;
					return;
				}
			}
			filters.push(filter);
			_target.filters = filters;
		}
		
		/**
		 * @inheritDoc
		 */
		override public function update(time:Number):void
		{
			var factor:Number = 0, t:DisplayObject = _target, d:DisplayObjectParameter = _destination, s:DisplayObjectParameter = _source, f:uint = _flags;
			
			if (time >= _delay) {
				if ((time -= _delay) < _time) {
					factor = _easing.calculate(time, 0.0, 1.0, _time);
				}
				else {
					factor = 1.0;
				}
			}
			
			var invert:Number = 1.0 - factor;
			
			if ((f & 0x0001) != 0) {
				t.x = s.x * invert + d.x * factor;
			}
			if ((f & 0x0002) != 0) {
				t.y = s.y * invert + d.y * factor;
			}
			if ((f & 0x0004) != 0) {
				t.z = s.z * invert + d.z * factor;
			}
			if ((f & 0x0038) != 0) {
				if ((f & 0x0008) != 0) {
					t.scaleX = s.scaleX * invert + d.scaleX * factor;
				}
				if ((f & 0x0010) != 0) {
					t.scaleY = s.scaleY * invert + d.scaleY * factor;
				}
				if ((f & 0x0020) != 0) {
					t.scaleZ = s.scaleZ * invert + d.scaleZ * factor;
				}
			}
			if ((f & 0x03c0) != 0) {
				if ((f & 0x0040) != 0) {
					t.rotation = s.rotation * invert + d.rotation * factor;
				}
				if ((f & 0x0080) != 0) {
					t.rotationX = s.rotationX * invert + d.rotationX * factor;
				}
				if ((f & 0x0100) != 0) {
					t.rotationY = s.rotationY * invert + d.rotationY * factor;
				}
				if ((f & 0x0200) != 0) {
					t.rotationZ = s.rotationZ * invert + d.rotationZ * factor;
				}
			}
			if ((f & 0x1c00) != 0) {
				if ((f & 0x0400) != 0) {
					t.alpha = s.alpha * invert + d.alpha * factor;
				}
				if ((f & 0x0800) != 0) {
					t.width = s.width * invert + d.width * factor;
				}
				if ((f & 0x1000) != 0) {
					t.height = s.height * invert + d.height * factor;
				}
			}
		}
	}
}

internal class DisplayObjectParameter
{
	public var x:Number;
	public var y:Number;
	public var z:Number;
	public var scaleX:Number;
	public var scaleY:Number;
	public var scaleZ:Number;
	public var rotation:Number;
	public var rotationX:Number;
	public var rotationY:Number;
	public var rotationZ:Number;
	public var alpha:Number;
	public var width:Number;
	public var height:Number;
}