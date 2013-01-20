package com {
	import Box2D.Collision.Shapes.b2CircleShape;
	import Box2D.Collision.Shapes.b2PolygonShape;
	import Box2D.Common.Math.b2Vec2;
	import Box2D.Dynamics.Joints.b2PrismaticJoint;
	import Box2D.Dynamics.Joints.b2PrismaticJointDef;
	import Box2D.Dynamics.Joints.b2RevoluteJoint;
	import Box2D.Dynamics.Joints.b2RevoluteJointDef;
	import Box2D.Dynamics.b2Body;
	import Box2D.Dynamics.b2BodyDef;
	import Box2D.Dynamics.b2FixtureDef;
	import Box2D.Dynamics.b2World;
	
	import bala.BaseWorld;
	import bala.Utils.BalaUtils;
	
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.KeyboardEvent;
	import flash.geom.Point;
	import flash.ui.Keyboard;
	
	public class BikeBox2d extends MovieClip{
		
		private var worldScale:int=30;
		public static var me:BikeBox2d;
		public var bikeBody:b2Body;
		private var leftWheelRevoluteJoint:b2RevoluteJoint;
		private var rightWheelRevoluteJoint:b2RevoluteJoint;
		private var left:Boolean=false;
		private var right:Boolean=false;
		private var motorSpeed:Number=0;
		private var leftAxlePrismaticJoint:b2PrismaticJoint;
		private var rightAxlePrismaticJoint:b2PrismaticJoint;
		//
		private var carPosX:Number=320;
		private var carPosY:Number=250;
		private var carWidth:Number=45;
		private var carHeight:Number=10;
		
		private var axleContainerDistance:Number=60;
		private var axleContainerDistance_Wb:Number=0;
		private var axleContainerDistance_Wf:Number=0;
		
		private var axleContainerWidth:Number=5;
		private var axleContainerHeight:Number=20;
		private var axleContainerDepth:Number=10;
		private var axleAngle:Number=20;
		private var wheelRadius:Number=25;
		private const degreesToRadians:Number=0.0174532925;
		private var passWorld:b2World;
		public var motorPower:Number = 10;
		private var bikeBluePrint:MovieClip = new BikeBluePrint();
		public function BikeBox2d(_passWorld:b2World) {
			// Bala constructor code to setup dynamic values..
			me = this;
			passWorld = _passWorld;
			worldScale = BaseWorld.ptm_ratio;
			axleContainerDistance_Wb = Point.distance(new Point(bikeBluePrint.wb.x,0),new Point(bikeBluePrint.body.x,0))
			axleContainerDistance_Wf = Point.distance(new Point(bikeBluePrint.wf.x,0),new Point(bikeBluePrint.body.x,0))
			axleContainerDistance = BalaUtils.average(axleContainerDistance_Wb,axleContainerDistance_Wf);
			trace("axleContainerDistance=",axleContainerDistance);
			
			carPosX = bikeBluePrint.body.x;
			carPosY = bikeBluePrint.body.y;
			
			var avrgWheelLenFromBody:Number = BalaUtils.average(bikeBluePrint.wb.y,bikeBluePrint.wf.y);
			axleContainerHeight = Point.distance(new Point(0,bikeBluePrint.wb.y),new Point(0,carPosY))/2;
			//Bala dynamic pos and size from bikeBluePrint..
			if(axleContainerHeight<16){
				axleContainerHeight = 16;
			}
			trace("axleContainerHeight=",axleContainerHeight,carPosY,bikeBluePrint.wb.y)
			// ************************ THE CAR ************************ //
			var carShape:b2PolygonShape = new b2PolygonShape();
		//	trace(bikeBluePrint.body.width/2,bikeBluePrint.body.height/4,"arj")
			//carShape.SetAsBox(carWidth/worldScale,carHeight/worldScale);
			carShape.SetAsBox((bikeBluePrint.body.width/3.5)/worldScale,(bikeBluePrint.body.height/9)/worldScale);
			var carFixture:b2FixtureDef = new b2FixtureDef();
			carFixture.density=5;
			carFixture.friction=3;
			carFixture.restitution=0.3;
			carFixture.filter.groupIndex=-1;
			carFixture.shape=carShape;
			var carBodyDef:b2BodyDef = new b2BodyDef();
			carBodyDef.position.Set(carPosX/worldScale,carPosY/worldScale);
		carBodyDef.type=b2Body.b2_dynamicBody;
			carBodyDef.userData = new BikeBody_MC();
			Game.me.currentWeponMC = carBodyDef.userData.hand.currentWepon
			carBodyDef.userData.alpha = .5
			Game.me.addChild(carBodyDef.userData);
			
			// ************************ MERGING ALL TOGETHER ************************ //
			bikeBody=passWorld.CreateBody(carBodyDef);
			bikeBody.CreateFixture(carFixture);
		//	bikeBody.CreateFixture(leftAxleContainerFixture);
			//bikeBody.CreateFixture(rightAxleContainerFixture);
			// ************************ THE AXLES ************************ //
			var leftAxleShape:b2PolygonShape = new b2PolygonShape();
			leftAxleShape.SetAsOrientedBox(axleContainerWidth/worldScale/2,axleContainerHeight/worldScale,new b2Vec2(0,0),axleAngle*degreesToRadians);
			var leftAxleFixture:b2FixtureDef = new b2FixtureDef();
			leftAxleFixture.density=0.5;
			leftAxleFixture.friction=3;
			leftAxleFixture.restitution=0;
			leftAxleFixture.shape=leftAxleShape;
			leftAxleFixture.filter.groupIndex=-1;
			var leftAxleBodyDef:b2BodyDef = new b2BodyDef();
		leftAxleBodyDef.type=b2Body.b2_dynamicBody;
			var leftAxle:b2Body=passWorld.CreateBody(leftAxleBodyDef);
			leftAxle.CreateFixture(leftAxleFixture);
			leftAxle.SetPosition(new b2Vec2(carPosX/worldScale-axleContainerDistance/worldScale-axleContainerHeight/worldScale*Math.cos((90-axleAngle)*degreesToRadians),carPosY/worldScale+axleContainerDepth/worldScale+axleContainerHeight/worldScale*Math.sin((90-axleAngle)*degreesToRadians)));
			
			var rightAxleShape:b2PolygonShape = new b2PolygonShape();
			//rightAxleShape.position.Set()
			rightAxleShape.SetAsBox((bikeBluePrint.axelright.width/4)/worldScale,(bikeBluePrint.axelright.height/2)/worldScale)
			//rightAxleShape.SetAsOrientedBox((bikeBluePrint.axelright.width/2)/worldScale/2,(bikeBluePrint.axelright.height/2)/worldScale,new b2Vec2(0,0),-axleAngle*degreesToRadians);
			var rightAxleFixture:b2FixtureDef = new b2FixtureDef();
			rightAxleFixture.density=0.5;
			rightAxleFixture.friction=3;
			rightAxleFixture.restitution=0;
			rightAxleFixture.shape=rightAxleShape;
			rightAxleFixture.filter.groupIndex=-1;
			var rightAxleBodyDef:b2BodyDef = new b2BodyDef();
			rightAxleBodyDef.angle=bikeBluePrint.axelright.rotation*(Math.PI/180);
			rightAxleBodyDef.position.Set((bikeBluePrint.axelright.x)/worldScale,(bikeBluePrint.axelright.y)/worldScale)
			rightAxleBodyDef.type=b2Body.b2_dynamicBody;
			var rightAxle:b2Body=passWorld.CreateBody(rightAxleBodyDef);
			rightAxle.CreateFixture(rightAxleFixture);
			//rightAxle.SetPosition(new b2Vec2(carPosX/worldScale+axleContainerDistance/worldScale+axleContainerHeight/worldScale*Math.cos((90-axleAngle)*degreesToRadians),carPosY/worldScale+axleContainerDepth/worldScale+axleContainerHeight/worldScale*Math.sin((90-axleAngle)*degreesToRadians)));
			// ************************ THE WHEELS ************************ //;
			var wheelShape:b2CircleShape=new b2CircleShape((bikeBluePrint.wb.width/2)/worldScale);
			var wheelFixture:b2FixtureDef = new b2FixtureDef();
			wheelFixture.density=1;
			wheelFixture.friction=15;
			wheelFixture.restitution=0.2;
			wheelFixture.filter.groupIndex=-1;
			wheelFixture.shape=wheelShape;
			var wheelBodyDef:b2BodyDef = new b2BodyDef();
		wheelBodyDef.type=b2Body.b2_dynamicBody;
			//bala 1st wheel..wheelback-wb
			wheelBodyDef.position.Set(carPosX/worldScale-axleContainerDistance/worldScale-2*axleContainerHeight/worldScale*Math.cos((90-axleAngle)*degreesToRadians),carPosY/worldScale+axleContainerDepth/worldScale+2*axleContainerHeight/worldScale*Math.sin((90-axleAngle)*degreesToRadians));
			wheelBodyDef.userData = bikeBluePrint.wb;
			wheelBodyDef.userData.alpha = .4
			Game.me.addChild(wheelBodyDef.userData);
			var leftWheel:b2Body=passWorld.CreateBody(wheelBodyDef);
			leftWheel.CreateFixture(wheelFixture);
			//bala 2nd wheel..wheelfront-wf
			wheelFixture.shape=new b2CircleShape((bikeBluePrint.wf.width/2)/worldScale); 
			wheelBodyDef.position.Set(carPosX/worldScale+axleContainerDistance/worldScale+2*axleContainerHeight/worldScale*Math.cos((90-axleAngle)*degreesToRadians),carPosY/worldScale+axleContainerDepth/worldScale+2*axleContainerHeight/worldScale*Math.sin((90-axleAngle)*degreesToRadians));
			wheelBodyDef.userData =bikeBluePrint.wf;
			Game.me.addChild(wheelBodyDef.userData);
			var rightWheel:b2Body=passWorld.CreateBody(wheelBodyDef);
			rightWheel.CreateFixture(wheelFixture);
			
			// ************************ REVOLUTE JOINTS ************************ //
			var leftWheelRevoluteJointDef:b2RevoluteJointDef=new b2RevoluteJointDef();
			leftWheelRevoluteJointDef.Initialize(leftWheel,leftAxle,leftWheel.GetWorldCenter());
			leftWheelRevoluteJointDef.enableMotor=true;
			leftWheelRevoluteJoint=passWorld.CreateJoint(leftWheelRevoluteJointDef) as b2RevoluteJoint;
			leftWheelRevoluteJoint.SetMaxMotorTorque(10);
			var rightWheelRevoluteJointDef:b2RevoluteJointDef=new b2RevoluteJointDef();
			rightWheelRevoluteJointDef.Initialize(rightWheel,rightAxle,rightWheel.GetWorldCenter());
			rightWheelRevoluteJointDef.enableMotor=true;
			rightWheelRevoluteJoint=passWorld.CreateJoint(rightWheelRevoluteJointDef) as b2RevoluteJoint;
			rightWheelRevoluteJoint.SetMaxMotorTorque(motorPower);
			// ************************ PRISMATIC JOINTS ************************ //
			var leftAxlePrismaticJointDef:b2PrismaticJointDef=new b2PrismaticJointDef();
			leftAxlePrismaticJointDef.lowerTranslation=0;
			leftAxlePrismaticJointDef.upperTranslation=axleContainerDepth/worldScale;
			leftAxlePrismaticJointDef.enableLimit=true;
			leftAxlePrismaticJointDef.enableMotor=true;
			leftAxlePrismaticJointDef.Initialize(bikeBody,leftAxle,leftAxle.GetWorldCenter(), new b2Vec2(-Math.cos((90-axleAngle)*degreesToRadians),Math.sin((90-axleAngle)*degreesToRadians)));
			leftAxlePrismaticJoint=passWorld.CreateJoint(leftAxlePrismaticJointDef) as b2PrismaticJoint;
			leftAxlePrismaticJoint.SetMaxMotorForce(motorPower);                         
			leftAxlePrismaticJoint.SetMotorSpeed(10);                         			
			var rightAxlePrismaticJointDef:b2PrismaticJointDef=new b2PrismaticJointDef();
			rightAxlePrismaticJointDef.lowerTranslation=0;
			rightAxlePrismaticJointDef.upperTranslation=axleContainerDepth/worldScale;
			rightAxlePrismaticJointDef.enableLimit=true;
			rightAxlePrismaticJointDef.enableMotor=true;
			rightAxlePrismaticJointDef.Initialize(bikeBody,rightAxle,rightAxle.GetWorldCenter(), new b2Vec2(Math.cos((90-axleAngle)*degreesToRadians),Math.sin((90-axleAngle)*degreesToRadians)));
			rightAxlePrismaticJoint=passWorld.CreateJoint(rightAxlePrismaticJointDef) as b2PrismaticJoint;
			rightAxlePrismaticJoint.SetMaxMotorForce(motorPower);                         
			rightAxlePrismaticJoint.SetMotorSpeed(10);      
			//addEventListener(Event.ENTER_FRAME,updateWorld);
			//addEventListener(Event.ADDED_TO_STAGE,added);
			trace("bike added..");
		}
		
		public function keyDown(e:KeyboardEvent):void {
			switch (e.keyCode) {
				case Keyboard.LEFT :
					left=true;
					trace("left keyPressed")
					break;
				case Keyboard.RIGHT :
					right=true;
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
			}
		}
		public function updateBike(e:Event=null):void {
			if (left) {
				motorSpeed+=Game.currentBikeSpeed;
				trace("lefting..")
			}
			if (right) {
				motorSpeed-=Game.currentBikeSpeed;
				trace("righting...")
			}
			motorSpeed*=0.99;
			if (motorSpeed>10) {
				motorSpeed=10;
			}
			leftWheelRevoluteJoint.SetMotorSpeed(motorSpeed);
			rightWheelRevoluteJoint.SetMotorSpeed(motorSpeed);
		}
		
		
	}
	
}
