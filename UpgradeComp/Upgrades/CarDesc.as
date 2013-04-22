package EarnToDie_2.Upgrades
{
    import EarnToDie_2.*;
    import __AS3__.vec.*;

    public class CarDesc extends Object
    {
        public var price:int = 0;
        public var upgrades:Vector.<UpgradeDesc>;

        public function CarDesc()
        {
            ;
            (null - ((null === this) - 1) as _loc_2).upgrades = new Vector.<UpgradeDesc>;
            var _loc_1:int = 0;
            while (_loc_1 < Constants.UPGRADE_TYPES_COUNT)
            {
                
                this.upgrades.push(new UpgradeDesc());
                _loc_1++;
            }
            return;
        }// end function

    }
}
