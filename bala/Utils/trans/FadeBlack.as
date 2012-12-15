package com.Utils.trans
{
    import com.greensock.*;
    import com.greensock.easing.*;
    import flash.display.*;

    public class FadeBlack extends Sprite
    {

        public function FadeBlack(param1:MovieClip, param2:MovieClip, param3:Number)
        {
            var _loc_4:* = param1.parent;
            var _loc_5:* = param1.stage;
            var _loc_6:* = new BitmapData(_loc_5.stageWidth, _loc_5.stageHeight);
            var _loc_7:* = new Bitmap(_loc_6);
            _loc_4.currentScreen = param2;
            _loc_6.draw(param1);
            _loc_4.addChild(_loc_7);
            param1.x = _loc_5.stageWidth;
            if (param1 != param2)
            {
                trace("Removing old screen slowly");
                TweenMax.to(param1, param3, {ease:Linear.easeNone, onComplete:this.remove, onCompleteParams:[param1]});
            }
            else
            {
                this.remove(param1);
            }
            TweenMax.to(_loc_7, param3 / 2, {colorTransform:{tint:0, tintAmount:1}, onComplete:this.fadeIn, onCompleteParams:[_loc_7, param2, _loc_4, param3]});
            return;
        }// end function

        public function fadeIn(param1:DisplayObject, param2:MovieClip, param3:Object, param4:Number) : void
        {
            this.remove(param1);
            TweenMax.to(param2, 0, {colorTransform:{tint:0, tintAmount:1}});
            param2.x = 0;
            param3.addChild(param2);
            TweenMax.to(param2, param4 / 2, {colorTransform:{tint:0, tintAmount:0}});
            return;
        }// end function

        public function remove(param1:DisplayObject) : void
        {
            param1.parent.removeChild(param1);
            return;
        }// end function

        public static function go(param1:MovieClip, param2:MovieClip, param3:Number) : FadeBlack
        {
            return new FadeBlack(param1, param2, param3);
        }// end function

    }
}
