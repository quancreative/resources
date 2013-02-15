package {
	
	import flash.display.Bitmap;
	import flash.display.BitmapData
	import flash.display.MovieClip;
	import flash.display.SimpleButton;
	import flash.display.Sprite;
	import flash.display.LineScaleMode;
	import flash.display.CapsStyle;
	import flash.display.JointStyle;
	import flash.text.TextField;
	import flash.geom.Point;
	import flash.ui.Keyboard;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.events.KeyboardEvent;
	import flash.display.BlendMode;
	import flash.net.navigateToURL;
	import flash.net.URLRequest;
	import flash.net.URLRequestMethod;
	import flash.net.URLRequestHeader;
	import flash.utils.ByteArray;
	
	import fl.controls.CheckBox;
	import fl.controls.ColorPicker;
	import fl.controls.Slider;
	import fl.controls.ComboBox;
	import fl.events.ColorPickerEvent;
	import fl.events.SliderEvent;
	import fl.data.DataProvider;
	
	import com.nocircleno.graffiti.GraffitiCanvas;
	import com.nocircleno.graffiti.events.CanvasEvent;
	import com.nocircleno.graffiti.tools.BrushTool;
	import com.nocircleno.graffiti.tools.BrushType;
	import com.nocircleno.graffiti.tools.LineTool;
	import com.nocircleno.graffiti.tools.LineType;
	import com.nocircleno.graffiti.tools.ShapeTool;
	import com.nocircleno.graffiti.tools.ShapeType;
	import com.nocircleno.graffiti.tools.ToolMode;
	import com.nocircleno.graffiti.tools.ITool;
	
	import com.adobe.images.JPGEncoder;
	
	public class Main extends MovieClip {
		
		public var click_message_txt:TextField;
		
		// ui
		public var brush_tool_mc:MovieClip;
		public var eraser_tool_mc:MovieClip;
		public var line_tool_mc:MovieClip;
		public var rectangle_tool_mc:MovieClip;
		public var oval_tool_mc:MovieClip;
		public var clear_btn:SimpleButton;
		public var save_btn:SimpleButton;
		public var undo_btn:SimpleButton;
		public var redo_btn:SimpleButton;
		public var slider_label_txt:TextField;
		public var slider_2_label_txt:TextField;
		public var slider_3_label_txt:TextField;
		public var combo_label_txt:TextField;
		public var stroke_color_mc:ColorPicker;
		public var fill_color_mc:ColorPicker;
		public var slider_mc:Slider;
		public var slider_2_mc:Slider;
		public var slider_3_mc:Slider;
		public var zoom_slider_mc:Slider;
		public var combo_list:ComboBox;
		public var overlay_cb:CheckBox;
		public var overlay_mc:MovieClip;
		public var canvas:GraffitiCanvas;
		public var border:Sprite;
		
		// tools
		private var _brush:BrushTool;
		private var _eraser:BrushTool;
		private var _line:LineTool;
		private var _shape:ShapeTool;
		
		// props
		private var _brushSize:Number = 2;
		private var _brushShapeIndex:int;
		private var _lineStyleIndex:int;
		private var _strokeColor:uint = 0x00FF00;
		private var _fillColor:uint = 0xFF0000;
		private var _strokeAlpha:Number = 1;
		private var _fillAlpha:Number = 1;
		private var _brushBlur:Number = 0;
		private var _brushShapes:DataProvider;
		private var _lineStyles:DataProvider;
		private var _activeTool:ITool;
		
		private var _orginalComboBoxItemsPos = new Object();
		
		public function Main() {
			
			click_message_txt.alpha = 0;
			
			// create brushes
			_brush = new BrushTool(_brushSize, _fillColor, _fillAlpha, _brushBlur, BrushType.ROUND);
			_eraser = new BrushTool(_brushSize, _fillColor, 1, _brushBlur, BrushType.ROUND, ToolMode.ERASE);
			_line = new LineTool(2, _strokeColor, _strokeAlpha, LineType.SOLID);
			_shape = new ShapeTool(2, _strokeColor, _fillColor, _strokeAlpha, _fillAlpha, ShapeType.RECTANGLE);
		
			// create canvas
			canvas = new GraffitiCanvas(750, 470, 10);
			canvas.x = 0;
			canvas.y = 120;
			canvas.addEventListener(MouseEvent.MOUSE_WHEEL, scrollHandler);
			canvas.addEventListener(GraffitiCanvas.HISTORY_LENGTH_CHANGE, historyLengthChangeHandler);
			addChild(canvas);
			
			overlay_mc = new OverlayImage();
			canvas.overlay = overlay_mc;
			
			stage.addEventListener(KeyboardEvent.KEY_DOWN, keyHandler);
			stage.addEventListener(KeyboardEvent.KEY_UP, keyHandler);
			
			// event listener
			brush_tool_mc.addEventListener(MouseEvent.CLICK, toolHandler);
			eraser_tool_mc.addEventListener(MouseEvent.CLICK, toolHandler);
			line_tool_mc.addEventListener(MouseEvent.CLICK, toolHandler);
			rectangle_tool_mc.addEventListener(MouseEvent.CLICK, toolHandler);
			oval_tool_mc.addEventListener(MouseEvent.CLICK, toolHandler);

			// setup data providers
			_brushShapes = new DataProvider();
			_brushShapes.addItem({label:"Round", data: BrushType.ROUND});
			_brushShapes.addItem({label:"Square", data: BrushType.SQUARE});
			_brushShapes.addItem({label:"Diamond", data: BrushType.DIAMOND});
			_brushShapes.addItem({label:"Vertical", data: BrushType.VERTICAL_LINE});
			_brushShapes.addItem({label:"Horizontal", data: BrushType.HORIZONTAL_LINE});
			_brushShapes.addItem({label:"Forward", data: BrushType.FORWARD_LINE});
			_brushShapes.addItem({label:"Backward", data: BrushType.BACKWARD_LINE});
			
			_lineStyles = new DataProvider();
			_lineStyles.addItem({label:"Solid", data: LineType.SOLID});
			_lineStyles.addItem({label:"Dotted", data: LineType.DOTTED});
			_lineStyles.addItem({label:"Dashed", data: LineType.DASHED});
			
			// setup color pickers
			stroke_color_mc.focusEnabled = false;
			stroke_color_mc.selectedColor = _strokeColor;
			stroke_color_mc.addEventListener(ColorPickerEvent.CHANGE, colorPickerHandler);
			stroke_color_mc.enabled = false;
			
			fill_color_mc.focusEnabled = false;
			fill_color_mc.selectedColor = _fillColor;
			fill_color_mc.addEventListener(ColorPickerEvent.CHANGE, colorPickerHandler);
			
			slider_mc.addEventListener(SliderEvent.CHANGE, sliderHandler);
			slider_2_mc.addEventListener(SliderEvent.CHANGE, sliderHandler);
			slider_3_mc.addEventListener(SliderEvent.CHANGE, sliderHandler);
			overlay_cb.addEventListener(Event.CHANGE, overlayHandler);
			
			// config combo list
			combo_list.addEventListener(Event.CHANGE, comboEventHandler);
			combo_list.dataProvider = _brushShapes;
			
			// store positions
			_orginalComboBoxItemsPos.comboBox = new Point(combo_list.x, combo_list.y);
			_orginalComboBoxItemsPos.comboBoxLabel = new Point(combo_label_txt.x, combo_label_txt.y);
			
			// disable undo and redo buttons
			undo_btn.mouseEnabled = false;
			undo_btn.alpha = .5;
			redo_btn.mouseEnabled = false;
			redo_btn.alpha = .5;
			
			// add event listeners
			undo_btn.addEventListener(MouseEvent.CLICK, historyHandler);
			redo_btn.addEventListener(MouseEvent.CLICK, historyHandler);
			clear_btn.addEventListener(MouseEvent.CLICK, clearCanvasHandler);
			save_btn.addEventListener(MouseEvent.CLICK, saveHandler);
			
			zoom_slider_mc.maximum = canvas.maxZoom;
			zoom_slider_mc.addEventListener(SliderEvent.CHANGE, zoomHandler);
			
			_activeTool = _brush;
			canvas.activeTool = _activeTool;
			
			// set brush tool
			brush_tool_mc.selected = true;
			setSelectedBrushShape(BrushType.ROUND);
		
		}
		
		/**************************************************************************
			Method	: overlayHandler()
			
			Purpose	: This method toggles the overlay on and off.
			
			Params	: e -- Event object.
		***************************************************************************/
		private function overlayHandler(e:Event):void {
			if(e.currentTarget.selected) {
				canvas.overlay = overlay_mc;
			} else {
				canvas.overlay = null;
			}
		}
		
		/**************************************************************************
			Method	: historyHandler()
			
			Purpose	: This method undo or redo the drawing depending on the button
					  clicked by the user.
			
			Params	: e -- MouseEvent object.
		***************************************************************************/
		private function historyHandler(e:MouseEvent):void {
			
			if(e.currentTarget == undo_btn) {
				
				canvas.prevHistory();
				
				if(canvas.historyPosition == 0) {
					undo_btn.mouseEnabled = false;
					undo_btn.alpha = .5;
				}
				
				redo_btn.mouseEnabled = true;
				redo_btn.alpha = 1;
				
			} else if(e.currentTarget == redo_btn) {
				
				canvas.nextHistory();
				
				if(canvas.historyPosition == (canvas.historyLength - 1)) {
					redo_btn.mouseEnabled = false;
					redo_btn.alpha = .5;
				}
				
				undo_btn.mouseEnabled = true;
				undo_btn.alpha = 1;
				
			}
			
		}
		
		/**************************************************************************
			Method	: clearCanvasHandler()
			
			Purpose	: This method will clear the canvas.
			
			Params	: e -- MouseEvent object.
		***************************************************************************/
		private function clearCanvasHandler(e:MouseEvent):void {
			canvas.clearCanvas();
		}
		
		/**************************************************************************
			Method	: saveHandler()
			
			Purpose	: This method will save the drawing aa a jpg image.
			
			Params	: e -- MouseEvent object.
		***************************************************************************/
		private function saveHandler(e:MouseEvent):void {
			
			// get drawing as bitmapdata from the Graffiti Canvas instance.
			var canvasBmp:BitmapData = canvas.drawing();
			
			// create new jpg encoder object and convert bitmapdata to jpg
			var jpgEncoder:JPGEncoder = new JPGEncoder(85);
			var jpgStream:ByteArray = jpgEncoder.encode(canvasBmp);
			
			// make sure you dispose of the bitmapdata object when finished.
			canvasBmp.dispose();
			
			// create jpg image and send to server
			var header:URLRequestHeader = new URLRequestHeader("Content-type", "application/octet-stream");
			var jpgURLRequest:URLRequest = new URLRequest("http://www.nocircleno.com/graffiti/download_jpg.php?name=graffiti_demo.jpg");
			jpgURLRequest.requestHeaders.push(header);
			jpgURLRequest.method = URLRequestMethod.POST;
			jpgURLRequest.data = jpgStream;
			navigateToURL(jpgURLRequest, "_blank");

		}
		
		/**************************************************************************
			Method	: historyLengthChangeHandler()
			
			Purpose	: This method will handle the change in the number of stored
					  history items.  This is used to toggle the redo and undo
					  buttons.
			
			Params	: e -- Event object.
		***************************************************************************/
		private function historyLengthChangeHandler(e:Event):void {
			
			if(canvas.historyLength > 0 && canvas.historyPosition != 0) {
				undo_btn.mouseEnabled = true;
				undo_btn.alpha = 1;
			} else {
				undo_btn.mouseEnabled = false;
				undo_btn.alpha = .5;
			}
			
			if(canvas.historyLength > 0 && canvas.historyPosition != canvas.historyLength - 1) {
				redo_btn.mouseEnabled = true;
				redo_btn.alpha = 1;
			} else {
				redo_btn.mouseEnabled = false;
				redo_btn.alpha = .5;
			}
			
		}
		
		/**************************************************************************
			Method	: zoomHandler()
			
			Purpose	: This method will handle the zoom slider event and set the
					  canvas to the new zoom level.
			
			Params	: e -- SliderEvent object.
		***************************************************************************/
		private function zoomHandler(e:SliderEvent):void {
			
			// set zoom of canvas
			canvas.zoom = e.value;
			
			// if canvas is zoomed in then display message about dragging canvas with mouse.
			if(canvas.zoom  > 1) {
				click_message_txt.alpha = 1;
			} else {
				click_message_txt.alpha = 0;
			}
			
		}
		
		/**************************************************************************
			Method	: colorPickerHandler()
			
			Purpose	: This method will handle the color picker event.
			
			Params	: e -- ColorPickerEvent object.
		***************************************************************************/
		private function colorPickerHandler(e:ColorPickerEvent):void {
			
			if(_activeTool == _brush || _activeTool == _eraser) {
				
				_fillColor = e.color;
				BrushTool(_activeTool).color = _fillColor;
			
			} else if(_activeTool == _line) {
				
				_strokeColor = e.color;
				LineTool(_activeTool).color = _strokeColor;
			
			} else if(_activeTool == _shape) {
				
				if(e.currentTarget == stroke_color_mc) {
					
					_strokeColor = e.color;
					ShapeTool(_activeTool).strokeColor = _strokeColor;
				
				} else if (e.currentTarget == fill_color_mc) {
					
					_fillColor = e.color;
					ShapeTool(_activeTool).fillColor = _fillColor;
				
				}
				
			}
			
			
		}
		
		/**************************************************************************
			Method	: sliderHandler()
			
			Purpose	: This method will handle the slider change.
			
			Params	: e -- SliderEvent object.
		***************************************************************************/
		private function sliderHandler(e:SliderEvent):void {
			
			if(e.currentTarget == slider_mc) {
			
				if(_activeTool == _brush || _activeTool == _eraser) {
					
					_brushSize = e.value;
					BrushTool(_activeTool).size = _brushSize;
					
				} else if(_activeTool == _line) {
					LineTool(_activeTool).lineWidth = e.value;
				} else if(_activeTool == _shape) {
					ShapeTool(_activeTool).strokeWidth = e.value;
				}
				
			} else if(e.currentTarget == slider_2_mc) {
				
				if(_activeTool == _brush) {
					
					_fillAlpha = e.value;
					BrushTool(_activeTool).alpha = e.value;
					
				} else if(_activeTool == _line) {
					_strokeAlpha = e.value;
					LineTool(_activeTool).alpha = e.value;
				} else if(_activeTool == _shape) {
					_strokeAlpha = e.value;
					ShapeTool(_activeTool).strokeAlpha = e.value;
				}
				
			} else if(e.currentTarget == slider_3_mc) {
				
				if(_activeTool == _brush) {
					
					_brushBlur = e.value;
					BrushTool(_activeTool).blur = e.value;
					
				} else if(_activeTool == _shape) {
					_fillAlpha = e.value;
					ShapeTool(_activeTool).fillAlpha = e.value;
				}
				
			}
			
			
		}
		
		/**************************************************************************
			Method	: toolHandler()
			
			Purpose	: This method will handle switching between brush and eraser
					  tools.  The two tool buttons call this method on click.
			
			Params	: e -- Mouse Event object.
		***************************************************************************/
		private function toolHandler(e:MouseEvent):void {
			
			// deselect all button to start
			brush_tool_mc.selected = false;
			eraser_tool_mc.selected = false;
			line_tool_mc.selected = false;
			rectangle_tool_mc.selected = false;
			oval_tool_mc.selected = false;
			
			// show combo box
			combo_label_txt.visible = true;
			combo_list.visible = true;
			combo_list.x = _orginalComboBoxItemsPos.comboBox.x;
			combo_list.y = _orginalComboBoxItemsPos.comboBox.y;
			
			combo_label_txt.x = _orginalComboBoxItemsPos.comboBoxLabel.x;
			combo_label_txt.y = _orginalComboBoxItemsPos.comboBoxLabel.y;
			
			// alpha
			slider_2_label_txt.alpha = 1;
			
			// brush tool selected
			if(e.currentTarget == brush_tool_mc) {
				
				// set selected tool state
				brush_tool_mc.selected = true;
				
				// config color pickers
				fill_color_mc.enabled = true;
				stroke_color_mc.enabled = false;
				
				// set brush shape list
				combo_label_txt.text = "Brush Shapes";
				combo_list.dataProvider = _brushShapes;
				combo_list.selectedIndex = _brushShapeIndex;
				
				// config and set brush tool as active tool
				_brush.color = _fillColor;
				_brush.alpha = _fillAlpha;
				_brush.blur = _brushBlur;
				_brush.size = _brushSize;
				_brush.type = combo_list.selectedItem.data;
				_activeTool = _brush;
				canvas.activeTool = _activeTool;
				
				// update slider
				slider_label_txt.text = "Brush Size";
				slider_mc.value = BrushTool(_activeTool).size;
				
				slider_2_label_txt.text = "Brush Alpha";
				slider_2_label_txt.alpha = 1;
				slider_2_mc.enabled = true;
				slider_2_mc.snapInterval = .1;
				slider_2_mc.value = BrushTool(_activeTool).alpha;
				
				slider_3_label_txt.text = "Brush Blur";
				slider_3_label_txt.visible = true;
				slider_3_label_txt.alpha = 1;
				slider_3_mc.visible = true;
				slider_3_mc.snapInterval = 1;
				slider_3_mc.enabled = true;
				slider_3_mc.minimum = 0;
				slider_3_mc.maximum = 20;
				slider_3_mc.value = BrushTool(_activeTool).blur;
				
			// eraser tool selected
			} else if(e.currentTarget == eraser_tool_mc) {
				
				// set selected tool state
				eraser_tool_mc.selected = true;
			
				// config color picker
				fill_color_mc.enabled = false;
				stroke_color_mc.enabled = false;
				
				// set brush shape list
				combo_label_txt.text = "Brush Shapes";
				combo_list.dataProvider = _brushShapes;
				combo_list.selectedIndex = _brushShapeIndex;
				
				// config and set eraser tool as active tool
				_eraser.color = _fillColor;
				_brush.alpha = 1;
				_brush.blur = _brushBlur;
				_eraser.size = _brushSize;
				_eraser.type = combo_list.selectedItem.data;
				_activeTool = _eraser;
				canvas.activeTool = _activeTool;
				
				// update slider
				slider_label_txt.text = "Brush Size";
				slider_mc.value = BrushTool(_activeTool).size;
				
				slider_2_label_txt.text = "Brush Alpha";
				slider_2_label_txt.alpha = .5;
				slider_2_mc.enabled = false;
				slider_2_mc.snapInterval = .1;
				slider_2_mc.value = BrushTool(_activeTool).alpha;
				
				slider_3_label_txt.text = "Brush Blur";
				slider_3_label_txt.visible = true;
				slider_3_label_txt.alpha = .5;
				slider_3_mc.visible = true;
				slider_3_mc.minimum = 0;
				slider_3_mc.maximum = 20;
				slider_3_mc.enabled = false;
				slider_3_mc.value = BrushTool(_activeTool).blur;
			
			// line tool
			} else if(e.currentTarget == line_tool_mc) {
				
				// set selected tool state
				line_tool_mc.selected = true;
				
				// config color picker
				fill_color_mc.enabled = false;
				stroke_color_mc.enabled = true;
				
				// set line style list
				combo_label_txt.text = "Line Style";
				combo_list.dataProvider = _lineStyles;
				combo_list.selectedIndex = _lineStyleIndex;
				
				combo_label_txt.x = slider_3_label_txt.x + 8;
				combo_list.x = slider_3_mc.x;
				
				// config and set line tool as active tool
				_line.color = _strokeColor;
				_line.alpha = _strokeAlpha;
				_line.type = combo_list.selectedItem.data;
				_activeTool = _line;
				canvas.activeTool = _activeTool;
				
				// update slider
				slider_label_txt.text = "Stroke Size";
				slider_mc.value = LineTool(_activeTool).lineWidth;
				
				slider_2_label_txt.text = "Line Alpha";
				slider_2_mc.enabled = true;
				slider_2_mc.snapInterval = .1;
				slider_2_mc.value = LineTool(_activeTool).alpha;
				
				slider_3_label_txt.visible = false;
				slider_3_mc.visible = false;
				
			// rectangle tool
			} else if(e.currentTarget == rectangle_tool_mc) {
				
				// set selected tool state
				rectangle_tool_mc.selected = true;
				
				// config color picker
				fill_color_mc.enabled = true;
				stroke_color_mc.enabled = true;
				
				// config and set shape tool as active tool
				_shape.strokeColor = _strokeColor;
				_shape.fillColor = _fillColor;
				_shape.strokeAlpha = _strokeAlpha;
				_shape.fillAlpha = _fillAlpha;
				_activeTool = _shape;
				_activeTool.type = ShapeType.RECTANGLE;
				canvas.activeTool = _activeTool;
				
				// set slide value
				slider_label_txt.text = "Stroke Size";
				slider_mc.value = ShapeTool(_activeTool).strokeWidth;
				
				slider_2_label_txt.text = "Stroke Alpha";
				slider_2_label_txt.alpha = 1;
				slider_2_mc.enabled = true;
				slider_2_mc.snapInterval = .1;
				slider_2_mc.value = ShapeTool(_activeTool).strokeAlpha;
				
				slider_3_label_txt.text = "Fill Alpha";
				slider_3_label_txt.visible = true;
				slider_3_label_txt.alpha = 1;
				slider_3_mc.visible = true;
				slider_3_mc.enabled = true;
				slider_3_mc.minimum = 0;
				slider_3_mc.maximum = 1;
				slider_3_mc.snapInterval = .1;
				slider_3_mc.value = ShapeTool(_activeTool).fillAlpha;
				
				// hide combo box
				combo_label_txt.visible = false;
				combo_list.visible = false;
			
			// oval tool
			} else if(e.currentTarget == oval_tool_mc) {
				
				// set selected tool state
				oval_tool_mc.selected = true;
				
				// config and set shape tool as active tool
				_shape.strokeColor = _strokeColor;
				_shape.fillColor = _fillColor;
				_shape.strokeAlpha = _strokeAlpha;
				_shape.fillAlpha = _fillAlpha;
				_activeTool = _shape;
				_activeTool.type = ShapeType.OVAL;
				canvas.activeTool = _activeTool;
				
				// config color picker
				fill_color_mc.enabled = true;
				stroke_color_mc.enabled = true;
				
				// update slider
				slider_label_txt.text = "Stroke Size";
				slider_mc.value = ShapeTool(_activeTool).strokeWidth;
				
				slider_2_label_txt.text = "Stroke Alpha";
				slider_2_label_txt.alpha = 1;
				slider_2_mc.enabled = true;
				slider_2_mc.snapInterval = .1;
				slider_2_mc.value = ShapeTool(_activeTool).strokeAlpha;
				
				slider_3_label_txt.text = "Fill Alpha";
				slider_3_label_txt.visible = true;
				slider_3_label_txt.alpha = 1;
				slider_3_mc.visible = true;
				slider_3_mc.enabled = true;
				slider_3_mc.minimum = 0;
				slider_3_mc.maximum = 1;
				slider_3_mc.snapInterval = .1;
				slider_3_mc.value = ShapeTool(_activeTool).fillAlpha;
				
				// hide combo box
				combo_label_txt.visible = false;
				combo_list.visible = false;
				
			}
			
		}
		
		/**************************************************************************
			Method	: comboEventHandler()
			
			Purpose	: This method will handle the button events for the different
					  Combo box in the UI.
			
			Params	: e -- Mouse Event object.
		***************************************************************************/
		private function comboEventHandler(e:Event):void {
			
			if(_activeTool == _brush || _activeTool == _eraser) {
				
				// store brush shape index
				_brushShapeIndex = ComboBox(e.currentTarget).selectedIndex;
				setSelectedBrushShape(ComboBox(e.currentTarget).selectedItem.data);
			
			} else if(_activeTool == _line) {
				
				// store line style index
				_lineStyleIndex = ComboBox(e.currentTarget).selectedIndex;
				setSelectedLineStyle(ComboBox(e.currentTarget).selectedItem.data);
			
			}
			
		}
		
		/**************************************************************************
			Method	: setSelectedBrushShape()
			
			Purpose	: This method will update the active brush with a new brush
					  type.
			
			Params	: localType -- Type of Brush.
		***************************************************************************/
		private function setSelectedLineStyle(localType:String):void {
			
			// update the Brush object if different type
			if(_activeTool.type != localType) {
				_activeTool.type = localType;
			}
			
		}
		
		
		/**************************************************************************
			Method	: setSelectedBrushShape()
			
			Purpose	: This method will update the active brush with a new brush
					  type.
			
			Params	: localType -- Type of Brush.
		***************************************************************************/
		private function setSelectedBrushShape(localType:String):void {
			
			// update the Brush object if different type
			if(_activeTool.type != localType) {
				_activeTool.type = localType;
			}
			
		}
		
		/**************************************************************************
			Method	: scrollHandler()
			
			Purpose	: This method handles the event from the mouse scroll wheel.
			
			Params	: e -- MouseEvent object
		***************************************************************************/
		public function scrollHandler(e:MouseEvent):void {
			
			// calculate and set zoom of canvas
			canvas.zoom += (e.delta/3) * 1;
			
			// sync slider to new zoom value.
			zoom_slider_mc.value = canvas.zoom;
			
			// if canvas is zoomed in then display message about dragging canvas around.
			if(canvas.zoom  > 1) {
				click_message_txt.alpha = 1;
			} else {
				click_message_txt.alpha = 0;
			}
			
		}
	
		/**************************************************************************
			Method	: keyHandler()
			
			Purpose	: This method handle the keyboard shortcut to drag allow
					  the user to drag the canvas with their mouse.
			
			Params	: e -- KeyboardEvent object
		***************************************************************************/
		public function keyHandler(e:KeyboardEvent):void {
			
			if(e.keyCode == Keyboard.SPACE) {
				
				if(e.type == KeyboardEvent.KEY_UP) {
					canvas.mouseDrag = false;
				} else if(e.type == KeyboardEvent.KEY_DOWN) {
					canvas.mouseDrag = true;
				}
				
			} 
			
		}
	
		
	}
	
	
		
}