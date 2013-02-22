package bala
{
	import Box2D.Collision.b2ContactPoint;
	import Box2D.Collision.b2Manifold;
	import Box2D.Common.Math.b2Vec2;
	import Box2D.Common.b2internal;
	import Box2D.Dynamics.Contacts.b2Contact;
	import Box2D.Dynamics.Contacts.b2ContactResult;
	import Box2D.Dynamics.Joints.b2JointEdge;
	import Box2D.Dynamics.Joints.b2WeldJointDef;
	import Box2D.Dynamics.b2Body;
	import Box2D.Dynamics.b2ContactListener;
	
	import com.BulletTracer;
	import com.Game;
	
	import flash.display.MovieClip;
	
	/**
	 * @author : Balakrishna.
	 * @email  : vamsibalu@gmail.com
	 * @version: 5.0
	 */
	public class BodyContacts extends b2ContactListener
	{
		
		public function BodyContacts()
		{
			// constructor code
		}
		
		private static var game:Game;
		public static function setGame(_game:Game):void{
			game = _game;
		}
		override public function BeginContact(contact:b2Contact):void
		{
			var b1:b2Body = contact.GetFixtureA().GetBody();
			var b2:b2Body = contact.GetFixtureB().GetBody();
			var mc1:MovieClip = b1.GetUserData();
			var mc2:MovieClip = b2.GetUserData();
			//trace(contact.GetManifold().m_localPoint);
			
			if(mc1 && mc2 && game){
				if(mc1.name == "bullet" && (mc2.name == "notmoving" || mc2.name == "glass" || mc2.name == "block" || mc2.name == "rock"||mc2.name == "nife")){
					
					if(mc2.name == "glass"){
						mc2.name = "glassX";
						mc1.name = "bulletXX";
						game.glassX = b2;
						game.bulletXX = b1;
					}else{
						mc1.name = "bulletX";
						game.bulletX = b1;
					}
				}else if((mc1.name == "notmoving" || mc1.name == "glass" || mc1.name == "block"|| mc1.name == "rock"||mc1.name == "nife") && mc2.name == "bullet"){
					if(mc1.name == "glass"){
						mc1.name = "glassX"
						mc2.name = "bulletXX";
						game.glassX = b1;
						game.bulletXX = b2;
					}else{
						mc2.name = "bulletX";
						game.bulletX = b2;
					}
				}else if((mc1.name == "bullet" ||mc1.name == "rock" || mc1.name == "nife") && mc2.name == "enemy"){
					mc2.name = "enemyX";
					game.enemyX = b2;
					if(mc1.name == "bullet"){
						mc1.name = "bulletXX";
						game.bulletXX = b1;
					}
				}else if(mc1.name == "enemy" && (mc2.name == "bullet" ||mc2.name == "rock" ||mc2.name == "nife")){
					mc1.name = "enemyX";
					game.enemyX = b1;
					if(mc2.name == "bullet"){
						mc2.name = "bulletXX";
						game.bulletXX = b2;
					}
				}else if(mc1.name == "hero" && (mc2.name == "rock" ||mc2.name == "nife" ||mc2.name == "enemy")){
					mc1.name = "heroX";
					game.heroX = b1;
				}else if(mc2.name == "hero" && (mc1.name == "rock" ||mc1.name == "nife" ||mc1.name == "enemy")){
					mc2.name = "heroX";
					game.heroX = b2;
				}else if(mc1.name == "iron" && mc2.name == "bullet"){
					var btt:BulletTracer = b2.GetUserData().myEffect as BulletTracer;
					if(btt){
						btt.reCreate();
					}
					SoundM.me.playSound(SoundM.STEEL);
				}else if(mc1.name == "bullet" && mc2.name == "iron"){
					var btt2:BulletTracer = b1.GetUserData().myEffect as BulletTracer;
					if(btt2){
						btt2.reCreate();
					}
					SoundM.me.playSound(SoundM.STEEL);
				}
				
				
				//for track and wheel detection.
				if(mc1.name == "notmoving" && (mc2.name == "wb" || mc2.name == "wf")){
					game.bykeOnFloor = true;
					trace("touched=",contact.IsContinuous(),game.bykeOnFloor);
				}else if(mc2.name == "notmoving" && (mc1.name == "wb" || mc1.name == "wf")){
					game.bykeOnFloor = true;
					trace("touched=",contact.IsContinuous(),game.bykeOnFloor);
				}else{
					game.bykeOnFloor = false;
				}
				
				//trace("touched=",contact.IsContinuous(),game.bykeOnFloor);
			}
		}
		
		
		//for arrow Hit Bala
		override public function PreSolve(contact:b2Contact, oldManifold:b2Manifold):void {
			var contactPoint:b2Vec2;
			var weldJointDef:b2WeldJointDef;
			if (contact.IsTouching()) {
				var bodyA:b2Body=contact.GetFixtureA().GetBody();
				var bodyB:b2Body=contact.GetFixtureB().GetBody();
				var objA:Object=bodyA.GetUserData();
				var objB:Object=bodyB.GetUserData();
				if (objA && objB){
					if (objA.name=="arrow"&&objB.name=="arrow") {
						for (var j:b2JointEdge=bodyA.GetJointList(); j; j=j.next) {
							bodyA.GetWorld().DestroyJoint(j.joint);
						}
						for (j=bodyB.GetJointList(); j; j=j.next) {
							bodyB.GetWorld().DestroyJoint(j.joint);
						}
					}
					if (objA.name=="notmoving"&&objB.name=="arrow") {
						if (! objB.freeFlight) {
							weldJointDef = new b2WeldJointDef();
							weldJointDef.Initialize(bodyB,bodyA,bodyA.GetWorldCenter());
							bodyB.GetWorld().CreateJoint(weldJointDef);
						}
					}
					if (objB.name=="notmoving"&&objA.name=="arrow") {
						if (! objA.freeFlight) {
							weldJointDef = new b2WeldJointDef();
							weldJointDef.Initialize(bodyA,bodyB,bodyB.GetWorldCenter());
							bodyA.GetWorld().CreateJoint(weldJointDef);
						}
					}
					if (objA.name=="enemy"&&objB.name=="arrow") {
						contactPoint=contact.GetManifold().m_points[0].m_localPoint;
						if (! objB.freeFlight&&Math.round(contactPoint.x*10)==6) {
							weldJointDef = new b2WeldJointDef();
							weldJointDef.Initialize(bodyB,bodyA,bodyA.GetWorldCenter());
							bodyB.GetWorld().CreateJoint(weldJointDef);
						}
					}
					if (objB.name=="enemy"&&objA.name=="arrow") {
						contactPoint=contact.GetManifold().m_points[0].m_localPoint;
						if (! objA.freeFlight&&Math.round(contactPoint.x*10)==6) {
							weldJointDef = new b2WeldJointDef();
							weldJointDef.Initialize(bodyA,bodyB,bodyB.GetWorldCenter());
							bodyA.GetWorld().CreateJoint(weldJointDef);
						}
					}
					if (objB.name=="arrow") {
						objB.freeFlight=true;
					}
					if (objA.name=="arrow") {
						objA.freeFlight=true;
					}
				}
			}
		}
		
		
		//add anything
	}
	
}