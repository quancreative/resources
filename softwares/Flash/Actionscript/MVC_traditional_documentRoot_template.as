
//TODO add package
package com
{
	import flash.display.MovieClip;
	import flash.events.Event;
	
	//TODO import com.events.AnimationEvent;
	
	public class CLASS_NAME extends MovieClip
	{
private var model : ${var}Model;
private var view : ${var}View;
private var controller : ${var}Controller;

private var _state : String;

// have to standalone or plugin
private var _mode : String = "standalone";

private var _info : Object;

public function ${var} ()
{
	super();
	state = "instantiate";
	${cursor}
	
	// configure UI
	// get all the display objects on the timeline
	
	// adding the model
	model = new ${var}Model();
	model.addEventListener(Event.COMPLETE, onModelComplete);
	
	// !! Check if a standalone, if so then load the xml
	if (stage != null) start();
}

private function onModelComplete(event : Event) : void
{
	model.removeEventListener(Event.COMPLETE, onModelComplete);
	
	controller = new ${var}Controller(model);
	
	// at this point, all data should be in/collected
	// if on standalone then transtionIn();
	if (stage != null) transitionIn();
	else dispatchEvent(new Event(Event.INIT));
}

public function transitionIn() : void
{
	view = new ${var}View(model, controller);
	
	addChild(view);
	
	transitionInComplete();
}

private function transitionInComplete() : void
{
	// add accessibility
	
	dispatchEvent(new Event(AnimationEvent.TRANSITION_IN_COMPLETE));			
}

public function start() : void
{
	state = "starting";
	
	model.load(new URLRequest(_xmlUrl));
}

public function transtionOut() : void
{
	transitionOutComplete();
}

private function transitionOutComplete() : void
{
	dispatchEvent(new Event(AnimationEvent.TRANSITION_OUT_COMPLETE));
}

public function die() : void
{
	
}

public function get mode() : String
{
	return _mode;
}

public function set mode(value : String) : void
{
	_mode = value;
}

public function get info() : Object
{
	return _info;
}

public function set info(value : Object) : void
{
	_info = value;
}
	}
}