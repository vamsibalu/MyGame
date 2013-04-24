﻿package bala{
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

	import com.BikeBox2d;
	import com.BulletTracer;
	import com.Game;

	import flash.display.MovieClip;

	/**
	 * @author : Balakrishna.
	 * @email  : vamsibalu@gmail.com
	 * @version: 5.0
	 */
	public class BodyContacts extends b2ContactListener {

		public function BodyContacts() {
			// constructor code
		}

		private static var game:Game;
		public static function setGame(_game:Game):void {
			game=_game;
		}
		override public function BeginContact(contact:b2Contact):void {
			var b1:b2Body=contact.GetFixtureA().GetBody();
			var b2:b2Body=contact.GetFixtureB().GetBody();
			var mc1:MovieClip=b1.GetUserData();
			var mc2:MovieClip=b2.GetUserData();
			//trace(contact.GetManifold().m_localPoint);

			if (((mc1&&mc2)&&game)) {
				if (mc1.name=="playerhead"||mc1.name=="body"&&mc2.name=="notmoving"||mc2.name=="nife"||mc2.name=="enemy") {
					BikeBox2d.me.headDamage=true;

				} else if (mc2.name=="playerhead"||mc2.name=="body"&&mc1.name=="notmoving"||mc1.name=="nife"||mc1.name=="enemy") {
					BikeBox2d.me.headDamage=true;
				}

				//for score gift..
				if (mc1.name=="block"&&mc2.name=="wb"||mc2.name=="wf") {

					game.giftX=b1;
					game.addChild(mc1);
					mc1.name="blockX";
				} else if (mc2.name=="block"&&mc1.name=="wb"||mc1.name=="wf") {

					game.giftX=b2;
					game.addChild(mc2);
					mc2.name="blockX";
				}
				//Bullet effect..
				if (mc1.name=="bullet"&&mc2.name=="notmoving"||mc2.name=="glass"||mc2.name=="block"||mc2.name=="rock"||mc2.name=="nife") {

					if (mc2.name=="glass") {
						mc2.name="glassX";
						mc1.name="bulletXX";
						game.glassX=b2;
						game.bulletXX=b1;
					} else {
						mc1.name="bulletX";
						game.bulletX=b1;
					}
				} else if (mc2.name=="bullet"&&mc1.name=="notmoving"||mc1.name=="glass"||mc1.name=="block"||mc1.name=="rock"||mc1.name=="nife") {

					if (mc1.name=="glass") {
						mc1.name="glassX";
						mc2.name="bulletXX";
						game.glassX=b1;
						game.bulletXX=b2;
					} else {
						mc2.name="bulletX";
						game.bulletX=b2;
					}
				}

				//for wepons and attacks....
				if (mc1.name=="enemy"&&mc2.name=="bullet"||mc2.name=="arrow") {

					game.enemyX=b1;
					mc1.name="enemyX";

				} else if (mc2.name=="enemy"&&mc1.name=="bullet"||mc1.name=="arrow") {

					game.enemyX=b2;
					mc2.name="enemyX";
				}


				//for track and wheel detection.
				if (mc1.name=="notmoving"&&mc2.name=="wb"||mc2.name=="wf") {
					game.bykeOnFloor=true;
					//trace("touched=",contact.IsContinuous(),game.bykeOnFloor);
				} else if (mc2.name=="notmoving"&&mc1.name=="wb"||mc1.name=="wf") {
					game.bykeOnFloor=true;
					//trace("touched=",contact.IsContinuous(),game.bykeOnFloor);
				} else {
					game.bykeOnFloor=false;
				}


				//for track and wheel detection.
				if (mc1.name=="brg"&&mc2.name=="wb"||mc2.name=="wf") {
					BikeBox2d.player_move_body.ApplyImpulse(new b2Vec2(-0.20,-0.01),BikeBox2d.player_move_body.GetWorldCenter());
					//trace("touched=",contact.IsContinuous(),game.bykeOnFloor);
					trace("bike adjusting.");
				} else if (mc2.name=="brg"&&mc1.name=="wb"||mc1.name=="wf") {
					BikeBox2d.player_move_body.ApplyImpulse(new b2Vec2(-0.20,-0.01),BikeBox2d.player_move_body.GetWorldCenter());
					//trace("touched=",contact.IsContinuous(),game.bykeOnFloor);
					trace("bike adjusting.");
				}

				//trace("touched=",contact.IsContinuous(),game.bykeOnFloor);

			}



			//this is the contact point in local coordinates(we assume that we need only

			//one point but m_points is a Vector so you can do this for every point):

			var contact_point:b2Vec2=contact.GetManifold().m_points[0].m_localPoint;

			//now you determine some stuff like which body is touching which material etc

			//lets get the contact point in actual flash coordinates so you can use it in your particle system etc

			var body:b2Body=bodyA;//this is the body you are considering

			//its either bodyA or bodyB, in this example it's bodyA as i assume here that it's a metal barrel

			var real_point:b2Vec2;

			real_point.x=body.GetWorldPoint(contact_point).x*main._main.physics.ratio;

			real_point.y=body.GetWorldPoint(contact_point).y*main._main.physics.ratio;
			// you can also play sounds in here! good luck.
		}


		//for arrow Hit Bala
		override public function PreSolve(contact:b2Contact,oldManifold:b2Manifold):void {
			var contactPoint:b2Vec2;
			var weldJointDef:b2WeldJointDef;

			//bala req
			if (contact.IsTouching()) {
				var bodyA:b2Body=contact.GetFixtureA().GetBody();
				var bodyB:b2Body=contact.GetFixtureB().GetBody();
				var objA:Object=bodyA.GetUserData();
				var objB:Object=bodyB.GetUserData();
				if ((objA&&objB)) {
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
							weldJointDef=new b2WeldJointDef  ;
							weldJointDef.Initialize(bodyB,bodyA,bodyA.GetWorldCenter());
							bodyB.GetWorld().CreateJoint(weldJointDef);
						}
					}
					if (objB.name=="notmoving"&&objA.name=="arrow") {
						if (! objA.freeFlight) {
							weldJointDef=new b2WeldJointDef  ;
							weldJointDef.Initialize(bodyA,bodyB,bodyB.GetWorldCenter());
							bodyA.GetWorld().CreateJoint(weldJointDef);
						}
					}
					if (objA.name=="enemy"&&objB.name=="arrow") {
						contactPoint=contact.GetManifold().m_points[0].m_localPoint;
						if (! objB.freeFlight&&Math.round(contactPoint.x*10)==6) {
							weldJointDef=new b2WeldJointDef  ;
							weldJointDef.Initialize(bodyB,bodyA,bodyA.GetWorldCenter());
							bodyB.GetWorld().CreateJoint(weldJointDef);
						}
					}
					if (objB.name=="enemy"&&objA.name=="arrow") {
						contactPoint=contact.GetManifold().m_points[0].m_localPoint;
						if (! objA.freeFlight&&Math.round(contactPoint.x*10)==6) {
							weldJointDef=new b2WeldJointDef  ;
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