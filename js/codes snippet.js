// ----------------------------------------------------------------------------
// HasClassName
//
// Description : returns boolean indicating whether the object has the class name
//    built with the understanding that there may be multiple classes
//
// Arguments:
//    objElement              - element to manipulate
//    strClass                - class name to add
//
function HasClassName(objElement, strClass)
{
	// if there is a class
	if ( objElement.className )
	{
		// the classes are just a space separated list, so first get the list
		var arrList = objElement.className.split(' ');
		
		// get uppercase class for comparison purposes
		var strClassUpper = strClass.toUpperCase();
		
		// find all instances and remove them
		for ( var i = 0; i < arrList.length; i++ )
		{
		// if class found
			if ( arrList[i].toUpperCase() == strClassUpper )
			{
			// we found it
			return true;
			
			}
		}
	}
	// if we got here then the class name is not there
	return false;
}
