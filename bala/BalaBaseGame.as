﻿package bala
{
	import Box2D.Collision.Shapes.b2CircleShape;
	import Box2D.Collision.Shapes.b2PolygonShape;
	import Box2D.Collision.Shapes.b2Shape;
	import Box2D.Collision.b2AABB;
	import Box2D.Common.Math.b2Vec2;
	import Box2D.Dynamics.Joints.b2RevoluteJointDef;
	import Box2D.Dynamics.b2Body;
	import Box2D.Dynamics.b2BodyDef;
	import Box2D.Dynamics.b2Fixture;
	import Box2D.Dynamics.b2FixtureDef;
	
	import bala.Utils.BalaUtils;
	
	import com.Game;
	
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.geom.Point;
	
	/**
	 * @author : Balakrishna.
	 * @email  : vamsibalu@gmail.com
	 * @version: 5.0
	 */
	public class BalaBaseGame extends ShapeWorld
	{
		
		[Embed(source='BalaLevelData.xml',mimeType="application/octet-stream")]
		private static const Levels:Class;
		public var levelDataXML:XML;
		private var blUtils:BalaUtils = new BalaUtils();
		public var allLevels:Array = [];
		public var sp:Sprite = new Sprite();
		
		//for game logics..
		public var totalEnemys:int = 0;
		
		public function BalaBaseGame(_dummyXML:XML,ww:Number)
		{
			trace("BalaBaseGame initialized1..")
			super(ww);
			
			//debugDraw = sp;
			addChild(sp);
			
			if(_dummyXML){
				levelDataXML= _dummyXML;
				trace("Used local XML")
			}else{
				levelDataXML = XML(new Levels());
			}
			blUtils.parseXMLData(levelDataXML,allLevels);
			//loadMyLevelForPreview(allLevels[1]);
			trace("got all levels=",allLevels.length)
			//startRender();
			trace("BalaBaseGame initialized2..")
		}
		
		public function loadMyLevelForPreview(_levelAry:Array):void{
			//trace("loadMyLevelForPreview objects no.=",_levelAry)
			removeEverything();
			setUpWalls();
			encc = 0;
			for(var obj:Object in _levelAry){
				var ary:Array;
				switch(_levelAry[obj][0])
				{
					case "BaseMC":
						ary = _levelAry[obj];
						createBase(ary[1],ary[2],ary[3],ary[4],ary[5],ary[6],ary[7]);
						break;
					case "hero":
						ary = _levelAry[obj];
						//trace("hero=",_levelAry[obj]);
						//createHero(ary[1],ary[2],ary[3],0);
						break;
					case "enemy":
						ary = _levelAry[obj];
						//trace("enemy=",_levelAry[obj]);
						createEnemy(ary[1],ary[2],ary[3],0);
						break;
					case "Block":
						ary = _levelAry[obj];
						//trace("boxx=",_levelAry[obj]);
						createBox(ary[1],ary[2],ary[3],ary[4],ary[5],ary[6],ary[7],true);
						break;
					case "GridIron":
						ary = _levelAry[obj];
						//trace("IROn=",_levelAry[obj]);
						createBox(ary[1],ary[2],ary[3],ary[4],ary[5],ary[6],ary[7],false,true);
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
					case "Bridge":
						ary = _levelAry[obj];
						//trace("B2Preview Bridge Data to Show=",ary);
						createHangingBridges(ary[1],parseXYToPoints(ary),ary[0],null,Number(ary[ary.length-1]),int(ary[ary.length-2])); //all are statics
						break;
				}
			}
			
			//trace("creating joints..")
			//for joints..
			for(var jjj:Object in _levelAry){
				switch(_levelAry[jjj][0])
				{
					case "JNT":
						ary = _levelAry[jjj];
						var p11:Point = new Point(ary[2].split("_")[0],ary[2].split("_")[1]);
						var p22:Point = new Point(ary[3].split("_")[0],ary[3].split("_")[1]);
						createJoint(ary[1].split("_")[1],p11,p22,ary[4],ary[5],ary[6],ary[7]);
						break;
				}
			}
			
			
		}
		
		//test for joints..
		private function createJoint(jointID:int,p1:Point,p2:Point,motorSpeed:Number,maxMotorTorque:Number,lowerAngle:Number,upperAngle:Number):void{
			p1.x = p1.x/ptm_ratio;
			p1.y = p1.y/ptm_ratio;
			p2.x = p2.x/ptm_ratio;
			p2.y = p2.y/ptm_ratio;
			var b1:b2Body = GetBodyAtMouse(p1.x,p1.y,true);//findBodyAtPoint(p1.x,p1.y);//getBodyByID(b1id);//
			var b2:b2Body = GetBodyAtMouse(p2.x,p2.y,true);
			//trace("preview Joint points=",p1,p2);
			//trace("preview Joint id=",jointID,b1,b2);
			if(b1==null || b2==null){
				if(b1){
					revoluteJointMaker(b1,world.GetGroundBody(),new b2Vec2(p1.x,p1.y),motorSpeed,maxMotorTorque,lowerAngle,upperAngle);
				}else if(b2){
					revoluteJointMaker(b2,world.GetGroundBody(),new b2Vec2(p2.x,p2.y),motorSpeed,maxMotorTorque,lowerAngle,upperAngle);
				}
			}else{
				revoluteJointMaker(b1,b2,new b2Vec2(p1.x,p1.y),motorSpeed,maxMotorTorque,lowerAngle,upperAngle);
			}
		}
		
		private var _mousePVec:b2Vec2 = new b2Vec2();
		private function GetBodyAtMouse(_mouseXWorldPhys:Number,_mouseYWorldPhys:Number,includeStatic:Boolean = false):b2Body
		{
			_mousePVec.Set(_mouseXWorldPhys, _mouseYWorldPhys);
			var aabb:b2AABB = new b2AABB();
			aabb.lowerBound.Set(_mouseXWorldPhys - 0.001, _mouseYWorldPhys - 0.001);
			aabb.upperBound.Set(_mouseXWorldPhys + 0.001, _mouseYWorldPhys + 0.001);
			var body:b2Body = null;
			var fixture:b2Fixture;
			
			// Query the world for overlapping shapes.
			function GetBodyCallback(fixture:b2Fixture):Boolean
			{
				var shape:b2Shape = fixture.GetShape();
				if (fixture.GetBody().GetType() != b2Body.b2_staticBody || includeStatic)
				{
					var inside:Boolean = shape.TestPoint(fixture.GetBody().GetTransform(), _mousePVec);
					if (inside)
					{
						body = fixture.GetBody();
						return false;
					}
				}
				return true;
			}
			world.QueryAABB(GetBodyCallback, aabb);
			return body;
		}
		
		public var canon:b2Body;
		public function newHero(_x1:Number,_y1:Number):void{
			//body medil
			bodyDef=new b2BodyDef()
			bodyDef.position.Set(_x1/ptm_ratio,(_y1/ptm_ratio)-realPixels(50))
			bodyDef.type=b2Body.b2_dynamicBody
			bodyDef.angle=Math.PI/9
			bodyDef.userData=new MovieClip();
			var hipmc:MovieClip = bodyDef.userData;
			bodyDef.userData.name = "playerhead";
			Game.me.addChild(bodyDef.userData);
			boxDef=new b2PolygonShape()
			boxDef.SetAsBox(realPixels(10),realPixels(60))
			fixtureDef=new b2FixtureDef()
			fixtureDef.density=1
			fixtureDef.friction=0.4
			fixtureDef.restitution=0.1
			fixtureDef.shape=boxDef
			fixtureDef.filter.groupIndex=-3;  //added bala for multiplayer bikes
			var middliebody:b2Body=world.CreateBody(bodyDef)
			middliebody.CreateFixture(fixtureDef);
			
			//stand...
			canon = createBox("boxxx",_x1,_y1,60,10,0,"standard",false);
			
			var rjd:b2RevoluteJointDef=new b2RevoluteJointDef()
			rjd.enableLimit=true
			rjd.lowerAngle=-10//(180/Math.PI)
			rjd.upperAngle=10;
			rjd.maxMotorTorque = 1;
			//rjd.enableMotor = true;
			
			rjd.Initialize(canon,middliebody,new b2Vec2((_x1+5)/ptm_ratio,((_y1)/ptm_ratio)))
			world.CreateJoint(rjd);
		}
		
		public var allZombies:Vector.<ZombieRunner> = new Vector.<ZombieRunner>();
		public function createZombies(nm:int,xx:Number,yy:Number):void{
			for(var i:int = 0; i<nm; i++){
				var zombieRuns:ZombieRunner = new ZombieRunner(this);
				zombieRuns.createZombieRun("myzimbe",new zombierun1(),xx,yy,0)
				allZombies.push(zombieRuns);
			}
		}
	}
}