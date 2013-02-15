import mx.events.EventDispatcher;
import mx.utils.Delegate;
class net.quip.sound.SoundSync extends Sound {
	// PROPERTIES
	private var _cuePoints:Array;
	private var _currentCuePoint:Number;
	private var _interval:Number;
	private var _intervalDuration:Number;
	private var _secondOffset:Number;
	// Event dispatcher
	public var dispatchEvent:Function;
	public var addEventListener:Function;
	private var removeEventListener:Function;
	// CONSTRUCTOR
	public function SoundSync(target:MovieClip) {
		super(target);
		init();
	}
	// METHODS
	private function init():Void {
		// Initialize properties
		_cuePoints = new Array();
		_currentCuePoint = 0;
		_intervalDuration = 50;
		_secondOffset = 0;
		// Initialize class instance as valid event broadcaster
		EventDispatcher.initialize(this);
	}
	// Add Cue Point
	public function addCuePoint(cuePointName:String, cuePointTime:Number):Void {
		_cuePoints.push(
			{
				type: "cuePoint",
				name: cuePointName,
				time: cuePointTime,
				target: this
			}
		);
		_cuePoints.sortOn("time", Array.NUMERIC);
	}
	// Get Cue Point
	public function getCuePoint(nameOrTime:Object):Object {
		var counter:Number = 0;
		while (counter < _cuePoints.length) {
			if (typeof(nameOrTime) == "string") {
				if (_cuePoints[counter].name == nameOrTime) {
					return _cuePoints[counter];
				}
			} else if (typeof(nameOrTime) == "number") {
				if (_cuePoints[counter].time == nameOrTime) {
					return _cuePoints[counter];
				}
			}
			counter++;
		}
		return null;
	}
	// Get Current Cue Point Index
	private function getCurrentCuePointIndex(cuePoint:Object):Number {
		var counter:Number = 0;
		while (counter < _cuePoints.length) {
			if (_cuePoints[counter].name == cuePoint.name) {
				return counter;
			}
			counter++;
		}
		return null;
	}
	// Get Next Cue Point Index
	private function getNextCuePointIndex(seconds:Number):Number {
		seconds = (seconds) ? seconds : 0;
		var counter:Number = 0;
		while (counter < _cuePoints.length) {
			if (_cuePoints[counter].time >= seconds * 1000) {
				return counter;
			}
			counter++;
		}
		return null;
	}
	// Remove Cue Point
	public function removeCuePoint(cuePoint:Object):Void {
		_cuePoints.splice(getCurrentCuePointIndex(cuePoint), 1);
	}
	// Remove All Cue Points
	public function removeAll_cuePoints():Void {
		_cuePoints = new Array();
	}
	// Start
	public function start(secondOffset:Number, loops:Number):Void {
		super.start(secondOffset, loops);
		dispatchEvent({type:"onStart", target:this});
		// Reset current cue point
		_secondOffset = secondOffset;
		_currentCuePoint = getNextCuePointIndex(secondOffset);
		// Poll for cue points
		clearInterval(_interval);
		_interval = setInterval(Delegate.create(this, pollCuePoints), _intervalDuration);
	}
	// Load Sound
	public function loadSound(url:String, isStreaming:Boolean):Void {
		super.loadSound(url, isStreaming);
		clearInterval(_interval);
		_interval = setInterval(Delegate.create(this, pollCuePoints), _intervalDuration);
	}
	// Stop
	public function stop(linkageID:String):Void {
		if (linkageID) {
			super.stop(linkageID);
		} else {
			super.stop();
		}
		dispatchEvent({type:"onStop", target:this});
		// Kill polling
		clearInterval(_interval);
	}
	// Poll Cue Points
	private function pollCuePoints():Void {
		// If current position is near the current cue point's time ...
		var time:Number = _cuePoints[_currentCuePoint].time;
		var span:Number = (_cuePoints[_currentCuePoint + 1].time) ? _cuePoints[_currentCuePoint + 1].time : time + _intervalDuration * 2;
		if (position >= time && position <= span) {
			// Dispatch event
			dispatchEvent(_cuePoints[_currentCuePoint]);
			// Advance to next cue point ...
			if (_currentCuePoint < _cuePoints.length) {
				_currentCuePoint++;
			} else {
				_currentCuePoint = getNextCuePointIndex(_secondOffset);
			}
		}
	}
	// EVENT HANDLERS
	// onSoundComplete
	public function onSoundComplete():Void {
		// Kill polling
		clearInterval(_interval);
		// Reset current cue point
		_currentCuePoint = 0;
		// Dispatch event
		dispatchEvent({type:"onSoundComplete", target:this});
	}
}