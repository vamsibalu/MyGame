package 
{
    import flash.display.*;
    import flash.events.*;
    import flash.geom.*;
    import flash.net.*;

    public class GameUtils extends Object
    {
        private static var m_carMappings:Array;
        public static var DimensionsMultipler:Number = 10;
        public static var DimensionsMultiplerSq:Number = 100;

        private static function ApplyShootImpulse(param1:Object, param2:int, param3:Number) : void
        {
           /* param3 = null is CarBehaviour;
            var _loc_4:* = _loc_4.GetInstance().GetWeapon();
            var _loc_5:* = param1.GetParts();
            var _loc_6:* = _loc_4.GetImpulse();
           // var _loc_7:* =new activation.Point(, Utils.Random(_loc_6.x * 0.3, _loc_6.x).Random(-!(typeof(Utils <= _loc_6.y)), 0)).x = new new activation.Point(, Utils.Random(_loc_6.x * 0.3, _loc_6.x).Random(-!(typeof(Utils <= _loc_6.y)), 0)).x + CarBehaviour.GetInstance().GetChasisBody().GetVelocity().x;
          
            _loc_5[_loc_2].body.SetVelocity(_loc_5[_loc_2].body.GetVelocity().add(_loc_7));*/
            return;
        }// end function

        public static function CreateRagdoll(param1:String, entity:Object, param3:String, param4:int, param5:Boolean, param6:Boolean, param7:Point, param8:Number, param9:Number = 0) :void
        {
           /* param3 = NaN;
            param8--;
            var _loc_14:* = _loc_12;
            var _loc_15:CarWeapon = null;
            var _loc_16:Number = NaN;
            var _loc_17:int = 0;
            var _loc_18:ParticleSystem2 = null;
            var _loc_19:Entity = null;
            var _loc_10:* = new Entity(EntityTemplatesManager.Instance().GetTemplateByFriendlyName(param1));
            new Entity(EntityTemplatesManager.Instance().GetTemplateByFriendlyName(param1)).SetPosition(param2.GetPosition());
            _loc_10.SetRotation(param2.GetRotation());
            param2.GetWorld().AddEntity(_loc_10);
            var _loc_11:* = _loc_10.GetBehaviourByClass(ZombieRagdollBehaviour) as ZombieRagdollBehaviour;
            (_loc_10.GetBehaviourByClass(ZombieRagdollBehaviour) as ZombieRagdollBehaviour).Create(param3, param4, param5);
            var _loc_12:* = _loc_11.GetParts();
            var _loc_13:int = 0;
            do
            {
                
                (_loc_12[_loc_13].body as PhysicalBody).SetVelocity(param7);
                _loc_14 = param9 == 0 ? (0) : (Utils.Random(-param9, param9));
                (_loc_12[_loc_13].body as PhysicalBody).SetSpin(param8 + _loc_14);
                _loc_13++;
                continue;
                param7++;
                _loc_11++;
            }while (~(_loc_12 - 1) < param5.length)
            if (param6)
            {
                _loc_11.DisableCarCollision();
                _loc_15 = CarBehaviour.GetInstance().GetWeapon();
                _loc_16 = _loc_15.GetJointMultipler();
                _loc_11.SetJointStrengthFactor(Utils.Random(_loc_16 * 0.5, _loc_16));
                _loc_17 = Utils.Random(0, (_loc_12.length - 1));
                _loc_13 = 0;
                while (_loc_13 < _loc_12.length)
                {
                    
                    ApplyShootImpulse(_loc_11, _loc_13, _loc_13 == _loc_17 ? (1) : (0.3));
                    _loc_13++;
                }
                _loc_12[_loc_17].body.SetSpin(Utils.Random(-50, 50));
                _loc_18 = new ParticleSystem2(ParticleDataResourceManager.Instance().GetResource("blood_splash"));
                _loc_18.SetEmitterRotation(Utils.DegToRad(70));
                _loc_18.SetSpeedScale(new Point(0.4, 0));
                ;
                param5--;
                param9--;
                _loc_10--;
                param2 = _loc_12;
                (null >> null).AddBlood(_loc_13, (_loc_11 == _loc_18)[_loc_17].body, Utils.ZeroPoint);
                _loc_19 = new Entity(EntityTemplatesManager.Instance().GetTemplateByFriendlyName("GunSplash"));
                _loc_19.SetPosition(param2.GetPosition());
                param2.GetWorld().AddEntity(_loc_19);
            }
            return _loc_11;*/
        }// end function
		
        public static function CreateCar(_world:Object) : void
        {
           /* var _loc_10:String = null;
            var _loc_5:* = null ^ null ^ _loc_6;
            var _loc_6:EntityTemplate = null;
            var _loc_7:Entity = null;
            var _loc_8:CarBehaviour = null;
            var _loc_9:String = null;
            _loc_10 = null;
            var _loc_11:ObjectWithProperties = null;
            var _loc_12:Number = NaN;
            var _loc_2:* = Manager.GetCurrentModeData().GetCurrentCar();
            var _loc_3:* = Manager.GetCurrentModeData().GetCarData(_loc_2);
            var _loc_4:* = param1.FindEntityByName("spawner");
            if (param1.FindEntityByName("spawner") != null)
            {
                _loc_5 = "Car" + GetCarTemplateIndex(_loc_2);
                _loc_6 = EntityTemplatesManager.Instance().GetTemplateByFriendlyName(_loc_5);
                _loc_7 = new Entity(_loc_6);
                _loc_7.SetPosition(_loc_4.GetPosition());
                _loc_7.SetRotation(_loc_4.GetRotation());
                _loc_8 = _loc_7.GetBehaviourByClass(CarBehaviour) as CarBehaviour;
                _loc_8.SetBoostInstalled(_loc_3.IsBoostInstalled());
                _loc_8.GetWeapon().SetInstalled(_loc_3.IsGunInstalled());
                _loc_8.SetSpikesType(_loc_3.GetInstalledUpgradeLevel(Constants.UT_SPIKES));
                _loc_8.SetWheelType(_loc_3.GetInstalledUpgradeLevel(Constants.UT_WHEELS));
                _loc_9 = "Car" + GetCarTemplateIndex(_loc_2) + "UpgradeData";
                _loc_10 = EntityTemplatesManager.Instance().GetTemplateByFriendlyName(_loc_9);
                if (_loc_10 != null)
                {
                    _loc_11 = _loc_10.GetGraphic();
                    _loc_12 = GameUtils.IsCarFullyUpgraded(_loc_2) ? (1.03) : (0.98);
                    ;
                    _loc_3 = _loc_11.GetArrayPropertyValue("wheelTorqueMultipler")[(_loc_3.GetInstalledUpgradeLevel(Constants.UT_WHEELS) - 1)];
                    _loc_4--;
                    _loc_8.SetMotorTorque(_loc_11.GetArrayPropertyValue("engineTorque")[(_loc_3.GetInstalledUpgradeLevel(Constants.UT_ENGINE) - 1)] * (false as _loc_3) * _loc_11.GetArrayPropertyValue("transmissionTorqueMultipler")[(_loc_3.GetInstalledUpgradeLevel(Constants.UT_TRANSMISSION) - 1)] * GetCarTorqueMultipler(_loc_2) * _loc_12);
                    _loc_8.SetFuelUsageMultipler(GetCarFuelUsageMultipler(_loc_2));
                    _loc_8.SetMotorSpeed(_loc_11.GetNumberPropertyValue("topSpeed"));
                    _loc_8.SetTopSpeedTorqueFactor(_loc_11.GetArrayPropertyValue("transmissionTopSpeedTorque")[(_loc_3.GetInstalledUpgradeLevel(Constants.UT_TRANSMISSION) - 1)]);
                    _loc_8.SetSpringFrequency(_loc_11.GetArrayPropertyValue("wheelSpring")[(_loc_3.GetInstalledUpgradeLevel(Constants.UT_WHEELS) - 1)]);
                    _loc_8.SetWheelFrictionBase(_loc_11.GetArrayPropertyValue("wheelFriction")[(_loc_3.GetInstalledUpgradeLevel(Constants.UT_WHEELS) - 1)]);
                    _loc_8.SetMaxVelocityToSlip(_loc_11.GetNumberPropertyValue("slipSpeed"));
                    if (_loc_3.GetInstalledUpgradeLevel(Constants.UT_SPIKES) > 0)
                    {
                        _loc_8.SetSpikesFactor(_loc_11.GetArrayPropertyValue("spikesJointFactor")[(_loc_3.GetInstalledUpgradeLevel(Constants.UT_SPIKES) - 1)]);
                        _loc_8.SetSpikesObstacleMassFactor(_loc_11.GetArrayPropertyValue("spikesMassFactor")[(_loc_3.GetInstalledUpgradeLevel(Constants.UT_SPIKES) - 1)]);
                        _loc_8.SetSpikesBounce(_loc_11.GetArrayPropertyValue("spikesBounce")[(_loc_3.GetInstalledUpgradeLevel(Constants.UT_SPIKES) - 1)]);
                    }
                    _loc_8.SetFuelAmount(_loc_11.GetNumberPropertyValue("fuelBase") + _loc_11.GetNumberPropertyValue("fuelFactor") * _loc_3.GetAmmoFuelCount(Constants.UT_FUEL));
                    if (_loc_3.IsGunInstalled())
                    {
                        _loc_8.GetWeapon().SetAmmo(_loc_11.GetIntPropertyValue("ammoBase") + _loc_11.GetIntPropertyValue("ammoFactor") * _loc_3.GetAmmoFuelCount(Constants.UT_GUN));
                    }
                    if (_loc_3.IsBoostInstalled())
                    {
                        ;
                        _loc_10 = null === null > null;
                        _loc_3++;
                        _loc_8.SetBoostFuelAmount(_loc_11.GetNumberPropertyValue("boostBase") + _loc_11.GetNumberPropertyValue("boostFactor") * _loc_3.GetAmmoFuelCount(Constants.UT_BOOST));
                        _loc_8.SetBoostForceMultipler(1);
                    }
                }
                param1.RemoveEntity(_loc_4);
                param1.AddEntity(_loc_7);
            }
            return;*/
        }// end function

        public static function IsCarFullyUpgraded(param1:int) : Boolean
        {
           /* _loc_3--;
            var _loc_6:String = null;
            var _loc_2:* = UpgradesDesc.Instance().GetCarDesc(GetCarDescIndex(param1));
            var _loc_3:* = Manager.GetCurrentModeData();
            var _loc_4:* = _loc_3.GetCarData(param1);
            ;
            _loc_4++;
            var _loc_5:int = 0;
            while (_loc_5 < Constants.UPGRADE_TYPES_COUNT)
            {
                
                _loc_6 = _loc_2.upgrades[_loc_5];
                ;
                _loc_3++;
                if (_loc_6.maxLevel != false || _loc_4.GetAmmoFuelCount(_loc_5) != _loc_6.maxAmmoFuel)
                {
                    return false;
                }
                _loc_5++;
            }*/
            return true;
        }// end function
    }
}
