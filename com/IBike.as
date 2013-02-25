package com
{
	import flash.events.Event;
	import flash.events.KeyboardEvent;

	public interface IBike
	{
		function create(_xx:Number,_yy:Number):void
		function keyUp(e:KeyboardEvent):void
		function bikeDestroy(moreEffect:Boolean = false,bikeAlso:Boolean = false):void
		function updateBike(e:Event=null):void
	}
}