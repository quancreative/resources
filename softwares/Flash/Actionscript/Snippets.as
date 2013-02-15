package com
{
	import flash.display.Sprite;

	/**
	 * @author qngo
	 */
	public class Snippet extends Sprite 
	{
		// Embed Georgia using the default names. Will conflict with the SWC!!
        [Embed(source="/assets/fonts/georgia.ttf", advancedAntiAliasing="true", fontFamily="Georgia", 
            fontName="Georgia", fontWeight="normal", mimeType="application/x-font" )]
        private var GeorgiaFont:Class;
        public static const GEORGIA:String = "Georgia";
        
        // Embed Georgia using a unique fontFamily and fontName.
        [Embed(source="/assets/fonts/georgia.ttf", advancedAntiAliasing="true", fontFamily="MyGeorgia", 
            fontName="MyGeorgia", fontWeight="normal", mimeType="application/x-font" )]
        private var MyGeorgiaFont:Class;
        public static const MY_GEORGIA:String = "MyGeorgia";
        
        // Used for storing a reference to the default Georgia font.
        private var georgiaFormat:TextFormat;
        
        // Used for storing a reference to the uniquely defined Georgia font.
        private var myGeorgiaFormat:TextFormat;
        
        // Stores the selected TextFormat.
        private var currentFormat:TextFormat;
        
        // TextField used for the invisible text example
		
		//public function DropShadowFilter(distance:Num = 4.0, angle:Num = 45, color:uint = 0, alpha:Num = 1.0, blurX:Num = 4.0, blurY:Num = 4.0, strength:Num = 1.0, quality:int = 1, inner:Boolean = false, knockout:Boolean = false, hideObject:Boolean = false)
		private var defaultDropShadow:DropShadowFilter = new DropShadowFilter(3, 125, 0x000000, 0.6, 7, 7, 2, 3);
		private var overDropShadow:DropShadowFilter = new DropShadowFilter(6, 125, 0x000000, 0.6, 12, 12, 2, 6);
		
		private function createShape(sWidth : int, sHeight : int, sBkgdColor : uint) : Shape
		{
			bkgd.filters = [defaultDropShadow];
			
			TweenPlugin.activate([AutoAlphaPlugin]); //activation is permanent in the SWF, so this line only needs to be run once.

TweenLite.to(mc, 2, {autoAlpha:0}); 
			
			var matrix:Matrix = new Matrix(  );
			/*
			 * Gradient box width: the width (in pixels) to which the gradient will spread
			 * Gradient box height: the height (in pixels) to which the gradient will spread
			 * Gradient box rotation: the rotation (in radians) that will be applied to the gradient
			 * 		rotation = 0; 
			 * 		rotation = Math.PI/4; // 45°
			 * 		rotation = Math.PI/2; // 90°
			 * Horizontal translation: how far (in pixels) the gradient is shifted horizontally
			 * Vertical translation: how far (in pixels) the gradient is shifted vertically
			 * 
     		 */
     		 
			matrix.createGradientBox(100, 100, Math.PI / 2, 50, 50);
			var colors:Array = [0x0076a3, 0x005b7f];
			var alphas:Array = [1, 1];
			var ratios:Array = [0, 255];
			
			var shape:Shape = new Shape();
			shape.graphics.beginFill(sBkgdColor);
			shape.graphics.lineStyle();
			// comments out the line below if you don't want gradient
			shape.graphics.beginGradientFill(GradientType.LINEAR , colors, alphas, ratios, matrix, SpreadMethod.PAD);	
			shape.graphics.drawRect(0, 0, sWidth, sHeight);
			//shape.graphics.endFill();
			
			return shape;
		}
		
		private function formatText(txtField:TextField, txt:String):void
		{
			var myText:String = txt;
			
			var myTextField:TextField = txtField;
			//myTextField.width = 333;
			myTextField.condenseWhite = true;
			myTextField.selectable = false;
			myTextField.multiline = true;
			myTextField.wordWrap = true;
			//myTextField.background = true;
			myTextField.backgroundColor = 0xFF0000;
			myTextField.embedFonts = true;
			myTextField.autoSize = TextFieldAutoSize.LEFT;
			myTextField.antiAliasType = AntiAliasType.ADVANCED;
			myTextField.gridFitType = GridFitType.PIXEL;
			//myTextField.sharpness = 10;
			myTextField.width = front.width;
			myTextField.styleSheet = css;
			myTextField.htmlText = myText;
			
			//var font:Font = new CooperBlack();
		   
			var format:TextFormat = new TextFormat();
			//format.font = font.fontName;
			format.color = 0xFFFFFF;
			format.size = 16;
			format.align = "left";
	
			myTextField.setTextFormat(format);
		}
		
		private function formateTextField(textField : TextField, css : StyleSheet) : void
		{
			textField.condenseWhite = true;
			textField.autoSize = TextFieldAutoSize.LEFT;
			textField.wordWrap = true;
			textField.multiline = true;
			textField.embedFonts = true;
			textField.antiAliasType = AntiAliasType.ADVANCED;
			textField.styleSheet = css;
		}
		
		private function gotoURL(url : String) : void
		{
			try 
			{
				navigateToURL(new URLRequest(url));
			}
			catch (error : Error)
			{
				trace("!!! Error : navigateToURL error : " + url);
			}
		}
		
		private function columnizer(count:Number, columnNum:Number) : Boolean
		{
			return ((count + 1) % columnNum == 0) ? true : false;
		}
		
		private function removeAllChildren() : void
		{
			while(markerHolder.numChildren > 0)
			{
				markerHolder.removeChildAt(0);
			}
		}
		
		private function genQuestion() : void
		{
			var question1 : MovieClip = MovieClip(createAsset(mainAssets, "Question1"));
			question1.x = 38;
			question1.y = 10;
			
			questionHolder.addChild(question1);
			
			var list 	: Array = model.items;
			var xPos 	: int = 40;
			var yPos 	: int = 150;
			var margin 	: int = 10;
			var tDelay	: Number = .2;
			
			for (var i : int = 0; i < list.length; i++) 
			{
				var inputElement : InputElement = list[i];
				
				var checkbox : CheckBox = new CheckBox();
				checkbox.x = xPos;
				checkbox.y = yPos;
				checkbox.id = String(i);
				checkbox.label = inputElement.content;
				
				xPos += margin + checkbox.width;
				
 				if (i == 1 || i == 2)
 					multiChoice.addChoice(checkbox, true);
				else 
					multiChoice.addChoice(checkbox);
				
				questionHolder.addChild(checkbox);
				TweenLite.from(checkbox, .4, {alpha : 0, y : yPos + 100, ease:Quad.easeOut, delay : tDelay});
				tDelay += .1;
			}
			
			var alphaBtn : MultiBtnAlpha = MultiBtnAlpha(createAsset(mainAssets, "OnlyOne"));
			questionHolder.addChild(alphaBtn);
		}
		
		private function removeElement(obj : Object , anArray : Array) : Object
		{
//			var returnArray : Array;
			var foundObj : Object;
			var array	: Array = anArray;
			var length 	: int = array.length;
			for (var i : int = 0; i < length; i++)
			{
				if (array[i] == obj)
				{	
					foundObj = array[i];
					array.splice(i, 1);
					break;
				}
			}
			return foundObj;		
		}
		
		private function getAllEmbedFont() : void
		{
			var fontList:Array = Font.enumerateFonts();
			for( var i:int=0; i<fontList.length; i++ )
			{
			    trace( "font: " + fontList[ i ].fontName );
			}
		}
		
		public function gotoPage(pg : Object) : void
		{
			// check if it's a number or a string
			if (isNaN(Number(pg)))
			{								
				//trace(pg + " it's a string");
			}
			else
			{
				//trace(pg + " it's a number");
			}
			
			global.setCurrentPage(myPageId, _currentPageNum, pageXml);
			
			dispatchEvent(new Event(Event.CHANGE));
		}
		
		public function isOnline() : Boolean
		{
			var playerType:String = Capabilities.playerType;
			switch(playerType)
			{
			    case "ActiveX":
			        trace("I'm a IE ActiveX");
		        break;
		        
			    case "Desktop":
			        trace("I'm an Air app");
		        break;
		        
			    case "External":
			        trace("I run in an external flash player");
		        break;
		        
			    case "PlugIn":
			        trace("I run in a webpage in a non-IE browser");
		        break;
		        
			    case "StandAlone":
			        trace("I run in a standalone flash player");
		        break;
			}
		}
	}
}
