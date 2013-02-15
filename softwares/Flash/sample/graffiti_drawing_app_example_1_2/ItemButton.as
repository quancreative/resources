package {
	
	import flash.display.MovieClip;
	import flash.events.MouseEvent;
	
	public class ItemButton extends MovieClip {
		
		public var button_states_mc:MovieClip;
		
		private var _selected:Boolean = false;
		
		public function ItemButton() {
			
			button_states_mc.stop();
			
			this.addEventListener(MouseEvent.ROLL_OVER, mouseHandler);
			this.addEventListener(MouseEvent.ROLL_OUT, mouseHandler);
			
		}
		
		/**************************************************************************
			Method	: selected()
			
			Purpose	: This method sets the selected value of the button.
			
			Params	: v -- Boolen value
		***************************************************************************/
		public function set selected(v:Boolean):void {
			
			_selected = v;
			
			if(_selected) {
				button_states_mc.gotoAndStop("selected");
			} else {
				button_states_mc.gotoAndStop("up");
			}
			
		}
		
		/**************************************************************************
			Method	: selected()
			
			Purpose	: This methods returns the selected value.
		***************************************************************************/
		public function get selected():Boolean {
			return _selected;
		}
		
		/**************************************************************************
			Method	: mouseHandler()
			
			Purpose	: This methods handles the rollover and rollout events.
			
			Params	: e -- MouseEvent object.
		***************************************************************************/
		private function mouseHandler(e:MouseEvent):void {
			
			if(!_selected && !e.buttonDown) {
				
				if(e.type == MouseEvent.ROLL_OVER) {
					button_states_mc.gotoAndStop("over");
				} else if(e.type == MouseEvent.ROLL_OUT) {
					button_states_mc.gotoAndStop("up");
				}
				
			}
			
		}
		
	}
	
}