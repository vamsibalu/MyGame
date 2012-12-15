package bala.Utils
{
	import flash.display.*;
	import flash.text.engine.*;
	//bala.Utils.RedPoint
	//emanueleferonato.com/2011/09/12/create-non-convex-complex-shapes-with-box2d/
	/**
	 * @author : Balakrishna.
	 * @email  : vamsibalu@gmail.com
	 * @version: 5.0
	 */
	public class RedPoint extends MovieClip
	{
		public var id:uint;
		public static var num:uint = 0;
		
		public function RedPoint()
		{
			this.mouseChildren = false;
			this.id = num++;
			var _loc_1:* = new ElementFormat();
			var _loc_2:* = new TextElement(String(this.id), _loc_1);
			var _loc_3:* = new TextBlock(_loc_2);
			var _loc_4:* = _loc_3.createTextLine();
			var _loc_5:Sprite = new Sprite();
			_loc_5.graphics.beginFill(16777215);
			_loc_5.graphics.drawRect(-5 - 0.5 * _loc_4.width, -_loc_4.ascent - 5, _loc_4.width + 10, _loc_4.height + 10);
			_loc_5.graphics.endFill();
			_loc_5.addChild(_loc_4);
			_loc_4.x = -0.5 * _loc_4.width;
			_loc_5.y = -15;
			this.addChild(_loc_5);
			return;
		}// end function
		
	}
}
