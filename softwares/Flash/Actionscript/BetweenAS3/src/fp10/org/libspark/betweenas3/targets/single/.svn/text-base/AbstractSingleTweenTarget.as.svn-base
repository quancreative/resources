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
	import org.libspark.betweenas3.easing.IEasing;
	
	/**
	 * ISingleTweenTarget を実装するための抽象クラスです.
	 * 
	 * @author	yossy:beinteractive
	 */
	public class AbstractSingleTweenTarget implements ISingleTweenTarget
	{
		protected var _time:Number = 0;
		protected var _delay:Number = 0;
		protected var _easing:IEasing = null;
		
		/**
		 * このトゥイーンターゲットが完了するまでにかかる時間 (秒) を返します.
		 */
		public function get duration():Number
		{
			return _time + _delay;
		}
		
		/**
		 * このトゥイーンに掛ける時間 (秒) を設定します.
		 */
		public function get time():Number
		{
			return _time;
		}
		
		/**
		 * @private
		 */
		public function set time(value:Number):void
		{
			_time = value;
		}
		
		/**
		 * このトゥイーンが開始されるまでに掛ける時間 (秒) を設定します.
		 */
		public function get delay():Number
		{
			return _delay;
		}
		
		/**
		 * @private
		 */
		public function set delay(value:Number):void
		{
			_delay = value;
		}
		
		/**
		 * このトゥイーンで使用するイージングを設定します.
		 */
		public function get easing():IEasing
		{
			return _easing;
		}
		
		/**
		 * @private
		 */
		public function set easing(value:IEasing):void
		{
			_easing = value;
		}
		
		/**
		 * このトゥイーンの対象となるオブジェクトを設定します.
		 */
		public function get target():Object
		{
			return null;
		}
		
		/**
		 * @private
		 */
		public function set target(value:Object):void
		{
			
		}
		
		/**
		 * 指定されたプロパティに対するトゥイーンの開始値を設定します.
		 * 
		 * @param	propertyName	設定するプロパティの名前
		 * @param	value	設定する値
		 * @param	isRelative	相対値であれば true, そうでなければ false
		 */
		public function setSourceValue(propertyName:String, value:Number, isRelative:Boolean = false):void
		{
			
		}
		
		/**
		 * 指定されたプロパティに対するトゥイーンの終了値を設定します.
		 * 
		 * @param	propertyName	設定するプロパティ名
		 * @param	value	設定する値
		 * @param	isRelative	相対値であれば true, そうでなければ false
		 */
		public function setDestinationValue(propertyName:String, value:Number, isRelative:Boolean = false):void
		{
			
		}
		
		/**
		 * 指定されたプロパティのオブジェクトを取得します.
		 * 
		 * @param	propertyName	取得するプロパティ名
		 * @return	対応するオブジェクト
		 */
		public function getObject(propertyName:String):Object
		{
			return null;
		}
		
		/**
		 * 指定されたプロパティにオブジェクトを代入します.
		 * 
		 * @param	propertyName	設定するプロパティ名
		 * @param	value	設定するオブジェクト
		 */
		public function setObject(propertyName:String, value:Object):void
		{
			
		}
		
		/**
		 * このトゥイーンターゲットを指定された時間の状態に更新します.
		 * 
		 * @param	time	時間 (秒)
		 */
		public function update(time:Number):void
		{
			
		}
	}
}