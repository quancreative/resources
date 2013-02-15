﻿/**	slider which moves along a bar.	- returns a value based on how far the slider is from the center of the bar	- will snap back to center when released from the mouse			required stage instances:		 	slider			:GlowButton			bg				:MovieClip*/package pdh.ui{	import flash.display.MovieClip;		import flash.events.MouseEvent;	import flash.events.TimerEvent;	import flash.utils.Timer;	import flash.events.Event;		import pdh.events.RotateSliderEvent;			public class RotateSlider extends MovieClip{				public var slider			:MovieClip;		public var bg				:MovieClip;		private var track_width			:Number		private var timer			:Timer;		private var sliderOffset	:Number;				public function RotateSlider()		{					addListeners();				init();		}				private function init():void 		{			trace("init RotateSlider");						slider.x = bg.width / 2;						track_width = bg.width / 2									timer = new Timer(10); 					timer.addEventListener(TimerEvent.TIMER, resetSlider,false,0,true)		}						public function setSize(w:Number, h:Number):void 		{					}								public function addListeners():void		{			slider.addEventListener(MouseEvent.MOUSE_DOWN, handleSliderEvent,false,0,true)						slider.addEventListener(MouseEvent.ROLL_OVER, handleSliderEvent,false,0,true)					}				private function handleMouseMove(evt:MouseEvent):void 		{						moveSlider(mouseX - sliderOffset, true);							}				private function moveSlider(val:Number, dispatch:Boolean = false):void 		{			slider.x = val;						if (slider.right > bg.width){				slider.right = bg.width;			} else if (slider.left < bg.x){				slider.left = bg.x;			} 						if (dispatch){				dispatchEvent(new RotateSliderEvent(RotateSliderEvent.START_SLIDE, calculateSpeed()));			}		}				private function calculateSpeed():Number		{						var mpos:Number = slider.x - track_width;					var t = (mpos / track_width)			return (t / (track_width - slider.width/2)) * 200;		}				private function handleSliderEvent(evt:MouseEvent):void 		{			//trace("slider event " + evt.type);						switch (evt.type) {				case Event.MOUSE_LEAVE:					trace("mouse leave");				    disableDrag();					break;				case MouseEvent.MOUSE_DOWN:								trace("mouse down slider");					enableDrag();					break ;					case MouseEvent.MOUSE_UP:									trace("mouse off slider");					disableDrag();					break ;					case MouseEvent.ROLL_OVER:											break ;									default:					break;			}									}						private function enableDrag():void 		{			sliderOffset = slider.mouseX;				timer.stop();			handleMouseMove(new MouseEvent("blank"));			stage.addEventListener(MouseEvent.MOUSE_UP, handleSliderEvent,false,0,true)			stage.addEventListener(MouseEvent.MOUSE_MOVE,handleMouseMove,false,0,true)				stage.addEventListener(Event.MOUSE_LEAVE, handleSliderEvent ,false,0,true)		}				private function disableDrag():void 		{			stage.removeEventListener(MouseEvent.MOUSE_UP, handleSliderEvent);			stage.removeEventListener(MouseEvent.MOUSE_MOVE,handleMouseMove)					stage.removeEventListener(Event.MOUSE_LEAVE, handleSliderEvent );						timer.start();							}					private function resetSlider(e:TimerEvent):void {			var amount;			var speed = 6;			var track_width = bg.width / 2;			if (slider.x > track_width){				amount = -speed;			} else {				amount = speed;			}						if (slider.x > track_width - 10 && slider.x < track_width + 10){				timer.stop();				dispatchEvent(new RotateSliderEvent(RotateSliderEvent.STOP_SLIDE, 0));								} else {							moveSlider(slider.x + amount, true);			}		}					} // end class} // end package