﻿/**behavior:		MOUSE_DOWN events:		- once a point is recieved within a radius it will take a half second to register (to avoid random screen brushes and phantom points)		- it will keep register additional clicks every 2 seconds to avoid flooding the ui with clicks			MOUSE_UP events:		- currently this is experimental and not recommended to be used			MOUSE_MOVE:		- registered for every new mouse location, due to multi user this could be all over the map, use with caution*/package pdh.potion{	import com.senocular.ui.*;	import com.potiondesign.*;		import gs.TweenMax;		import flash.display.Stage;	import flash.text.TextField;	import flash.geom.Point;	import flash.events.*;	import flash.geom.Rectangle;	import flash.display.Sprite;	import flash.events.EventDispatcher;			public class PotionProxy extends EventDispatcher	{					public var txtField				:TextField;			private var sock				:WallXMLSocket;		protected var _stage			:Stage;		private var potionPoints		:Array = [];		private var storedPoints		:Array;		private var vir_mouse			:VirtualMouse				private const PRESS				:String = "press"				private var hostIP				:String;						private var spaceRectangle		:Rectangle				private var screenResolutionWidth	:Number = 1920;		private var screenResolutionHeight	:Number = 1080;						private var heightRatio				:Number;		private var widthRatio				:Number		//***************************************************************************************************SCREEN COORDINATES				var y_flip:Boolean = true		public function flipY(val:Boolean):void 		{			y_flip = val;		}				public function getPoints():Array 		{			return potionPoints;		}						public function setScreenSize(screenX, screenY):void 		{			screenResolutionWidth = screenX;			screenResolutionHeight = screenY;		}				// adjust points actual screen coordinates		protected function convertPoint(point:Point):Point 		{			/*var newX:Number = (((point.x) - spaceRectangle.x) / spaceRectangle.width) * screenResolutionWidth;			var newY:Number;						if (y_flip)	{					newY = (( spaceRectangle.height  -  (point.y - spaceRectangle.y) ) / spaceRectangle.height) * screenResolutionHeight;			} else {				newY = (( (point.y - spaceRectangle.y) ) / spaceRectangle.height) * screenResolutionHeight;			}*/						var newX:Number = ((point.x) - spaceRectangle.x) * widthRatio,				newY:Number;						if (y_flip)	{					newY = ( spaceRectangle.height  -  (point.y - spaceRectangle.y) ) * heightRatio;			} else {				newY = ( (point.y - spaceRectangle.y) ) * heightRatio;			}						return new Point(int(newX), int(newY));		}				public function setMeasurements(obj:Object):void 		{			var _wid:Number =  obj.x2 - obj.x;			var _hei:Number = obj.y2 - obj.y;			spaceRectangle = new Rectangle(obj.x, obj.y, _wid, _hei)						heightRatio = screenResolutionHeight / _hei;			widthRatio = screenResolutionWidth / _wid;		}				// set the display area to map points to (probaby use stage)		public function setStage(_stg:Stage):void 		{			_stage = _stg			vir_mouse= new VirtualMouse(_stage, 0, 0);			_stage.addEventListener(Event.ENTER_FRAME, handleFrame, false,0, true)		}						private function handleFrame(e:Event):void 		{			onFrame(potionPoints)			potionPoints = [] // clear array		}				protected function onFrame(p_arr:Array):void 		{			// code here is only executed once per frame		}						//***************************************************************************************************NETWORK CONNECTIONS				public function connect(_ip:String, _port:Number = 9999):void 		{						hostIP = _ip					sock = new WallXMLSocket( _ip,_port );			sock.addEventListener(WallPointsEvent.GOTPOINTS, pointsRecieved);			sock.addEventListener(WallPointsEvent.ERROR, onError);			sock.addEventListener(WallPointsEvent.CONNECT, onConnect);						/* DEBUGGING CODE */			trace("** connecting to : " + _ip + " **")			if (txtField != null) txtField.appendText("connecting to: " + _ip + " ... \n")			/* END DEBUGGING CODE */		}						//function called by event listener attached to 'pointsHolder' that processes point array 		private function onError(e:WallPointsEvent) {			trace("** error connecting  **")						if (e.type != "security"){								/* DEBUGGING CODE */				//if (txtField != null) txtField.appendText("ERROR: " + e.parameters.message + "\n")				if (txtField != null) txtField.appendText("ERROR: cannot connect! Reconnecting in 30 sec. \n")				/* END DEBUGGING CODE */												// wait 30 seconds then reconnect				TweenMax.delayedCall(30, reconnect)			}		}				private function reconnect():void 		{			trace("** reconnecting **")						/* DEBUGGING CODE */			//if (txtField != null) txtField.appendText("ERROR: " + e.parameters.message + "\n")			if (txtField != null){				txtField.text = ""				txtField.appendText("Reconnecting to " + hostIP + " \n")			}			/* END DEBUGGING CODE */													sock.reconnect()		}				//function called by event listener attached to 'pointsHolder' that processes point array 		private function onConnect(e:WallPointsEvent) {			trace("** CONNECTED!!! **")			/* DEBUGGING CODE */			if (txtField != null) txtField.appendText("** Connected! **")			/* END DEBUGGING CODE */		}						//function called by event listener attached to 'pointsHolder' that processes point array 		public function pointsRecieved(e:Object) 		{			potionPoints = e.parameters.pointList as Array;			onData(potionPoints)		}				protected function onData(p_arr:Array):void 		{			// code here is executed everytime a point is recieved from the potion software		}						//***************************************************************************************************VIRTUAL MOUSE						protected function countPress(p:Point):void 		{			//countMove(obj)			//if (vir_mouse != null)							vir_mouse= new VirtualMouse(_stage,  p.x ,p.y);			/*vir_mouse.lock();			vir_mouse.x = obj.x;			vir_mouse.y = obj.y;			vir_mouse.unlock();*/						vir_mouse.press();			//vir_mouse.dispose()		}				protected function countRelease(p:Point):void 		{			//countMove(obj)			//vir_mouse= new VirtualMouse(_stage,  p.x ,p.y);			//vir_mouse.release();		}				protected function countMove(obj:Point):void 		{			//var vir_mouse= new VirtualMouse(_stage,  obj.x ,obj.y);			vir_mouse.lock();			vir_mouse.x = obj.x;			vir_mouse.y = obj.y;			vir_mouse.unlock();		}						//***************************************************************************************************DEBUGGING						// DEBUGGING START		public function setDebuggerText(textfield:TextField):void		{			txtField = textfield;			txtField.appendText("screen: " + screenResolutionWidth + " x " + screenResolutionHeight + "\n")		}		var marker:Sprite;		public function setMarker(val:Sprite):void 		{			marker = val;		}		// DEBUGGING END							}}