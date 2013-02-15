
//TODO add package
package com
{
	import flash.display.MovieClip;
	import flash.events.Event;
	
	//TODO import com.events.AnimationEvent;
	
	public class ${var}Model extends EventDispatcher
	{
public static const MODEL_CHANGE : String = "modelChange";
private var urlLoader : URLLoader;
private var xml : XML;

public function ${var}Model(target : IEventDispatcher = null)
{
	super(target);${cursor}
	
	urlLoader = new URLLoader();
	urlLoader.addEventListener(Event.COMPLETE, onUrlLoaderComplete);
}

public function load(urlRequest : URLRequest) : void 
{
	urlLoader.load(urlRequest);
}

private function onUrlLoaderComplete(event : Event) : void 
{
	urlLoader.removeEventListener(Event.COMPLETE, onUrlLoaderComplete);
	
	var myXml : XML = new XML(event.target.data);
	parseXml(myXml);
}

private function parseXml(data : XML) : void 
{
	xml = x;
	
	dispatchEvent(new Event(Event.COMPLETE));
}

public function gotoPage(pg : Object) : void 
{
	dispatchEvent(new Event(${var}Model.MODEL_CHANGE));
}
	}
}