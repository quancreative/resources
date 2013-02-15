package br.com.stimuli.loading.tests {
	import br.com.stimuli.kisstest.TestCase
	import br.com.stimuli.loading.*;
	import br.com.stimuli.loading.loadingtypes.*;
	
	import flash.display.*;
	import flash.events.*;
	import flash.net.*;
    /**@private*/
	public class ProgressEventsTest extends TestCase { 
	    public var _bulkLoader : BulkLoader;
		public var lastProgress : Number = 0;

		
		public var ioError : Event;
		
		public var percentLoadedWentDown : Boolean;
		public var largestPercentLoaded : Number = 0;
		public var badValueForPercentLoaded : Boolean
		public var weightPercentLoadedWentDown : Boolean;
		public var largestWeightPercent : Number = 0;
		public var badValueForWeightPercent : Boolean;
		public var ratioPercentLoadedWentDown  : Boolean;
		public var largestRatioLoaded   : Number = 0;
		public var badValueForRatioLoaded : Boolean;

		public var bytesCurrentLoadedWentDown  : Boolean;
		public var bytesCurrentLoaded   : Number = 0;
		public var badValueForBytesCurrent : Boolean;
		public var largestBytesCurrent : Number = 0;
		//localBytesTotalCurrent
		public function ProgressEventsTest(name : String) : void {
		  super(name);
		  this.name = name;
		}
		// Override the run method and begin the request for remote data
		public override function setUp():void {
            _bulkLoader = new BulkLoader(BulkLoader.getUniqueName())
            var goodURL : String = "http://www.emptywhite.com/bulkloader-assets/samplexml.xml";
            var badURL : String = "http://www.emptywhite.com/bulkloader-assets/bad-samplexml.xml"
            var theURL : String = goodURL;
            if (this.name == 'testIOError'){
                theURL = badURL;
            }
            
	 		_bulkLoader.add(theURL, {id:"text", preventCache:true});
            _bulkLoader.get("text").addEventListener(BulkLoader.ERROR, onIOError);
	 		_bulkLoader.add("http://www.emptywhite.com/bulkloader-assets/shoes.jpg", {id:"photo", preventCache:true});

	 		_bulkLoader.start();
	 		_bulkLoader.addEventListener(BulkLoader.COMPLETE, completeHandler);
	 		_bulkLoader.addEventListener(BulkLoader.PROGRESS, progressHandler);
		}

        public function onIOError(evt : Event) : void{
            ioError = evt;
            // call the on complete manually 
            completeHandler(evt);
            tearDown();
        }
        
		public function completeHandler(event:Event):void {
		    _bulkLoader.removeEventListener(BulkLoader.COMPLETE, completeHandler);
	 		_bulkLoader.removeEventListener(BulkLoader.PROGRESS, progressHandler);
			dispatchEvent(new Event(Event.INIT));
		}
		
		
		/** This also works as an assertion that event progress will never be NaN
		*/
		 public function progressHandler(anEvent:ProgressEvent):void {
		    var event : BulkProgressEvent = anEvent as BulkProgressEvent;
		    //var evt : * = event as Object;
			var current :Number = Math.floor((event as Object).percentLoaded * 100) /100;
			var delta : Number = current - lastProgress;
			if (current > lastProgress && delta > 0.099){
			    lastProgress = current;
			    if (BulkLoaderTestSuite.LOADING_VERBOSE) trace(current * 100 , "% loaded") ;
			}
			
			if (event.percentLoaded < largestPercentLoaded){
			    percentLoadedWentDown = true;
			}else{
			    largestPercentLoaded = event.percentLoaded;
			}
			if (event.percentLoaded < 0  || event.percentLoaded > 1){
			    badValueForPercentLoaded = true;
			}
			
			if (event.weightPercent < 0  || event.weightPercent > 1){
			    badValueForWeightPercent = true;
			}
			
			if (event.weightPercent < largestWeightPercent){
			    weightPercentLoadedWentDown = true;
			}else{
			    largestWeightPercent = event.weightPercent;
			}
			
			if (event.ratioLoaded < 0  || event.ratioLoaded > 1){
			    badValueForRatioLoaded = true;
			}
			if (event.ratioLoaded < largestRatioLoaded){
			    ratioPercentLoadedWentDown = true;
			}else{
			    largestRatioLoaded = event.ratioLoaded;
			}
			
			
			if (event.bytesTotalCurrent < 0 || event.bytesTotalCurrent != _bulkLoader._bytesTotalCurrent){
			    badValueForBytesCurrent = true;
			}
			if (event.bytesTotalCurrent < largestBytesCurrent){
			    bytesCurrentLoadedWentDown = true;
			}else{
			    largestBytesCurrent = event.bytesTotalCurrent;
			}
			
			for each(var propName : String in ["percentLoaded", "weightPercent", "ratioLoaded"] ){
			    if (isNaN(event[propName]) ){
			        trace(propName, "is not a number" );
			        assertFalse(isNaN(event[propName]));
			    }
			}
		}

		
		override public function tearDown():void {
		    _bulkLoader.clear();
			BulkLoader.removeAllLoaders();
            _bulkLoader = null;	
		}
		
		public function testGetProgressForItems() : void{
		    _bulkLoader.add("http://www.emptywhite.com/bulkloader-assets/chopin.mp3", {id:"sound"});
            var e : BulkProgressEvent = _bulkLoader.getProgressForItems(["text", "photo"]);
            assertNotNull(e);
        }
        
        public function testGetProgressForItemsPercentLoaded() : void{
            _bulkLoader.add("http://www.emptywhite.com/bulkloader-assets/chopin.mp3", {id:"sound"});
            var e : BulkProgressEvent = _bulkLoader.getProgressForItems(["text", "photo"]);
            assertEquals(e.percentLoaded,1);
        }
        
        public function testGetProgressForItemsRatioLoaded() : void{
            _bulkLoader.add("http://www.emptywhite.com/bulkloader-assets/chopin.mp3", {id:"sound"});
            var e : BulkProgressEvent = _bulkLoader.getProgressForItems(["text", "photo"]);
            assertEquals(e.ratioLoaded,1);
        }
        
        public function testPercentLoaded() : void{
            assertFalse(badValueForPercentLoaded);
            assertFalse(percentLoadedWentDown);
        }
        
        public function testWeightPercent() : void{
            assertFalse(badValueForWeightPercent);
            assertFalse(weightPercentLoadedWentDown);
        }
        
        public function testRatioLoaded() : void{
            assertFalse(badValueForRatioLoaded);
            assertFalse(ratioPercentLoadedWentDown);
        }
        
        public function testBytesCurrent() : void{
            assertFalse(badValueForBytesCurrent);
            assertFalse(bytesCurrentLoadedWentDown);
            assertEquals(largestBytesCurrent ,_bulkLoader._bytesTotalCurrent)
        }
	}
}