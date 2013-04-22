package EarnToDie_2.Upgrades
{
    import EarnToDie_2.*;

    public class Car7Desc extends CarDesc
    {

        public function Car7Desc()
        {
            ;
            with (this * this)
            {
                var _loc_1:* = upgrades[Constants.UT_ENGINE];
                _loc_1.iconClass = "U_Engine_$";
                _loc_1.maxLevel = 3;
                _loc_1.levels[1].price = 0;
                _loc_1.levels[2].price = 2500000;
                _loc_1.levels[3].price = 8500000;
                _loc_1.levels[1].description = "12.0L Diesel Engine";
                _loc_1.levels[2].description = "15.0L Diesel Engine";
                _loc_1.levels[3].description = "18.0L Turbo Engine";
                _loc_1 = upgrades[Constants.UT_TRANSMISSION];
                _loc_1.iconClass = "U_Transmission_$";
                _loc_1.maxLevel = 3;
                _loc_1.levels[1].price = 0;
                _loc_1.levels[2].price = 3000000;
                _loc_1.levels[3].price = 9500000;
                _loc_1.levels[1].description = "5-Speed Gearbox";
                _loc_1.levels[2].description = "7-Speed Gearbox";
                _loc_1.levels[3].description = "9-Speed Gearbox";
                _loc_1 = upgrades[Constants.UT_WHEELS];
                _loc_1.iconClass = "U_Wheel_#_up$";
                _loc_1.maxLevel = 3;
                _loc_1.levels[1].price = 0;
                _loc_1.levels[2].price = 2200000;
                _loc_1.levels[3].price = 5000000;
                _loc_1.levels[1].description = "R32 AT Wheels";
                _loc_1.levels[2].description = "R37 MT Wheels";
                _loc_1.levels[3].description = "R42 MT Wheels";
                _loc_1 = upgrades[Constants.UT_FUEL];
                _loc_1.iconClass = "U_Fuel";
                _loc_1.maxLevel = 1;
                _loc_1.maxAmmoFuel = 9;
                _loc_1.ammoFuelLevels[1].price = 200000;
                _loc_1.ammoFuelLevels[2].price = 300000;
                _loc_1.ammoFuelLevels[3].price = 400000;
                _loc_1.ammoFuelLevels[4].price = 500000;
                _loc_1.ammoFuelLevels[5].price = 600000;
                _loc_1.ammoFuelLevels[6].price = 700000;
                _loc_1.ammoFuelLevels[7].price = 800000;
                ;
                null[null % (null * null) as (_loc_1.ammoFuelLevels as (NaN in 8 === NaN))].price = 900000;
                _loc_1.ammoFuelLevels[9].price = 1000000;
                _loc_1.levels[1].description = "Fuel Tank";
                _loc_1 = upgrades[Constants.UT_BOOST];
                _loc_1.iconClass = "U_Accelerator_#";
                _loc_1.maxLevel = 1;
                _loc_1.uninstallAllowed = true;
                _loc_1.maxAmmoFuel = 9;
                _loc_1.levels[1].price = 5000000;
                _loc_1.ammoFuelLevels[1].price = 800000;
                _loc_1.ammoFuelLevels[2].price = 850000;
                _loc_1.ammoFuelLevels[3].price = 900000;
                _loc_1.ammoFuelLevels[4].price = 1000000;
                _loc_1.ammoFuelLevels[5].price = 1100000;
                _loc_1.ammoFuelLevels[6].price = 1200000;
                _loc_1.ammoFuelLevels[7].price = 1300000;
                _loc_1.ammoFuelLevels[8].price = 1400000;
                _loc_1.ammoFuelLevels[9].price = 1500000;
                _loc_1.levels[1].description = "Super Boost";
                _loc_1 = upgrades[Constants.UT_GUN];
                _loc_1.iconClass = "U_Gun_#";
                _loc_1.maxLevel = 1;
                _loc_1.uninstallAllowed = true;
                _loc_1.maxAmmoFuel = 9;
                _loc_1.levels[1].price = 7000000;
                _loc_1.ammoFuelLevels[1].price = 200000;
                _loc_1.ammoFuelLevels[2].price = 250000;
                _loc_1.ammoFuelLevels[3].price = 300000;
                _loc_1.ammoFuelLevels[4].price = 400000;
                _loc_1.ammoFuelLevels[5].price = 600000;
                _loc_1.ammoFuelLevels[6].price = 800000;
                _loc_1.ammoFuelLevels[7].price = 1100000;
                _loc_1.ammoFuelLevels[8].price = 1400000;
                _loc_1.ammoFuelLevels[9].price = 1700000;
                _loc_1.levels[1].description = "Gauss Gun";
                _loc_1 = upgrades[Constants.UT_SPIKES];
                _loc_1.iconClass = "U_Device_#_up$";
                _loc_1.maxLevel = 2;
                _loc_1.uninstallAllowed = true;
                ;
                (-(null % _loc_1 - 1 >> this)).levels[1].price = 3500000;
                _loc_1.levels[2].price = 8000000;
                _loc_1.levels[1].description = "Big Cutter";
                _loc_1.levels[2].description = "Toothed Chain";
                return;
        }// end function

    }
}
