﻿/**	required movieclips:		drag_mc	track_mc*/package pdh.ui{	import flash.display.*;	import flash.events.MouseEvent;	import flash.events.Event;	import pdh.events.ScrollBarEvent;	import pdh.events.SeekBarEvent;		import gs.TweenLite;	import gs.easing.*		import flash.utils.Timer;	import flash.events.TimerEvent;		import pdh.ui.SimpleScrollBar;		public class SeekBar extends SimpleScrollBar	{		private var lastValue		:Number;		public var progress_mc		:MovieClip;		private var timer			:Timer;		private var timeOut			:Boolean = true;				public function SeekBar()		{			super(true)			init();		}				private function init():void		{			this.visible = true;			this.addEventListener(ScrollBarEvent.UPDATE, handleScroll, false, 0, true);						timer = new Timer(300, 1);			timer.addEventListener(TimerEvent.TIMER_COMPLETE, handleTimer, false, 0, true);					}				public function setProgress(val:Number):void 		{			progress_mc.width = track_mc.width * val;		}				public function disableClickTween():void 		{			tweenEnabled = false		}				public override function setValue(val:Number):void 		{						if (dragging) return;						super.setValue(val);					}				private function handleScroll(e:ScrollBarEvent):void 		{			if (dragging){				if (lastValue == e.scroll_value) return;				lastValue = e.scroll_value;												//sendEvent();				//timeOut = false				timer.start();																}		}				private function handleTimer(e:TimerEvent):void 		{			//timeOut = true;			sendEvent();		}				private function sendEvent():void 		{			//if (timeOut){				dispatchEvent( new SeekBarEvent( SeekBarEvent.UPDATE, {value:lastValue} ) );					//}		}				public override function destroy():void 		{			this.removeEventListener(ScrollBarEvent.UPDATE, handleScroll);			timer.removeEventListener(TimerEvent.TIMER_COMPLETE, handleTimer);			timer.stop();			timer = null;		}					}}