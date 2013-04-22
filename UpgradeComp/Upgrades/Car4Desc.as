package EarnToDie_2.Upgrades
{
    import EarnToDie_2.*;

    public class Car4Desc extends CarDesc
    {

        public function Car4Desc()
        {
            ;
            default xml namespace = this;
            var _loc_1:* = upgrades[Constants.UT_ENGINE];
            _loc_1.iconClass = "U_Engine_$";
            _loc_1.maxLevel = 3;
            _loc_1.levels[1].price = 0;
            _loc_1.levels[2].price = 18000;
            _loc_1.levels[3].price = 65000;
            _loc_1.levels[1].description = "5.5L V8 Diesel Engine";
            _loc_1.levels[2].description = "6.0L V8 Diesel Engine";
            _loc_1.levels[3].description = "6.5L V8 Turbo Diesel";
            _loc_1 = upgrades[Constants.UT_TRANSMISSION];
            _loc_1.iconClass = "U_Transmission_$";
            _loc_1.maxLevel = 3;
            _loc_1.levels[1].price = 0;
            _loc_1.levels[2].price = 20000;
            _loc_1.levels[3].price = 70000;
            _loc_1.levels[1].description = "4-Speed Gearbox";
            _loc_1.levels[2].description = "5-Speed Gearbox";
            _loc_1.levels[3].description = "6-Speed Gearbox";
            _loc_1 = upgrades[Constants.UT_WHEELS];
            _loc_1.iconClass = "U_Wheel_#_up$";
            _loc_1.maxLevel = 3;
            _loc_1.levels[1].price = 0;
            _loc_1.levels[2].price = 16000;
            _loc_1.levels[3].price = 45000;
            _loc_1.levels[1].description = "R18 HT Wheels";
            _loc_1.levels[2].description = "R24 AT Wheels";
            _loc_1.levels[3].description = "R28 MT Wheels";
            _loc_1 = upgrades[Constants.UT_FUEL];
            _loc_1.iconClass = "U_Fuel";
            _loc_1.maxLevel = 1;
            _loc_1.maxAmmoFuel = 9;
            _loc_1.ammoFuelLevels[1].price = 2000;
            _loc_1.ammoFuelLevels[2].price = 2500;
            _loc_1.ammoFuelLevels[3].price = 2800;
            _loc_1.ammoFuelLevels[4].price = 3000;
            _loc_1.ammoFuelLevels[5].price = 3500;
            _loc_1.ammoFuelLevels[6].price = 4000;
            _loc_1.ammoFuelLevels[7].price = 5000;
            ;
            _loc_2 = 8;
            default xml namespace = -((_loc_1.ammoFuelLevels - 1) + 1);
            (null[null])[NaN].price = 6500;
            _loc_1.ammoFuelLevels[9].price = 7000;
            _loc_1.levels[1].description = "Fuel Tank";
            _loc_1 = upgrades[Constants.UT_BOOST];
            _loc_1.iconClass = "U_Accelerator_#";
            _loc_1.maxLevel = 1;
            _loc_1.uninstallAllowed = true;
            _loc_1.maxAmmoFuel = 9;
            _loc_1.levels[1].price = 40000;
            _loc_1.ammoFuelLevels[1].price = 6000;
            _loc_1.ammoFuelLevels[2].price = 6500;
            _loc_1.ammoFuelLevels[3].price = 7000;
            _loc_1.ammoFuelLevels[4].price = 7500;
            _loc_1.ammoFuelLevels[5].price = 8000;
            _loc_1.ammoFuelLevels[6].price = 9000;
            _loc_1.ammoFuelLevels[7].price = 10000;
            _loc_1.ammoFuelLevels[8].price = 11000;
            _loc_1.ammoFuelLevels[9].price = 12000;
            _loc_1.levels[1].description = "Double Jet Turbine";
            _loc_1 = upgrades[Constants.UT_GUN];
            _loc_1.iconClass = "U_Gun_#";
            _loc_1.maxLevel = 1;
            _loc_1.uninstallAllowed = true;
            _loc_1.maxAmmoFuel = 9;
            _loc_1.levels[1].price = 50000;
            _loc_1.ammoFuelLevels[1].price = 2000;
            _loc_1.ammoFuelLevels[2].price = 2500;
            _loc_1.ammoFuelLevels[3].price = 3000;
            _loc_1.ammoFuelLevels[4].price = 3500;
            _loc_1.ammoFuelLevels[5].price = 4000;
            _loc_1.ammoFuelLevels[6].price = 5000;
            _loc_1.ammoFuelLevels[7].price = 6000;
            _loc_1.ammoFuelLevels[8].price = 7000;
            _loc_1.ammoFuelLevels[9].price = 8000;
            _loc_1.levels[1].description = "Medium Machine Gun";
            _loc_1 = upgrades[Constants.UT_SPIKES];
            _loc_1.iconClass = "U_Device_#_up$";
            _loc_1.maxLevel = 1;
            _loc_1.uninstallAllowed = true;
            ;
            default xml namespace = null * _loc_1;
            (null / (null >>> (null + 1))).levels[1].price = 25000;
            _loc_1.levels[2].price = 60000;
            _loc_1.levels[1].description = "Spike Cover";
            _loc_1.levels[2].description = "Hatchet";
            return;
        }// end function

    }
}
