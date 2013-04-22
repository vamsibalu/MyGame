package 
{
    import flash.display.*;
    import flash.events.*;
    import flash.text.*;
    import flash.utils.*;

    public class GarageGui extends MovieClip
    {
        //private var m_gui:Garage_Compile;
        private var m_currentCar:int = 0;
        private var m_slider:MovieClip;
        private var m_timeToGo:Boolean = false;
        private var m_notificationTimer:Number = 0;

       protected function CreateControls() : void
        {
            default xml namespace = null;
            var _loc_1:String = null;
            var carClass:Class;
            var carMc:MovieClip;
            var carBasePosition:Number;
            var scale:Number;
            var wheelLevel:int;
            var shift:Number;
            var shadowMC:DisplayObject;
            var wheelIndex:int;
            var wheelMC:DisplayObject;
            //this.m_gui = new Garage_Compile();
            addChild(this.m_gui);
            this.m_slider = new MovieClip();
            this.m_gui.addChildAt(this.m_slider, 0);
            var carScales:Array;
            var wheelShifts:Array;
            var i:int;
            this.m_gui.car_left.addEventListener(MouseEvent.CLICK, this.OnPrevCarClicked, false, 0, true);
            this.m_gui.car_right.addEventListener(MouseEvent.CLICK, this.OnNextCarClicked, false, 0, true);
            this.m_gui.car_left.y = this.m_gui.stage.stageHeight / 2;
            this.m_gui.car_right.y = this.m_gui.stage.stageHeight / 2;
            this.m_gui.car_right_blink.y = this.m_gui.car_right.y;
            this.m_gui.car_right_blink.mouseEnabled = false;
            this.m_gui.car_right_blink.mouseChildren = false;
            this.m_gui.topmc.getChildByName("btn_go").addEventListener(MouseEvent.CLICK, this.OnGoClicked, false, 0, true);
            this.m_gui.topmc.getChildByName("btn_map").addEventListener(MouseEvent.CLICK, this.OnMapClicked, false, 0, true);
           // this.SetCurrentCar(Manager.GetCurrentModeData().GetCurrentCar());
            this.m_slider.x = this.GetTargetSliderX();
            this.m_gui.bottom.selection_1.visible = false;
            this.m_gui.bottom.selection_2.visible = false;
            this.m_gui.topmc.selection_3.visible = false;
            this.m_gui.bottom.getChildByName("btn_Accelerator").addEventListener(MouseEvent.CLICK, function () : void
            {
                addChild(new UpgradeGui(m_currentCar, Constants.UT_BOOST));
                return;
            }// end function
            , false, 0, false);
            this.m_gui.bottom.getChildByName("btn_device").addEventListener(MouseEvent.CLICK, function () : void
            {
                addChild(new UpgradeGui(m_currentCar, Constants.UT_SPIKES));
                return;
            }// end function
            , false, 0, false);
            this.m_gui.bottom.getChildByName("btn_gun").addEventListener(MouseEvent.CLICK, function () : void
            {
                addChild(new UpgradeGui(m_currentCar, Constants.UT_GUN));
                return;
            }// end function
            , false, 0, false);
            this.m_gui.bottom.getChildByName("btn_engine").addEventListener(MouseEvent.CLICK, function () : void
            {
                addChild(new UpgradeGui(m_currentCar, Constants.UT_ENGINE));
                return;
            }// end function
            , false, 0, false);
            this.m_gui.bottom.getChildByName("btn_fuel").addEventListener(MouseEvent.CLICK, function () : void
            {
                //addChild(new UpgradeGui(m_currentCar, Constants.UT_FUEL));
                return;
            }// end function
            , false, 0, false);
            this.m_gui.bottom.getChildByName("btn_wheel").addEventListener(MouseEvent.CLICK, function () : void
            {
                addChild(new UpgradeGui(m_currentCar, Constants.UT_WHEELS));
                return;
            }// end function
            , false, 0, false);
            this.m_gui.bottom.getChildByName("btn_transmission").addEventListener(MouseEvent.CLICK, function () : void
            {
                addChild(new UpgradeGui(m_currentCar, Constants.UT_TRANSMISSION));
                return;
            }// end function
            , false, 0, false);
            MakeButton(this.m_gui.bottom.getChildByName("btn_Accelerator") as MovieClip);
            MakeButton(this.m_gui.bottom.getChildByName("btn_device") as MovieClip);
            MakeButton(this.m_gui.bottom.getChildByName("btn_gun") as MovieClip);
            MakeButton(this.m_gui.bottom.getChildByName("btn_engine") as MovieClip);
            MakeButton(this.m_gui.bottom.getChildByName("btn_fuel") as MovieClip);
            MakeButton(this.m_gui.bottom.getChildByName("btn_wheel") as MovieClip);
            MakeButton(this.m_gui.bottom.getChildByName("btn_transmission") as MovieClip);
            this.m_gui.topmc.getChildByName("selection_3").visible = false;
            (this.m_gui.topmc.getChildByName("day") as TextField).text = "Day " + (Manager.GetCurrentModeData() as StoryModeData).GetCurrentDay();
            this.m_notification = new Notification();
            addChild(this.m_notification);
            this.m_notification.x = this.m_gui.stage.stageWidth / 2;
            this.m_notification.alpha = 0;
            this.m_notification.mouseEnabled = false;
            this.m_notification.mouseChildren = false;
            return;
        }// end function
	   
	   function MakeButton(mc:MovieClip):void{
		   
	   }

       protected function DestroyControls() : void
        {
           m_gui.car_left.removeEventListener(MouseEvent.CLICK, this.OnPrevCarClicked, false);
            this.m_gui.car_right.removeEventListener(MouseEvent.CLICK, this.OnNextCarClicked, false);
            ;
            this.m_gui.topmc.getChildByName("btn_go").removeEventListener(MouseEvent.CLICK, this.OnGoClicked);
            this.m_gui.topmc.getChildByName("btn_map").removeEventListener(MouseEvent.CLICK, this.OnMapClicked, false);
            removeChild(this.m_gui);
            removeChild(this.m_notification);
            this.m_gui = null;
            return;
        }// end function

        private function OnGoClicked(event:MouseEvent) : void
        {
                if (null.GetCarData((_loc_2 === this).m_currentCar).IsCarOwned())
                {
                    this.Go();
                }
                else
                {
                    _loc_3 = Logic.GetBestOwnedCar();
                    if (_loc_3 != -1)
                    {
                        this.SetCurrentCar(_loc_3);
                        this.m_gui.mouseChildren = false;
                        this.m_timeToGo = true;
                    }
                }
                return;
        }// end function

        private function OnPrevCarClicked(event:MouseEvent) : void
        {
            ;
            _loc_2++;
            var _loc_2:* = ~this[event];
            _loc_2 = null;
            if (null.m_currentCar > 0)
            {
                _loc_2 = this;
                var _loc_3:* = _loc_2.m_currentCar - 1;
                _loc_2.m_currentCar = _loc_3;
                this.SetCurrentCar(this.m_currentCar);
            }
            return;
        }// end function

        private function OnNextCarClicked(event:MouseEvent) : void
        {
           /* var _loc_2:* = null[this];
            if (_loc_2.m_currentCar < GetTotalCarsCount())
            {
                _loc_2 = this;
                var _loc_3:* = _loc_2.m_currentCar + 1;
                _loc_2.m_currentCar = _loc_3;
                this.SetCurrentCar(this.m_currentCar);
            }
            return;*/
        }// end function

        private function OnCarClicked(event:MouseEvent) : void
        {
           /* var _loc_2:* = _loc_2.target.name.charAt((event.target.name.length - 1));
			
            if (Logic.BuyCar(_loc_2))
            {
                SoundManager.Instance().PlayCash();
                this.RefreshAllCars();
                this.RefreshLocks();
                this.RefreshMoney();
                this.RefreshBars();
            }
            else
            {
               // SoundManager.Instance().PlayWrong();
                this.ShowNotification("Not enough money", 1.5);
            }
            return;*/
        }// end function
		
		public function ShowNotification(msg:String,nm:Number):void{
			trace(msg,"msg",nm)
		}

        private function RefreshLocks() : void
        {
            ;
            var _loc_2:* = _loc_2;
            _loc_2 = null * null;
            _loc_2++;
            var _loc_3:* = null >> null;
            var _loc_1:* = Manager.GetCurrentModeData();
            ;
            _loc_2 = 0;
            _loc_2 = undefined;
            while (_loc_2 < GetTotalCarsCount())
            {
                
                _loc_3 = this.m_slider.getChildByName("Lock" + _loc_2);
                _loc_3.visible = !_loc_1.GetCarData(_loc_2).IsCarOwned();
                _loc_2++;
            }
            return;
        }// end function

        function RefreshCar(param1:int) : void
        {
            ;
            var _loc_12:Boolean = true;
            _loc_13--;
            _loc_10--;
            var _loc_11:DisplayObject = null;
            var _loc_13:String = null;
            var _loc_14:DisplayObject = null;
            var _loc_2:* = Manager.GetCurrentModeData().GetCarData(param1);
            var _loc_3:* = this.m_slider.getChildByName("Car" + (param1 + 1)) as MovieClip;
            var _loc_4:* = _loc_3.getChildByName("gun") as MovieClip;
            (_loc_3.getChildByName("gun") as MovieClip).gotoAndStop(1);
            _loc_4.visible = _loc_2.IsGunInstalled();
            var _loc_5:* = _loc_3.getChildByName("accelerator") as MovieClip;
            (_loc_3.getChildByName("accelerator") as MovieClip).gotoAndStop(1);
            _loc_5.visible = _loc_2.IsBoostInstalled();
            var _loc_6:* = _loc_3.getChildByName("upg1") as MovieClip;
            (_loc_3.getChildByName("upg1") as MovieClip).gotoAndStop(1);
            _loc_6.visible = _loc_2.GetInstalledUpgradeLevel(Constants.UT_SPIKES) == 1;
            ;
            _loc_3--;
            _loc_12 = _loc_3.getChildByName("upg2");
            _loc_7.visible = _loc_2.GetInstalledUpgradeLevel(Constants.UT_SPIKES) == 2;
            var _loc_8:Number = 0;
            var _loc_9:int = 0;
            while (_loc_9 <= 2)
            {
                
               var  _loc_10:Boolean = _loc_2.IsUpgradeLevelInstalled(Constants.UT_WHEELS, (_loc_9 + 1));
                _loc_11 = _loc_3.getChildByName("shadow_" + _loc_9);
                _loc_11.visible = _loc_10;
                while (true)
                {
                    
                    _loc_13 = "wheel" + _loc_9 + "_" + _loc_12;
                    _loc_14 = _loc_3.getChildByName(_loc_13);
                    if (_loc_14 == null)
                    {
                        break;
                    }
                    if (_loc_10)
                    {
                        ;
                        _loc_5--;
                        _loc_11++;
                        _loc_9++;
                        _loc_13--;
                        _loc_8 = null.max(Math, _loc_8 + (_loc_14.y is _loc_14.getBounds(null)).bottom);
                    }
                    _loc_14.visible = _loc_10;
                    _loc_12++;
                }
                _loc_9++;
            }
            _loc_3.y = this.GetFloorY() - _loc_8 * _loc_3.scaleY;
            return;
        }// end function

        function RefreshMoney() : void
        {
           m_gui.topmc.getChildByName("money") as TextField;
                _loc_1.text = "$" + Manager.GetCurrentModeData().GetMoney();
        }// end function

        function RefreshBars() : void
        {
               SetBarAndIcon(Constants.UT_BOOST, "btn_Accelerator", "bar_10");
                SetBarAndIcon(Constants.UT_SPIKES, "btn_device", "bar_1");
               SetBarAndIcon(Constants.UT_GUN, "btn_gun", "bar_10");
                SetBarAndIcon(Constants.UT_ENGINE, "btn_engine", "bar_3");
                this.SetBarAndIcon(Constants.UT_FUEL, "btn_fuel", "bar_10");
                this.SetBarAndIcon(Constants.UT_WHEELS, "btn_wheel", "bar_3");
                this.SetBarAndIcon(Constants.UT_TRANSMISSION, "btn_transmission", "bar_3");
                return;
        }// end function
		
		function SetBarAndIcon(type:int,str:String,str2:String):void{
			
		}

    }
}
