package bala
{
	import Box2D.Common.Math.b2Vec2;
	import Box2D.Dynamics.b2World;
	
	import flash.display.MovieClip;
	import flash.display.Shape;
	import flash.display.SimpleButton;
	import flash.events.MouseEvent;
	
	/**
	 * @author : Balakrishna.
	 * @email  : vamsibalu@gmail.com
	 * @version: 5.0
	 */
	
	public class BalaPoly extends main
	{
		public var vecs:Vector.<b2Vec2> = new Vector.<b2Vec2>();
		public var vecsToSave:Array = [];
		private var baseWorld:BaseWorld;
		public static var ptm_ratio:Number = 30;
		public static const POINTS_CHANGED:String = "pchanges";
		public var bodyID:int;
		public function BalaPoly(arg0:BaseWorld=null,_name:String="notmoving")
		{
			baseWorld = arg0;
			this.name = _name;
			super();
			this.addEventListener(MouseEvent.CLICK,addPoint);
			bodyID = BaseWorld.bodyID;
			BaseWorld.bodyID++;
		}
		
		var temps:Array = [];
		private function addPoint(e:MouseEvent):void{
			if(dummy.visible == true && drawingFinish == false){
				var str:String = mouseX+"+"+mouseY;
				vecsToSave.push(str);
				vecs.push(BaseWorld.getB2vec(mouseX,mouseY));
				showPoly(vecs);
			}
		}
		
		public function getTag():String{
			return name+",ID_"+bodyID+","+vecsToSave.toString()+":";
		}
		
		public function getTag2():String{
			var str:String;
			vecs = new Vector.<b2Vec2>();
			vecsToSave = [];
			for(var i:int=0; i<pointsCont.numChildren; i++){
				var mc:MovieClip = pointsCont.getChildAt(i) as MovieClip;
				str = mc.x+"+"+mc.y;
				vecsToSave.push(str);
				vecs.push(BaseWorld.getB2vec(mc.x,mc.y));
			}
			return getTag();
		}
	}
}