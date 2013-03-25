package bala
{
	import flash.events.EventDispatcher;
	import flash.events.IEventDispatcher;
	import flash.media.Sound;
	import flash.media.SoundMixer;
	import flash.media.SoundTransform;
	
	public class SoundM extends EventDispatcher
	{
		public static var me:SoundM;
		public function SoundM()
		{
			super();
			createSounds();
			me = this;
		}
		
		private var snd_menu:Sound;
		private var snd_btn:Sound;
		private var snd_bg1:Sound;
		private var snd_lComplete:Sound;
		private var snd_lFail:Sound;
		private var snd_gameWin:Sound;
		private var snd_gameOver:Sound;
		private var snd_shoot:Sound;
		private var snd_steel:Sound;
		private var snd_glass:Sound;
		private var snd_hdie:Sound;
		private var snd_edie:Sound;
		private var snd_bike:Sound;
		
		public static const MENU:String = "menus";
		public static const BTN:String = "btns";
		public static const BG1:String = "bg1";
		public static const LCOMP:String = "lcomplete";
		public static const LFail:String = "lfails";
		public static const GAME_WIN:String = "gamewin";
		public static const HELP:String = "helps";
		public static const GAME_OVER:String = "gameover";
		public static const SHOOT:String = "shoot";
		public static const STEEL:String = "steel";
		public static const GLASS:String = "glasss";
		public static const HDIE:String = "hdie";
		public static const EDIE:String = "edie";
		
		//sounm
		private function createSounds(){
			
			/*snd_btn = new btn(); 
			snd_bike = new bikeSnd();
			snd_bg1 = new bg1();
			snd_lComplete = new lvlup()
			snd_hdie = new dieSnd()
			snd_glass = new giftSnd()*/
			/*snd_lComplete =snd_menu = new bikesound(); new lComplete();
			snd_lFail = new lFail();
			snd_gameWin = new gameWin();
			snd_gameOver = new gameOver();
			snd_shoot = new shoot();
			snd_steel = new steel();
			snd_glass = new glass();
			snd_hdie = new hdie();
			snd_edie = new edie();*/
			trace("created sounds...")
		}
		
		
		private var sndTrns:SoundTransform = new SoundTransform();
		public function playSound(snd_name:String,stopAll:Boolean = false):void{
			//GameStatics.canPlaySND = false;
			
			if(stopAll == true){
				SoundMixer.stopAll();
			}
			
			/*switch(snd_name)
			{
				case MENU:
					trace("snd_bg1=",snd_bg1)
					snd_bg1.play(0,999);
					break;
				case BTN:
					snd_btn.play();
					break;
				case BG1:
					sndTrns.volume = .5;
					snd_bg1.play(0,999).soundTransform = sndTrns;
					snd_bike.play(0,999);
					break;
				case LCOMP:
					snd_lComplete.play(0,999);
					snd_bg1.play(0,999);
					break;
				case LFail:
					snd_bg1.play(0,999);
					break;
				case GAME_WIN:
					snd_bg1.play(0,999);
					break;
				case HELP:
					snd_bg1.play(0,999);   //menu sound 
					break;
				case GAME_OVER:
					snd_bg1.play(0,999);
					break;
				case SHOOT:
				snd_shoot.play();
				break;
				case STEEL:
				snd_steel.play();
				break;
				case GLASS:
					snd_glass.play(0,1);
					break;
				case HDIE:
					snd_hdie.play();
					break;
				case EDIE:
				snd_edie.play();
				break;
			}*/
			if(GameStatics.canPlaySND == false){
				SoundMixer.soundTransform=new SoundTransform(0)
				trace("Silence pls..");
			}
		}
	}
}

