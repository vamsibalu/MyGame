package com
{
	import Box2D.Common.Math.b2Vec2;
	import Box2D.Dynamics.b2Body;
	import Box2D.Dynamics.b2World;
	
	import bala.BalaBaseGame;
	import bala.BaseWorld;
	import bala.ShapeWorld;
	import bala.SoundM;
	import bala.Utils.BalaUtils;
	import bala.Utils.TweenBox2d;
	import bala.ZombieRunner;
	
	import com.greensock.TweenLite;
	import com.vo.PlatFormType;
	
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.MovieClip;
	import flash.display.Shape;
	import flash.display.SimpleButton;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.events.TimerEvent;
	import flash.geom.Point;
	import flash.utils.Timer;
	
	//import com.data.Bike;
	
	public class Game extends BalaBaseGame
	{
		public static var me:Game;
		
		public var textBoxes:Array = [];
		public static var currentLevel:int = 1;
		public static var levelScore = 0;
		
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
		public var heroBike:HeroBike;
		public static const GUN:int = 2;
		public static const Javelin:int = 3;
		public var bykeOnFloor:Boolean;
		
		public var maxCamMoveX:Number = 15000;
		public var maxCamMoveY:Number = 680;
		private var BGG_FarView:MovieClip = new FarViewMC();
		private var BGG_FrontView:MovieClip = new FrontViewMC();
		private var BGG_MiddleView:MovieClip = new MiddleViewMC();
		
		//public var bike:Bike
		public function Game(_dummyXML:XML = null)
		{
			trace("GAme initialized1..")
			super(_dummyXML,9000); //important assumes path width.. for shootEnemy event
			me = this;
			myWorld = world;
			addChild(sp);
			
			//this.addEventListener(MouseEvent.CLICK,shootEnemy);  //bala req we will add this for hero hand..
			createDummyNext();
			tweenBox = new TweenBox2d(this);
			
			//add some temp explosionmcs
			
			for(var i:int = 0; i<10; i++){
				explosions.push(new ExplosionMc());
				//trace("explosions parnte=",explosions[explosions.length-1].parent)
			}
			trying = 0;
			//BGG_FarView.y = -100;
			addEventListener(Event.ADDED_TO_STAGE,added);
			//testing..
			
			//graphics.beginFill(0xcccccc,.5);
			//graphics.drawRect(0,0,640,480);
			trace("GAme initialized2..")
			ttm.addEventListener(TimerEvent.TIMER_COMPLETE,onTime);
			//gtime.addEventListener(TimerEvent.TIMER_COMPLETE,deletGift)
			stopRender();
			currentGift = new Block();
			currentGift2 = new Block();
		}
		
		private function added(e:Event):void{
			MainGame.me.mpanel.shootbtn.addEventListener(MouseEvent.CLICK,shootEnemy);
			MainGame.me.mpanel.speedbtn.addEventListener(MouseEvent.MOUSE_DOWN,speedup);
			MainGame.me.mpanel.speedbtn.addEventListener(MouseEvent.MOUSE_UP,speeddown);
			MainGame.me.mpanel.sliderbtn.addEventListener(MouseEvent.MOUSE_MOVE,sliderf);
			//weponchangecheck();
		}
		
		
		function sliderf(e:MouseEvent):void{
			updateHand();
		}
		function speedup(e:MouseEvent):void{
			heroBike.up_key=true;
		}
		
		function speeddown(e:MouseEvent):void{
			heroBike.up_key=false;
		}
		
		public static function get trying():int
		{
			return _trying;
		}
		
		public static function set trying(value:int):void
		{
			_trying = value;
			MainGame.me.footerM.livesTxt.text = String(canTryUpto-_trying)
		}
		
		public function createDummyNext():void{
			if(GameStatics.testing==true){
				testingnext = new nextdummy();
				MainGame.me.addChild(testingnext);
				testingnext.x = 640;
				testingnext.addEventListener(MouseEvent.CLICK,MainGame.me.nextSlectLevelfun);
			}
		}
		
		public override function renderGame(e:Event=null):void{
			super.renderGame(e);
			
			checkHeroPos();
			removeWasteBodies();
			//render all bikes..
			for(var i:int = 0; i<allBikes.length; i++){
				allBikes[i].updateBike();
			}
			
			//shoot it.
			if(heroBike && heroBike.player_body){
				cameraMovement();
			}
			
			traceAllbullets();
			//forArrowsCheck() //bala added for arrows
			if(canon){
				var pp:Point = BalaUtils.localToLocal(handMC.pp1,this);
				canon.SetPosition(new b2Vec2((pp.x+100)/ptm_ratio,(pp.y-80)/ptm_ratio));
			}
			
			
			
			for(var k:int = 0; k<allZombies.length; k++){
				if(Math.random()<.2){
					allZombies[k].runZombie(2);
				}
			}
		}
		public var destinationPointXX:Number;
		public var allBikes:Vector.<BikeBox2d> = new Vector.<BikeBox2d>();
		private var _oponentBike:BikeBox2d;
		public static var slowMotion:Number = 1/30;
		public override function loadMyLevelForPreview(_levelAry:Array):void{
			stage.focus = this;
			stage.stageFocusRect = false;
			//stage.focusRect = false;
			super.loadMyLevelForPreview(_levelAry);
			dispatched = false;
			heroIsDead = false;
			enemysDied = 0;
			enemyCount = 0;
			MainGame.me.mpanel.visible = true;
			GameStatics.currentLevelScore = 0;
			tempShadowDepthSetup = false;
			MainGame.me.footerM.scoreTxt.text = String(GameStatics.currentLevelScore);
			
			BGG_FarView.y = 0;
			BGG_FarView.x = -100;
			
			BGG_FrontView.y = 0;
			BGG_FrontView.x = -100;
			
			BGG_MiddleView.y = 0;
			BGG_MiddleView.x = -100;
			
			BikeBox2d.deleteSpringMC();
			levelScore = (enemyCount * SCOREPERENEMY);
			MainGame.me.gotoAndStop(Game.currentLevel+2);
			parent?parent.addChild(this):trace("not parent for game");
			MainGame.me.footerM.levelTxt.text = String(Game.currentLevel);
			
			SoundM.me.playSound(SoundM.BG1,true);
			tweenBox.addExtraEffectsIfAny();
			
			while(allBikes.length>0){
				allBikes[0] = null;
				allBikes.shift();
			}
			heroBike = new HeroBike(world);
			heroBike.create(200/30,300/30,false);
			allBikes.push(heroBike);
			heroUdata = heroBike.player_body.GetUserData();
			trace("On new Level..heroBike.destroyed=",heroBike.headDamage)
			//oponent bikes..
			/*_oponentBike= new OponentBike(world);
			_oponentBike.create(300/BaseWorld.ptm_ratio,300/BaseWorld.ptm_ratio);
			allBikes.push(_oponentBike);
			
			_oponentBike= new OponentBike(world);
			_oponentBike.create(300/BaseWorld.ptm_ratio,300/BaseWorld.ptm_ratio);
			allBikes.push(_oponentBike);
			
			_oponentBike= new OponentBike(world);
			_oponentBike.create(300/BaseWorld.ptm_ratio,300/BaseWorld.ptm_ratio);
			allBikes.push(_oponentBike);*/
			MainGame.me.waterEffect.visible = false;
			//BGG_FrontView.visible = false;
			//BGG_FarView.visible = false;
			switch(currentLevel)
			{
				case 1:
					createZombies(4,300,300);
					destinationPointXX = 19737;
					maxCamMoveX = destinationPointXX-740
					break;
				case 2:
					createZombies(6,400,300);
					destinationPointXX = 18725;
					maxCamMoveX = destinationPointXX-1040
					BGG_FrontView.visible = true;
					break;
				case 3:
					createZombies(8,500,300);
					destinationPointXX = 18149;
					maxCamMoveX = destinationPointXX-840
					//add Far Views..
					BGG_FarView.visible = true;
					break;
				case 4:
					createZombies(10,550,300);
					MainGame.me.waterEffect.visible = true;
					destinationPointXX = 21137;
					maxCamMoveX = destinationPointXX-740;
					break;
				case 5:
					createZombies(12,600,300);
					MainGame.me.waterEffect.visible = true;
					destinationPointXX = 18521;
					maxCamMoveX = destinationPointXX-740
					break;
				case 6:                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                  
					createZombies(13,650,300);
					MainGame.me.waterEffect.visible = true;
					destinationPointXX = 18717;
					maxCamMoveX = destinationPointXX-740
					break;
				case 7:
					createZombies(14,700,300);
					MainGame.me.waterEffect.visible = true;
					destinationPointXX = 16551;
					maxCamMoveX = destinationPointXX-740
					break;
				case 8:
					createZombies(15,750,300);
					MainGame.me.waterEffect.visible = true;
					destinationPointXX = 19369;
					maxCamMoveX = destinationPointXX-740
					break;
				case 9:
					createZombies(16,800,300);
					MainGame.me.waterEffect.visible = true;
					destinationPointXX = 15450;
					maxCamMoveX = destinationPointXX-740
					break;
				case 10:
					createZombies(17,800,300);
					MainGame.me.waterEffect.visible = true;
					destinationPointXX = 18521;
					maxCamMoveX = destinationPointXX-740
					break;
				case 11:
					createZombies(18,800,300);
					MainGame.me.waterEffect.visible = true;
					destinationPointXX = 16118;
					maxCamMoveX = destinationPointXX-740
					break;
				case 12:
					createZombies(19,800,300);
					MainGame.me.waterEffect.visible = true;
					destinationPointXX = 16892;
					maxCamMoveX = destinationPointXX-740
					break;
				case 13:
					createZombies(20,800,300);
					MainGame.me.waterEffect.visible = true;
					destinationPointXX = 17359;
					maxCamMoveX = destinationPointXX-740
					break;
				case 14:
					createZombies(21,800,300);
					MainGame.me.waterEffect.visible = true;
					destinationPointXX = 13983;
					maxCamMoveX = destinationPointXX-740
					break;
				case 15:
					createZombies(22,800,300);
					MainGame.me.waterEffect.visible = true;
					destinationPointXX = 15853;
					maxCamMoveX = destinationPointXX-740
					break;
				case 16:
					createZombies(23,800,300);
					MainGame.me.waterEffect.visible = true;
					destinationPointXX = 29122;
					maxCamMoveX = destinationPointXX-740
					break;
				case 17:
					createZombies(24,800,300);
					MainGame.me.waterEffect.visible = true;
					destinationPointXX = 17303;
					maxCamMoveX = destinationPointXX-740
					break;
				case 18:
					createZombies(25,800,300);
					MainGame.me.waterEffect.visible = true;
					destinationPointXX = 18565;
					maxCamMoveX = destinationPointXX-740
					break;
				case 19:
					createZombies(26,800,300);
					MainGame.me.waterEffect.visible = true;
					destinationPointXX = 16962;
					maxCamMoveX = destinationPointXX-740
					break;
				case 20:
					createZombies(27,800,300);
					MainGame.me.waterEffect.visible = true;
					destinationPointXX = 17782;
					maxCamMoveX = destinationPointXX-740
					break;
			}
			
			trace("gotoAndBGG=",currentLevel)
			MainGame.me.BGG.gotoAndStop(currentLevel);
			//var bodyroad:b2Body=roadPath["Lvl_"+currentLevel](world);
			
			MainGame.me.addChildAt(BGG_FarView,0);
			MainGame.me.addChildAt(BGG_MiddleView,1);
			MainGame.me.addChildAt(BGG_FrontView,2);
			if(testingnext){
				MainGame.me.addChild(testingnext);
			}
			
			//newHero(200,100);
			startRender();
			//tempRefWheel = heroBike.frent_wheel.GetUserData()
			//tempRefWheelTest2 = new dummyWheel();
			//addChild(tempRefWheelTest2);
			
			//placeNearestGift()
			weponchangecheck();
		}
		//var tempRefWheel:MovieClip;
		//var tempRefWheelTest2:MovieClip;
		
		var roadPath:gamePathFile=new gamePathFile();
		private var dispatched:Boolean =  false;
		
		//body contacts will call these funs..//bala req
		/*public function set heroX(bbb:b2Body):void{
		dispatchEvent(new Event(LEVEL_FAIL));
		heroIsDead = true;
		deleteBodyAndData(bbb);
		}*/
		
		private var enemysDied:int = 0;
		
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
			GameStatics.currentLevelScore = enemysDied * SCOREPERENEMY;
			MainGame.me.footerM.scoreTxt.text = String(GameStatics.currentLevelScore);
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
		
		private var gtime:Timer = new Timer(500,1);
		
		public var currentGift:MovieClip;
		public var currentGift2:MovieClip;
		public function set giftX(bbb:b2Body):void{
			SoundM.me.playSound(SoundM.GLASS);
			bbb.GetUserData().anim.gotoAndPlay(2);
			GameStatics.currentLevelScore += 100;
			//currentGift = bbb;
			//gtime.start();
			tempBodiesTobeRemoved.push(bbb);
			MainGame.me.footerM.scoreTxt.text = String(GameStatics.currentLevelScore);
		}
		
		/*private function deletGift(e:TimerEvent):void{
		tempBodiesTobeRemoved.push(currentGift);
		currentGift = null;
		}*/
		
		private var ppb1:Point = new Point();
		private var ppg1:Point = new Point();
		private function placeNearestGift():void{
			var dd:Number = 50000;
			var currentB:b2Body;
			for(var i:int = 0; i<allGifts.length; i++){
				ppg1.x = allGifts[i].GetUserData().x;
				ppg1.y = allGifts[i].GetUserData().y;
				
				ppb1.x = BikeBox2d.bagMC.x;
				ppb1.y = BikeBox2d.bagMC.y;
				var curntD:Number = Point.distance(ppb1,ppg1)
				
				if(curntD<dd){
					dd = curntD;
					currentB = allGifts[i];
				}
			}
			addChild(currentGift);
			currentB.SetUserData(currentGift);
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
		private var ttm:Timer = new Timer(2000,1);
		private var heroIsDead:Boolean = false;
		private function checkHeroPos():void{
			if(heroBike && heroBike.player_body){
				var plyPosXX = heroBike.player_body.GetUserData().x;
				var plyAng:Number = heroBike.player_body.GetAngle();
				//trace("checking..=",heroBike.destroyed,heroIsDead)
				if(heroIsDead == false && heroBike.headDamage == true){
					trace("hero Down..")
					//ttm.start();
					//heroIsDead = true;
					SoundM.me.playSound(SoundM.HDIE);
				}
				
				if(plyPosXX>=destinationPointXX && dispatched == false){
					dispatchEvent(new Event(Game.NEXT_LEVEL));
					dispatched = true;
					trace("You done it..")
				}
			}
		}
		
		private function onTime(e:TimerEvent):void{
			trace("OnTime LevelFail..");
			ttm.stop();
			dispatchEvent(new Event(LEVEL_FAIL));
			stopRender();
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
		private var heroUdata:MovieClip;
		
		public function updateHand() : void
		{
			
			if(heroBike && heroBike.player_body && heroUdata && heroUdata.hand){
				var handPP:Point = BalaUtils.localToLocal(heroUdata,this,new Point(heroUdata.hand.x,heroUdata.hand.y));
				var diffx:Number =  handPP.x - mouseX;
				var diffy:Number =  handPP.y - mouseY;
				weaponAngle = Math.atan2(-diffy, -diffx);
				//this.weaponAngle = Math.atan2(-diffy, -diffx);
				if (mouseX <  heroUdata.x)
				{
					//BikeBox2d.player_body.GetUserData().scaleX = -1;
					//this.weaponAngle = Math.atan2(diffy, diffx);
				}
				else
				{
					//BikeBox2d.player_body.GetUserData().scaleX = 1;
				}
				heroUdata.hand.rotation = (weaponAngle * RadtoDeg -  heroUdata.rotation) * heroUdata.scaleX;
				pointBlock = BalaUtils.localToLocal(heroUdata.hand,this,new Point(heroUdata.hand.pp1.x,heroUdata.hand.pp1.y));
			}
		}// end function
		
		private function weponchangecheck():void{
			if(currentWeponType == Javelin){
				currentWeponMC.gotoAndStop("Javelin");
				heroUdata.hand.currentWepon.gotoAndStop(Javelin);
			}else if(currentWeponType == GUN){
				currentWeponMC.gotoAndStop("GUN");
				//do gun requirement
			}
		}
		
		
		private var pointBlock:Point;
		public function shootEnemy(e:MouseEvent):void{
			if(e.target is SimpleButton || e.target is FooterMC){
				trace("don't shoot..");
			}else{
				
				if(currentWeponType == Javelin && heroBike.player_body.GetUserData().hand.currentWepon){
					
					addArrow(pointBlock.x,pointBlock.y,false);
					
				}else if(currentWeponType == GUN){
					var bul:b2Body = createBullet(handMC);
					addChild(new BulletTracer(bul));
					if(currentWeponMC){
						var sxx:Number = 1;//heroBody.GetUserData().scaleX;
						//heroBody.GetUserData().arm.weapon.beffect.visible = true;
						//heroBody.GetUserData().arm.weapon.beffect.play();
						bul.ApplyImpulse(new b2Vec2(sxx* Math.cos(weaponAngle) * power, sxx* Math.sin(weaponAngle) * power), bul.GetPosition());
					}
				}
				//SoundM.me.playSound(SoundM.SHOOT);
				//slowMotion = 2;
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
		
		var tempShadowDepthSetup:Boolean = false;
		private function cameraMovement():void{
			var pos_x:Number;
			var pos_y:Number;
			
			if (heroBike.player_body) {
				pos_x = heroUdata.x;//BikeBox2d.player_body.GetWorldCenter().x*ptm_ratio;
				pos_y = heroUdata.y;//BikeBox2d.player_body.GetWorldCenter().y*ptm_ratio;
			} else {
				//pos_x=the_cannonball_itself.GetWorldCenter().x*world_scale;
				//pos_y=the_cannonball_itself.GetWorldCenter().y*world_scale; what is
			}
			pos_x=50-pos_x;
			if (pos_x<-maxCamMoveX) {
				pos_x=-maxCamMoveX;
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
			if (heroBike.player_body && x!=0) {
				var vvx:Number = heroBike.player_body.GetLinearVelocity().x;
				var vvy:Number = heroBike.player_body.GetLinearVelocity().y;
				
				BGG_FarView.updatePos(vvx * 0.1,0);
				BGG_MiddleView.updatePos(vvx * 0.4,vvy * 0);
				//BGG_FrontView.x -= heroBike.player_body.GetLinearVelocity().x * .1;
				//BGG_FrontView.y -= heroBike.player_body.GetLinearVelocity().y * .1;
				BGG_FrontView.updatePos(vvx * 1.5,vvy * 0);
			}
			//BGG_FrontView.x = x;
			//BGG_FrontView.y = pos_y;
			//to make sure 3D Top layer having top depth..
			if(tempShadowDepthSetup == false){
				//addChild(BGG_FrontView);
				if(testingnext){
					MainGame.me.addChild(testingnext)
				}
				MainGame.me.addChild(MainGame.me.footerM)
				tempShadowDepthSetup = true;
				MainGame.me.addChild(MainGame.me.mpanel);
			}
		}
		
	}
}