﻿package com.cortinaproductions.away3d{		import away3d.core.clip.FrustumClipping;	import away3d.containers.View3D;	import away3d.containers.Scene3D;	import flash.display.Sprite;	import away3d.core.render.*;	import com.cortinaproductions.away3d.RenderManager;				public class VirtualMouseBasic3dSprite extends Sprite	{				// ***********************				protected var view				:VirtualMouseView3D;		// ************************				protected var renderManager		:RenderManager;				function Basic3dSprite(useBasic:Boolean = false):void 		{			setupScene(500, 500);					}				protected function setupScene(__width, __height, renderer:Object = null):void 		{			// create a 3D-viewport			///if (renderer != null){				//view = new View3D({x:__width, y:__height, renderer:renderer});			//} else {				view = new VirtualMouseView3D({x:__width, y:__height, renderer:Renderer.CORRECT_Z_ORDER});			//}																		// add viewport to the stage			addChild(view);						renderManager = new RenderManager(this, view);						}								protected function render():void 		{			renderManager.render();		}						public function destroy():void 		{			view.destroy();			view.clear();			removeChild(view);			renderManager.destroy();			renderManager = null;		}			}		}