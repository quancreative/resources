﻿package com.cortinaproductions.util {		import flash.display.Sprite;		public class MouseDisabler	{				public static function disable(target:Sprite):void 		{			target.mouseEnabled = false;			target.mouseChildren = false;		}					}}