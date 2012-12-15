package bala
{
	import Box2D.Dynamics.Contacts.b2Contact;
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
				
			}
		}
	}
	
}