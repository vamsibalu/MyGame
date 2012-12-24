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
	import flash.display.SimpleButton;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.utils.Timer;
	
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
		public function Game(_dummyXML:XML = null)
		{
			super(_dummyXML);
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
			if(heroBody && heroIsDead == false && (heroBody.GetWorldCenter().y*ptm_ratio) >= 400){
				trace("hero Down..")
				dispatchEvent(new Event(LEVEL_FAIL));
				heroIsDead = true;
				deleteBodyAndData(heroBody);
				//stopRender();
				SoundM.me.playSound(SoundM.HDIE);
			}
		}
		
		private var explosions:Vector.<ExplosionMc> = new Vector.<ExplosionMc>();
		public function explosionAnim(bbb:b2Body):void{
			var exmc:ExplosionMc = BalaUtils.me.findUnUsedItem(explosions);
			if(exmc){
				exmc.x = ptm_ratio * bbb.GetPosition().x;
				exmc.y = ptm_ratio * bbb.GetPosition().y;
				exmc.ballTypemc.gotoAndPlay(1);
				addChild(exmc);
			}
		}
		
		public function updateHand() : void
		{
			if(heroBody && heroBody.GetUserData()){
				var diffx:Number =  heroBody.GetUserData().x - mouseX;
				var diffy:Number =  heroBody.GetUserData().y - mouseY;
				this.weaponAngle = Math.atan2(-diffy, -diffx);
				if (mouseX <  heroBody.GetUserData().x)
				{
					heroBody.GetUserData().scaleX = -1;
					this.weaponAngle = Math.atan2(diffy, diffx);
				}
				else
				{
					heroBody.GetUserData().scaleX = 1;
				}
				
				heroBody.GetUserData().arm.rotation = (this.weaponAngle * RadtoDeg -  heroBody.GetUserData().rotation) *  heroBody.GetUserData().scaleX;
				//heroBody.GetUserData().hamboHead.rotation = (this.weaponAngle * RadtoDeg -  heroBody.GetUserData().rotation) *  heroBody.GetUserData().scaleX / 2;
				
				//trace("hero rotation=",heroBody.GetAngle(),heroBody.GetAngularVelocity(),heroBody.GetAngularDamping())
				/*if(heroBody.GetAngle()>2 || heroBody.GetAngle()<-2){
				heroBody.SetAngle(0);
				//trace("setting hero angle to 0",heroBody.GetAngle());
				}*/
			}
		}// end function
		
		public function shootEnemy(e:MouseEvent):void{
			if(e.target is SimpleButton || e.target is sndbtn || e.target is FooterMC){
				trace("don't shoot..");
			}else{
				/*var bul:b2Body = createBullet();
				addChild(new BulletTracer(bul));
				if(heroBody){
					var sxx:Number = heroBody.GetUserData().scaleX;
					heroBody.GetUserData().arm.weapon.beffect.visible = true;
					heroBody.GetUserData().arm.weapon.beffect.play();
					bul.ApplyImpulse(new b2Vec2(sxx* Math.cos(weaponAngle) * power, sxx* Math.sin(weaponAngle) * power), body.GetPosition());
				}*/
				addArrow(); //added for arrow bala
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
			
			if (heroBody) {
				pos_x=heroBody.GetWorldCenter().x*ptm_ratio;
				pos_y=heroBody.GetWorldCenter().y*ptm_ratio;
			} else {
				//pos_x=the_cannonball_itself.GetWorldCenter().x*world_scale;
				//pos_y=the_cannonball_itself.GetWorldCenter().y*world_scale;
			}
			pos_x=stage.stageWidth/2-pos_x;
			if (pos_x<0-4500) {
				pos_x=-4500;
			}
			if (pos_x>0) {
				pos_x=0;
			}
			x=pos_x;
			pos_y=stage.stageHeight/2-pos_y;
			if (pos_y<0-15) {
				pos_y=-15;
			}
			if (pos_y>285) {
				pos_y=285;
			}
			y=pos_y;
		}
		
	}
}