/*
*  	Graffiti 1.2.2
*  	______________________________________________________________________
*  	www.nocircleno.com/graffiti/
*/

/*
* 	THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
* 	EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES
* 	OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
* 	NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT
* 	HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY,
* 	WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
* 	FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
* 	OTHER DEALINGS IN THE SOFTWARE.
*/

package com.nocircleno.graffiti.tools {
	
	import flash.display.DisplayObject;
	import flash.geom.Point;
	
	/**
	* The ITool interface will be implemented by the BrushTool, LineTool and ShapeTool Classes.
	*
	* @langversion 3.0
    * @playerversion Flash 10 AIR 1.5 
	*/
	public interface ITool {
		
		/**
		* The <code>apply</code> method must be implemented by the sub Class.
		* 
		* @param drawingTarget Sprite object to draw to.
		* @param point1 First Point of Drawing interaction.
		* @param point2 Second Point of Drawing interaction.
		* 
		*/
		function apply(drawingTarget:DisplayObject, point1:Point, point2:Point = null):void;
		
		/**
		* The <code>resetTool</code> method must be implemented by the sub Class.  
		*/
		function resetTool():void;
		
		/**
		* Tools Render Mode
		*/
		function get renderType():String;
		
		/**
		* Tools Drawing Mode
		*/
		function set mode(toolMode:String):void;
		function get mode():String;
		
		/**
		* Type of Tool
		*/
		function set type(toolType:String):void;
		function get type():String;
		
	}
	
}