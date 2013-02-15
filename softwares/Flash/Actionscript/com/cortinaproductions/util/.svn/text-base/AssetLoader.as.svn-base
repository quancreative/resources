package com.cortinaproductions.util 
{
	import flash.display.Loader;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.HTTPStatusEvent;
	import flash.events.IEventDispatcher;
	import flash.events.IOErrorEvent;
	import flash.events.ProgressEvent;
	import flash.net.URLRequest;
	import flash.system.ApplicationDomain;
	import flash.system.LoaderContext;
	import flash.utils.Dictionary;

	/**
	 * 		
	var urlArray:Array = ["swf/external_assets.swf", "swf/interactive-program.swf", "swf/map.swf", "swf/photoZoomer.swf", "swf/videoplayer.swf"];
	var assetLoader:AssetLoader = new AssetLoader(urlArray);
	assetLoader.addEventListener(AssetLoaderEvent.COMPLETE_LOADING, onCompleteLoad);
	assetLoader.addEventListener(AssetLoaderEvent.ALL_COMPLETE_LOADING, onAllCompleteLoad);
	assetLoader.startQueue();

	private function onCompleteLoad(e:AssetLoaderEvent) : void
	{
	trace (this + " onCompleteLoading " + e.parameters[0] + "; loading ratio: " + e.parameters[1]);
	}
	private function onAllCompleteLoad(e:AssetLoaderEvent) : void
	{
	trace (this + " onAllCompleteLoading");
	}		
	 */
	 
	public class AssetLoader extends EventDispatcher
	{
		private var queue : Array;
		private var loadIndex : int;	
		private var dictionary : Dictionary;
		private const MAX_LOAD : int = 4;
		private var currentLoading : uint = 0;
		private var finishLoading : uint = 0;

		
		public function AssetLoader(args : Array) 
		{
			dictionary = new Dictionary();
			queue = new Array();
			loadIndex = 0; 
			addToQueue(args);
		}

		public function addToQueue(args : Array) : void
		{  	
			for (var i : int = 0;i < args.length; i++)
			{
				queue.push(args[i]);
			}
		}

		public function startQueue() : void
		{
			var addedDefinitions : LoaderContext = new LoaderContext();
			addedDefinitions.applicationDomain = ApplicationDomain.currentDomain;			
			
			while (currentLoading < MAX_LOAD && loadIndex < queue.length)
			{
				var request : URLRequest = new URLRequest(queue[loadIndex]);
				var loader : Loader = new Loader();   
				startListeners(loader.contentLoaderInfo); 
				loader.load(request, addedDefinitions);  
				dictionary[loader] = queue[loadIndex];
				
				currentLoading++;
				loadIndex++;
			}
		}

		public function stopQueue() : void
		{
		}

		public function startListeners( loaderInfo : IEventDispatcher ) : void 
		{			
			loaderInfo.addEventListener(Event.OPEN, onStart);
			loaderInfo.addEventListener(Event.COMPLETE, onComplete);
			loaderInfo.addEventListener(ProgressEvent.PROGRESS, onUpdate);
			loaderInfo.addEventListener(HTTPStatusEvent.HTTP_STATUS, onHTTPStatus);
			loaderInfo.addEventListener(IOErrorEvent.IO_ERROR, onIOError);
		}

		public function stopListeners( loaderInfo : IEventDispatcher ) : void 
		{
			loaderInfo.removeEventListener(Event.OPEN, onStart);
			loaderInfo.removeEventListener(Event.COMPLETE, onComplete);
			loaderInfo.removeEventListener(ProgressEvent.PROGRESS, onUpdate);
			loaderInfo.removeEventListener(HTTPStatusEvent.HTTP_STATUS, onHTTPStatus);
			loaderInfo.removeEventListener(IOErrorEvent.IO_ERROR, onIOError);
		}

		private function onStart(event : Event) : void
		{
			//trace(this + "onStart");
		}

		private function onComplete(event : Event) : void
		{
			trace(dictionary[event.target]);
			trace(this + "onComplete");
			currentLoading--;
			finishLoading++;
			var percent : String = finishLoading + "/" + queue.length;
			startQueue();
			if (finishLoading == queue.length)
			{
				dispatchEvent(new AssetLoaderEvent(AssetLoaderEvent.ALL_COMPLETE_LOADING, [dictionary[event.target], percent]));
			} 
			else 
			{
				dispatchEvent(new AssetLoaderEvent(AssetLoaderEvent.COMPLETE_LOADING, [dictionary[event.target], percent]));
			}
		}

		private function onUpdate(event : ProgressEvent) : void
		{
			//trace(this + "onUpdate");
		}

		private function onHTTPStatus(event : HTTPStatusEvent) : void
		{
			//trace(this + "onHTTPStatus");
		}

		private function onIOError(event : IOErrorEvent) : void
		{
			//trace(this + "onIOError");
		}
	}
}
