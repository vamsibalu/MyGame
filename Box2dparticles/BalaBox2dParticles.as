package {
	import Box2D.Dynamics.b2Body;
	import Box2D.Dynamics.b2FixtureDef;
	import Box2D.Collision.Shapes.b2CircleShape;
	import Box2D.Dynamics.b2World;
	import Box2D.Dynamics.b2BodyDef;
	import flash.display.Sprite;
	import Box2D.Collision.Shapes.b2PolygonShape;
	import flash.display.MovieClip;
	import Box2D.Common.Math.b2Vec2;

	public class BalaBox2dParticles {
		public var world:b2World;
		public var cont:Sprite;
		public function BalaBox2dParticles(_world,_cont) {
			// constructor code
			world=_world;
			cont=_cont;
		}
		private var ptm_ratio:Number=30;
		public var bodies:Vector.<b2Body> = new Vector.<b2Body>();
		var body:b2Body;
		var bodyDef:b2BodyDef;
		var fixtureDef:b2FixtureDef;
		var busyItems:Vector.<b2Body> = new Vector.<b2Body>();

		public function createCircle(bodyID:String,xx:Number,yy:Number,rr:Number,counter:int) {


			var circleDef:b2CircleShape;
			fixtureDef = new b2FixtureDef();
			bodyDef=new b2BodyDef();
			bodyDef.type=b2Body.b2_dynamicBody;
			bodyDef.position.Set(xx/ptm_ratio,yy/ptm_ratio);
			bodyDef.userData = new CircleStone();
			bodyDef.userData.name="ball";//override
			fixtureDef.friction=1;
			fixtureDef.restitution=0.1;
			//fixtureDef.filter.groupIndex=-4;
			bodyDef.userData.width=rr;
			bodyDef.userData.height=rr;
			bodyDef.userData.x=xx;
			bodyDef.userData.y=yy;
			bodyDef.userData.rotation=0;
			//bodyDef.userData=new addebles()
			//bodyDef.userData.width=_w*2
			//bodyDef.userData.height=_h*2
			//this_parent.addChildAt(bodyDef.userData,2)
			circleDef=new b2CircleShape(realPixels(rr));
			fixtureDef.density=1;
			fixtureDef.shape=circleDef;
			//create particles..

			for (var k:int = 0; k<counter; k++) {
				bodyDef.userData = new CircleStone();
				bodyDef.userData.busy=false;
				var bb:b2Body=createBody();
				bb.SetActive(false);
			}
		}

		private function createBody():b2Body {
			body=world.CreateBody(bodyDef);
			body.CreateFixture(fixtureDef);
			cont.addChild(bodyDef.userData);
			bodies.push(body);
			return body;
		}

		var tempBB:b2Body;
		var tempVec:b2Vec2 = new b2Vec2();
		public function addParticle(xx:Number,yy:Number,ang:Number,ang2:Number,pow:Number = 0.001,canDie:Boolean = true):void {
			for each (var bb:b2Body in busyItems) {
				if (bb.IsAwake()==false||bb.GetUserData().currentFrame==1) {
					tempBB=busyItems.splice(busyItems.indexOf(bb),1)[0];
					bodies.push(tempBB);
					tempVec.x=0;
					tempVec.y=0;
					tempBB.SetPosition(tempVec);
					tempBB.SetAwake(false);
					tempBB.SetActive(false);
				}
			}

			tempBB=null;
			tempBB=bodies.pop();
			if (tempBB) {
				tempVec.x=xx;
				tempVec.y=yy;
				if (canDie == true) {
					tempBB.GetUserData().play();
				} else {
					trace("all parti creating..")
					tempBB.GetUserData().gotoAndStop(1);
				}
				tempBB.SetPosition(tempVec);
				tempBB.SetActive(true);
				tempBB.SetAwake(true);
				busyItems.push(tempBB);
				//tempBB.ApplyTorque(Math.random());
				//tempBB.ApplyImpulse(new b2Vec2(Math.random()/2,Math.random()/2),tempBB.GetWorldCenter());
				//watr.ApplyImpulse(new b2Vec2(Math.cos(fireEngine1_angle)*pow/90, Math.sin(fireEngine1_angle)*pow/90),watr.GetWorldCenter());
				var cc:Number=randomWithinRange(ang,ang2);
				//tempBB.ApplyImpulse(new b2Vec2(Math.cos(cc),Math.sin(cc)),tempBB.GetWorldCenter());
			}

		}

		public function randomWithinRange(min:Number, max:Number):Number {
			return min + (Math.random() * (max - min));
		}

		public function realPixels(param1:Number):Number {
			return (param1 / ptm_ratio) / 2;
		}// end function

	}

}