package bala.Utils
{
	import com.ExplosionMc;
	import com.greensock.TweenLite;
	
	import flash.display.DisplayObject;
	import flash.display.MovieClip;
	import flash.events.MouseEvent;
	import flash.filters.DropShadowFilter;
	import flash.geom.Point;
	import flash.text.AntiAliasType;
	import flash.text.Font;
	import flash.text.StaticText;
	import flash.text.TextField;
	import flash.text.TextFormat;
	import flash.text.TextFormatAlign;
	import flash.ui.Mouse;
	import flash.ui.MouseCursor;
	
	/**
	 * @author : Balakrishna.
	 * @email  : vamsibalu@gmail.com
	 * @version: 5.0
	 */
	public class BalaUtils extends Object
	{
		public static var me:BalaUtils;
		var dsf:DropShadowFilter = new DropShadowFilter();
		public function BalaUtils()
		{
			super();
			me = this;
			dsf.color = 0;
			dsf.blurX = 3;
			dsf.blurY = 3;
			dsf.angle = 0;
			dsf.alpha = 1;
			dsf.distance = 0;
			dsf.strength = 2;
		}
		
		public function createTextBox(param1:int = 10, param2:int = 10, param3:int = 0, param4:String = "") : MovieClip
		{
			var mc:MovieClip = new MovieClip();
			mc.x = param1;
			mc.y = param2;
			mc.rotation = param3;
			//var _loc_6:Font = new myFont(); //check
			var _loc_7:TextFormat = new TextFormat();
			_loc_7.size = 14;
			_loc_7.align = TextFormatAlign.CENTER;
			//_loc_7.font = _loc_6.fontName;  //check
			var tf:TextField = new TextField();
			new TextField().defaultTextFormat = _loc_7;
			tf.embedFonts = true;
			tf.antiAliasType = AntiAliasType.ADVANCED;
			tf.text = param4;
			tf.selectable = false;
			tf.filters = [dsf];
			mc.addChild(tf);
			tf.textColor = 16777215;
			tf.wordWrap = true;
			tf.width = 200;
			tf.height = 100;
			return mc;
		}// end function
		
		public function parseXMLData(xml:XML,allLevels:Array):void{
			var levelList:XMLList = xml.children();
			if(levelList){
				for(var i:int = 0; i<levelList.length(); i++){
					var ary:Array = levelList[i].toString().split(":");
					var levelNo:int = levelList[i].@id;
					trace("parseXMLData levels found=",levelNo)
					if(ary){
						for(var k:int = 0; k<ary.length; k++){
							ary[k] = ary[k].toString().split(",");
						}
						allLevels[levelNo] = ary;
					}else{
						trace("Bad XML formate, not Found ':' ")
					}
				}
				trace("allLevels.length=",allLevels.length);
			}
		}
		
		public function setAsButton(param1:MovieClip) : void
		{
			param1.buttonMode = true;
			//param1.addEventListener(MouseEvent.ROLL_OVER, this.overBtn);
			//param1.addEventListener(MouseEvent.ROLL_OUT, this.offBtn);
		}// end function
		
		public function remove(obj:DisplayObject,time:Number = 0,delay:Number = 0):void{
			if(time == 0){
				if(obj.parent){
					obj.parent.removeChild(obj);
				}
			}else if(obj.parent){
				removeSlow(obj as MovieClip,time,delay);
				trace("removeSlow",obj)
			}
		}
		
		// Convert co-ords from one DisplayObject to another DisplayObject
		public static function localToLocal(containerFrom:DisplayObject, containerTo:DisplayObject, origin:Point=null):Point 
		{
			var point:Point = origin ? origin : new Point();
			point=containerFrom.localToGlobal(point);
			point=containerTo.globalToLocal(point);
			return point;
		}
		
		public function addSlow(obj:MovieClip,time:Number,_delay:Number):void{
			obj.alpha = 0;
			obj.gotoAndStop(1);
			TweenLite.to(obj,time,{alpha:1,delay:_delay,onComplete:complt,onCompleteParams:[obj]});
		}
		
		private function removeSlow(obj:MovieClip,time:Number,_delay:Number):void{
			obj.alpha = 1;
			TweenLite.to(obj,time,{alpha:0,delay:_delay,onComplete:compltForRemove,onCompleteParams:[obj]});
		}
		
		private function complt(_obj:MovieClip):void{
			trace("tween completed..")
			_obj.gotoAndPlay(1);
		}
		
		private function compltForRemove(_obj:MovieClip):void{
			if(_obj.parent){
				_obj.parent.removeChild(_obj);
			}
		}
		
		public static function toRadians(param1:Number) : Number
		{
			return param1 * Math.PI / 180;
		}// end function
		
		static function toDegrees(param1:Number) : Number
		{
			return param1 * 180 / Math.PI;
		}// end function
		
		public static function maxValInAry(givenArray):Number
		{
			var max = givenArray[0];
			for (var ma:int = 0; ma<givenArray.length; ma++)
			{
				if (givenArray[ma] > max)
				{
					max = givenArray[ma];
				}
			}
			return max;
		}
		
		public static function minValInAry(givenArray):Number
		{
			var min = givenArray[0];
			for (var mi:int = 0; mi<givenArray.length; mi++)
			{
				if (givenArray[mi] < min)
				{
					min = givenArray[mi];
				}
			}
			return min;
		}
		
		private function test():void{
			var ary:Array = [];
			//ary.
		}
		
		function maxVal(givenArray):Number
		{
			return Math.max.apply(this, givenArray);
		}
		
		function minVal(givenArray):Number
		{
			return Math.min.apply(this, givenArray);
		}
		
		public function findUnUsedItem(vecs:Vector.<ExplosionMc>):ExplosionMc{
			var mcc:ExplosionMc;
			for each(var mct:ExplosionMc in vecs){
				if(mct.parent == null){
					mcc = mct;
					break;
				}else{
					trace("mct.parent=",mct.parent)
				}
			}
			return mcc;
		}
		
		public static function average(... args) : Number{
			var sum:Number = 0;
			for (var i:uint = 0; i < args.length; i++) {
				sum += args[i];
			}
			return (sum / args.length);
		}
		
		//Number utils..
		public function randomNumber(param1:int, param2:int) : Number
		{
			return Math.floor(Math.random() * (1 + param2 - param1)) + param1;
		}// end function
		
		public static function randomWithinRange(min:Number, max:Number):Number {
			return min + (Math.random() * (max - min));
		}
		
		public static function randomIntegerWithinRange(min:int, max:int):int {
			return Math.floor(Math.random() * (1 + max - min) + min);
		}
		
		public static function isEven(value:Number):Boolean {
			return (value & 1) == 0;
		}
		
		public static function isOdd(value:Number):Boolean {
			return !BalaUtils.isEven(value);
		}
		
		public static function roundDecimalToPlace(value:Number, place:uint):Number {
			var p:Number = Math.pow(10, place);
			
			return Math.round(value * p) / p;
		}
	}
}