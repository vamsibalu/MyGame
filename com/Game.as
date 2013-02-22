package com
{
	import Box2D.Common.Math.b2Vec2;
	import Box2D.Dynamics.b2Body;
	import Box2D.Dynamics.b2World;
	
	import bala.BalaBaseGame;
	import bala.ShapeWorld;
	import bala.SoundM;
	import bala.Utils.BalaUtils;
	import bala.Utils.TweenBox2d;
	
	import com.greensock.TweenLite;
	import com.vo.PlatFormType;
	
	import flash.display.MovieClip;
	import flash.display.Shape;
	import flash.display.SimpleButton;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.geom.Point;
	import flash.utils.Timer;
	
	//import com.data.Bike;
	
	public class Game extends BalaBaseGame
	{
		public static var me:Game;
		
		public var textBoxes:Array = [];
		public static var currentLevel:int = 1;
		public static var totalScore:Number = 0;
		public static var levelScore = 0;
		
		private var sp:Sprite = new Sprite();
		public static var myWorld:b2World;
		public static var NEXT_LEVEL:String = "nextLevel1";
		public static var LEVEL_FAIL:String = "levelfail1";
		public static var GAME_OVER:String = "ngameover1";
		private var testingnext:SimpleButton
		public static const SCOREPERENEMY:Number = 100;
		
		public static const canTryUpto:int = 3;
		private static var _trying:int = 0;
		
		//[Embed(source="../bala/LevelBg.swf")]
		//private var BGG:Class;
		
		//private var bgMC:MovieClip;
		public var tweenBox:TweenBox2d;
		public var bike:BikeBox2d;
		public static const GUN:int = 2;
		public static const Javelin:int = 3;
		public var bykeOnFloor:Boolean;
		
		public var maxCamMoveX:Number = 15000;
		public var maxCamMoveY:Number = 680;
		//public var bike:Bike
		public function Game(_dummyXML:XML = null)
		{
			super(_dummyXML,9000); //important assumes path width.. for shootEnemy event
			me = this;
			myWorld = world;
			addChild(sp);
			
			this.addEventListener(MouseEvent.CLICK,shootEnemy);  //we will add this for hero hand..
			createDummyNext();
			tweenBox = new TweenBox2d(this);
			
			//add some temp explosionmcs
			
			for(var i:int = 0; i<10; i++){
				explosions.push(new ExplosionMc());
				//trace("explosions parnte=",explosions[explosions.length-1].parent)
			}
			trying = 0;
			
			addEventListener(Event.ADDED_TO_STAGE,added);
			//testing..
			
			var bg:Shape = new Shape();
			graphics.beginFill(0xcccccc,.5);
			graphics.drawRect(0,0,640,480);
		}
		
		private function added(e:Event):void{
			
		}
		public static function get trying():int
		{
			return _trying;
		}
		
		public static function set trying(value:int):void
		{
			_trying = value;
			MainGame.me.footer.livesTxt.text = Number(canTryUpto-_trying)+"/"+canTryUpto;
		}
		
		public function createDummyNext():void{
			if(MainGame.testing==true){
				testingnext = new nextdummy();
				addChild(testingnext);
				testingnext.x = 640;
				testingnext.addEventListener(MouseEvent.CLICK,MainGame.me.nextSlectLevelfun);
			}
		}
		
		public override function renderGame(e:Event):void{
			super.renderGame(e);
			updateHand();
			traceAllbullets();
			checkHeroPos();
			removeWasteBodies();
			if(bike){
				bike.updateBike();
			}
			
			forArrowsCheck() //bala added for arrows
		}
		public var destinationPoint:b2Vec2;
		public override function loadMyLevelForPreview(_levelAry:Array):void{
			dispatched = false;
			heroIsDead = false;
			enemysDied = 0;
			enemyCount = 0;
			super.loadMyLevelForPreview(_levelAry);
			levelScore = (enemyCount * SCOREPERENEMY);
			MainGame.me.gotoAndStop(Game.currentLevel+2);
			parent?parent.addChild(this):trace("not parent for game");
			MainGame.me.footer.levelTxt.text = String(Game.currentLevel);
			if(MainGame.testing==true){
				addChild(testingnext);
			}
			SoundM.me.playSound(SoundM.BG1,true);
			tweenBox.addExtraEffectsIfAny();
			bike = new BikeBox2d(world);
			bike.create(100/30,300/30);
			switch(currentLevel)
			{
				case 1:
				{
					destinationPoint = getBodyByID("ID_23").GetPosition();
					break;
				}
					
				default:
				{
					break;
				}
			}
			
			
			createRoad();
		}
		
		private var dispatched:Boolean =  false;
		
		//body contacts will call these funs..
		public function set heroX(bbb:b2Body):void{
			dispatchEvent(new Event(LEVEL_FAIL));
			heroIsDead = true;
			deleteBodyAndData(bbb);
		}
		
		private var enemysDied:int = 0;
		public static var currentLevelScore:Number = 0;
		public function set enemyX(bbb:b2Body):void{
			//deleteBodisByID(bbb.GetUserData().id);
			pinkExplosion(bbb);
			explosionAnim(bbb);
			deleteBodyAndData(bbb);
			enemysDied++;
			if((enemysDied == enemyCount) && dispatched == false){
				dispatchEvent(new Event(Game.NEXT_LEVEL));
				dispatched = true;
				//trace("b2contacts dispatched NextLevel");
			}
			SoundM.me.playSound(SoundM.EDIE);
			currentLevelScore = enemysDied * SCOREPERENEMY;
			MainGame.me.footer.scoreTxt.text = String(currentLevelScore);
		}
		
		public function set bulletX(bbb:b2Body):void{
			bbb.GetUserData().canTrace = false;
			explosionAnim(bbb);
			deleteBodyAndData(bbb);
			//trace("effect bulletX")
		}
		public function set bulletXX(bbb:b2Body):void{
			bbb.GetUserData().canTrace = false;
			deleteBodyAndData(bbb);
			//trace("effect bulletXX")
		}
		
		public function set glassX(bbb:b2Body):void{
			smashEffect(bbb);
			deleteBodyAndData(bbb);
			//trace("effect glassX")
			if(currentLevel == 6 && bbb == getBodyByID("ID_19")){
				BalaUtils.me.remove(TweenBox2d.popup1);
			}
			SoundM.me.playSound(SoundM.GLASS);
		}
		public var heroIsDead:Boolean = false;
		private function checkHeroPos():void{
			if(BikeBox2d.player_body){
				var plyPos:b2Vec2 = BikeBox2d.player_body.GetWorldCenter();
				var plyAng:Number = BikeBox2d.player_body.GetAngle();
				if(heroIsDead == false && plyAng>180){
					trace("hero Down..")
					//dispatchEvent(new Event(LEVEL_FAIL));
					//heroIsDead = true;
					//deleteBodyAndData(BikeBox2d.player_body);
					//stopRender();
					//SoundM.me.playSound(SoundM.HDIE);
				}
				
				if(plyPos.x>=destinationPoint.x && dispatched == false){
					//dispatchEvent(new Event(Game.NEXT_LEVEL));
					//dispatched = true;
					trace("You done it..")
				}
			}
		}
		
		private var explosions:Vector.<ExplosionMc> = new Vector.<ExplosionMc>();
		public function explosionAnim(bbb:b2Body):void{
			var exmc:ExplosionMc = BalaUtils.me.findUnUsedItem(explosions);
			if(exmc){
				exmc.x = ptm_ratio * bbb.GetPosition().x;
				exmc.y = ptm_ratio * bbb.GetPosition().y;
				//exmc.ballTypemc.gotoAndPlay(1);  //erro
				addChild(exmc);
			}
		}
		public static var currentWeponType:int = GUN;
		public var currentWeponMC:MovieClip;
		public var handMC:MovieClip;
		
		
		public function updateHand() : void
		{
			if(BikeBox2d.player_body)
			{
				//trace(BikeBox2d.player_body.GetUserData().hand,"aeshjshkjdhajsk")
			}
			
			
			if(BikeBox2d.player_body && BikeBox2d.player_body.GetUserData().hand){
				cameraMovement();
				
				var handPP:Point = BalaUtils.localToLocal(BikeBox2d.player_body.GetUserData(),this,new Point(BikeBox2d.player_body.GetUserData().hand.x,BikeBox2d.player_body.GetUserData().hand.y));
				var diffx:Number =  handPP.x - mouseX;
				var diffy:Number =  handPP.y - mouseY;
				weaponAngle = Math.atan2(-diffy, -diffx);
				//this.weaponAngle = Math.atan2(-diffy, -diffx);
				if (mouseX <  BikeBox2d.player_body.GetUserData().x)
				{
					//BikeBox2d.player_body.GetUserData().scaleX = -1;
					//this.weaponAngle = Math.atan2(diffy, diffx);
				}
				else
				{
					//BikeBox2d.player_body.GetUserData().scaleX = 1;
				}
				BikeBox2d.player_body.GetUserData().hand.rotation = (weaponAngle * RadtoDeg -  BikeBox2d.player_body.GetUserData().rotation) * BikeBox2d.player_body.GetUserData().scaleX;
				pointBlock = BalaUtils.localToLocal(BikeBox2d.player_body.GetUserData().hand,this,new Point(BikeBox2d.player_body.GetUserData().hand.pp1.x,BikeBox2d.player_body.GetUserData().hand.pp1.y));
				if(currentWeponType == Javelin){
					currentWeponMC.gotoAndStop("Javelin");
					BikeBox2d.player_body.GetUserData().hand.currentWepon.gotoAndStop(Javelin);
				}else if(currentWeponType == GUN){
					currentWeponMC.gotoAndStop("GUN");
					//do gun requirement
				}
			}
		}// end function
		
		
		private var pointBlock:Point;
		public function shootEnemy(e:MouseEvent):void{
			if(e.target is SimpleButton || e.target is sndbtn || e.target is FooterMC){
				trace("don't shoot..");
			}else{
				
				if(currentWeponType == Javelin && BikeBox2d.player_body.GetUserData().hand.currentWepon){
					
					addArrow(pointBlock.x,pointBlock.y,false);
					
				}else if(currentWeponType == GUN){
					var bul:b2Body = createBullet(handMC);
					//addChild(new BulletTracer(bul));
					if(currentWeponMC){
						var sxx:Number = 1;//heroBody.GetUserData().scaleX;
						//heroBody.GetUserData().arm.weapon.beffect.visible = true;
						//heroBody.GetUserData().arm.weapon.beffect.play();
						bul.ApplyImpulse(new b2Vec2(sxx* Math.cos(weaponAngle) * power, sxx* Math.sin(weaponAngle) * power), bul.GetPosition());
					}
				}
				//SoundM.me.playSound(SoundM.SHOOT);
			}
		}
		
		final private function traceAllbullets():void{
			for each(var bt:BulletTracer in BulletTracer.allBTracers){
				bt.traceMe();
			}
		}
		
		/*public function doAmmoCheck() : void
		{
		var _loc_1:Boolean = false;
		var _loc_2:int = 0;
		if (this.ammoArray[this.currentWeapon] == 0)
		{
		_loc_1 = false;
		_loc_2 = 1;
		while (_loc_2 < this.ammoArray.length)
		{
		
		if (this.ammoArray[_loc_2] != 0)
		{
		_loc_1 = true;
		//this.equipWeapon(_loc_2);
		break;
		}
		_loc_2++;
		}
		if (!_loc_1)
		{
		trace("All ammo has been used up, wait to end level");
		heroBody.GetUserData().arm.weapon.gotoAndStop("empty");
		//this.startChecking();
		}
		}
		return;
		}
		
		public function updateHealthDisplay(param1:MovieClip) : void
		{
		param1.healthBar.bar.scaleX = param1.health / 100;
		return;
		}*/
		
		private function removeWasteBodies():void{
			while(tempBodiesTobeRemoved.length>0){
				world.DestroyBody(tempBodiesTobeRemoved[0]);
				tempBodiesTobeRemoved.shift();
			}
		}
		
		//for arrows bala
		private function forArrowsCheck():void{
			for (var i:Number=arrowVector.length-1; i>=0; i--) {
				var body:b2Body=arrowVector[i];
				if (body.GetType()==b2Body.b2_dynamicBody) {
					if (! body.GetUserData().freeFlight) {
						var flyingAngle:Number=Math.atan2(body.GetLinearVelocity().y,body.GetLinearVelocity().x);
						body.SetAngle(flyingAngle);
					}
				}
				else {
					arrowVector.splice(i,1);
					body.SetBullet(false);
					body.GetUserData().follow=false;
				}
				if (body.GetUserData().follow) {
					var posX:Number=body.GetPosition().x*ptm_ratio;
					posX=stage.stageWidth/2-posX;
					if (posX>0) {
						posX=0;
					}
					if (posX<-640) {
						posX=-640;
					}
					x=posX;
				}
			}
		}
		
		private function cameraMovement():void{
			var pos_x:Number;
			var pos_y:Number;
			
			if (BikeBox2d.player_body) {
				pos_x=BikeBox2d.player_body.GetWorldCenter().x*ptm_ratio;
				pos_y=BikeBox2d.player_body.GetWorldCenter().y*ptm_ratio;
			} else {
				//pos_x=the_cannonball_itself.GetWorldCenter().x*world_scale;
				//pos_y=the_cannonball_itself.GetWorldCenter().y*world_scale; what is
			}
			pos_x=320-pos_x;
			if (pos_x<-maxCamMoveX) {
				pos_x=-(maxCamMoveX-640);
			}
			if (pos_x>0) {
				pos_x=0;
			}
			x=pos_x;
			pos_y=240-pos_y;
			if (pos_y<-200) {
				pos_y=-200;
			}
			if (pos_y>0) {
				pos_y=0;
			}
			y=(pos_y+100);
			
			MainGame.me.BGG.x = x;
			MainGame.me.BGG.y = pos_y;
		}
		
	}
}