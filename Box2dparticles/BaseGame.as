package  {
	
	import Box2D.Common.Math.b2Vec2;
	import Box2D.Dynamics.Joints.b2MouseJoint;
	import Box2D.Dynamics.Joints.b2MouseJointDef;
	import Box2D.Dynamics.b2Body;
	
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.events.TimerEvent;
	import flash.utils.Timer;
	
	
	public class BaseGame extends BaseWorldSingle {
		private var _tableGame:MovieClip
		
		public function BaseGame() {
			_tableGame = new TableGamePageMC();  //ingamemc.timetxt
			addChild(_tableGame);
			_tableGame.startpage.startbtn.addEventListener(MouseEvent.CLICK,startGame);
			super();
			balaEffectEngn = new BalaBox2dParticles(world,this);
			timer.addEventListener(TimerEvent.TIMER,sectiming);
		}
		
		private var _mouseXWorldPhys:Number = 0;
		private var _mouseYWorldPhys:Number = 0;
		public override function renderGame(e:Event=null):void{
			_mouseXWorldPhys = mouseX / ptm_ratio;
			_mouseYWorldPhys = mouseY / ptm_ratio;
			super.renderGame(e);
		}
		
		private var timer:Timer = new Timer(1000);
		private function startGame(e:MouseEvent):void {
			//trace("xmll clickedbox.",allLevels[1])
			timer.reset();
			timer.start();
			_tableGame.startpage.visible = false;
			_tableGame.ingamemc.visible = true;
			balaEffectEngn.createCircle("ab",100,100,5,2);
			if (mytable == null) {
				loadMyLevelForPreview(allLevels[1]);
				//add water..
				for (var i:int = 0; i<300; i++) {
					//trace("for loop parti");
					balaEffectEngn.addParticle(200/30,200/30,45,0,0.001,false);
				}
			}
		}
		
		private function sectiming(e:TimerEvent):void{
			trace("timing..")
			_tableGame.ingamemc.timetxt.text = timer.currentCount;
		}
		
		var balaEffectEngn:BalaBox2dParticles;
		public override function loadMyLevelForPreview(_levelAry:Array):void{
			super.loadMyLevelForPreview(_levelAry);
			//mytable = 
			
			stage.addEventListener(MouseEvent.MOUSE_DOWN,on_mouse_down);
			stage.addEventListener(MouseEvent.MOUSE_MOVE,on_mouseMove);
			stage.addEventListener(MouseEvent.MOUSE_UP,on_mouse_up);
		}
		
		public override function addedToStage(e:Event=null):void{
			super.addedToStage(e);
			//debugDraw = sp;
			trace("xmll addedToStage.");
		}
		
		
		private var mouseJoint:b2MouseJoint;
		public function on_mouse_down(evt:MouseEvent):void {
			_mouseXWorldPhys = mouseX / ptm_ratio;
			_mouseYWorldPhys = mouseY / ptm_ratio;
			
			if (mytable) {
				var mouse_joint:b2MouseJointDef = new b2MouseJointDef;
				mouse_joint.bodyA = world.GetGroundBody();
				mouse_joint.bodyB = mytable;
				mouse_joint.target.Set(_mouseXWorldPhys, _mouseYWorldPhys);
				mouse_joint.maxForce = 300.0 * mytable.GetMass();//10000;
				//mouse_joint.timeStep = m_timeStep;
				mouse_joint.collideConnected = true;
				mouseJoint = world.CreateJoint(mouse_joint) as b2MouseJoint;
				mytable.SetAwake(true);
			}
		}
		public function on_mouseMove(e:MouseEvent):void{
			if (mouseJoint)
			{
				var p2:b2Vec2 = new b2Vec2(_mouseXWorldPhys, _mouseYWorldPhys);
				mouseJoint.SetTarget(p2);
			}
		}
		public function on_mouse_up(evt:MouseEvent):void {
			if (mouseJoint) {
				world.DestroyJoint(mouseJoint);
				mouseJoint = null;
			}
		}
	}
	
}
