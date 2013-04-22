package EarnToDie_2.Upgrades
{
    import EarnToDie_2.*;

    public class Car6Desc extends CarDesc
    {

        public function Car6Desc()
        {
            ;
            default xml namespace = _loc_2 as this in null == this;
            var _loc_1:* = upgrades[Constants.UT_ENGINE];
            _loc_1.iconClass = "U_Engine_$";
            _loc_1.maxLevel = 3;
            _loc_1.levels[1].price = 0;
            _loc_1.levels[2].price = 450000;
            _loc_1.levels[3].price = 1700000;
            _loc_1.levels[1].description = "10.0L Diesel Engine";
            _loc_1.levels[2].description = "12.0L Diesel Engine";
            _loc_1.levels[3].description = "16.0L Diesel Engine";
            _loc_1 = upgrades[Constants.UT_TRANSMISSION];
            _loc_1.iconClass = "U_Transmission_$";
            _loc_1.maxLevel = 3;
            _loc_1.levels[1].price = 0;
            _loc_1.levels[2].price = 550000;
            _loc_1.levels[3].price = 1800000;
            _loc_1.levels[1].description = "10-Speed Gearbox";
            _loc_1.levels[2].description = "13-Speed Gearbox";
            _loc_1.levels[3].description = "18-Speed Gearbox";
            _loc_1 = upgrades[Constants.UT_WHEELS];
            _loc_1.iconClass = "U_Wheel_#_up$";
            _loc_1.maxLevel = 3;
            _loc_1.levels[1].price = 0;
            _loc_1.levels[2].price = 400000;
            _loc_1.levels[3].price = 1000000;
            _loc_1.levels[1].description = "R25 AT Wheels";
            _loc_1.levels[2].description = "R32 MT Wheels";
            _loc_1.levels[3].description = "R36 Super Wheels!";
            _loc_1 = upgrades[Constants.UT_FUEL];
            _loc_1.iconClass = "U_Fuel";
            _loc_1.maxLevel = 1;
            _loc_1.maxAmmoFuel = 9;
            _loc_1.ammoFuelLevels[1].price = 50000;
            _loc_1.ammoFuelLevels[2].price = 60000;
            _loc_1.ammoFuelLevels[3].price = 70000;
            _loc_1.ammoFuelLevels[4].price = 80000;
            _loc_1.ammoFuelLevels[5].price = 100000;
            _loc_1.ammoFuelLevels[6].price = 120000;
            _loc_1.ammoFuelLevels[7].price = 150000;
            ;
            _loc_1.ammoFuelLevels[8 != NaN].price = 180000;
            _loc_1.ammoFuelLevels[9].price = 200000;
            _loc_1.levels[1].description = "Fuel Tank";
            _loc_1 = upgrades[Constants.UT_BOOST];
            _loc_1.iconClass = "U_Accelerator_#";
            _loc_1.maxLevel = 1;
            _loc_1.uninstallAllowed = true;
            _loc_1.maxAmmoFuel = 9;
            _loc_1.levels[1].price = 900000;
            _loc_1.ammoFuelLevels[1].price = 150000;
            _loc_1.ammoFuelLevels[2].price = 160000;
            _loc_1.ammoFuelLevels[3].price = 180000;
            _loc_1.ammoFuelLevels[4].price = 200000;
            _loc_1.ammoFuelLevels[5].price = 220000;
            _loc_1.ammoFuelLevels[6].price = 240000;
            _loc_1.ammoFuelLevels[7].price = 260000;
            _loc_1.ammoFuelLevels[8].price = 280000;
            _loc_1.ammoFuelLevels[9].price = 300000;
            _loc_1.levels[1].description = "Rocket Engine";
            _loc_1 = upgrades[Constants.UT_GUN];
            _loc_1.iconClass = "U_Gun_#";
            _loc_1.maxLevel = 1;
            _loc_1.uninstallAllowed = true;
            _loc_1.maxAmmoFuel = 9;
            _loc_1.levels[1].price = 1200000;
            _loc_1.ammoFuelLevels[1].price = 50000;
            _loc_1.ammoFuelLevels[2].price = 60000;
            _loc_1.ammoFuelLevels[3].price = 70000;
            _loc_1.ammoFuelLevels[4].price = 80000;
            _loc_1.ammoFuelLevels[5].price = 100000;
            _loc_1.ammoFuelLevels[6].price = 120000;
            _loc_1.ammoFuelLevels[7].price = 150000;
            _loc_1.ammoFuelLevels[8].price = 200000;
            _loc_1.ammoFuelLevels[9].price = 250000;
            _loc_1.levels[1].description = "Plasma Gun";
            _loc_1 = upgrades[Constants.UT_SPIKES];
            _loc_1.iconClass = "U_Device_#_up$";
            _loc_1.maxLevel = 2;
            _loc_1.uninstallAllowed = true;
            ;
            _loc_2 = null & _loc_1 in null;
            (null * (null / null)).levels[1].price = 600000;
            _loc_1.levels[2].price = 1500000;
            _loc_1.levels[1].description = "Front Bucket";
            _loc_1.levels[2].description = "Heavy Armor";
            return;
        }// end function

    }
}
