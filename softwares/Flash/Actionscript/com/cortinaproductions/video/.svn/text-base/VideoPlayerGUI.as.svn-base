package com.cortinaproductions.video
{	
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.geom.Rectangle;
	import flash.utils.getDefinitionByName;

	public class VideoPlayerGUI extends MovieClip
	{
		public var _clip:MovieClip;
		public var _slider:MovieClip;
		public var _bufferbar:MovieClip;
		public var _progbar:MovieClip;
		public var _playpause:MovieClip;
		private var _isPlaying:Boolean;
		private var _videoObj:VideoPlayer;
		private var _sliderbounds:Rectangle;
		private var _dragging:Boolean;
		private var _videoEnd:Boolean;
		
		public function VideoPlayerGUI(vidobj:VideoPlayer, externalAsset:String = "")
		{
			
			var newGraphic : Class;
			if (externalAsset == "" ) externalAsset = "VideoControl";
			newGraphic = getDefinitionByName(externalAsset) as Class;
			_clip = new newGraphic() as MovieClip;
			this.addChild(_clip);				
			
			_playpause = _clip._playpause;
			_slider = _clip._slider;
			_progbar = _clip._progbar;
			_bufferbar = _clip._bufferbar;
			
			_videoObj = vidobj;
			_videoObj.addEventListener("MOVIE_DONE", movieEnd);
			
			_playpause.buttonMode = true;
			_slider.buttonMode = true;
			
			_dragging = false;
			_videoEnd = false;
			_isPlaying = false;
			_playpause.gotoAndStop("PLAY");
			
			_bufferbar.width = 0;
			
			_sliderbounds = new Rectangle(_progbar.x, _progbar.y, _progbar.width - _slider.width, 0);
			_slider.addEventListener(MouseEvent.MOUSE_DOWN, startScrub);
			_slider.addEventListener(MouseEvent.MOUSE_UP, stopScrub);
			_playpause.addEventListener(MouseEvent.CLICK, clickPlayPause);
			_bufferbar.addEventListener(MouseEvent.CLICK, jumpToSection);
			
			this.addEventListener(Event.ENTER_FRAME, onEnterFrame);
			
		}
		private function movieEnd(e:Event):void {
			_videoEnd = true;
			_isPlaying = false;
			_playpause.gotoAndStop("PLAY");
		}
		
		public function clickPlayPause(e:MouseEvent):void {
			if (_isPlaying == true) {
				_isPlaying = false;
				_playpause.gotoAndStop("PLAY");
				_videoObj._ns.pause();
			} else if (_isPlaying == false) {
				_isPlaying = true;
				if (_videoEnd == true) {
					//restart
					_videoEnd = false;
					_videoObj._ns.seek(0);
					_videoObj._ns.resume();	
				} else {
					_videoObj._ns.resume();	
				}
				_playpause.gotoAndStop("PAUSE");
			} 			
		}
		
		private function onEnterFrame(e:Event):void {
			if (_dragging == false) {
				var playheadPos:Number = _videoObj.getPlayhead() * (_progbar.width - _slider.width);
				if (playheadPos > 0) {
					_slider.x = playheadPos;
				}
			}
			var pctloaded:Number = _videoObj.getPercentLoaded();
			if (pctloaded > 0) { _bufferbar.width = pctloaded * _progbar.width;}
		}
		
		private function childUpOutside(e:MouseEvent):void
		{
	   		stage.removeEventListener(MouseEvent.MOUSE_UP, childUpOutside);
			stage.removeEventListener(MouseEvent.MOUSE_MOVE, updateWhileScrubbing);
	   		if (e.target != _slider && _dragging == true) {stopScrub(null);}
		}
		
		private function loseFocus(e:Event):void {
			stage.removeEventListener(Event.MOUSE_LEAVE, loseFocus);
			stage.removeEventListener(MouseEvent.MOUSE_MOVE, updateWhileScrubbing);
			if (_dragging == true) {stopScrub(null);}
		}
		
		private function startScrub(e:MouseEvent):void {
			stage.addEventListener(MouseEvent.MOUSE_UP,childUpOutside);
			stage.addEventListener(Event.MOUSE_LEAVE, loseFocus);
			stage.addEventListener(MouseEvent.MOUSE_MOVE, updateWhileScrubbing);
			_videoObj._ns.pause();
			_dragging = true;
			_slider.startDrag(false, _sliderbounds);
		}
		private function stopScrub(e:MouseEvent):void {
			_slider.stopDrag();
			var pctdragged:Number = _slider.x / (_progbar.width - _slider.width);
			_videoObj.seekTo(pctdragged);
			if (_isPlaying == true) {
				_videoObj._ns.resume();
			}
			_dragging = false;
			_videoEnd = false;
		}

		private function jumpToSection(e:MouseEvent):void {
			var jumpPct:Number = this.mouseX / _progbar.width;
			_videoObj.seekTo(jumpPct);
		}

		private function updateWhileScrubbing(e:MouseEvent) : void
		{
			var jumpPct:Number = this.mouseX / _progbar.width;
			_videoObj.seekTo(jumpPct);
			_videoObj._ns.pause();
		}
	}
}
