﻿package com.potiondesign {	    import flash.events.*;    import flash.net.XMLSocket;    public class WallXMLSocket extends EventDispatcher {		        private var hostName:String;        private var port:uint;        private var socket:XMLSocket;        public function WallXMLSocket( _hostName:String,_port:uint ) {			hostName = _hostName;			port = _port;			            socket = new XMLSocket();            configureListeners(socket);            socket.connect(hostName, port);        }				public function reconnect():void 		{			if (hostName == null) return;			socket.connect(hostName, port);		}        public function send(data:Object):void {            socket.send(data);        }        private function configureListeners(dispatcher:IEventDispatcher):void {            dispatcher.addEventListener(Event.CLOSE, closeHandler);            dispatcher.addEventListener(Event.CONNECT, connectHandler);            dispatcher.addEventListener(DataEvent.DATA, dataHandler);            dispatcher.addEventListener(IOErrorEvent.IO_ERROR, ioErrorHandler);            dispatcher.addEventListener(ProgressEvent.PROGRESS, progressHandler);            dispatcher.addEventListener(SecurityErrorEvent.SECURITY_ERROR, securityErrorHandler);        }        private function progressHandler(event:ProgressEvent):void {            trace("progressHandler loaded:" + event.bytesLoaded + " total: " + event.bytesTotal);        }       		/*		<points>			<point x="" y="" />			...		</points>		 */        private function dataHandler(event:DataEvent):void {            //trace("dataHandler: " + event);			var xml:XML = XML(event.data);			// process			var npoints = xml.point.length();			var points = new Array();			for each(var p in xml.point) {				var xp = p.@x;				var yp = p.@y;				points.push({x:xp, y:yp});			}			// notify listeners			dispatchEvent(new WallPointsEvent(WallPointsEvent.GOTPOINTS, {numPoints: npoints, pointList: points}));        }        private function ioErrorHandler(event:IOErrorEvent):void {            trace("ioErrorHandler: " + event);			dispatchEvent(new WallPointsEvent(WallPointsEvent.ERROR, {message: "ioErrorHandler: " + event, type:"io"}));        }				 private function closeHandler(event:Event):void {            trace("closeHandler: " + event);			dispatchEvent(new WallPointsEvent(WallPointsEvent.ERROR, {message: "closeHandler: " + event, type:"close"}));        }        private function connectHandler(event:Event):void {            trace("connectHandler: " + event);			dispatchEvent(new WallPointsEvent(WallPointsEvent.CONNECT, {message: "connectHandler: " + event, type:"connect"}));        }        private function securityErrorHandler(event:SecurityErrorEvent):void {            trace("securityErrorHandler: " + event);			dispatchEvent(new WallPointsEvent(WallPointsEvent.ERROR, {message: "securityErrorHandler: " + event , type:"security"}));        }    }}