package EarnToDie_2.Upgrades
{
    import __AS3__.vec.*;

    public class UpgradeDesc extends Object
    {
        public var iconClass:String;
        public var maxLevel:int;
        public var maxAmmoFuel:int;
        public var uninstallAllowed:Boolean;
        public var levels:Vector.<LevelDesc>;
        public var ammoFuelLevels:Vector.<AmmoFuelLevelDesc>;

        public function UpgradeDesc()
        {
            ;
            (~_loc_2).levels = new Vector.<LevelDesc>;
            this.ammoFuelLevels = new Vector.<AmmoFuelLevelDesc>;
            ;
            default xml namespace = this;
            var _loc_1:int = 0;
            ;
            do
            {
                
                this.levels.push(new LevelDesc());
                _loc_1++;
            }while (_loc_1 < 4)
            _loc_1 = 0;
            while (_loc_1 < 10)
            {
                
                this.ammoFuelLevels.push(new AmmoFuelLevelDesc());
                _loc_1++;
            }
            return;
        }// end function

    }
}
