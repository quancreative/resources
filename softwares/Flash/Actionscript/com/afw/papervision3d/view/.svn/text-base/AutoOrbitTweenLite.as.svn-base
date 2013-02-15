package com.afw.papervision3d.view {
	import org.papervision3d.view.BasicView;
	import org.papervision3d.objects.DisplayObject3D;
	import flash.events.MouseEvent;
	import gs.TweenLite;
	import gs.easing.Linear;
	
	/**
	 * ...
	 * @author AllFlashWebsite.com [Gil Birman]
	 */
	public class AutoOrbitTweenLite {
		
		// Camera Orbitting
		private var cameraPitch:Number = 90;
		private var cameraYaw:Number = 270;
		private var previousMouseX:Number;
		private var previousMouseY:Number;
		private var changed:Boolean = false;
		
		/**
		 * TODO: Use other targets?
		 */
		public var view:BasicView;
		
		/**
		 * PUBLIC: Current Pitch and Yaw. !! To modify these directly, set mouseEnabled = false
		 */
		public var p1:Number = 90;
		public var y1:Number = 270;
		
		/**
		 * PUBLIC: Target for orbit
		 */
		public var cameraTarget:DisplayObject3D = DisplayObject3D.ZERO;
		
		/**
		 * PUBLIC Orbit? (doesn't stop current tweens)
		 */
		public var mouseEnabled:Boolean = true;
		
		/**
		 * PUBLIC Linear seems to work best
		 */
		public var tweenEase:Function = Linear.easeIn;
		
		/**
		 * PUBLIC Tween Duration
		 */
		public var tweenDuration:Number = 0.5;
		
		/**
		 * PUBLIC Camera Pitch: initially at 90 maxDown < 180 && maxUp > 0
		 */
		public var maxPitch:Number = 179;	// min:90 ...to... max:180
		
		/**
		 * PUBLIC Camera Pitch: initially at 90 maxDown < 180 && maxUp > 0
		 */
		public var minPitch:Number = 1; 	// min:90 ...to... max:0
		
		/**
		 * PUBLIC: Camera Yaw: initially at 270
		 */
		public var maxYaw:Number = 360;	// min:270....to... max:360
		
		/**
		 * PUBLIC: Camera Yaw: initially at 270
		 */
		public var minYaw:Number = 180; 	// min:180 ...to... max:270
		
		//public var orbitSmoothing:Number = 0.1;
		
		/**
		 * view and view.stage must be initialized
		 * @param	view
		 */
		public function AutoOrbitTweenLite(view:BasicView, cameraTarget:DisplayObject3D = null) {
			this.cameraTarget = cameraTarget;
			this.view = view;
		}
		
		/**
		 * call from render/enter frame function
		 */
		public function update():void {
			if (mouseEnabled) {
				changed = false;
				if ( previousMouseX != view.mouseX && view.mouseX > 0 && view.mouseX < view.width ) {
					cameraYaw = minYaw + (maxYaw - minYaw) * (view.mouseX / view.width);
					previousMouseX = view.mouseX;
					changed = true;
				}
				if ( previousMouseY != view.mouseY && view.mouseY > 0 && view.mouseY < view.height ) {
					cameraPitch = minPitch + (maxPitch - minPitch) * (view.mouseY / view.height);
					previousMouseY = view.mouseY;
					changed = true;
				}
				
				if (changed)
					TweenLite.to(this, tweenDuration, { y1: cameraYaw, p1: cameraPitch, ease: tweenEase });
					//TweenLite.to(this, tweenDuration, { y1: cameraYaw, p1: cameraPitch });
			}
			
			// update orbit when necessary
			if ( p1 != cameraPitch || y1 != cameraYaw)
				view.camera.orbit(p1 % 360, y1 % 360, true, cameraTarget);
		}
		
		/**
		 * Tweens to specified orbit and sets mouseEnabled = false
		 * @param	pitch	see camera.orbit (pv3d)
		 * @param	yaw		see camera.orbit (pv3d)
		 */
		public function snapTo(pitch:Number, yaw:Number):void {
			mouseEnabled = false;
			cameraPitch = pitch;
			cameraYaw = yaw;
			TweenLite.to(this, tweenDuration, { p1: pitch, y1: yaw, ease: tweenEase });
			//TweenLite.to(this, tweenDuration, { y1: 270, p1: 90 });
		}
		
		/**
		 * Tweens "forward" and sets isOrbiting = false
		 */
		public function snapForward():void {
			snapTo(90, 270);
		}
		
	}
	
}