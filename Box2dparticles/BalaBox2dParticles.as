package  {
	import Box2D.Dynamics.b2Body;
	import Box2D.Dynamics.b2FixtureDef;
	import Box2D.Collision.Shapes.b2CircleShape;
	import Box2D.Dynamics.b2World;
	import Box2D.Dynamics.b2BodyDef;
	import flash.display.Sprite;
	import Box2D.Collision.Shapes.b2PolygonShape;
	import flash.display.MovieClip;
	
	public class BalaBox2dParticles {
		public var world:b2World;
		public var cont:Sprite;
		public function BalaBox2dParticles(_world,_cont) {
			// constructor code
			world = _world;
			cont = _cont;
		}
		private var ptm_ratio:Number = 30;
		public var bodies:Vector.<b2Body> = new Vector.<b2Body>();
		var body:b2Body;
		var bodyDef:b2BodyDef;
		var fixtureDef:b2FixtureDef
		public function createCircle(bodyID:String,xx:Number,yy:Number,rr:Number,counter:int)
		{
			
			
			var circleDef:b2CircleShape;
			fixtureDef = new b2FixtureDef();
			bodyDef=new b2BodyDef()
			bodyDef.type=b2Body.b2_dynamicBody
			bodyDef.position.Set(xx/ptm_ratio,yy/ptm_ratio)
			bodyDef.userData = new CircleStone();
			bodyDef.userData.name = "ball"; //override
			fixtureDef.friction=.8;
			fixtureDef.restitution=0.5
			fixtureDef.filter.groupIndex = -4;
			bodyDef.userData.width = rr;
			bodyDef.userData.height = rr;
			bodyDef.userData.x = xx;
			bodyDef.userData.y = yy;
			bodyDef.userData.rotation = 0;
			//bodyDef.userData=new addebles()
			//bodyDef.userData.width=_w*2
			//bodyDef.userData.height=_h*2
			//this_parent.addChildAt(bodyDef.userData,2)
			circleDef=new b2CircleShape(realPixels(rr));
			fixtureDef.density=1
			fixtureDef.shape=circleDef;
			//create particles..
			
			for(var k:int = 0; k<counter; k++){
				createBody();
			}
		}
		
		
		private function createBody():void{
			body=world.CreateBody(bodyDef)
			body.CreateFixture(fixtureDef);
			cont.addChild(bodyDef.userData);
			bodies.push(body);
		}
		
		public function realPixels(param1:Number) : Number
		{
			return (param1 / ptm_ratio) / 2;
		}// end function

	}
	
}
