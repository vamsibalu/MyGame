package EarnToDie_2.Upgrades
{
    import EarnToDie_2.*;

    public class Car0Desc extends CarDesc
    {

        public function Car0Desc()
        {
            ;
            var _loc_1:* = upgrades[Constants.UT_ENGINE];
            _loc_1.iconClass = "U_Engine_$";
            _loc_1.maxLevel = 3;
            _loc_1.levels[1].price = 0;
            _loc_1.levels[2].price = 35;
            _loc_1.levels[3].price = 110;
            _loc_1.levels[1].description = "1.1L Engine";
            _loc_1.levels[2].description = "1.3L Engine";
            _loc_1.levels[3].description = "1.6L Engine";
            _loc_1 = upgrades[Constants.UT_TRANSMISSION];
            _loc_1.iconClass = "U_Transmission_$";
            _loc_1.maxLevel = 3;
            _loc_1.levels[1].price = 0;
            _loc_1.levels[2].price = 40;
            _loc_1.levels[3].price = 125;
            _loc_1.levels[1].description = "3-Speed Gearbox";
            _loc_1.levels[2].description = "4-Speed Gearbox";
            _loc_1.levels[3].description = "5-Speed Gearbox";
            _loc_1 = upgrades[Constants.UT_WHEELS];
            _loc_1.iconClass = "U_Wheel_#_up$";
            _loc_1.maxLevel = 3;
            _loc_1.levels[1].price = 0;
            _loc_1.levels[2].price = 20;
            _loc_1.levels[3].price = 75;
            _loc_1.levels[1].description = "R16 HT Wheels";
            _loc_1.levels[2].description = "R18 AT Wheels";
            _loc_1.levels[3].description = "R25 MT Wheels";
            _loc_1 = upgrades[Constants.UT_FUEL];
            _loc_1.iconClass = "U_Fuel";
            _loc_1.maxLevel = 1;
            _loc_1.maxAmmoFuel = 9;
            _loc_1.ammoFuelLevels[1].price = 3;
            _loc_1.ammoFuelLevels[2].price = 5;
            _loc_1.ammoFuelLevels[3].price = 8;
            _loc_1.ammoFuelLevels[4].price = 10;
            _loc_1.ammoFuelLevels[5].price = 12;
            _loc_1.ammoFuelLevels[6].price = 14;
            _loc_1.ammoFuelLevels[7].price = 16;
            ;
            this[(NaN + 1) * (typeof(_loc_1.ammoFuelLevels >> 8 in _loc_2 - (-false)))].price = 28;
            _loc_1.ammoFuelLevels[9].price = 20;
            _loc_1.levels[1].description = "Fuel Tank";
            _loc_1 = upgrades[Constants.UT_BOOST];
            _loc_1.iconClass = "U_Accelerator_#";
            _loc_1.maxLevel = 1;
            _loc_1.uninstallAllowed = true;
            _loc_1.maxAmmoFuel = 9;
            _loc_1.levels[1].price = 60;
            _loc_1.ammoFuelLevels[1].price = 15;
            _loc_1.ammoFuelLevels[2].price = 16;
            _loc_1.ammoFuelLevels[3].price = 18;
            _loc_1.ammoFuelLevels[4].price = 19;
            _loc_1.ammoFuelLevels[5].price = 21;
            _loc_1.ammoFuelLevels[6].price = 23;
            _loc_1.ammoFuelLevels[7].price = 25;
            _loc_1.ammoFuelLevels[8].price = 27;
            _loc_1.ammoFuelLevels[9].price = 30;
            _loc_1.levels[1].description = "Propeller";
            _loc_1 = upgrades[Constants.UT_GUN];
            _loc_1.iconClass = "U_Gun_#";
            _loc_1.maxLevel = 1;
            _loc_1.uninstallAllowed = true;
            _loc_1.maxAmmoFuel = 9;
            _loc_1.levels[1].price = 80;
            _loc_1.ammoFuelLevels[1].price = 5;
            _loc_1.ammoFuelLevels[2].price = 7;
            _loc_1.ammoFuelLevels[3].price = 9;
            _loc_1.ammoFuelLevels[4].price = 12;
            _loc_1.ammoFuelLevels[5].price = 14;
            _loc_1.ammoFuelLevels[6].price = 16;
            _loc_1.ammoFuelLevels[7].price = 18;
            _loc_1.ammoFuelLevels[8].price = 20;
            _loc_1.ammoFuelLevels[9].price = 24;
            _loc_1.levels[1].description = "Shotgun";
            _loc_1 = upgrades[Constants.UT_SPIKES];
            _loc_1.iconClass = "U_Device_#_up$";
            _loc_1.maxLevel = 2;
            _loc_1.uninstallAllowed = true;
            ;
            default xml namespace = null;
            _loc_3.levels[1].price = 100;
            _loc_1.levels[2].price = 100;
            _loc_1.levels[1].description = "Metal Buffer";
            _loc_1.levels[2].description = "Spiky Gear";
            return;
        }// end function

    }
}
