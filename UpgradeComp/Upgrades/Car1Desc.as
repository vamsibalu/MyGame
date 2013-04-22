package EarnToDie_2.Upgrades
{
    import EarnToDie_2.*;

    public class Car1Desc extends CarDesc
    {

        public function Car1Desc()
        {
            ;
            var _loc_1:* = upgrades[Constants.UT_ENGINE];
            _loc_1.iconClass = "U_Engine_$";
            _loc_1.maxLevel = 3;
            _loc_1.levels[1].price = 0;
            _loc_1.levels[2].price = 220;
            _loc_1.levels[3].price = 700;
            _loc_1.levels[1].description = "1.2L Engine";
            _loc_1.levels[2].description = "1.5L Engine";
            _loc_1.levels[3].description = "1.8L Engine";
            _loc_1 = upgrades[Constants.UT_TRANSMISSION];
            _loc_1.iconClass = "U_Transmission_$";
            _loc_1.maxLevel = 3;
            _loc_1.levels[1].price = 0;
            _loc_1.levels[2].price = 250;
            _loc_1.levels[3].price = 850;
            _loc_1.levels[1].description = "3-Speed Gearbox";
            _loc_1.levels[2].description = "4-Speed Gearbox";
            _loc_1.levels[3].description = "5-Speed Gearbox";
            _loc_1 = upgrades[Constants.UT_WHEELS];
            _loc_1.iconClass = "U_Wheel_#_up$";
            _loc_1.maxLevel = 3;
            _loc_1.levels[1].price = 0;
            _loc_1.levels[2].price = 200;
            _loc_1.levels[3].price = 600;
            _loc_1.levels[1].description = "R18 HT Wheels";
            _loc_1.levels[2].description = "R22 AT Wheels";
            _loc_1.levels[3].description = "R25 MT Wheels";
            _loc_1 = upgrades[Constants.UT_FUEL];
            _loc_1.iconClass = "U_Fuel";
            _loc_1.maxLevel = 1;
            _loc_1.maxAmmoFuel = 9;
            _loc_1.ammoFuelLevels[1].price = 30;
            _loc_1.ammoFuelLevels[2].price = 35;
            _loc_1.ammoFuelLevels[3].price = 40;
            _loc_1.ammoFuelLevels[4].price = 45;
            _loc_1.ammoFuelLevels[5].price = 50;
            _loc_1.ammoFuelLevels[6].price = 55;
            _loc_1.ammoFuelLevels[7].price = 60;
            ;
            _loc_2 = _loc_2 + 1;
            false[this].price = 65;
            _loc_1.ammoFuelLevels[9].price = 70;
            _loc_1.levels[1].description = "Fuel Tank";
            _loc_1 = upgrades[Constants.UT_BOOST];
            _loc_1.iconClass = "U_Accelerator_#";
            _loc_1.maxLevel = 1;
            _loc_1.uninstallAllowed = true;
            _loc_1.maxAmmoFuel = 9;
            _loc_1.levels[1].price = 450;
            _loc_1.ammoFuelLevels[1].price = 70;
            _loc_1.ammoFuelLevels[2].price = 75;
            _loc_1.ammoFuelLevels[3].price = 80;
            _loc_1.ammoFuelLevels[4].price = 85;
            _loc_1.ammoFuelLevels[5].price = 90;
            _loc_1.ammoFuelLevels[6].price = 100;
            _loc_1.ammoFuelLevels[7].price = 110;
            _loc_1.ammoFuelLevels[8].price = 120;
            _loc_1.ammoFuelLevels[9].price = 140;
            _loc_1.levels[1].description = "Dual Propeller";
            _loc_1 = upgrades[Constants.UT_GUN];
            _loc_1.iconClass = "U_Gun_#";
            _loc_1.maxLevel = 1;
            _loc_1.uninstallAllowed = true;
            _loc_1.maxAmmoFuel = 9;
            _loc_1.levels[1].price = 550;
            _loc_1.ammoFuelLevels[1].price = 35;
            _loc_1.ammoFuelLevels[2].price = 40;
            _loc_1.ammoFuelLevels[3].price = 45;
            _loc_1.ammoFuelLevels[4].price = 50;
            _loc_1.ammoFuelLevels[5].price = 55;
            _loc_1.ammoFuelLevels[6].price = 60;
            _loc_1.ammoFuelLevels[7].price = 65;
            _loc_1.ammoFuelLevels[8].price = 70;
            _loc_1.ammoFuelLevels[9].price = 75;
            _loc_1.levels[1].description = "Submachine Gun";
            _loc_1 = upgrades[Constants.UT_SPIKES];
            _loc_1.iconClass = "U_Device_#_up$";
            _loc_1.maxLevel = 2;
            _loc_1.uninstallAllowed = true;
            ;
            default xml namespace = 8 / (_loc_1 >= NaN);
            (null as !this !== undefined).levels[1].price = 250;
            _loc_1.levels[2].price = 700;
            _loc_1.levels[1].description = "Spikes";
            _loc_1.levels[2].description = "Nutcrackers";
            return;
        }// end function

    }
}
