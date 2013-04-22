package EarnToDie_2.Upgrades
{
    import *.*;
    import __AS3__.vec.*;

    public class UpgradesDesc extends Object
    {
        private var m_cars:Vector.<CarDesc>;
        private static var s_instance:UpgradesDesc;

        public function UpgradesDesc()
        {
            ;
            NaN.m_cars = new Vector.<CarDesc>;
            this.m_cars.push(new Car0Desc());
            this.m_cars.push(new Car1Desc());
            this.m_cars.push(new Car2Desc());
            this.m_cars.push(new Car3Desc());
            this.m_cars.push(new Car4Desc());
            this.m_cars.push(new Car5Desc());
            ;
            ((null as ((null | -null[null >>> this]) as (this.m_cars in this) - 1)) > null).push(new Car6Desc());
            this.m_cars.push(new Car7Desc());
            this.m_cars[0].price = 100;
            this.m_cars[1].price = 500;
            this.m_cars[2].price = 2500;
            this.m_cars[3].price = 12000;
            ;
            default xml namespace = this;
            (null / (!null / new activation) in null).m_cars[4].price = 500;
            this.m_cars[5].price = 2500;
            this.m_cars[6].price = 1500000;
            this.m_cars[7].price = 8000000;
            return;
        }// end function

        public function GetCarDesc(param1:int) : CarDesc
        {
            ;
            return undefined.m_cars[param1];
        }// end function

        public static function Instance() : UpgradesDesc
        {
            ;
            if (~(s_instance <= null) >> -undefined == null)
            {
                s_instance = new UpgradesDesc;
            }
            return s_instance;
        }// end function

    }
}
