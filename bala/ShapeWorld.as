package bala
{
	
	import Box2D.Collision.Shapes.b2CircleShape;
	import Box2D.Collision.Shapes.b2PolygonShape;
	import Box2D.Common.Math.b2Vec2;
	import Box2D.Dynamics.Joints.b2RevoluteJointDef;
	import Box2D.Dynamics.b2Body;
	import Box2D.Dynamics.b2BodyDef;
	import Box2D.Dynamics.b2FixtureDef;
	
	import bala.Box2DSeparator.b2Separator;
	import bala.Utils.BalaUtils;
	import bala.vo.PlatFormType;
	
	import com.greensock.TweenLite;
	
	import flash.display.BitmapData;
	import flash.display.DisplayObject;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.geom.Point;
	import flash.utils.Dictionary;
	
	/**
	 * @author : Balakrishna.
	 * @email  : vamsibalu@gmail.com
	 * @version: 5.0
	 */
	
	public class ShapeWorld extends BaseWorld
	{
		public var bodies:Vector.<b2Body> = new Vector.<b2Body>();
		public var heroBody:b2Body;
		//
		public var ammoArray:Array = [];
		public var currentWeapon:int;
		public var weaponAngle:Number = 0;
		public var bulletsb2Ary:Array = [];
		public var joints:Dictionary = new Dictionary();
		public function ShapeWorld()
		{
			trace("shape world created.")
			//TODO: implement function
			super();
			//addChild(heroMC);
			conv = new b2Separator();
			
			// for slicing..First, I create the textures, which are BitmapData objects.
			var tempSpr:Sprite;
			
			tempSpr = new texture1();
			woodTexture = new BitmapData(tempSpr.width, tempSpr.height);
			woodTexture.draw(tempSpr);
			
			
			tempSpr = new Sprite();
			tempSpr.graphics.lineStyle(2, 0x00FF00);
			tempSpr.graphics.beginFill(0x00FF00, 0.3);
			tempSpr.graphics.drawRect(-0.5*640, (480-10), 2*640, 20);
			tempSpr.graphics.endFill();
			//addChild(tempSpr);
			
			enemyMCS.push(new EN1(),new EN2(),new EN3(),new EN4(),new EN5(),new EN6(),new EN1(),new EN2(),new EN3(),new EN4(),new EN5(),new EN6(),new EN1(),new EN2(),new EN3(),new EN4(),new EN5(),new EN6());
			trace("have enms=",enemyMCS.length);
			
		}
		
		public function createHero(bodyID:String,_xx:Number,_yy:Number,angle:Number){
			bodyDef=new b2BodyDef()
			bodyDef.type=b2Body.b2_dynamicBody;
			bodyDef.position.Set(_xx/ptm_ratio,_yy/ptm_ratio)
			bodyDef.userData=new HeroMC();
			bodyDef.userData.arm.weapon.beffect.visible = false;
			bodyDef.userData.name = "hero";
			bodyDef.userData.bodyID = bodyID;
			debugging==false?addChildAt(bodyDef.userData,1):"";
			if(angle!=0){
				bodyDef.angle=Math.PI/angle
			}
			boxDef=new b2PolygonShape()
			boxDef.SetAsBox(realPixels(30),realPixels(40))
			fixtureDef=new b2FixtureDef();
			fixtureDef.density=5;
			fixtureDef.friction=0.1;
			fixtureDef.restitution=0;
			fixtureDef.shape=boxDef
			fixtureDef.filter.groupIndex = -5;
			body=world.CreateBody(bodyDef)
			heroBody = body;
			bodies.push(body);
			body.CreateFixture(fixtureDef);
		}
		
		
		public var enemyCount:int = 0;
		public var enemyMCS:Vector.<MovieClip> = new Vector.<MovieClip>();
		public var encc:int = 0;
		
		public function createEnemy(bodyID:String,_xx:Number,_yy:Number,angle:Number){
			enemyCount++;
			bodyDef=new b2BodyDef()
			bodyDef.type=b2Body.b2_dynamicBody
			bodyDef.position.Set(_xx/ptm_ratio,_yy/ptm_ratio);
			if(enemyMCS[encc]){
				
			}else{
				encc = 0;
			}
			enemyMCS[encc].gotoAndStop(1);
			bodyDef.userData = enemyMCS[encc];
			bodyDef.userData.name = "enemy";
			bodyDef.userData.bodyID = bodyID;
			debugging==false?addChildAt(bodyDef.userData,1):"";
			if(angle!=0){
				bodyDef.angle=Math.PI/angle
			}
			boxDef=new b2PolygonShape()
			boxDef.SetAsBox(realPixels(30),realPixels(45))
			fixtureDef=new b2FixtureDef();
			fixtureDef.density=5;
			fixtureDef.friction=0.1;
			fixtureDef.restitution=0;
			fixtureDef.shape=boxDef
			body=world.CreateBody(bodyDef)
			bodies.push(body);
			body.CreateFixture(fixtureDef);
			encc++;
		}
		
		public function createCircle(bodyID:String,xx:Number,yy:Number,ww:Number,hh:Number,angle:Number,type:String)
		{
			var body:b2Body
			var bodyDef:b2BodyDef
			var circleDef:b2CircleShape
			var fixtureDef:b2FixtureDef = new b2FixtureDef();
			bodyDef=new b2BodyDef()
			bodyDef.type=b2Body.b2_dynamicBody
			bodyDef.position.Set(xx/ptm_ratio,yy/ptm_ratio)
			bodyDef.userData = new CircleStone();
			bodyDef.userData.name = "ball"; //override
			fixtureDef.friction=.8;
			fixtureDef.restitution=0.5
			switch(type){
				case PlatFormType.STANDARD:
					bodyDef.userData.gotoAndStop("standard");
					//bodyDef.userData.name = "block";
					break;
				case PlatFormType.BOUNCY:
					fixtureDef.restitution = 1;
					bodyDef.userData.gotoAndStop("bouncy");
					//bodyDef.userData.name = "bouncy";
					break;
				case PlatFormType.ICE:
					fixtureDef.friction = 0.01;
					bodyDef.userData.gotoAndStop("ice");
					bodyDef.userData.name = "nife";
					break;
				case PlatFormType.GLASS:
					bodyDef.userData.gotoAndStop("glass");
					bodyDef.userData.name = "glass";
					break;
			}
			bodyDef.userData.bodyID = bodyID;
			bodyDef.userData.width = ww;
			bodyDef.userData.height = hh;
			bodyDef.userData.x = xx;
			bodyDef.userData.y = yy;
			bodyDef.userData.rotation = angle;
			
			//bodyDef.userData=new addebles()
			//bodyDef.userData.width=_w*2
			//bodyDef.userData.height=_h*2
			//this_parent.addChildAt(bodyDef.userData,2)
			if(angle!=0){
				bodyDef.angle=Math.PI/angle
			}
			circleDef=new b2CircleShape(realPixels(ww));
			//circleDef.SetAsBox(_w/ptm_ratio,_h/ptm_ratio)
			fixtureDef.density=1
			fixtureDef.shape=circleDef
			body=world.CreateBody(bodyDef)
			body.CreateFixture(fixtureDef)
			
			addChild(bodyDef.userData);
			bodies.push(body);
		}
		
		public function createBase(bodyID:String,xx:int = 10, yy:int = 10, ww:int = 10, hh:int = 10, angle:int = 0, type:String = PlatFormType.STANDARD) : void
		{
			bodyDef = new b2BodyDef();
			bodyDef.position.Set(xx / ptm_ratio, yy / ptm_ratio);
			bodyDef.angle = angle / (180 / Math.PI);
			boxDef = new b2PolygonShape();
			boxDef.SetAsBox(realPixels(ww), realPixels(hh));
			fixtureDef=new b2FixtureDef()
			fixtureDef.restitution = 0.2;
			fixtureDef.friction = 0.6;
			bodyDef.userData = new BaseMC();
			bodyDef.userData.name = "notmoving"; //override
			bodyDef.userData.bodyID = bodyID;
			switch(type){
				case PlatFormType.STANDARD:
					bodyDef.userData.gotoAndStop("standard");
					//bodyDef.userData.name = "block";
					break;
				case PlatFormType.BOUNCY:
					fixtureDef.restitution = 1;
					bodyDef.userData.gotoAndStop("bouncy");
					//bodyDef.userData.name = "bouncy";
					break;
				case PlatFormType.ICE:
					fixtureDef.friction = 0.01;
					bodyDef.userData.gotoAndStop("ice");
					//bodyDef.userData.name = "ice";
					break;
				case PlatFormType.GLASS:
					bodyDef.userData.gotoAndStop("glass");
					bodyDef.userData.name = "glass";
					break;
			}
			
			fixtureDef.density = 0;
			bodyDef.userData.width = ww;
			bodyDef.userData.height = hh;
			bodyDef.userData.x = xx;
			bodyDef.userData.y = yy;
			bodyDef.userData.rotation = angle;
			body = world.CreateBody(bodyDef);
			
			fixtureDef.shape = boxDef;
			body.CreateFixture(fixtureDef);
			
			addChild(bodyDef.userData);
			bodies.push(body);
			
		}// end function
		
		public var power:Number = .8;
		public function createBullet() : b2Body
		{
			bodyDef = new b2BodyDef();
			bodyDef.userData = new Bullet();
			bodyDef.userData.name = "bullet";
			bodyDef.type=b2Body.b2_dynamicBody;
			bodyDef.bullet = true;
			boxDef = new b2PolygonShape();
			boxDef.SetAsBox(this.realPixels(this.bodyDef.userData.width), this.realPixels(this.bodyDef.userData.height));
			
			//check for circle..
			var ccdshape:b2CircleShape = new b2CircleShape(realPixels(bodyDef.userData.height));
			fixtureDef=new b2FixtureDef();
			fixtureDef.density = .5;
			fixtureDef.friction = 0.01;
			fixtureDef.restitution = 1;
			fixtureDef.shape = ccdshape;//boxDef;
			fixtureDef.filter.groupIndex = -5;
			body = world.CreateBody(this.bodyDef);
			bodies.push(body);
			body.CreateFixture(fixtureDef);
			//var pp:Point =  heroBody.GetUserData().localToGlobal(new Point(heroBody.GetUserData().arm.weapon.gunpoint.x,heroBody.GetUserData().arm.weapon.gunpoint.y));
			if(heroBody){
				var pp:Point = BalaUtils.localToLocal(heroBody.GetUserData().arm.weapon.gunpoint,this);
				//addChild(MainGame.me.dummymc);
				//MainGame.me.dummymc.x = pp.x;
				//MainGame.me.dummymc.y = pp.y;
				//trace("PP =", pp);
				body.SetPositionAndAngle(new b2Vec2(pp.x/ptm_ratio,pp.y/ptm_ratio),weaponAngle);
				body.GetUserData().scaleX = heroBody.GetUserData().scaleX;
			}
			body.GetUserData().rotation = weaponAngle;
			body.GetUserData().x = pp.x;
			body.GetUserData().y = pp.y;
			debugging==false?addChild(bodyDef.userData):true;
			bulletsb2Ary.push(body);
			return body;
		}
		
		
		/*protected function explode(_b2vec:b2Vec2, force:Number = 2, param3:Number = 5) : void
		{
		trace("Explosion!");
		var exmc:ExplosionMc = new ExplosionMc();
		addChild(exmc);
		exmc.x = ptm_ratio * _b2vec.x;
		exmc.y = ptm_ratio * _b2vec.y;
		exmc.scaleY = param3 / 10;
		exmc.scaleX = param3 / 10;
		
		var tempB:b2Body;
		var diff:b2Vec2 = new b2Vec2(0, 0);
		
		var len:int = this.bodies.length - 1;
		while (len >= 0)
		{
		
		tempB = bodies[len];
		
		diff.x = tempB.GetPosition().x - _b2vec.x;
		diff.y = tempB.GetPosition().y - _b2vec.y;
		
		var nm9:Number = diff.Normalize();
		if (nm9 <= param3)
		{
		trace("very close danger=",tempB.GetUserData().name)
		if (tempB.GetUserData().name == "glass")
		{
		this.smashEffect(tempB);
		deleteBodyAndData(tempB);
		this.bodies.splice(len, 1);
		trace("at explode=",tempB.GetUserData().name)
		}else{
		//trace("not glass.",tempB.GetUserData().name)
		var mult:Number = (param3 - nm9) * force;
		diff.x = diff.x * mult;
		diff.y = diff.y * mult;
		//pinkExplosion(tempB);
		//tempB.ApplyImpulse(diff, tempB.GetPosition());
		if (tempB.GetUserData().name == "enemyX")
		{
		trace("enemyX pink explosion");
		pinkExplosion(tempB);
		break;
		}
		}
		}else{
		//trace("objects are too long to explode..",tempB.GetUserData().name)
		}
		len = len - 1;
		}
		}
		
		public function deleteBodisByID(_id:int) : void{
		var bbb:b2Body = world.GetBodyList();
		while (bbb)
		{
		if(bbb.GetUserData() && bbb.GetUserData().id == _id){
		bodies.splice(bodies.indexOf(bbb), 1);
		deleteBodyAndData(bbb);
		}
		bbb = bbb.GetNext();
		
		}
		//trace("bodies.length",bodies.length);
		}*/
		
		public function getBodyByID(_bodyID:String) : b2Body{
			var gotBody:b2Body;
			var bbb:b2Body = world.GetBodyList();
			while (bbb)
			{
				if(bbb.GetUserData() && bbb.GetUserData().bodyID == _bodyID){
					gotBody = bbb;
				}
				bbb = bbb.GetNext();
				
			}
			return gotBody;
		}
		
		
		//:-( not working..
		/*public function checkForEnemy5(tst:int):Boolean{
		var enemyExist:Boolean = false;
		var bbb:b2Body = world.GetBodyList();
		while (bbb)
		{
		trace(tst,"checkForEnemy =",bbb.GetUserData().name,bbb.GetUserData().id)
		if(bbb.GetUserData() && (bbb.GetUserData().name == "enemy")){
		enemyExist = true;
		break;
		}
		bbb = bbb.GetNext();
		}
		return enemyExist;
		}
		
		
		//recently commented.
		public function checkForEnemy():Boolean{
		var enemyExist:Boolean = false;
		
		for each(var bbb:b2Body in bodies){
		if(bbb.GetUserData() && (bbb.GetUserData().name == "enemy" || bbb.GetUserData().name == "enemyX")){
		enemyExist = true;
		trace("enemy exist..checking break..",enemyExist,bbb,bbb.GetUserData())
		break;
		}
		}
		return enemyExist;
		}*/
		
		public var tempBodiesTobeRemoved:Vector.<b2Body> = new Vector.<b2Body>();
		
		public function deleteBodyAndData(_b2b:b2Body):void{
			if (_b2b.GetUserData() && _b2b.GetUserData() is DisplayObject)
			{
				if(_b2b.GetUserData().name == "enemyX"){
					_b2b.GetUserData().gotoAndStop(2);
				}else{
					BalaUtils.me.remove(_b2b.GetUserData());
				}
			}
			world.DestroyBody(_b2b);
			if(tempBodiesTobeRemoved.indexOf(_b2b)<0){
				tempBodiesTobeRemoved.push(_b2b);
				//trace("tempBodiesTobeRemoved push",_b2b.GetUserData())
			}
		}
		
		public function smashEffect(param1:b2Body) : void
		{
			trace("Smash glass");
			var glass:PlatformGlass;
			
			//this.sounds.playSoundEffect("glassBreak");
			var theRotation:* = param1.GetUserData().rotation;
			param1.GetUserData().rotation = 0;
			glass = new PlatformGlass();
			glass.x = param1.GetUserData().x;
			glass.y = param1.GetUserData().y;
			glass.width = param1.GetUserData().width;
			glass.height = param1.GetUserData().height;
			glass.rotation = theRotation;
			param1.GetUserData().rotation = theRotation;
			addChild(glass);
			//glass.startfxx();
		}
		
		public function pinkExplosion(param1:b2Body) : void
		{
			var _loc_3:PinkParticle;
			var _loc_4:int = 0;
			var _loc_5:int = 0;
			var _loc_6:int = 0;
			var _loc_2:int = 0;
			while (_loc_2 <= 30)
			{
				
				_loc_3 = new PinkParticle();
				_loc_4 = BalaUtils.me.randomNumber(-10, 10);
				_loc_5 = BalaUtils.me.randomNumber(-10, 10);
				_loc_3.x = param1.GetUserData().x + _loc_4;
				_loc_3.y = param1.GetUserData().y + _loc_5;
				_loc_3.rotation = BalaUtils.me.randomNumber(0, 360);
				var _loc_7:* = Math.random() + 0.5;
				_loc_3.scaleY = Math.random() + 0.5;
				_loc_3.scaleX = _loc_7;
				_loc_3.alpha = Math.random() + 0.5;
				_loc_6 = Math.random() * 5 + 1;
				TweenLite.to(_loc_3, _loc_6 / 4, {scaleX:1, scaleY:1, alpha:0, x:_loc_3.x + _loc_4 * _loc_6, y:_loc_3.y + _loc_5 * _loc_6, onComplete:BalaUtils.me.remove, onCompleteParams:[_loc_3]});
				addChild(_loc_3);
				_loc_2++;
			}
			return;
		}// end function
		
		private var rope:b2Body;
		public function createRope(ropeMC:MovieClip):void{
			// ceiling polygon shape
			var polygonShape:b2PolygonShape = new b2PolygonShape();
			
			var fixtureDef:b2FixtureDef = new b2FixtureDef();
			fixtureDef.density=1;
			fixtureDef.friction=1;
			fixtureDef.restitution=0.5;
			fixtureDef.shape=polygonShape;
			// link polygon shape
			polygonShape.SetAsBox(realPixels(ropeMC.width),realPixels(ropeMC.height));
			// link fixture;
			fixtureDef.density=1;
			fixtureDef.shape=polygonShape;
			// link body
			bodyDef.type=b2Body.b2_dynamicBody;
			// link creation
		}
		
		//remove all from the box2d world..
		public function removeEverything() : void
		{
			//trace("Removing Everything");
			var _loc_1:b2Body = world.GetBodyList();
			while (_loc_1)
			{
				
				if (_loc_1.GetUserData())
				{
					BalaUtils.me.remove(_loc_1.GetUserData());
				}
				
				world.DestroyBody(_loc_1);
				
				_loc_1 = _loc_1.GetNext();
			}
			bodies = new Vector.<b2Body>;
			//clear all timers.
			//trace("Everything Removed");
		}
		
		
		//for arrows bala
		public var arrowVector:Vector.<b2Body>=new Vector.<b2Body>();
		
		protected function addArrow():void {
			var angle:Number=Math.atan2(mouseY-240,mouseX-50);
			var vertices:Vector.<b2Vec2>=new Vector.<b2Vec2>();
			vertices.push(new b2Vec2(-1.4,0));
			vertices.push(new b2Vec2(0,-0.1));
			vertices.push(new b2Vec2(0.6,0));
			vertices.push(new b2Vec2(0,0.1));
			var bodyDef:b2BodyDef= new b2BodyDef();
			bodyDef.position.Set(50/ptm_ratio,240/ptm_ratio);
			bodyDef.type=b2Body.b2_dynamicBody;
			var udata:MovieClip = new MovieClip();
			udata.name = "arrow";
			udata.freeFlight = false;
			udata.follow = true;
			bodyDef.userData = udata; //{name:"arrow",freeFlight:false,follow:true};
			bodyDef.bullet=true;
			var polygonShape:b2PolygonShape = new b2PolygonShape();
			polygonShape.SetAsVector(vertices,4);
			var fixtureDef:b2FixtureDef = new b2FixtureDef();
			fixtureDef.shape=polygonShape;
			fixtureDef.density=1;
			fixtureDef.friction=0.5;
			fixtureDef.restitution=0.5;
			var body:b2Body=world.CreateBody(bodyDef);
			body.CreateFixture(fixtureDef);
			body.SetLinearVelocity(new b2Vec2(30*Math.cos(angle),30*Math.sin(angle)));
			body.SetAngle(angle);
			for (var i:Number=0; i<arrowVector.length; i++) {
				arrowVector[i].GetUserData().follow=false;
			}
			arrowVector.push(body);
		}
	}
}