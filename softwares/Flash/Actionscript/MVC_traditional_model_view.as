package com
{
	import flash.display.Sprite;

	/**
	 * @author qngo
	 */
	public class ${var}View extends Sprite 
	{
private var model : ${var}Model;
private var controller : ${var}Controller;

public function ${var}View(m : ${var}Model, c : ${var}Controller)
{
	model = m;
	model.addEventListener(${var}Model.MODEL_CHANGE, onModelChange);
	
	controller = c;
}

private function onModelChange(event : Event) : void 
{
	${cursor}
}
	}
}
