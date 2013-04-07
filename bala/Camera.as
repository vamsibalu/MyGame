package com
{
	import com.greensock.TweenLite;
    import flash.display.*;
    import flash.events.*;
    import flash.geom.*;

    public class Camera extends Object
    {
        public var lockWay:String;
        public var count:int = 50;
        public var lockTarget:DisplayObject;
        public var lockPoint:Point;
        public var easingRate:Number = 0.5;
        private var _isLocked:Boolean = false;
        public var easing:Boolean = true;
		private var zoom:Number = 1.2;
        public static var LOCKWAY_NORMAL:String = "lockway_normal";
        public static var Scene:DisplayObject;
        private static var _instance:Camera;
        public static var LOCKWAY_X:String = "lockway_x";
        public static var LOCKWAY_Y:String = "lockway_y";
		public var actualPosition:Point;
		public var zoomEnabled:Boolean = true;
        public function Camera(param1:SingleEnforcer)
        {
			actualPosition = new Point(this.x, this.y);
            if (param1 == null)
            {
                throw new Error("using SingletonPattern");
            }
            return;
        }// end function
		public function setZoom(zoomAmount:Number):void
		{
			//TweenLite.to(this, 1, { zoom:zoomAmount } );
			zoom = zoomAmount;
		}
		public function getZoom():Number
		{
			return Scene.scaleX;
		}
        public function set y(param1:Number) : void
        {
			//Scene.y = -param1;
            Scene.y = -param1*getZoom();
            return;
        }// end function

        private function lockWayNormal() : void
        {
			
            if (easing)
            {
				if (zoomEnabled)
				{
					this.x = this.x + (lockTarget.x - this.x - lockPoint.x) * easingRate /zoom;
					this.y = this.y + (lockTarget.y - this.y - lockPoint.y) * easingRate / zoom;
					Scene.scaleX = Scene.scaleY = zoom;
				}
				else
				{
					this.x = this.x + (lockTarget.x - this.x - lockPoint.x) * easingRate;
					this.y = this.y + (lockTarget.y - this.y - lockPoint.y) * easingRate;
				}
				actualPosition.x = actualPosition.x - (lockTarget.x - actualPosition.x - lockPoint.x) * easingRate;
				actualPosition.y = actualPosition.y - (lockTarget.y - actualPosition.y - lockPoint.y) * easingRate;
                if (lockTarget.y < -200)
                {
                }
                else
                {
                    this.y = this.y + (lockTarget.y - this.y - lockPoint.y) * easingRate*zoom;
					actualPosition.y = actualPosition.y - (lockTarget.y - actualPosition.y - lockPoint.y) * easingRate;
                }
            }
            else
            {
				if (zoomEnabled)
				{
					TweenLite.to(Scene, 3, { scaleX:zoom, scaleY:zoom } );
					this.x = lockTarget.x - lockPoint.x/Scene.scaleX;
					this.y = lockTarget.y - lockPoint.y / Scene.scaleY;
				}
				else
				{
					this.x = lockTarget.x - lockPoint.x;
					this.y = lockTarget.y - lockPoint.y;
				}
				actualPosition.x = -lockTarget.x + lockPoint.x;
                actualPosition.y = -lockTarget.y + lockPoint.y;
            }
            return;
        }// end function

        public function clear()
        {
            _instance = null;
            return;
        }// end function

        public function reset() : void
        {
            Scene.x = 0;
            Scene.y = 0;
            return;
        }// end function

        public function get isLocked() : Boolean
        {
            return _isLocked;
        }// end function

        private function lockWayY() : void
        {
            if (easing)
            {
                this.y = this.y + (lockTarget.y - this.y - lockPoint.y) * easingRate;
            }
            else
            {
                this.y = lockTarget.y - lockPoint.y;
            }
            return;
        }// end function

        private function lockWayX() : void
        {
            if (easing)
            {
                this.x = this.x + (lockTarget.x - this.x - lockPoint.x) * easingRate;
            }
            else
            {
                this.x = lockTarget.x - lockPoint.x;
            }
            return;
        }// end function

        public function moveTo(param1:Point, param2:Point = null) : void
        {
            this.x = param2.x - param1.x;
            this.y = param2.y - param1.y;
            return;
        }// end function

        public function set x(param1:Number) : void
        {
            Scene.x = -param1*getZoom();
			//Scene.x = -param1;
            return;
        }// end function

        public function lookAt(param1:DisplayObject, param2:Point = null, param3:String = "lockway_normal") : void
        {
			if (param2 == null)
            {
                lockPoint = new Point(0, 0);
            }
            else
            {
                lockPoint = param2;
            }
            lockTarget = param1;
            lockWay = param3;
            lockCemeraHandler(null);
            return;
        }// end function

        private function lockCemeraHandler(event:Event) : void
        {
			
			switch(lockWay)
            {
                case LOCKWAY_NORMAL:
                {
                    lockWayNormal();
                    break;
                }
                case LOCKWAY_X:
                {
                    lockWayX();
                    break;
                }
                case LOCKWAY_Y:
                {
                    lockWayY();
                    break;
                }
                default:
                {
                    break;
                }
            }
            return;
        }// end function

        public function get y() : Number
        {
            return -Scene.y;
        }// end function

        public function get x() : Number
        {
            return -Scene.x;
        }// end function

        public static function getInstance(param1:Sprite=null) : Camera
        {
            if (_instance == null)
            {
				if (param1 != null)
				{
					Scene = param1;
				}
                _instance = new Camera(new SingleEnforcer());
            }
            return _instance;
        }// end function

    }
}
class SingleEnforcer
{
	
}
