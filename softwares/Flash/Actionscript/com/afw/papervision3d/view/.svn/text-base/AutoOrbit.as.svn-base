package com.afw.papervision3d.view {
	import org.papervision3d.view.BasicView;
	import org.papervision3d.objects.DisplayObject3D;
	import flash.events.MouseEvent;
	
	/**
	 * ...
	 * @author AllFlashWebsite.com [Gil Birman]
	 */
	public class AutoOrbit {
		
		// Camera Orbitting
		private var cameraPitch:Number = 90;
		private var cameraYaw:Number = 270;
		private var previousMouseX:Number;
		private var previousMouseY:Number;
		
		/**
		 * Less == slower, more == faster (Default: 0.1)
		 */
		public var smoothing:Number = 0.1;
		
		/**
		 * Rounding, don't confuse with snapTo() (Default: 0.05)
		 */
		public var snap:Number = 0.05;
		
		/**
		 * Current Pitch and Yaw. !! To modify these directly, set mouseEnabled = true first
		 */
		public var p1:Number = 90;
		public var y1:Number = 270;
		
		/**
		 * TODO: Use other targets?
		 */
		public var view:BasicView;
		
		/**
		 * PUBLIC: Target for orbit
		 */
		public var cameraTarget:DisplayObject3D = DisplayObject3D.ZERO;
		
		/**
		 * PUBLIC Orbit on mouse move? (doesn't stop easing)
		 */
		public var mouseEnabled:Boolean = true;
		
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
		public function AutoOrbit(view:BasicView, cameraTarget:DisplayObject3D = null) {
			this.cameraTarget = cameraTarget;
			this.view = view;
		}
		
		/**
		 * call from render/enter frame function
		 */
		public function update():void {
			if (mouseEnabled) {
				if ( previousMouseX != view.mouseX && view.mouseX > 0 && view.mouseX < view.width ) {
					// TODO: optimize maxYaw - minYaw
					cameraYaw = minYaw + (maxYaw - minYaw) * (view.mouseX / view.width);
					previousMouseX = view.mouseX;
				}
				if ( previousMouseY != view.mouseY && view.mouseY > 0 && view.mouseY < view.height ) {
					cameraPitch = minPitch + (maxPitch - minPitch) * (view.mouseY / view.height);
					previousMouseY = view.mouseY;
				}
			}
			
			// update orbit when necessary
			if ( p1 != cameraPitch || y1 != cameraYaw) {
				var pd:Number = cameraPitch - p1;
				var yd:Number = cameraYaw - y1;
				
				p1 = Math.abs(pd) < snap ? cameraPitch : p1 + pd * smoothing;
				y1 = Math.abs(yd) < snap ? cameraYaw : y1 + yd * smoothing;
				
				view.camera.orbit(p1 % 360, y1 % 360, true, cameraTarget);
			}
		}
		
		/**
		 * Tweens to specified orbit and sets isOrbiting = false
		 * @param	pitch	see camera.orbit (pv3d)
		 * @param	yaw		see camera.orbit (pv3d)
		 */
		public function snapTo(pitch:Number, yaw:Number):void {
			cameraPitch = pitch;
			cameraYaw = yaw;
			mouseEnabled = false;
		}
		
		/**
		 * Tweens "forward" and sets isOrbiting = false
		 */
		public function snapForward():void {
			snapTo(90, 270);
		}
		
	}
	
}