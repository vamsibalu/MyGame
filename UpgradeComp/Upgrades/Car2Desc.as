package EarnToDie_2.Upgrades
{
    import EarnToDie_2.*;

    public class Car2Desc extends CarDesc
    {

        public function Car2Desc()
        {
            ;
            var _loc_1:* = upgrades[Constants.UT_ENGINE];
            _loc_1.iconClass = "U_Engine_$";
            _loc_1.maxLevel = 3;
            _loc_1.levels[1].price = 0;
            _loc_1.levels[2].price = 750;
            _loc_1.levels[3].price = 2750;
            _loc_1.levels[1].description = "4.0L V6 Engine";
            _loc_1.levels[2].description = "4.5L V8 Engine";
            _loc_1.levels[3].description = "5.5L V8 Turbo Engine";
            _loc_1 = upgrades[Constants.UT_TRANSMISSION];
            _loc_1.iconClass = "U_Transmission_$";
            _loc_1.maxLevel = 3;
            _loc_1.levels[1].price = 0;
            _loc_1.levels[2].price = 900;
            _loc_1.levels[3].price = 3000;
            _loc_1.levels[1].description = "4-Speed Gearbox";
            _loc_1.levels[2].description = "5-Speed Gearbox";
            _loc_1.levels[3].description = "6-Speed Gearbox";
            _loc_1 = upgrades[Constants.UT_WHEELS];
            _loc_1.iconClass = "U_Wheel_#_up$";
            _loc_1.maxLevel = 3;
            _loc_1.levels[1].price = 0;
            _loc_1.levels[2].price = 700;
            _loc_1.levels[3].price = 1800;
            _loc_1.levels[1].description = "R18 HT Wheels";
            _loc_1.levels[2].description = "R20 AT Wheels";
            _loc_1.levels[3].description = "R22 MT Wheels";
            _loc_1 = upgrades[Constants.UT_FUEL];
            _loc_1.iconClass = "U_Fuel";
            _loc_1.maxLevel = 1;
            _loc_1.maxAmmoFuel = 9;
            _loc_1.ammoFuelLevels[1].price = 100;
            _loc_1.ammoFuelLevels[2].price = 110;
            _loc_1.ammoFuelLevels[3].price = 130;
            _loc_1.ammoFuelLevels[4].price = 150;
            _loc_1.ammoFuelLevels[5].price = 180;
            _loc_1.ammoFuelLevels[6].price = 220;
            _loc_1.ammoFuelLevels[7].price = 260;
            ;
            _loc_3 = 8;
            _loc_3 = _loc_1.ammoFuelLevels;
            null[null instanceof null <= null].price = 300;
            _loc_1.ammoFuelLevels[9].price = 350;
            _loc_1.levels[1].description = "Fuel Tank";
            _loc_1 = upgrades[Constants.UT_BOOST];
            _loc_1.iconClass = "U_Accelerator_#";
            _loc_1.maxLevel = 1;
            _loc_1.uninstallAllowed = true;
            _loc_1.maxAmmoFuel = 9;
            _loc_1.levels[1].price = 1500;
            _loc_1.ammoFuelLevels[1].price = 250;
            _loc_1.ammoFuelLevels[2].price = 270;
            _loc_1.ammoFuelLevels[3].price = 290;
            _loc_1.ammoFuelLevels[4].price = 320;
            _loc_1.ammoFuelLevels[5].price = 350;
            _loc_1.ammoFuelLevels[6].price = 380;
            _loc_1.ammoFuelLevels[7].price = 410;
            _loc_1.ammoFuelLevels[8].price = 450;
            _loc_1.ammoFuelLevels[9].price = 500;
            _loc_1.levels[1].description = "Twin Propeller";
            _loc_1 = upgrades[Constants.UT_GUN];
            _loc_1.iconClass = "U_Gun_#";
            _loc_1.maxLevel = 1;
            _loc_1.uninstallAllowed = true;
            _loc_1.maxAmmoFuel = 9;
            _loc_1.levels[1].price = 2000;
            _loc_1.ammoFuelLevels[1].price = 120;
            _loc_1.ammoFuelLevels[2].price = 130;
            _loc_1.ammoFuelLevels[3].price = 140;
            _loc_1.ammoFuelLevels[4].price = 150;
            _loc_1.ammoFuelLevels[5].price = 170;
            _loc_1.ammoFuelLevels[6].price = 210;
            _loc_1.ammoFuelLevels[7].price = 250;
            _loc_1.ammoFuelLevels[8].price = 300;
            _loc_1.ammoFuelLevels[9].price = 350;
            _loc_1.levels[1].description = "Light Machine Gun";
            _loc_1 = upgrades[Constants.UT_SPIKES];
            _loc_1.iconClass = "U_Device_#_up$";
            _loc_1.maxLevel = 1;
            _loc_1.uninstallAllowed = true;
            ;
            default xml namespace = _loc_1;
            (_loc_2 >> undefined).levels[1].price = 1000;
            _loc_1.levels[2].price = 2500;
            _loc_1.levels[1].description = "Blades";
            _loc_1.levels[2].description = "Cogwheels";
            return;
        }// end function

    }
}
