package bala
{
	import flash.events.EventDispatcher;
	import flash.events.IEventDispatcher;
	import flash.media.Sound;
	import flash.media.SoundMixer;
	
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
			snd_menu = new menu();
			snd_btn = new btn();
			snd_bg1 = new bg1();
			snd_lComplete = new lComplete();
			snd_lFail = new lFail();
			snd_gameWin = new gameWin();
			snd_gameOver = new gameOver();
			snd_shoot = new shoot();
			snd_steel = new steel();
			snd_glass = new glass();
			snd_hdie = new hdie();
			snd_edie = new edie();
			trace("created sounds...")
		}
		
		
		
		public function playSound(snd_name:String,stopAll:Boolean = false):void{
			if(MainGame.canPlaySND == true){
				if(stopAll == true){
					SoundMixer.stopAll();
				}
				
				switch(snd_name)
				{
					case MENU:
						snd_menu.play(0,999);
						break;
					case BTN:
						snd_btn.play();
						break;
					case BG1:
						snd_bg1.play(0,999);
						break;
					case LCOMP:
						snd_lComplete.play(0,999);
						break;
					case LFail:
						snd_lFail.play(0,999);
						break;
					case GAME_WIN:
						snd_gameWin.play(0,999);
						break;
					case HELP:
						snd_menu.play(0,999);   //menu sound
						break;
					case GAME_OVER:
						snd_gameOver.play(0,999);
						break;
					case SHOOT:
						snd_shoot.play();
						break;
					case STEEL:
						snd_steel.play();
						break;
					case GLASS:
						snd_glass.play();
						break;
					case HDIE:
						snd_hdie.play();
						break;
					case EDIE:
						snd_edie.play();
						break;
				}
			}else{
				trace("Silence pls..");
			}
		}
	}
}

