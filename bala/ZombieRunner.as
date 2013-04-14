package bala
{
	import Box2D.Collision.Shapes.b2CircleShape;
	import Box2D.Common.Math.b2Vec2;
	import Box2D.Dynamics.b2Body;
	import Box2D.Dynamics.b2BodyDef;
	import Box2D.Dynamics.b2FixtureDef;
	
	import com.Game;
	
	import flash.display.MovieClip;
	import flash.events.EventDispatcher;
	import flash.events.IEventDispatcher;
	
	public class ZombieRunner extends EventDispatcher
	{
		private var game:BalaBaseGame;
		public function ZombieRunner(_game:BalaBaseGame)
		{
			game = _game;
			super();
		}
		private var ptm_ratio:Number = 30;
		var zombiee:b2Body;
		public function createZombieRun(namee:String,mcc:MovieClip,_xx:Number,_yy:Number,angle:Number):void{
			var def:b2BodyDef = new b2BodyDef();
			def.userData = mcc;
			def.type=b2Body.b2_dynamicBody
			def.position.Set(_xx/ptm_ratio,_yy/ptm_ratio);
			def.userData.name = "enemy";
			game.addChild(def.userData);
			var shapedef:b2CircleShape = new b2CircleShape(25/30);
			zombiee = game.world.CreateBody(def);
			
			var fixtureDef:b2FixtureDef=new b2FixtureDef();
			fixtureDef.density=0;
			fixtureDef.friction=0.1;
			fixtureDef.restitution=0;
			fixtureDef.shape=shapedef;
			ShapeWorld.enemyCount++;
			zombiee.CreateFixture(fixtureDef);
			
			
		}
		
		public function runZombie(nm:Number):void{
			zombiee.ApplyImpulse(new b2Vec2(0.5,0),zombiee.GetWorldCenter());
		}
	}
}