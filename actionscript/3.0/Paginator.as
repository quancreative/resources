package com.utils{
	
	import flash.display.*;
	import flash.geom.*;
	import flash.text.*;
	import flash.events.*;
	
	public class Paginator extends Sprite{
		
		private var xmlList:XMLList;
		
		private var itemArray:Array;
		private var itemIndex:int = 0;
		private var totalItem:uint;				
		private var maxWidth:uint;		
		private var padding:uint = 1;
		private var xPos:uint = 0;
				
		private var holder:Sprite = new Sprite();
		private var prev:Item = new Item('<');	
		private var next:Item = new Item('>');
		private var current:Item;
		
		private var tempArray:Array = new Array();
		
		//var lowLimit:int = 0;
		private var limit:uint = 10;
		
		public function Paginator(list:XMLList = null, mWidth:uint = 0){
			xmlList = list;
			maxWidth = mWidth;			
			totalItem = xmlList.length();
						
			xPos += prev.width + padding;
			//var numOfTime:int = totalItem / 10;
			
			/*for (var i:int = 0; i < numOfTime; i ++){
				var a:int;
				var b:int;
				var c:int;
				
				if (numOfTime <= 1){
					a = (10 / numOfTime);
					b = a * i;
					c = b + a -1;
				} else if(numOfTime > 1){
					a = (lowLimit + 10);
					b = a * i;
					c = b + a -1;
				}
			}*/
			

			itemArray = new Array();
			for (var i:uint = 0; i < limit; i++){
								
				var myItem:Item= new Item(i + 1);
				myItem.x = xPos;
				
				itemArray.push(myItem);				
				xPos += myItem.width + padding;
				
				holder.addChild(myItem);				
			}
			
			//paginate(itemArray,holder,10 )
			prev.greyOut();
			next.x = xPos;
			updateCurrentItem();
			
			addChild(prev);
			addChild(next);
			//holder.x = int((maxWidth - holder.width) * .5);
			
			addChild(holder);	
			
			addEventListener('ITEM_PICK', itemPicked);			
		}
		
		public function get index():int{
			return itemIndex;
		}
		
		public function set index(val:int):void{
			itemIndex = val;
			
			checkIndex();
		}
		
		private function checkIndex():void{
			/**
			 * reset 
			 */
			prev.greyOut(false);
			next.greyOut(false);

			
			if (itemIndex > 5 && itemIndex < (totalItem - 5)){
				
				for (var i:uint = 0; i < itemArray.length; i++){
				
					var myItem:Item = itemArray[i];
					holder.removeChild(myItem);
				}
				
				xPos = prev.width + padding;
				var min:uint = itemIndex - 4;
				var max:uint = min + 10;
				itemArray = new Array();
				
				for (var j:uint = min; j < max; j ++){					
					var myNewItem:Item= new Item(j + 1);
					myNewItem.x = xPos;
					
					itemArray.push(myNewItem);				
					xPos += myNewItem.width + padding;
					
					holder.addChild(myNewItem);
				}
			}
			
			
			if (itemIndex >= totalItem - 1){
				next.greyOut();
			} else if (itemIndex <= 0){
				prev.greyOut();
			}
			
			updateCurrentItem();
		}
				
		private function itemPicked(event:Event):void{			
				
			if (typeof(event.target.info) == 'number'){
				itemIndex = event.target.info - 1;							
			} else if (typeof(event.target.info == 'string')){
				if (event.target.info == '<'){
					itemIndex --;
				} else{
					itemIndex ++;
				}
			}
			
			checkIndex();
			
			var myEvent:Event = new Event ('VIDEO_PICK', true, true);
			//dispatchEvent (myEvent);
		}
		
		private function updateCurrentItem():void{
			if (current){
				current.greyOut(false);
			}

			//current = itemArray[itemIndex];
			//current.greyOut();
		}		
	}
}