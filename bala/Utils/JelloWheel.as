package bala.Utils
{
	import Box2D.Collision.Shapes.b2CircleShape;
	import Box2D.Common.Math.b2Vec2;
	import Box2D.Dynamics.Joints.b2DistanceJoint;
	import Box2D.Dynamics.Joints.b2DistanceJointDef;
	import Box2D.Dynamics.b2Body;
	import Box2D.Dynamics.b2BodyDef;
	import Box2D.Dynamics.b2FixtureDef;
	import Box2D.Dynamics.b2World;
	
	import flash.display.BitmapData;
	import flash.display.Graphics;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	
	public class JelloWheel extends Sprite
	{
		private var sphereVector:Vector.<b2Body>;
		private var particleNumber:Number=30;
		private var particleDistance:Number=50;
		public var shape:MovieClip = new MovieClip();
		private var pointArray:Array=new Array()
		private var bodyArray:Array=new Array()
		private var p1
		private var p2
		private var h:int=1
		private var middlebody:b2Body
		private var theSphere:b2Body
		private var jellyPoints:Vector.<MovieClip> = new Vector.<MovieClip>();
		private var worldScale:Number=30;
		
		public function JelloWheel()
		{
			super();
		}
		private var world:b2World;
		public var mainWheel:b2Body;
		public function createBlob(_world:b2World,xx:Number,yy:Number,rr:Number)
		{
			world = _world
			//jellyPoints = new Vector.<MovieClip>();
			sphereVector=new Vector.<b2Body>();
			mainWheel = sphere(xx,yy,rr)
			sphereVector.push(mainWheel);
			
			for (var i:Number=0; i<particleNumber; i++) {
				var angle:Number=(2*Math.PI)/particleNumber*i;
				var posX:Number=xx+particleDistance*Math.cos(angle);
				var posY:Number=yy+particleDistance*Math.sin(angle);
				
				
				
				sphereVector.push(sphere(posX,posY,2));
				var dJoint:b2DistanceJointDef=new b2DistanceJointDef();
				dJoint.bodyA=sphereVector[0];
				dJoint.bodyB=sphereVector[sphereVector.length-1];
				dJoint.localAnchorA=new b2Vec2(0,0);
				dJoint.localAnchorB=new b2Vec2(0,0);
				dJoint.length=particleDistance/worldScale;
				dJoint.dampingRatio=0.5;
				dJoint.frequencyHz=5;
				var distanceJoint:b2DistanceJoint;
				distanceJoint=world.CreateJoint(dJoint) as b2DistanceJoint;
				if (i>0) {
					var distanceX:Number=posX/worldScale-sphereVector[sphereVector.length-2].GetPosition().x;
					var distanceY:Number=posY/worldScale-sphereVector[sphereVector.length-2].GetPosition().y;
					var distance:Number=Math.sqrt(distanceX*distanceX+distanceY*distanceY);
					dJoint.bodyA=sphereVector[sphereVector.length-2];
					dJoint.bodyB=sphereVector[sphereVector.length-1];
					dJoint.localAnchorA=new b2Vec2(0,0);
					dJoint.localAnchorB=new b2Vec2(0,0);
					dJoint.length=distance;
					distanceJoint=world.CreateJoint(dJoint) as b2DistanceJoint;
					
				}
				if (i==particleNumber-1) {
					distanceX=posX/worldScale-sphereVector[1].GetPosition().x;
					distanceY=posY/worldScale-sphereVector[1].GetPosition().y;
					distance=Math.sqrt(distanceX*distanceX+distanceY*distanceY);
					dJoint.bodyA=sphereVector[1];
					dJoint.bodyB=sphereVector[sphereVector.length-1];
					dJoint.localAnchorA=new b2Vec2(0,0);
					dJoint.localAnchorB=new b2Vec2(0,0);
					dJoint.length=distance;
					distanceJoint=world.CreateJoint(dJoint) as b2DistanceJoint;
				}
			}
			
			 g = shape.graphics;
			 bmd = new snow();
		}
		
		var g:Graphics;
		private function sphere(pX:int,pY:int,r:Number):b2Body {
			var bodyDef:b2BodyDef=new b2BodyDef();
			bodyDef.position.Set(pX/worldScale,pY/worldScale);
			bodyDef.type=b2Body.b2_dynamicBody;
			bodyDef.userData=new jellydotmc()
			addChild(bodyDef.userData)
			var circleShape:b2CircleShape;
			circleShape=new b2CircleShape(r/worldScale);
			var fixtureDef:b2FixtureDef=new b2FixtureDef();
			fixtureDef.shape=circleShape;
			fixtureDef.density=1;
			fixtureDef.restitution=0.4;
			fixtureDef.friction=0.5;
			trace("sphere1")
			
			theSphere=world.CreateBody(bodyDef);
			theSphere.CreateFixture(fixtureDef);
			
			var mc:MovieClip=new jellydotmc()
			mc.x=theSphere.GetWorldCenter().x*30
			mc.y=theSphere.GetWorldCenter().y*30
			
			trace(mc.x,mc.y,"points",r,h)
			if(h==1)
			{
				middlebody=theSphere
			}
			h++
				//pointArray.push({xx:mc.x,yy:mc.y})
				
				jellyPoints.push(bodyDef.userData);
			pointArray.push({xx:mc.x,yy:mc.y})
			bodyArray.push({xx:(theSphere.GetWorldCenter().x*30),yy:(theSphere.GetWorldCenter().y*30)})
			mc.alpha=0
			MainGame.me.addChild(mc)
			
			return theSphere;
		}
		
		private var bmd:BitmapData;
		public function drawShape2():MovieClip
		{
			//trace(pointArray.length,middlebody.GetWorldCenter().y,"center",theSphere.GetWorldCenter().x*30)
			
			p1 = jellyPoints[1]
			//trace(p1.x,"p1",p1,jellyPoints[1].x,jellyPoints.length)
			var n: int = jellyPoints.length,px:Number, py:Number
			g.clear();
			
			//g.beginFill(0xffffff);
			g.beginBitmapFill(bmd);
			g.lineStyle(2,0xffcccc)
			g.moveTo(p1.x , p1.y);
			for(var i:int=0;i<jellyPoints.length;i++)
			{
				//trace(i," :first",jellyPoints[i].x)
				//trace(i+1,"  :second",pointArray[i + 1])
				//trace(i,)
				
				if(i<=(particleNumber-1))
				{
					p1 = jellyPoints[i];
					p2 = jellyPoints[i + 1];
					px = (jellyPoints[1].x - p2.x) * 0.05 + p2.x;
					py = (jellyPoints[1].y - p2.y) * 0.05 + p2.y;
					g.curveTo(p1.x, p1.y , px , py );
				}
				
			}
			//px = middlebody.GetWorldCenter().x
			//py = middlebody.GetWorldCenter().y
			g.endFill()
			//trace("_____________")
			
			return shape
		}
	}
}