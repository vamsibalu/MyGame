package com
{
	import Box2D.Dynamics.b2World;
	
	import bala.Utils.BalaUtils;
	
	import flash.events.Event;
	
	public class OponentBike extends BikeBox2d
	{
		public function OponentBike(_passWorld:b2World)
		{
			super(_passWorld);
		}
		
		public override function updateBike(e:Event=null):void{
			randomCompPlay();
			super.updateBike();
		}
		
		private function randomCompPlay():void{
			//trace("Oponent Speed=",player_body.GetLinearVelocity().x.toFixed(1))
			if(Math.random()<=.8){
				if(player_body.GetLinearVelocity().x<BalaUtils.randomIntegerWithinRange(12,20)){
					up_key = true;
				}else{
					up_key = false;
				}
			}
		}
	}
}