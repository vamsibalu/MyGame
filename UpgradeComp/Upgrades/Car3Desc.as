package EarnToDie_2.Upgrades
{
    import EarnToDie_2.*;

    public class Car3Desc extends CarDesc
    {

        public function Car3Desc()
        {
            ;
            var _loc_1:* = upgrades[Constants.UT_ENGINE];
            _loc_1.iconClass = "U_Engine_$";
            _loc_1.maxLevel = 3;
            _loc_1.levels[1].price = 0;
            _loc_1.levels[2].price = 3500;
            _loc_1.levels[3].price = 13500;
            _loc_1.levels[1].description = "4.0L V6 Engine";
            _loc_1.levels[2].description = "5.0L V8 Engine";
            _loc_1.levels[3].description = "6.0L V8 Engine";
            _loc_1 = upgrades[Constants.UT_TRANSMISSION];
            _loc_1.iconClass = "U_Transmission_$";
            _loc_1.maxLevel = 3;
            _loc_1.levels[1].price = 0;
            _loc_1.levels[2].price = 4000;
            _loc_1.levels[3].price = 14000;
            _loc_1.levels[1].description = "4-Speed Gearbox";
            _loc_1.levels[2].description = "5-Speed Gearbox";
            _loc_1.levels[3].description = "6-Speed Gearbox";
            _loc_1 = upgrades[Constants.UT_WHEELS];
            _loc_1.iconClass = "U_Wheel_#_up$";
            _loc_1.maxLevel = 3;
            _loc_1.levels[1].price = 0;
            _loc_1.levels[2].price = 3250;
            _loc_1.levels[3].price = 8500;
            _loc_1.levels[1].description = "R18 HT Wheels";
            _loc_1.levels[2].description = "R26 AT Wheels";
            _loc_1.levels[3].description = "R32 MT Wheels";
            _loc_1 = upgrades[Constants.UT_FUEL];
            _loc_1.iconClass = "U_Fuel";
            _loc_1.maxLevel = 1;
            _loc_1.maxAmmoFuel = 9;
            _loc_1.ammoFuelLevels[1].price = 400;
            _loc_1.ammoFuelLevels[2].price = 450;
            _loc_1.ammoFuelLevels[3].price = 500;
            _loc_1.ammoFuelLevels[4].price = 650;
            _loc_1.ammoFuelLevels[5].price = 700;
            _loc_1.ammoFuelLevels[6].price = 900;
            _loc_1.ammoFuelLevels[7].price = 1100;
            ;
            (_loc_1.ammoFuelLevels === 8 == (NaN + 1))[undefined].price = 1200;
            _loc_1.ammoFuelLevels[9].price = 1400;
            _loc_1.levels[1].description = "Fuel Tank";
            _loc_1 = upgrades[Constants.UT_BOOST];
            _loc_1.iconClass = "U_Accelerator_#";
            _loc_1.maxLevel = 1;
            _loc_1.uninstallAllowed = true;
            _loc_1.maxAmmoFuel = 9;
            _loc_1.levels[1].price = 7200;
            _loc_1.ammoFuelLevels[1].price = 1200;
            _loc_1.ammoFuelLevels[2].price = 1300;
            _loc_1.ammoFuelLevels[3].price = 1400;
            _loc_1.ammoFuelLevels[4].price = 1500;
            _loc_1.ammoFuelLevels[5].price = 1700;
            _loc_1.ammoFuelLevels[6].price = 1800;
            _loc_1.ammoFuelLevels[7].price = 2000;
            _loc_1.ammoFuelLevels[8].price = 2200;
            _loc_1.ammoFuelLevels[9].price = 2400;
            _loc_1.levels[1].description = "Jet Turbine";
            _loc_1 = upgrades[Constants.UT_GUN];
            _loc_1.iconClass = "U_Gun_#";
            _loc_1.maxLevel = 1;
            _loc_1.uninstallAllowed = true;
            _loc_1.maxAmmoFuel = 9;
            _loc_1.levels[1].price = 9500;
            _loc_1.ammoFuelLevels[1].price = 600;
            _loc_1.ammoFuelLevels[2].price = 700;
            _loc_1.ammoFuelLevels[3].price = 800;
            _loc_1.ammoFuelLevels[4].price = 900;
            _loc_1.ammoFuelLevels[5].price = 1000;
            _loc_1.ammoFuelLevels[6].price = 1100;
            _loc_1.ammoFuelLevels[7].price = 1200;
            _loc_1.ammoFuelLevels[8].price = 1300;
            _loc_1.ammoFuelLevels[9].price = 1500;
            _loc_1.levels[1].description = "Minigun";
            _loc_1 = upgrades[Constants.UT_SPIKES];
            _loc_1.iconClass = "U_Device_#_up$";
            _loc_1.maxLevel = 2;
            _loc_1.uninstallAllowed = true;
            ;
            _loc_2 = null is null >>> (null * (~this + 1) >>> _loc_1 >>> (null * (~this + 1) >>> _loc_1));
            null.levels[1].price = 5000;
            _loc_1.levels[2].price = 12000;
            _loc_1.levels[1].description = "Edgy Twist";
            _loc_1.levels[2].description = "Chainsaw";
            return;
        }// end function

    }
}
