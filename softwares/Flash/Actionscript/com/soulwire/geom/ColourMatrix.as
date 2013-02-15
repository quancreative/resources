/**
 *	@author  >> Justin Windle
 *	Based on the great Mario Klingemann's ColorMatrix class
 *
 *	@link	 >> soulwire.co.uk
 *	@version >> V1
 */

package com.soulwire.geom 
{

	public class ColourMatrix 
	{
		
		/*
		========================================================
		| Private Variables                         | Data Type  
		========================================================
		*/
		
		protected const LUMINANCE_R:				Number = 0.212671;
		protected const LUMINANCE_G:				Number = 0.715160;
		protected const LUMINANCE_B:				Number = 0.072169;
		protected const IDENTITY:					Array  = [1, 0, 0, 0, 0,
															  0, 1, 0, 0, 0,
															  0, 0, 1, 0, 0,
														  	  0, 0, 0, 1, 0];
											  
		protected var _matrix:						Array;
		protected var _hue:							Number;
		protected var _saturation:					Number;
		protected var _brightness:					Number;
		protected var _contrast:					Number;
		protected var _alpha:						Number;
		
		/*
		========================================================
		| Constructor
		========================================================
		*/
		
		public function ColourMatrix( matrix:Array = null ) 
		{
			init(matrix == null ? IDENTITY.concat() : matrix.concat());
		}
		
		/*
		========================================================
		| Private Methods
		========================================================
		*/
		
		protected function init( matrix:Array ):void
		{
			_matrix = matrix;
			setDefaultValues();
		}

		protected function setDefaultValues():void
		{
			_alpha      = 100;
			_brightness = 0;
			_contrast   = 0;
			_hue        = 0;
			_saturation = 0;
		}

		protected function multiply(matrix:Array):void
		{
			var aBuffer:Array = new Array();
			var n:int = 0;
			
			for(var i:int = 0; i < 4; i++)
			{
				for(var j:int = 0; j < 5; j++)
				{
					aBuffer[n + j] = matrix[n] 	   * _matrix[j] 	 + 
									 matrix[n + 1] * _matrix[j + 5]  + 
									 matrix[n + 2] * _matrix[j + 10] + 
									 matrix[n + 3] * _matrix[j + 15] + 
									 (j == 4 ? matrix[n + 4] : 0);
				}
				n += 5;
			}
			_matrix = aBuffer.concat();
		}
		
		/*
		========================================================
		| Public Methods
		========================================================
		*/
		
		public function getMatrix():Array
		{
			return _matrix.concat();
		}

		public function clone():ColourMatrix
		{
			return new ColourMatrix( getMatrix() );
		}
		
		public function reset():void
		{
			init( IDENTITY.concat() );
		}
		
		/*
		========================================================
		| Getters + Setters
		========================================================
		*/
		
		/* ALPHA */
		
		public function get alpha():Number { return _alpha; }
		
		/**
		 * Sets the alpha.
		 * @param	alpha	A value between 0 and 100 (0 being 0% alpha, 100 being 100% alpha).
		 */
		
		public function set alpha( a:Number ):void
		{
			var old:Number = _alpha / 100;
			
			_alpha = a;
			a /= 100;
			a /= old;
			
			var matrix:Array = [1, 0, 0, 0, 0,
								0, 1, 0, 0, 0,
								0, 0, 1, 0, 0,
								0, 0, 0, a, 0];
			
			multiply(matrix);
		}
		
		/* BRIGHTNESS */
		
		public function get brightness():Number { return _brightness; }
		
		/**
		 * Sets the brightness.
		 * @param	brightness		A value between -100 and 100 (0 being 'no changes').
		 */
		
		public function set brightness( b:Number ):void
		{
			var old:Number = _brightness * (255 / 100);
			
			_brightness = b;
			b *= (255 / 100);
			b -= old;
			
			var matrix:Array = [1, 0, 0, 0, b,
								0, 1, 0, 0, b,
								0, 0, 1, 0, b,
								0, 0, 0, 1, 0];
			multiply(matrix);
		}
		
		/* CONTRAST */
		
		public function get contrast():Number { return _contrast; }
		
		/**
		 * Sets the contrast.
		 * @param	contrast	A value between -100 and 100 (0 being 'no changes').
		 */
		
		public function set contrast( c:Number ):void
		{
			var old:Number = _contrast / 100 + 1;
			
			_contrast = c;
			c = c / 100 + 1;
			c /= old;
			
			var matrix:Array = [c, 0, 0, 0, 128 * (1 - c),
								0, c, 0, 0, 128 * (1 - c),
								0, 0, c, 0, 128 * (1 - c),
								0, 0, 0, 1, 0 ];
			multiply(matrix);
		}
		
		/* HUE */
		
		public function get hue():Number { return _hue; }
		
		/**
		 * Sets the hue.
		 * @param	angle	A value between -180 and 180 (0 being 'no changes').
		 */
		
		public function set hue( a:Number ):void
		{
			var old:Number = _hue * (Math.PI / 180);
			
			_hue = a;
			a *= Math.PI / 180;
			a -= old;
			
			var c:Number = Math.cos(a);
			var s:Number = Math.sin(a);
			var matrix:Array = [(LUMINANCE_R + (c * (1 - LUMINANCE_R))) + (s * (-LUMINANCE_R)),       (LUMINANCE_G + (c * (-LUMINANCE_G)))    + (s * (-LUMINANCE_G)), (LUMINANCE_B + (c * (-LUMINANCE_B)))    + (s * (1 - LUMINANCE_B)), 0, 0,
								(LUMINANCE_R + (c * (-LUMINANCE_R)))    + (s * 0.143),                (LUMINANCE_G + (c * (1 - LUMINANCE_G))) + (s * 0.14),           (LUMINANCE_B + (c * (-LUMINANCE_B)))    + (s * -0.283),            0, 0,
								(LUMINANCE_R + (c * (-LUMINANCE_R)))    + (s * (-(1 - LUMINANCE_R))), (LUMINANCE_G + (c * (-LUMINANCE_G)))    + (s * LUMINANCE_G),    (LUMINANCE_B + (c * (1 - LUMINANCE_B))) + (s * LUMINANCE_B),       0, 0,
								0,                                                                    0,                                                              0,                                                                 1, 0];
			multiply(matrix);
		}
		
		/* SATURATION */
		
		public function get saturation():Number { return _saturation; }
		
		/**
		 * Sets the saturation.
		 * @param	saturation		A value between -100 and 100 (0 being 'no changes').
		 */
		
		public function set saturation( s:Number ):void
		{
			var old:Number = (_saturation + 100) / 100;
			
			_saturation = Math.min(100, Math.max(-99.99, s));
			s = (_saturation + 100) / 100;
			s /= old;
			
			var r:Number  = (1 - s) * LUMINANCE_R;
			var g:Number  = (1 - s) * LUMINANCE_G;
			var b:Number  = (1 - s) * LUMINANCE_B;
			var matrix:Array = [r + s, g, b, 0, 0, 
								r, g + s, b, 0, 0,
								r, g, b + s, 0, 0,
								0, 0, 0, 1, 0];
		
			multiply(matrix);
		}
	}
	
}
