package com
{
	import Box2D.Dynamics.b2World;
	
	import flash.events.Event;
	import flash.events.KeyboardEvent;
	import flash.ui.Keyboard;
	
	public class HeroBike extends BikeBox2d
	{
		public static const FUELKHATAM:String = "nofuel";
		public function HeroBike(_passWorld:b2World)
		{
			super(_passWorld);
		}
		
		public override function bikeDestroy(moreEffect:Boolean=false, bikeAlso:Boolean=false):void{
			super.bikeDestroy(moreEffect,bikeAlso);
		}
		
		
		public function keyDown(e:KeyboardEvent):void {
			switch (e.keyCode) {
				case Keyboard.LEFT :
					left=true;
					break;
				case Keyboard.RIGHT :
					right=true;
					break;
				case Keyboard.UP :
					up_key=true;
					break;
				case Keyboard.DOWN :
					down_key=true;
					break;
				//WasD
				case Keyboard.A :
					left=true;
					break;
				case Keyboard.D :
					right=true;
					break;
				case Keyboard.W :
					up_key=true;
					break;
				case Keyboard.S :
					down_key=true;
					break;
			}
		}
		public function keyUp(e:KeyboardEvent):void {
			switch (e.keyCode) {
				case Keyboard.LEFT :
					left=false;
					trace("left")
					break;
				case Keyboard.RIGHT :
					right=false;
					break;
				case Keyboard.UP :
					up_key=false;
					break;
				case Keyboard.DOWN :
					down_key=false;
					break;
				case Keyboard.NUMBER_1 :
					Game.currentWeponType = Game.Javelin;
					break;
				case Keyboard.NUMBER_2 :
					Game.currentWeponType = Game.GUN;
					break;
				
				//WasD
				case Keyboard.A :
					left=false;
					break;
				case Keyboard.D :
					right=false;
					break;
				case Keyboard.W :
					up_key=false;
					break;
				case Keyboard.S :
					down_key=false;
					break;
			}
		}
		public var selftControlble:Boolean = true;
		public override function updateBike(e:Event=null):void{
			
			if (selftControlble == true)
			{
				if (player_body.GetAngle() < -.3)
				{
					//trace("right pressed.",player_body.GetAngle().toFixed(1),player_body.GetAngularVelocity().toFixed(1))
					right = true;
				}
				else
				{
					//trace("danger..2",player_body.GetAngularVelocity().toFixed(1))
					right = false;
				}
				
				if (player_body.GetAngle() > .3)
				{
					///trace("leftPressed",player_body.GetAngle().toFixed(1),player_body.GetAngularVelocity().toFixed(1))
					left = true;
				}
				else
				{
					//trace("danger..2",player_body.GetAngularVelocity().toFixed(1))
					left = false;
				}
			}
			
			super.updateBike();
		}
		
		//chary needs work on it....
		
		/*public function updateWithGarageData(_vo:Car):void{
			if(_vo.enging == Carvo.en1){
				changeBikeSpeed(1
			}
		}*/
	}
}