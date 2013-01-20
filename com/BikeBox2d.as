package com
{
	import flash.display.MovieClip;
	import Box2D.Dynamics.b2Body;
	import Box2D.Dynamics.b2BodyDef;
	import Box2D.Collision.Shapes.b2PolygonShape;
	import Box2D.Collision.Shapes.b2CircleShape;
	import Box2D.Dynamics.b2FixtureDef;
	import Box2D.Dynamics.Joints.b2PrismaticJointDef;
	import Box2D.Dynamics.Joints.b2RevoluteJointDef;
	import Box2D.Common.Math.b2Vec2;
	import Box2D.Dynamics.Joints.b2RevoluteJoint;
	import Box2D.Dynamics.Joints.b2PrismaticJoint;
	import flash.events.KeyboardEvent;
	import flash.events.Event;
	import flash.ui.Keyboard;
	import flash.geom.Point;
	import Box2D.Dynamics.b2World;
	import bala.BaseWorld;

	public class BikeBox2d extends MovieClip
	{
		private var bodyDef:b2BodyDef;
		private var boxDef:b2PolygonShape;
		private var circleDef:b2CircleShape;
		private var fixtureDef:b2FixtureDef;
		private var frent_axel:b2Body;
		private var back_axel:b2Body;
		private var frent_wheel:b2Body
		private var back_wheel:b2Body;
		private var this_parent:Object;
		private var pjd:b2PrismaticJointDef;
		private var rjd:b2RevoluteJointDef;
		private var body_skin:MovieClip
		
		private var back_wheel_skin:MovieClip
		private var r2p:Number=17
		
		private var down_key:Boolean;
		private var up_key:Boolean;
		private var left:Boolean=false;
		private var right:Boolean=false;
		private var speed:Number = 0;
		private var speed_decay:Number = 0.98;
		private var acceleration:Number = 1;
		private var wheel_rotation:Number=0.5
		private var bikeBluePrint:MovieClip = new BikeBluePrint();
		
		private var axleContainerDistance:Number=60;
		private var axleContainerDistance_Wb:Number=0;
		private var axleContainerDistance_Wf:Number=0;
		
		public static var player_body:b2Body
		private var player_move_body:b2Body
		private var middliebody:b2Body
		private var legup:b2Body
		private var legdown:b2Body
		private   var b_and_c_joint1:b2RevoluteJoint
		private  var b_and_c_joint2:b2RevoluteJoint
		
		
		//
		private var worldScale:int=30;
		public static var me:BikeBox2d;
		
		private var car:b2Body;
		private var leftWheelRevoluteJoint:b2RevoluteJoint;
		private var rightWheelRevoluteJoint:b2RevoluteJoint;
		
		private var motorSpeed:Number=0;
		private var leftAxlePrismaticJoint:b2PrismaticJoint;
		private var rightAxlePrismaticJoint:b2PrismaticJoint;
		//
		private var carPosX:Number=320;
		private var carPosY:Number=250;
		private var carWidth:Number=45;
		private var carHeight:Number=10;
		
		
		
		private var axleContainerWidth:Number=5;
		private var axleContainerHeight:Number=20;
		private var axleContainerDepth:Number=10;
		private var axleAngle:Number=20;
		private var wheelRadius:Number=25;
		private const degreesToRadians:Number=0.0174532925;
		private var passWorld:b2World;
		public var motorPower:Number = 10;
		
		
		public function BikeBox2d(_passWorld:b2World)
		{
			// constructor code
			passWorld = _passWorld;
			worldScale = BaseWorld.ptm_ratio;
		}
		public function create(_xx:Number,_yy:Number)
		{
			axleContainerDistance_Wb = Point.distance(new Point(bikeBluePrint.wb.x,0),new Point(bikeBluePrint.body.x,0))
			axleContainerDistance_Wf = Point.distance(new Point(bikeBluePrint.wf.x,0),new Point(bikeBluePrint.body.x,0))
			
			
			
				bodyDef=new b2BodyDef();
				bodyDef.position.Set(bikeBluePrint.bikemainbody.x/30,bikeBluePrint.bikemainbody.y/30);
				//trace(_xx,_yy,bikeBluePrint.body.x,bikeBluePrint.body.x/30,bikeBluePrint.body.x/17,"arjj")
				bodyDef.type = b2Body.b2_dynamicBody;
				bodyDef.userData=new BikeBody_MC();
				bodyDef.userData.alpha=1
				Game.me.addChild(bodyDef.userData);
				body_skin=bodyDef.userData
				boxDef=new b2PolygonShape();
				boxDef.SetAsBox((bikeBluePrint.bikemainbody.width/2)/worldScale,(bikeBluePrint.bikemainbody.height/2)/worldScale);
				fixtureDef=new b2FixtureDef();
				fixtureDef.density = 0;
				fixtureDef.friction = 1;
				fixtureDef.restitution = 0.2;
				fixtureDef.shape = boxDef;
				fixtureDef.filter.groupIndex = -1;
				player_body = passWorld.CreateBody(bodyDef);
				player_body.CreateFixture(fixtureDef);
				boxDef.SetAsOrientedBox(5/r2p,5/r2p,new b2Vec2(0,10/r2p),0)
				fixtureDef.shape=boxDef
				player_body.CreateFixture(fixtureDef)
				
				//frent axel;
				trace("rotation6  "+ player_body.GetAngle())
				bodyDef=new b2BodyDef();
				trace(axleContainerDistance_Wb,axleContainerDistance_Wf,"arj")
				bodyDef.position.Set(bikeBluePrint.wf.x/30,(bikeBluePrint.wf.y-12)/30);
				//bodyDef.position.Set(_xx+26/r2p,_yy+12/r2p);
				//bodyDef.position.Set(bikeBluePrint.wf.x/r2p,bikeBluePrint.wf.y/r2p);
				bodyDef.type = b2Body.b2_dynamicBody;
				boxDef=new b2PolygonShape();
				boxDef.SetAsBox(3/r2p,5/r2p);
				fixtureDef=new b2FixtureDef();
				fixtureDef.density = 0.5;
				fixtureDef.friction = 0.5;
				fixtureDef.restitution = 0.2;
				fixtureDef.shape = boxDef;
				fixtureDef.filter.groupIndex = -1;
				frent_axel = passWorld.CreateBody(bodyDef);
				frent_axel.CreateFixture(fixtureDef);
				//back axel;
				bodyDef=new b2BodyDef();
				bodyDef.position.Set(bikeBluePrint.wb.x/30,(bikeBluePrint.wb.y-12)/30);
				//bodyDef.position.Set(_xx-39/r2p,_yy+8/r2p);
				bodyDef.type = b2Body.b2_dynamicBody;
				boxDef=new b2PolygonShape();
				boxDef.SetAsBox(3/r2p,5/r2p);
				fixtureDef=new b2FixtureDef();
				fixtureDef.density = 0.5;
				fixtureDef.friction = 0.5;
				fixtureDef.restitution = 0.2;
				fixtureDef.shape = boxDef;
				fixtureDef.filter.groupIndex = -1;
				back_axel = passWorld.CreateBody(bodyDef);
				back_axel.CreateFixture(fixtureDef);
				
				//frent wheel;
				bodyDef=new b2BodyDef();
				bodyDef.position.Set(frent_axel.GetWorldCenter().x,frent_axel.GetWorldCenter().y+5/r2p);
				bodyDef.type = b2Body.b2_dynamicBody;
				bodyDef.userData=new Wheel_MC();
				bodyDef.userData.width = (bikeBluePrint.wf.width)
				//bodyDef.userData.width = bikeBluePrint.wf.width
				bodyDef.userData.height = (bikeBluePrint.wf.width)
				Game.me.addChild(bodyDef.userData);
				//Physics.frent_wheel_skin=bodyDef.userData
				//circleDef = new b2CircleShape(13 / r2p);
				trace(13 / r2p,"jhjjhjkk", bikeBluePrint.wf.width/worldScale)
				circleDef = new b2CircleShape( (bikeBluePrint.wf.width/2)/worldScale);
				fixtureDef=new b2FixtureDef();
				fixtureDef.density = 1;
				fixtureDef.friction = 0.5;
				fixtureDef.restitution = 0.5;
				fixtureDef.filter.groupIndex = -1;
				fixtureDef.shape = circleDef;
				frent_wheel = passWorld.CreateBody(bodyDef);
				frent_wheel.CreateFixture(fixtureDef);
				//back wheel;
				bodyDef=new b2BodyDef();
				bodyDef.position.Set(back_axel.GetWorldCenter().x,back_axel.GetWorldCenter().y+5/r2p);
				bodyDef.type = b2Body.b2_dynamicBody;
				bodyDef.userData=new Wheel_MC();
				bodyDef.userData.width = bikeBluePrint.wb.width
				bodyDef.userData.height = bikeBluePrint.wb.width
				Game.me.addChild(bodyDef.userData);
				back_wheel_skin=bodyDef.userData
				//circleDef = new b2CircleShape(13 / r2p);
				circleDef = new b2CircleShape( (bikeBluePrint.wb.width/2)/worldScale);
				fixtureDef=new b2FixtureDef();
				fixtureDef.density = 1;
				fixtureDef.friction = 0.5;
				fixtureDef.restitution = 0.5;
				fixtureDef.filter.groupIndex = -1;
				fixtureDef.shape = circleDef;
				back_wheel = passWorld.CreateBody(bodyDef);
				back_wheel.CreateFixture(fixtureDef);
				rjd=new b2RevoluteJointDef();
				rjd.enableMotor = true;
				//rjd.maxMotorTorque=10
				rjd.Initialize(frent_wheel,frent_axel,new b2Vec2(frent_axel.GetWorldCenter().x,frent_axel.GetWorldCenter().y+5/r2p));
				rightWheelRevoluteJoint=passWorld.CreateJoint(rjd) as b2RevoluteJoint;
				rjd=new b2RevoluteJointDef();
				rjd.enableMotor = true;
				//rjd.maxMotorTorque=10
				rjd.Initialize(back_wheel,back_axel,new b2Vec2(back_axel.GetWorldCenter().x,back_axel.GetWorldCenter().y+5/r2p));
				leftWheelRevoluteJoint=passWorld.CreateJoint(rjd) as b2RevoluteJoint;
				pjd=new b2PrismaticJointDef();
				pjd.lowerTranslation = -0.1;
				pjd.upperTranslation = 0.1;
				pjd.enableMotor = true;
				pjd.enableLimit = true;
				pjd.Initialize(player_body,frent_axel,frent_axel.GetWorldCenter(),new b2Vec2(0,1));
				rightAxlePrismaticJoint=passWorld.CreateJoint(pjd) as b2PrismaticJoint;
				pjd=new b2PrismaticJointDef();
				pjd.lowerTranslation = -0.1;
				pjd.upperTranslation = 0.1;
				pjd.enableMotor = true;
				pjd.enableLimit = true;
				pjd.Initialize(player_body,back_axel,back_axel.GetWorldCenter(),new b2Vec2(0,1));
				leftAxlePrismaticJoint = passWorld.CreateJoint(pjd) as b2PrismaticJoint;
				
				//Physics.frente_wheel=frent_wheel
				trace(_xx,"centerrr ",_yy)
				//character(_xx,_yy)
				character(bikeBluePrint.bikemainbody.x/30,(bikeBluePrint.bikemainbody.y-10)/30)
		}
		
			var uprhandBody:b2Body
			var lwrhandBody:b2Body
			
			
			var headbody:b2Body
			var body7:b2Body
			var body8:b2Body
			var body9:b2Body			
			var rjd1:b2RevoluteJointDef
		private function character(_x1:Number,_y1:Number){
			
			var bodyDef:b2BodyDef
			var boxDef:b2PolygonShape
			var circleDef:b2CircleShape
			var fixtureDef:b2FixtureDef
			var rjd:b2RevoluteJointDef
			//man center control
			
			bodyDef=new b2BodyDef()
			bodyDef.position.Set(_x1-10/r2p,_y1-7/r2p)
			bodyDef.type=b2Body.b2_dynamicBody
			circleDef=new b2CircleShape(3/r2p)
			fixtureDef=new b2FixtureDef()
			fixtureDef.density=0.1
			fixtureDef.friction=0.4
			fixtureDef.restitution=0.1
			fixtureDef.shape=circleDef
			fixtureDef.filter.groupIndex=-1
			player_move_body=passWorld.CreateBody(bodyDef)
			player_move_body.CreateFixture(fixtureDef)
			//body medil
			bodyDef=new b2BodyDef()
			bodyDef.position.Set(_x1-7/r2p,_y1-15/r2p)
			bodyDef.type=b2Body.b2_dynamicBody
			bodyDef.angle=Math.PI/9
			bodyDef.userData=new hip();
			//bodyDef.userData.alpha=0
			Game.me.addChild(bodyDef.userData);
			boxDef=new b2PolygonShape()
			boxDef.SetAsBox(4/r2p,7/r2p)
			fixtureDef=new b2FixtureDef()
			fixtureDef.density=0.1
			fixtureDef.friction=0.4
			fixtureDef.restitution=0.1
			fixtureDef.shape=boxDef
			//fixtureDef.filter.groupIndex=-1
			middliebody=passWorld.CreateBody(bodyDef)
			middliebody.CreateFixture(fixtureDef)
			rjd=new b2RevoluteJointDef()
			rjd.enableLimit=true
			rjd.lowerAngle=0//(180/Math.PI)
			rjd.upperAngle=0
			rjd.Initialize(player_move_body,middliebody,new b2Vec2(_x1-10/r2p,_y1-7/r2p))
			passWorld.CreateJoint(rjd)
			//uper foot
			bodyDef=new b2BodyDef()
			bodyDef.position.Set(_x1-5/r2p,_y1-3/r2p)
			bodyDef.type=b2Body.b2_dynamicBody
			bodyDef.angle=Math.PI/5
			bodyDef.userData=new leg1();
			//bodyDef.userData.alpha=0.1
				Game.me.addChild(bodyDef.userData);
			boxDef=new b2PolygonShape()
			boxDef.SetAsBox(6/r2p,3/r2p)
			fixtureDef=new b2FixtureDef()
			fixtureDef.density=0.1
			fixtureDef.friction=0.4
			fixtureDef.restitution=0.1
			fixtureDef.shape=boxDef
			fixtureDef.filter.groupIndex=-1
			legup=passWorld.CreateBody(bodyDef)
			legup.CreateFixture(fixtureDef)
			rjd=new b2RevoluteJointDef()
			rjd.enableLimit=true
			rjd.lowerAngle=0//(180/Math.PI)
			rjd.upperAngle=0
			rjd.Initialize(player_move_body,legup,new b2Vec2(_x1-10/r2p,_y1-7/r2p))
			passWorld.CreateJoint(rjd)
			//down foot
			bodyDef=new b2BodyDef()
			bodyDef.position.Set(_x1-4/r2p,_y1+5/r2p)
			bodyDef.type=b2Body.b2_dynamicBody
			bodyDef.angle=Math.PI/6
			bodyDef.userData=new leg();
			Game.me.addChild(bodyDef.userData);
			boxDef=new b2PolygonShape()
			boxDef.SetAsBox(3/r2p,6/r2p)
			fixtureDef=new b2FixtureDef()
			fixtureDef.density=0.1
			fixtureDef.friction=0.4
			fixtureDef.restitution=0.1
			fixtureDef.shape=boxDef
			fixtureDef.filter.groupIndex=-1
			legdown=passWorld.CreateBody(bodyDef)
			legdown.CreateFixture(fixtureDef)
			rjd=new b2RevoluteJointDef()
			rjd.enableLimit=true
			rjd.lowerAngle=0//(180/Math.PI)
			rjd.upperAngle=0
			rjd.Initialize(legup,legdown,new b2Vec2(_x1,_y1))
			passWorld.CreateJoint(rjd)
			//uper hand
			bodyDef=new b2BodyDef()
			bodyDef.position.Set(_x1-4/r2p,_y1-15/r2p)
			bodyDef.type=b2Body.b2_dynamicBody
			bodyDef.angle=Math.PI/3
			bodyDef.userData=new hand1();
			//bodyDef.userData.alpha=0.2
			Game.me.addChild(bodyDef.userData);
			boxDef=new b2PolygonShape()
			boxDef.SetAsBox(5/r2p,2/r2p)
			fixtureDef=new b2FixtureDef()
			fixtureDef.density=0.1
			fixtureDef.friction=0.4
			fixtureDef.restitution=0.1
			fixtureDef.shape=boxDef
			//fixtureDef.filter.groupIndex=-1
			uprhandBody=passWorld.CreateBody(bodyDef)
			uprhandBody.CreateFixture(fixtureDef)
			rjd=new b2RevoluteJointDef()
			rjd.enableLimit=true
			rjd.lowerAngle=0//(180/Math.PI)
			rjd.upperAngle=0
			rjd.Initialize(middliebody,uprhandBody,new b2Vec2(_x1-4/r2p,_y1-16/r2p))
			passWorld.CreateJoint(rjd)
			//lower hand
			bodyDef=new b2BodyDef()
			bodyDef.position.Set(_x1+4/r2p,_y1-9/r2p)
			bodyDef.type=b2Body.b2_dynamicBody
			//bodyDef.angle=-Math.PI/4
			bodyDef.userData=new hand2();
			//bodyDef.userData.alpha=0.2
			Game.me.addChild(bodyDef.userData);
			boxDef=new b2PolygonShape()
			boxDef.SetAsBox(4/r2p,2/r2p)
			fixtureDef=new b2FixtureDef()
			fixtureDef.density=0.1
			fixtureDef.friction=0.4
			fixtureDef.restitution=0.1
			fixtureDef.shape=boxDef
			//fixtureDef.filter.groupIndex=-1
			lwrhandBody=passWorld.CreateBody(bodyDef)
			lwrhandBody.CreateFixture(fixtureDef)
			rjd=new b2RevoluteJointDef()
			rjd.enableLimit=true
			rjd.lowerAngle=0
			rjd.upperAngle=0//(180/Math.PI)
			rjd.Initialize(uprhandBody,lwrhandBody,new b2Vec2(_x1+0.5/r2p,_y1-7/r2p))
			passWorld.CreateJoint(rjd)			
			//head
			bodyDef=new b2BodyDef()
			bodyDef.position.Set(_x1-1/r2p,_y1-26/r2p)
			bodyDef.angle=Math.PI/6
			bodyDef.type=b2Body.b2_dynamicBody
			bodyDef.userData=new head();
			bodyDef.userData.alpha=0.2
			Game.me.addChild(bodyDef.userData);
			circleDef=new b2CircleShape(4/r2p)
			fixtureDef=new b2FixtureDef()
			fixtureDef.density=0.1
			fixtureDef.friction=0.4
			fixtureDef.restitution=0.1
			fixtureDef.shape=circleDef
			//fixtureDef.filter.groupIndex=-1
			headbody=passWorld.CreateBody(bodyDef)
			headbody.CreateFixture(fixtureDef)
			rjd=new b2RevoluteJointDef()
			rjd.enableLimit=true
			rjd.lowerAngle=0//(180/Math.PI)
			rjd.upperAngle=0
			
			rjd.Initialize(middliebody,headbody,new b2Vec2(_x1-5/r2p,_y1-19/r2p))
			passWorld.CreateJoint(rjd)
			
			rjd1=new b2RevoluteJointDef()
			rjd1.enableLimit=true
			rjd1.lowerAngle=-30/(180/Math.PI)
			rjd1.upperAngle=115/(180/Math.PI)
			rjd1.Initialize(legdown,player_body,new b2Vec2(_x1-6/r2p,_y1+12/r2p))
			b_and_c_joint1 = passWorld.CreateJoint(rjd1)as b2RevoluteJoint
			
			rjd1=new b2RevoluteJointDef()
			rjd1.enableLimit=true
			rjd1.lowerAngle=-15/(180/Math.PI)
			rjd1.upperAngle=45/(180/Math.PI)
			rjd1.Initialize(lwrhandBody,player_body,new b2Vec2(_x1+8/r2p,_y1-8/r2p))
			b_and_c_joint2=passWorld.CreateJoint(rjd1) as b2RevoluteJoint
			
			
			
		}
		public function bikeRotation()
		{}
		
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
					
			}
		}
		public function updateBike(e:Event=null):void 
		{
			
			if (left) {
				player_body.ApplyTorque(20);
				player_move_body.ApplyImpulse(new b2Vec2(-1.50,0.50),player_move_body.GetWorldCenter())
				middliebody.ApplyImpulse(new b2Vec2(-2.8,0.5),middliebody.GetWorldCenter())
				middliebody.SetLinearVelocity(new b2Vec2(-2,0))
				headbody.ApplyImpulse(new b2Vec2(0.1,-0.1),headbody.GetWorldCenter())
				//legup.ApplyImpulse(new b2Vec2(-1,-0.50),legup.GetWorldCenter())
				middliebody.SetAngularVelocity(30)
				
			} else if (right) {
				player_body.ApplyTorque(20);
				player_move_body.ApplyImpulse(new b2Vec2(-0.50,0.50),player_move_body.GetWorldCenter())
				middliebody.ApplyImpulse(new b2Vec2(1.3,0.2),middliebody.GetWorldCenter())
				headbody.ApplyImpulse(new b2Vec2(0.0,-0.1),headbody.GetWorldCenter())
				//middliebody.ApplyTorque(-5)
				middliebody.SetAngularVelocity(10)
			} else {
				player_body.ApplyTorque(0);
			}
			if (Math.abs(speed) > 0.98) {
				speed *=  speed_decay;
			} else {
				speed = 0;
			}
			if (up_key) {
				speed -=  acceleration;
				wheel_rotation=10
			} else if (down_key) {
				speed +=  acceleration ;
				wheel_rotation=10
			}else{
				wheel_rotation=0.5
				}
				
			rightWheelRevoluteJoint.SetMotorSpeed(speed);
			rightWheelRevoluteJoint.SetMaxMotorTorque(wheel_rotation);
			leftWheelRevoluteJoint.SetMotorSpeed(speed);
			leftWheelRevoluteJoint.SetMaxMotorTorque(wheel_rotation);
			//trace(((-Physics.m2p*player_body.GetWorldCenter().x+SCREEN_WIDTH/2-player_body.GetLinearVelocity().x*5))/3+" screen")
		//screen.x-=30+(screen.x-(-Physics.m2p*player_body.GetWorldCenter().x+SCREEN_WIDTH/2-player_body.GetLinearVelocity().x*5))/3;
//screen.y -= (screen.y - (-Physics.m2p*player_body.GetWorldCenter().y + 2*SCREEN_HEIGHT/4 + player_body.GetLinearVelocity().y*6))/3;

			
			}

	}

}