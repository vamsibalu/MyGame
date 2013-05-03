package 
{
	import Box2D.Collision.Shapes.b2CircleShape;
	import Box2D.Collision.Shapes.b2PolygonShape;
	import Box2D.Common.Math.b2Vec2;
	import Box2D.Dynamics.Joints.b2DistanceJointDef;
	import Box2D.Dynamics.Joints.b2Joint;
	import Box2D.Dynamics.Joints.b2PrismaticJointDef;
	import Box2D.Dynamics.Joints.b2RevoluteJointDef;
	import Box2D.Dynamics.b2Body;
	import Box2D.Dynamics.b2BodyDef;
	import Box2D.Dynamics.b2DebugDraw;
	import Box2D.Dynamics.b2Fixture;
	import Box2D.Dynamics.b2FixtureDef;
	import Box2D.Dynamics.b2World;
	
	import flash.display.BitmapData;
	import flash.display.DisplayObject;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.geom.Point;
	import flash.text.StaticText;
	
	/**
	 * @author : Balakrishna.
	 * @email  : vamsibalu@gmail.com
	 * @version: 5.0
	 */
	
	public class BaseWorldSingle extends MovieClip
	{
		// ptm ratio
		public static var ptm_ratio:Number = 30;
		
		// create the box2d world, set up gravity
		public var world:b2World=new b2World(new b2Vec2(0,10),true);
		
		//basic items 
		[Embed(source='BalaLevelData.xml',mimeType="application/octet-stream")]
		private static const Levels:Class;
		public var levelDataXML:XML;
		public var allLevels:Array = [];
		//create arrow..
		public var bodyDef:b2BodyDef;
		public var body:b2Body;
		public var boxDef:b2PolygonShape;
		public var fixtureDef:b2FixtureDef;
		public var debugging:Boolean = false;
		
		public static var bodyID:int = 1;
		
		public function BaseWorldSingle()
		{
			//TODO: implement function
			trace("BaseWorld created.")
			super();
			bg();
			addEventListener(Event.ADDED_TO_STAGE,addedToStage);
			trace("BaseWorld created.")
		}
		
		private function bg():void{
			var sp:Sprite = new Sprite();
			sp.graphics.beginFill(0xff00cc,0);
			sp.graphics.drawRect(-100,-100,840,680);
			addChild(sp);
			
			//var mc:MovieClip = new note();
			//addChild(mc);
			
			//world.SetContactListener(new BodyContacts())
		}
		
		private function addedToStage(e:Event):void{
			setUpWalls();
			//addChild(objectsCont);
			//for slicing..
			//stage.addEventListener(MouseEvent.MOUSE_DOWN, mDown);
		levelDataXML = XML(new Levels());
		
		parseXMLData(levelDataXML,allLevels);
		}
		
		public function loadMyLevelForPreview(_levelAry:Array):void{
			//trace("loadMyLevelForPreview objects no.=",_levelAry)
			removeEverything();
			setUpWalls();
			for(var obj:Object in _levelAry){
				var ary:Array;
				switch(_levelAry[obj][0])
				{
					case "Block":
						ary = _levelAry[obj];
						//trace("boxx=",_levelAry[obj]);
						createBox(ary[1],ary[2],ary[3],ary[4],ary[5],ary[6],ary[7]);
						break;
					case "CircleStone":
						ary = _levelAry[obj];
						//trace("ball=",_levelAry[obj]);
						createCircle(ary[1],ary[2],ary[3],ary[4],ary[5],ary[6],ary[7]);
						break;
					case "Poly":
						ary = _levelAry[obj];
						//trace("Poly Data to Show=",ary);
						//trace("Poly Data to Show parsed=",parseXY(ary));
						createPoly(ary[1],parseXY(ary),"notmoving",null);
						break;
				}
			}
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
		}
		
		private function parseXMLData(xml:XML,allLevels:Array):void{
			var levelList:XMLList = xml.children();
			if(levelList){
				for(var i:int = 0; i<levelList.length(); i++){
					var ary:Array = levelList[i].toString().split(":");
					var levelNo:int = levelList[i].@id;
					trace("parseXMLData levels found=",levelNo)
					if(ary){
						for(var k:int = 0; k<ary.length; k++){
							ary[k] = ary[k].toString().split(",");
						}
						allLevels[levelNo] = ary;
					}else{
						trace("Bad XML formate, not Found ':' ")
					}
				}
				trace("allLevels.length=",allLevels.length);
			}
		}
		
		protected function startRender():void{
			addEventListener(Event.ENTER_FRAME,renderGame);
		}
		
		protected function stopRender():void{
			removeEventListener(Event.ENTER_FRAME,renderGame);
		}
		
		//public var wallT:b2Body;
		public var wallR:b2Body;
		public var wallL:b2Body;
		//for reloading levels and walls bala
		public function setUpWalls()
		{
			wallL = createBox("border1",-100, 500/2, 5, 500); //left
			
			wallR = createBox("border2",643, 500/2, 5,500); //right
			
			
			//wallT =	createBox("border3",640/2, -3, 700, 5);
			
			//bottom
			createBox("border4",700/2, 384, 900, 5);
		}
		
		final protected function createBox(bodyID:String,x:int,y:int,ww:int,hh:int,_angle:Number=0):b2Body
		{
			
			var bodyDef:b2BodyDef = new b2BodyDef();
			var fixtureDef:b2FixtureDef = new b2FixtureDef();
			bodyDef.position.Set(x /ptm_ratio, y / ptm_ratio);
			bodyDef.angle = _angle / (180 / Math.PI);
			fixtureDef.friction = .1;
			fixtureDef.restitution = 0.001;
			
				
			bodyDef.userData = new MovieClip();
			bodyDef.userData.name = "notmoving";
			
			bodyDef.userData.bodyID = bodyID;
			
			bodyDef.userData.width = ww;
			bodyDef.userData.height = hh;
			bodyDef.userData.rotation = _angle;
			
			var body:b2Body = world.CreateBody(bodyDef);
			var dynamicBox:b2PolygonShape = new b2PolygonShape();
				dynamicBox.SetAsBox(realPixels(ww),realPixels(hh));
			fixtureDef.shape = dynamicBox;
			fixtureDef.density = 0.5;
			//fixtureDef.filter.groupIndex = -2;
			body.CreateFixture(fixtureDef);
			//trace(body.GetUserData().name);
			
			return body;
		}
		
		private function resetWalls():void{
			//wallT.SetPosition(new b2Vec2(320/ptm_ratio,-3/ptm_ratio));
			//wallR.SetPosition(new b2Vec2(643/ptm_ratio,250/ptm_ratio));
			//wallL.SetPosition(new b2Vec2(-3/ptm_ratio,250/ptm_ratio));
		}
		// this function runs the world simulation
		// and adjusts the sprites according to the positions
		// of the objects in the simulation
		public var RadtoDeg:Number = 180/Math.PI;
		public var DegtoRad:Number = Math.PI/180;
		public function renderGame(e:Event = null):void {
			// step the world
			
			world.Step(1/30, 10, 10);
			
			world.ClearForces();
			world.DrawDebugData();
			
			// update the sprites from the physics data
			var Body:b2Body = world.GetBodyList();
			for ( ; Body; Body = Body.GetNext()) {
				if (Body.GetUserData() is MovieClip) {
					
					// get the user date value from the body
					var mcc:MovieClip = MovieClip(Body.GetUserData());
					
					// extract the position and set the sprite to it
					mcc.x=Body.GetPosition().x*ptm_ratio;
					mcc.y=Body.GetPosition().y*ptm_ratio;
					
					// set the rotation of the sprite
					if(mcc.name == "wf" || mcc.name == "wb"){
						mcc.rotation += Body.GetAngularVelocity(); //Body.GetAngle() * RadtoDeg;
						//mcc.rotation = Body.GetAngle() * RadtoDeg ;
						//mcc.rotation = newRotation % 2*Math.PI;
						
						if(mcc.rotation>360){
							mcc.rotation = 0;
						}
					}else{
						mcc.rotation = Body.GetAngle() * RadtoDeg ;
					}
					//fallower(Body);
				}
			}
			
		}
		
		//bala create Poly...
		var enterPointsVec:Vector.<b2Vec2> = new Vector.<b2Vec2>();
		protected var woodTexture:BitmapData, rockTexture:BitmapData;
		protected function createPoly(bodyID:String,vec:Vector.<b2Vec2>,_name:String,polyTexture:BitmapData) : b2Body
		{
			this.bodyDef = new b2BodyDef();
			this.bodyDef.type = b2Body.b2_staticBody;
			//this.bodyDef.userData = new MovieClip();
			if(polyTexture){
				//bodyDef.userData = new userData(0, vec, polyTexture); //for slicing..
				bodyDef.userData = new MovieClip();
			}else{
				bodyDef.userData = new MovieClip();//new userData(0, vec, new BitmapData(200,200)); //for slicing..
			}
			bodyDef.userData.bodyID = bodyID;
			addChild(bodyDef.userData);
			this.bodyDef.userData.name = _name;
			//this.bodyDef.position.Set(0/30, 0/30);//100
			this.body = this.world.CreateBody(this.bodyDef);
			this.fixtureDef = new b2FixtureDef();
			this.fixtureDef.density = 5;
			this.fixtureDef.friction = 0.2;
			this.fixtureDef.restitution = 0;
			this.conv.Separate(this.body, this.fixtureDef, vec);
			trace("created you poly body..")
			body.SetBullet(true);
			return body;
		}
		
		
		private function fallower(obj:b2Body):void{
			if(obj.GetUserData().fallowme && obj.GetUserData().fallowme is b2Body){
				var fallowerb2:b2Body = b2Body(obj.GetUserData().fallowme);
				fallowerb2.SetPositionAndAngle(obj.GetPosition(),obj.GetAngularVelocity());
			}
		}
		
		protected var conv:b2Separator = new b2Separator();
		public var allGifts:Vector.<b2Body> = new Vector.<b2Body>();
		public function set debugDraw(sp:Sprite)
		{
			var db:b2DebugDraw=new b2DebugDraw();
			db.SetSprite(sp);
			db.SetDrawScale(ptm_ratio);
			db.SetFillAlpha(0.2);
			db.SetLineThickness(2);
			db.SetFlags(b2DebugDraw.e_jointBit | b2DebugDraw.e_shapeBit) // | b2DebugDraw.e_centerOfMassBit//b2DebugDraw.e_shapeBit//t|b2DebugDraw.e_shapeBit
			world.SetDebugDraw(db);
		}
		
		public function realPixels(param1:Number) : Number
		{
			return (param1 / ptm_ratio) / 2;
		}// end function
		
		//remove all from the box2d world..
		public function removeEverything() : void
		{
			trace("removing everthing...")
			//trace("Removing Everything");
			var _loc_1:b2Body = world.GetBodyList();
			while (_loc_1)
			{
				
				if (_loc_1.GetUserData())
				{
					remove(_loc_1.GetUserData());
				}
				
				world.DestroyBody(_loc_1);
				
				_loc_1 = _loc_1.GetNext();
			}
			//clear all timers.
			//trace("Everything Removed");
		}
		
		public function remove(obj:DisplayObject,time:Number = 0,delay:Number = 0):void{
			if(time == 0){
				if(obj.parent){
					obj.parent.removeChild(obj);
				}
			}else if(obj.parent){
				obj.parent.removeChild(obj);
				trace("removeSlow",obj)
			}
		}
		
		public static function parseXYToPoints(ary:Array):Array{
			var vvvc:Array = [];
			for(var i:int =0; i<ary.length; i++){
				var k:Array = ary[i].split("+");
				if(k && k.length>1){
					vvvc.push(new Point(k[0],k[1]));
				}
			}
			return vvvc;
		}
	}
}