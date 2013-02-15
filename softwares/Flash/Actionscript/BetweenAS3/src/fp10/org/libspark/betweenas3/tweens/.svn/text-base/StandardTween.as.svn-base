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
package org.libspark.betweenas3.tweens
{
	import flash.events.EventDispatcher;
	import flash.events.IEventDispatcher;
	import flash.events.Event;
	import org.libspark.betweenas3.events.BetweenEvent;
	import org.libspark.betweenas3.targets.ITweenTarget;
	import org.libspark.betweenas3.tickers.ITicker;
	import org.libspark.betweenas3.tickers.TickerListener;
	
	/**
	 * .
	 * 
	 * @author	yossy:beinteractive
	 */
	public class StandardTween extends TickerListener implements ITween
	{
		public function StandardTween(tweenTarget:ITweenTarget, ticker:ITicker, position:Number)
		{
			_tweenTarget = tweenTarget;
			_ticker = ticker;
			_position = position;
			_duration = tweenTarget.duration;
		}
		
		private var _tweenTarget:ITweenTarget;
		private var _ticker:ITicker;
		private var _position:Number;
		private var _duration:Number;
		private var _startTime:Number;
		private var _isPlaying:Boolean = false;
		private var _stopOnComplete:Boolean = true;
		private var _dispatcher:IEventDispatcher;
		private var _willTriggerFlags:uint = 0;
		private var _onPlay:Function;
		private var _onPlayParams:Array;
		private var _onStop:Function;
		private var _onStopParams:Array;
		private var _onUpdate:Function;
		private var _onUpdateParams:Array;
		private var _onComplete:Function;
		private var _onCompleteParams:Array;
		
		/**
		 * @inheritDoc
		 */
		public function get tweenTarget():ITweenTarget
		{
			return _tweenTarget;
		}
		
		/**
		 * このトゥイーンの継続時間 (秒) を返します.
		 */
		public function get duration():Number
		{
			return _duration;
		}
		
		/**
		 * このトゥイーンの現在位置 (秒) を返します.
		 */
		public function get position():Number
		{
			return _position;
		}
		
		/**
		 * このトゥイーンが現在再生中であれば true, そうでなければ false を返します.
		 */
		public function get isPlaying():Boolean
		{
			return _isPlaying;
		}
		
		/**
		 * @inheritDoc
		 */
		public function get stopOnComplete():Boolean
		{
			return _stopOnComplete;
		}
		
		/**
		 * @private
		 */
		public function set stopOnComplete(value:Boolean):void
		{
			_stopOnComplete = value;
		}
		
		public function get onPlay():Function
		{
			return _onPlay;
		}
		
		public function set onPlay(value:Function):void
		{
			_onPlay = value;
		}
		
		public function get onPlayParams():Array
		{
			return _onPlayParams;
		}
		
		public function set onPlayParams(value:Array):void
		{
			_onPlayParams = value;
		}
		
		public function get onStop():Function
		{
			return _onStop;
		}
		
		public function set onStop(value:Function):void
		{
			_onStop = value;
		}
		
		public function get onStopParams():Array
		{
			return _onStopParams;
		}
		
		public function set onStopParams(value:Array):void
		{
			_onStopParams = value;
		}
		
		public function get onUpdate():Function
		{
			return _onUpdate;
		}
		
		public function set onUpdate(value:Function):void
		{
			_onUpdate = value;
		}
		
		public function get onUpdateParams():Array
		{
			return _onUpdateParams;
		}
		
		public function set onUpdateParams(value:Array):void
		{
			_onUpdateParams = value;
		}
		
		public function get onComplete():Function
		{
			return _onComplete;
		}
		
		public function set onComplete(value:Function):void
		{
			_onComplete = value;
		}
		
		public function get onCompleteParams():Array
		{
			return _onCompleteParams;
		}
		
		public function set onCompleteParams(value:Array):void
		{
			_onCompleteParams = value;
		}
		
		/**
		 * このトゥイーンの再生を現在の位置から開始します.
		 */
		public function play():void
		{
			if (!_isPlaying && _position < _tweenTarget.duration) {
				var t:Number = _ticker.time;
				_startTime = t - _position;
				_isPlaying = true;
				_ticker.addTickerListener(this);
				if ((_willTriggerFlags & 0x01) != 0) {
					_dispatcher.dispatchEvent(new BetweenEvent(BetweenEvent.PLAY));
				}
				if (_onPlay != null) {
					_onPlay.apply(null, _onPlayParams);
				}
				tick(t);
			}
		}
		
		/**
		 * このトゥイーンの再生を現在の位置で停止します.
		 */
		public function stop():void
		{
			if (_isPlaying) {
				_isPlaying = false;
				_ticker.removeTickerListener(this);
				if ((_willTriggerFlags & 0x02) != 0) {
					_dispatcher.dispatchEvent(new BetweenEvent(BetweenEvent.STOP));
				}
				if (_onStop != null) {
					_onStop.apply(null, _onStopParams);
				}
			}
		}
		
		/**
		 * このトゥイーンの再生を指定された位置から開始します.
		 * 
		 * @param	position	再生を開始する位置 (秒)
		 */
		public function gotoAndPlay(position:Number):void
		{
			_position = position;
			play();
		}
		
		/**
		 * このトゥイーンの再生を指定された位置で停止します.
		 * 
		 * @param	position	再生を停止する位置 (秒)
		 */
		public function gotoAndStop(position:Number):void
		{
			_position = position;
			_tweenTarget.update(position);
			if ((_willTriggerFlags & 0x04) != 0) {
				_dispatcher.dispatchEvent(new BetweenEvent(BetweenEvent.UPDATE));
			}
			if (_onUpdate != null) {
				_onUpdate.apply(null, _onUpdateParams);
			}
			stop();
		}
		
		override public function tick(time:Number):Boolean
		{
			var t:Number = time - _startTime;
			
			_position = t;
			_tweenTarget.update(t);
			
			if ((_willTriggerFlags & 0x04) != 0) {
				_dispatcher.dispatchEvent(new BetweenEvent(BetweenEvent.UPDATE));
			}
			if (_onUpdate != null) {
				_onUpdate.apply(null, _onUpdateParams);
			}
			
			if (t >= _duration) {
				_position = _tweenTarget.duration;
				if (_stopOnComplete) {
					_isPlaying = false;
					if ((_willTriggerFlags & 0x08) != 0) {
						_dispatcher.dispatchEvent(new BetweenEvent(BetweenEvent.COMPLETE));
					}
					if (_onComplete != null) {
						_onComplete.apply(null, _onCompleteParams);
					}
					return true;
				}
				else {
					if ((_willTriggerFlags & 0x08) != 0) {
						_dispatcher.dispatchEvent(new BetweenEvent(BetweenEvent.COMPLETE));
					}
					if (_onComplete != null) {
						_onComplete.apply(null, _onCompleteParams);
					}
					_position = t - _duration;
					_startTime = time - _position;
					tick(time);
				}
			}
			
			return false;
		}
		
		/**
		 * @inheritDoc
		 */
		public function addEventListener(type:String, listener:Function, useCapture:Boolean = false, priority:int = 0, useWeakReference:Boolean = false):void
		{
			if (_dispatcher == null) {
				_dispatcher = new EventDispatcher(this);
			}
			_dispatcher.addEventListener(type, listener, useCapture, priority, useWeakReference);
			updateWillTriggerFlags();
		}
		
		/**
		 * @inheritDoc
		 */
		public function dispatchEvent(event:Event):Boolean
		{
			if (_dispatcher != null) {
				return _dispatcher.dispatchEvent(event);
			}
			return false;
		}
		
		/**
		 * @inheritDoc
		 */
		public function hasEventListener(type:String):Boolean
		{
			if (_dispatcher != null) {
				return _dispatcher.hasEventListener(type);
			}
			return false;
		}
		
		/**
		 * @inheritDoc
		 */
		public function removeEventListener(type:String, listener:Function, useCapture:Boolean = false):void
		{
			if (_dispatcher != null) {
				_dispatcher.removeEventListener(type, listener, useCapture);
				updateWillTriggerFlags();
			}
		}
		
		/**
		 * @inheritDoc
		 */
		public function willTrigger(type:String):Boolean
		{
			if (_dispatcher != null) {
				return _dispatcher.willTrigger(type);
			}
			return false;
		}
		
		private function updateWillTriggerFlags():void
		{
			if (_dispatcher.willTrigger(BetweenEvent.PLAY)) {
				_willTriggerFlags |= 0x01;
			}
			else {
				_willTriggerFlags &= ~0x01;
			}
			if (_dispatcher.willTrigger(BetweenEvent.STOP)) {
				_willTriggerFlags |= 0x02;
			}
			else {
				_willTriggerFlags &= ~0x02;
			}
			if (_dispatcher.willTrigger(BetweenEvent.UPDATE)) {
				_willTriggerFlags |= 0x04;
			}
			else {
				_willTriggerFlags &= ~0x04;
			}
			if (_dispatcher.willTrigger(BetweenEvent.COMPLETE)) {
				_willTriggerFlags |= 0x08;
			}
			else {
				_willTriggerFlags &= ~0x08;
			}
		}
	}
}