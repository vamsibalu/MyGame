package bala.Utils
{
	import Box2D.Common.Math.b2Vec2;
	import Box2D.Dynamics.b2Body;
	
	import bala.BaseWorld;
	
	import caurina.transitions.Tweener;
	
	import com.Game;
	import com.greensock.TweenLite;
	
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.IEventDispatcher;
	
	public class TweenBox2d extends Sprite
	{
		private var game:Game;
		public static var popup1:MovieClip;
		public function TweenBox2d(_game:Game)
		{
			//pls work on this..
			/*game = _game;
			tweenObjj = new TempVals();
			
			popup1 = new popupMC1()
			popup1.y = 30;*/
		}
		
		
		public var tweenObjj:TempVals;
		public var effectsAreExists:Boolean = false;
		public function addExtraEffectsIfAny():void{
			removeEventListener(Event.ENTER_FRAME,runAnimations);
			effectsAreExists = false;
			tweenObjj.ef30 = false;
			tweenObjj.ef29 = false;
			BalaUtils.me.remove(popup1);
			switch(Game.currentLevel)
			{
				case 6:
					game.addChild(popup1);
					break;
				case 16:
					game.wallT.SetPosition(new b2Vec2(game.wallT.GetPosition().x,-100/BaseWorld.ptm_ratio));
					break;
				case 28:
					game.wallT.SetPosition(new b2Vec2(game.wallT.GetPosition().x,-100/BaseWorld.ptm_ratio));
					break;
				case 29:
					temprotvall = 45;
					tweenObjj.tempxyvall_1 = 6;
					tweenObjj.rotationval = 0;
					tweenObjj.rotb1 = game.getBodyByID("ID_34");
					addTweenForRot();
					tweenObjj.moveb1 = game.getBodyByID("ID_21");
					tweenObjj.xx1 = tweenObjj.moveb1.GetPosition().x;
					trace("tweenObjj.xx1=",tweenObjj.xx1)
					addTweenForMoveXY(tweenObjj.xx1 + tweenObjj.tempxyvall_1,1);
					tweenObjj.ef29 = true;
					trace("29");
					effectsAreExists = true;
					break;
				case 30:
					game.wallT.SetPosition(new b2Vec2(game.wallT.GetPosition().x,-300/BaseWorld.ptm_ratio));
					game.wallR.SetPosition(new b2Vec2(game.wallT.GetPosition().x+10,game.wallT.GetPosition().y));
					tweenObjj.tempxyvall_1 = 7;
					tweenObjj.tempxyvall_2 = 7;
					tweenObjj.moveb1 = game.getBodyByID("ID_17");
					tweenObjj.moveb2 = game.getBodyByID("ID_14");
					
					tweenObjj.xx1 = tweenObjj.moveb1.GetPosition().x;
					tweenObjj.xx2 = tweenObjj.moveb2.GetPosition().x;
					
					addTweenForMoveXY(tweenObjj.xx1 + tweenObjj.tempxyvall_1,1);
					addTweenForMoveXY(tweenObjj.xx2 + tweenObjj.tempxyvall_2,2);
					tweenObjj.ef30 = true;
					trace("29");
					effectsAreExists = true;
					break;
			}
			
			if(effectsAreExists == true){
				addEventListener(Event.ENTER_FRAME,runAnimations);
			}
		}
		
		//for angle...
		private var temprotvall:Number = 0;
		private function addTweenForRot():void{
			Tweener.addTween(tweenObjj,{time:2,delay:1,rotationval:temprotvall, onComplete:compltForRot});
		}
		
		public function compltForRot():void{
			temprotvall = temprotvall * -1;
			addTweenForRot();
		}
		
		
		//for movement..
		private function addTweenForMoveXY(xxd:Number,nm:int):void{
			if(nm == 1){
				Tweener.addTween(tweenObjj,{time:9,xx1:xxd,delay:1,onComplete:compltForMoveXY,onCompleteParams:[nm]});
			}else if(nm == 2){
				Tweener.addTween(tweenObjj,{time:9,xx2:xxd,delay:1,onComplete:compltForMoveXY,onCompleteParams:[nm]});
			}else if(nm == 3){
				Tweener.addTween(tweenObjj,{time:9,xx3:xxd,delay:1,onComplete:compltForMoveXY,onCompleteParams:[nm]});
			}
		}
		
		public function compltForMoveXY(nm:int):void{
			tweenObjj["tempxyvall_"+nm] = tweenObjj["tempxyvall_"+nm] * -1;
			addTweenForMoveXY(tweenObjj["xx"+nm]+tweenObjj["tempxyvall_"+nm],nm);
		}
		
		
		
		public function tweenableObjectsRotation(targetB:b2Body,valNm:Number):void{
			if(targetB){
				targetB.SetAngle(BalaUtils.toRadians(valNm));
			}
		}
		
		public function tweenableObjectsMove(targetB:b2Body,valNm:b2Vec2):void{
			if(targetB){
				//trace("moving 29",valNm.x)
				targetB.SetPosition(valNm);
			}
		}
		
		
		private function runAnimations(e:Event):void{
			if(tweenObjj.ef29 == true){
				tweenableObjectsRotation(tweenObjj.rotb1,tweenObjj.rotationval);
				tweenableObjectsMove(tweenObjj.moveb1,new b2Vec2(tweenObjj.xx1,b2Body(tweenObjj.moveb1).GetPosition().y));
			}
			
			if(tweenObjj.ef30 == true){
				tweenableObjectsMove(tweenObjj.moveb1,new b2Vec2(tweenObjj.xx1,b2Body(tweenObjj.moveb1).GetPosition().y));
				tweenableObjectsMove(tweenObjj.moveb2,new b2Vec2(tweenObjj.xx2,b2Body(tweenObjj.moveb2).GetPosition().y));
			}
		}
	}
}
import Box2D.Dynamics.b2Body;

class TempVals{
	
	public var rotationval:Number;
	public var xx1:Number = 0;
	public var xx2:Number = 0;
	
	
	public var tempxyvall_1:Number = 0;
	public var tempxyvall_2:Number = 0;
	public var tempxyvall_3:Number = 0;
	public var tempxyvall_4:Number = 0;
	public var tempxyvall_5:Number = 0;
	
	public var rotb1:b2Body;
	public var rotb2:b2Body;
	public var rotb3:b2Body;
	public var rotb4:b2Body;
	public var rotb5:b2Body;
	
	public var moveb1:b2Body;
	public var moveb2:b2Body;
	public var moveb3:b2Body;
	public var moveb4:b2Body;
	public var moveb5:b2Body;
	
	
	public var ef29:Boolean;
	public var ef30:Boolean;
}