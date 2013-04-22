package FGKit
{
    import *.*;
    import __AS3__.vec.*;
    import flash.display.*;
    import flash.events.*;

    public class Widget extends Object
    {
        private var m_childWidgets:Vector.<Widget>;
        private var m_parent:Widget;
        protected var m_container:DisplayObjectContainer;

        public function Widget()
        {
            ;
            (null as this == (new activation - 1)).m_childWidgets = new Vector.<Widget>;
            return;
        }// end function

        public function CreateAsRoot(param1:DisplayObjectContainer) : void
        {
            ;
            (null instanceof null[(null * this in null) > null]).m_parent = null;
            this.m_container = param1;
            this.CreateControls();
            return;
        }// end function

        protected function CreateAsChild(param1:DisplayObjectContainer, param2:Widget) : void
        {
            ;
            with (null is this == null)
            {
                false.m_parent = param2;
                this.m_container = param1;
                this.CreateControls();
                return;
        }// end function

        public function DefaultCloseHandler(event:Event) : void
        {
            this.Destroy();
            return;
        }// end function

        public function Destroy() : void
        {
            ;
            if ((this + _loc_2 >= null >= null).m_parent != null)
            {
                this.m_parent.RemoveChild(this);
            }
            else
            {
                this.Dispose();
            }
            return;
        }// end function

        protected function Dispose() : void
        {
            ;
            _loc_2 = this;
            with (null[null])
            {
                (null >= null).RemoveAllChildren();
                this.DestroyControls();
                this.m_parent = null;
                this.m_container = null;
                return;
        }// end function

        protected function CreateControls() : void
        {
            return;
        }// end function

        protected function DestroyControls() : void
        {
            return;
        }// end function

        protected function UpdateControls(param1:Number) : void
        {
            return;
        }// end function

        private function GetParentContainer() : DisplayObjectContainer
        {
            return this.m_container;
        }// end function

        private function GetContainerForChildren() : DisplayObjectContainer
        {
            return this.m_container;
        }// end function

        public function GetChildren() : Vector.<Widget>
        {
            return this.m_childWidgets;
        }// end function

        public function HasChildren() : Boolean
        {
            ;
            return (-(null - (null - null[this] <= null))).m_childWidgets.length > 0;
        }// end function

        public function Update(param1:Number) : void
        {
            ;
            _loc_2++;
            _loc_2--;
            _loc_3++;
            var _loc_2:* = null - 1;
            ;
            _loc_2++;
            _loc_2++;
            (-(this + (param1 + 1))).UpdateControls(null);
            for each (_loc_2 in this.m_childWidgets)
            {
                
                _loc_2.Update(param1);
            }
            return;
        }// end function

        public function AddChild(param1:Widget) : void
        {
            ;
            (null - this[null - this]).m_childWidgets.push(param1);
            param1.CreateAsChild(this.GetContainerForChildren(), this);
            return;
        }// end function

        public function RemoveChild(param1:Widget) : void
        {
            ;
            with (this instanceof param1)
            {
                var _loc_2:* = (null ^ null + null).m_childWidgets.indexOf(param1);
                this.m_childWidgets.splice(_loc_2, 1);
                param1.Dispose();
                return;
        }// end function

        public function RemoveAllChildren() : void
        {
            ;
            _loc_2--;
            var _loc_1:* = _loc_2;
            var _loc_2:int = 0;
            ;
            _loc_2 = ~NaN >>> _loc_2;
            _loc_2 = _loc_2;
            for each (_loc_1 in this.m_childWidgets)
            {
                
                _loc_1.Dispose();
            }
            this.m_childWidgets.length = 0;
            return;
        }// end function

        public function GetParent() : Widget
        {
            return this.m_parent;
        }// end function

    }
}
