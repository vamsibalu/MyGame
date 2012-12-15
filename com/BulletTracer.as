package com
{
	import Box2D.Dynamics.b2Body;
	
	import bala.BaseWorld;
	
	import com.greensock.TweenLite;
	
	import flash.display.DisplayObject;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.TimerEvent;
	import flash.utils.Timer;
	
	public class BulletTracer extends Sprite
	{
		public static var allBTracers:Vector.<BulletTracer> = new Vector.<BulletTracer>();
		private var bb:b2Body;
		var timer:Timer = new Timer(0.001);
		private var origX:Number = 0;
		private var origY:Number = 0;
		private var traceClip:MovieClip;
		public function BulletTracer(bulletBody:b2Body)
		{
			bb = bulletBody;
			traceClip = new BTMC();
			bb.GetUserData().canTrace = true;
			addChild(traceClip);
			bb.GetUserData().myEffect = this;
			allBTracers.push(this);
			origX = bulletBody.GetPosition().x * BaseWorld.ptm_ratio;
			origY = bulletBody.GetPosition().y * BaseWorld.ptm_ratio;
			
			traceClip.x = bb.GetUserData().x;
			traceClip.y = bb.GetUserData().y;
			removeSlow(traceClip,4,.5);
		}
		
		private var blife:int = 0;
		public function reCreate():void{
			origX = traceClip.x;
			origY = traceClip.y;
			blife++;
			
			trace("bullet life")
			if(blife == 4){
				Game.me.bulletXX = bb;
			}
		}
		
		private function removeSlow(obj:DisplayObject,time:Number,_delay:Number):void{
			obj.alpha = 1;
			TweenLite.to(obj,time,{alpha:0,delay:_delay,onComplete:compltForRemove,onCompleteParams:[obj]});
		}
		
		private function compltForRemove(_obj:DisplayObject):void{
			if(_obj && _obj.parent){
				_obj.parent.removeChild(_obj);
				_obj = null;
			}
		}
		
		
		public function traceMe():void{
			if(bb.GetUserData().canTrace == true){
				traceClip.x = bb.GetUserData().x;
				traceClip.y = bb.GetUserData().y;
				
				traceClip.rotation = 0;
				traceClip.width = Math.sqrt((origX - bb.GetUserData().x) * (origX - bb.GetUserData().x) + (origY - bb.GetUserData().y) * (origY - bb.GetUserData().y));
				traceClip.rotation = 180 + Math.atan2(origY - bb.GetUserData().y,origX - bb.GetUserData().x) * (180 / Math.PI);
			}else{
				compltForRemove(traceClip);
				compltForRemove(this);
				allBTracers.splice(allBTracers.indexOf(this),1);
			}
		}
		
	}
}