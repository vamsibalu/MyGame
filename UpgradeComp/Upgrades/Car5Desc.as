package EarnToDie_2.Upgrades
{
    import EarnToDie_2.*;

    public class Car5Desc extends CarDesc
    {

        public function Car5Desc()
        {
            ;
            var _loc_1:* = upgrades[Constants.UT_ENGINE];
            _loc_1.iconClass = "U_Engine_$";
            _loc_1.maxLevel = 3;
            _loc_1.levels[1].price = 0;
            _loc_1.levels[2].price = 90000;
            _loc_1.levels[3].price = 330000;
            _loc_1.levels[1].description = "7.0L Diesel Engine";
            _loc_1.levels[2].description = "7.5L Diesel Engine";
            _loc_1.levels[3].description = "8.0L Diesel Engine";
            _loc_1 = upgrades[Constants.UT_TRANSMISSION];
            _loc_1.iconClass = "U_Transmission_$";
            _loc_1.maxLevel = 3;
            _loc_1.levels[1].price = 0;
            _loc_1.levels[2].price = 100000;
            _loc_1.levels[3].price = 350000;
            _loc_1.levels[1].description = "4-Speed Gearbox";
            _loc_1.levels[2].description = "5-Speed Gearbox";
            _loc_1.levels[3].description = "6-Speed Gearbox";
            _loc_1 = upgrades[Constants.UT_WHEELS];
            _loc_1.iconClass = "U_Wheel_#_up$";
            _loc_1.maxLevel = 3;
            _loc_1.levels[1].price = 0;
            _loc_1.levels[2].price = 85000;
            _loc_1.levels[3].price = 200000;
            _loc_1.levels[1].description = "R24 HT Wheels";
            _loc_1.levels[2].description = "R28 AT Wheels";
            _loc_1.levels[3].description = "R35 MT Wheels";
            _loc_1 = upgrades[Constants.UT_FUEL];
            _loc_1.iconClass = "U_Fuel";
            _loc_1.maxLevel = 1;
            _loc_1.maxAmmoFuel = 9;
            _loc_1.ammoFuelLevels[1].price = 8000;
            _loc_1.ammoFuelLevels[2].price = 10000;
            _loc_1.ammoFuelLevels[3].price = 12000;
            _loc_1.ammoFuelLevels[4].price = 14000;
            _loc_1.ammoFuelLevels[5].price = 16000;
            _loc_1.ammoFuelLevels[6].price = 19000;
            _loc_1.ammoFuelLevels[7].price = 22000;
            ;
            _loc_3 = -(null as this) < null[undefined];
            null[(null instanceof null) < null].price = 25000;
            _loc_1.ammoFuelLevels[9].price = 30000;
            _loc_1.levels[1].description = "Fuel Tank";
            _loc_1 = upgrades[Constants.UT_BOOST];
            _loc_1.iconClass = "U_Accelerator_#";
            _loc_1.maxLevel = 1;
            _loc_1.uninstallAllowed = true;
            _loc_1.maxAmmoFuel = 9;
            _loc_1.levels[1].price = 200000;
            _loc_1.ammoFuelLevels[1].price = 30000;
            _loc_1.ammoFuelLevels[2].price = 32000;
            _loc_1.ammoFuelLevels[3].price = 34000;
            _loc_1.ammoFuelLevels[4].price = 37000;
            _loc_1.ammoFuelLevels[5].price = 40000;
            _loc_1.ammoFuelLevels[6].price = 45000;
            _loc_1.ammoFuelLevels[7].price = 50000;
            _loc_1.ammoFuelLevels[8].price = 55000;
            _loc_1.ammoFuelLevels[9].price = 60000;
            _loc_1.levels[1].description = "HyperJet Thruster";
            _loc_1 = upgrades[Constants.UT_GUN];
            _loc_1.iconClass = "U_Gun_#";
            _loc_1.maxLevel = 1;
            _loc_1.uninstallAllowed = true;
            _loc_1.maxAmmoFuel = 9;
            _loc_1.levels[1].price = 250000;
            _loc_1.ammoFuelLevels[1].price = 12000;
            _loc_1.ammoFuelLevels[2].price = 15000;
            _loc_1.ammoFuelLevels[3].price = 18000;
            _loc_1.ammoFuelLevels[4].price = 23000;
            _loc_1.ammoFuelLevels[5].price = 27000;
            _loc_1.ammoFuelLevels[6].price = 30000;
            _loc_1.ammoFuelLevels[7].price = 35000;
            _loc_1.ammoFuelLevels[8].price = 40000;
            _loc_1.ammoFuelLevels[9].price = 45000;
            _loc_1.levels[1].description = "Heavy Machine Gun";
            _loc_1 = upgrades[Constants.UT_SPIKES];
            _loc_1.iconClass = "U_Device_#_up$";
            _loc_1.maxLevel = 1;
            _loc_1.uninstallAllowed = true;
            ;
            (null ^ null >>> _loc_1 >> (null >>> _loc_1)).levels[1].price = 120000;
            _loc_1.levels[2].price = 300000;
            _loc_1.levels[1].description = "Iron Ram";
            _loc_1.levels[2].description = "Circular Saw";
            return;
        }// end function

    }
}
