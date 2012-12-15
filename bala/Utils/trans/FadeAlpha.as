package com.Utils.trans
{
    import com.greensock.*;
    import com.greensock.easing.*;
    import flash.display.*;

    public class FadeAlpha extends Sprite
    {

        public function FadeAlpha(param1:MovieClip, param2:MovieClip, param3:Number)
        {
            var _loc_4:* = param1.parent;
            var _loc_5:* = param1.stage;
            param1.x = _loc_5.stageWidth;
            var _loc_6:* = new BitmapData(_loc_5.stageWidth, _loc_5.stageHeight);
            var _loc_7:* = new Bitmap(_loc_6);
            if (param1 != param2)
            {
                TweenMax.to(param1, param3, {ease:Linear.easeNone, onComplete:this.remove, onCompleteParams:[param1]});
            }
            else
            {
                this.remove(param1);
            }
            param2.x = 0;
            _loc_4.currentScreen = param2;
            _loc_4.addChild(param2);
            _loc_6.draw(param1);
            _loc_4.addChild(_loc_7);
            TweenMax.to(_loc_7, param3, {alpha:0, ease:Linear.easeNone, onComplete:this.remove, onCompleteParams:[_loc_7]});
            return;
        }// end function

        public function remove(param1:DisplayObject) : void
        {
            param1.parent.removeChild(param1);
            return;
        }// end function

        public static function go(param1:MovieClip, param2:MovieClip, param3:Number) : FadeAlpha
        {
            return new FadeAlpha(param1, param2, param3);
        }// end function

    }
}
