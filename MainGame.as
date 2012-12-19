package
{
	import bala.BodyContacts;
	import bala.SoundM;
	import bala.Starter;
	import bala.Utils.BalaUtils;
	
	import com.Game;
	
	import flash.display.DisplayObject;
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.KeyboardEvent;
	import flash.events.MouseEvent;
	import flash.media.SoundMixer;
	import flash.net.URLRequest;
	import flash.net.navigateToURL;
	import flash.ui.Keyboard;
	
	public class MainGame extends Starter
	{
		private var gg:Game;
		private var balautils:BalaUtils
		public static var me:MainGame;
		
		
		
		//pages...
		public var menu_mc:MovieClip;
		public var tryAgain_mc:MovieClip;
		public var levelComplete_mc:MovieClip;
		public var selectLevel_mc:MovieClip;
		public var help_mc:MovieClip;
		public var gameWin_mc:MovieClip;
		public var gameOver_mc:MovieClip;
		public var allPages:Vector.<MovieClip> = new Vector.<MovieClip>();
		public var footer:MovieClip;
		private static var _canPlaySND:Boolean = true;
		private var sndManager:SoundM;
		public function MainGame()
		{
			super(this);
			me = this;
			balautils= new BalaUtils();
			//addFrameScript(1,keyFrame2);
		}
		
		public static var testing:Boolean = false;
		private var tempXML:XML;
		public override function loadingDone(_xml:XML = null):void{
			//testing...
			if(_xml){
				Game.currentLevel = Number(_xml.@level);
				testing = true;
			}
			tempXML = _xml;
			addFrameScript(1,keyFrame2);
			gotoAndStop(2);
		}
		
		
		private function keyFrame2():void{
			footerCreation();
			pagesCreation();
			allPages.push(menu_mc,tryAgain_mc,levelComplete_mc,selectLevel_mc,help_mc,gameOver_mc,gameWin_mc);
			stage.addEventListener(MouseEvent.CLICK,clickOnStage);
			
			
			///___________
			
			
			loading_mc.start_btn.addEventListener(MouseEvent.CLICK,showMenu);
			menu_mc.addFrameScript(menu_mc.totalFrames-1,addListeners);
			menu_mc.gotoAndPlay(1);
			gg = new Game(tempXML);
			gg.addEventListener(Game.NEXT_LEVEL,showLevelComp);
			gg.addEventListener(Game.LEVEL_FAIL,levelFail);
			stage.addEventListener(KeyboardEvent.KEY_DOWN,keyDownf);
			BodyContacts.setGame(gg);
			sndManager = new SoundM();
		}
		
		private function levelFail(e:Event):void{
			trace("Level failed.tryagain");
			Game.trying++;
			if(Game.trying<Game.canTryUpto){
				removeAllPagesButNotOne(tryAgain_mc);
				//balautils.addSlow(next_mc,1,3);
				tryAgain_mc.try_btn.addEventListener(MouseEvent.CLICK,retryLevel,false,0,true);
				SoundM.me.playSound(SoundM.LFail,true);
			}else{
				removeAllPagesButNotOne(gameOver_mc);
				SoundM.me.playSound(SoundM.GAME_OVER,true);
				gameOver_mc.playAgain_btn.addEventListener(MouseEvent.CLICK,showMenu,false,0,true);
			}
		}
		
		private function retryLevel(e:MouseEvent):void{
			trace("clicked retry..")
			trace("selected level=",Game.currentLevel )
			removeAllPagesButNotOne(gg);
			gg.loadMyLevelForPreview(gg.allLevels[Game.currentLevel]);
			gg.addChild(footer);
			addChild(gg);
		}
		
		private function showMenu(e:MouseEvent):void{
			Game.trying = 0;
			Game.totalScore = 0;
			Game.levelScore = 0;
			gotoAndStop("loaded");
			menu_mc.gotoAndPlay(2);
			addChild(menu_mc);
			//removeAllPagesButNotOne(menu_mc);
			SoundM.me.playSound(SoundM.MENU,true);
			
			stage.focus = balaTxt;
			balaTxt.addEventListener(Event.CHANGE, checkYouBala);
		}
		
		private function addListeners():void{
			trace("add listeners..")
			menu_mc.play_btn.addEventListener(MouseEvent.CLICK,showhelpfun);
			menu_mc.help_btn.addEventListener(MouseEvent.CLICK,showhelpfun);
			menu_mc.levels_btn.addEventListener(MouseEvent.CLICK,showlevelfun);
			//menu_mc.more_btn.addEventListener(MouseEvent.CLICK,morefun);
			menu_mc.host_btn.addEventListener(MouseEvent.CLICK,hostfun);
		}
		
		
		private function playGame(e:MouseEvent):void{
			//load my first level
			Game.currentLevel = 1;
			trace("play firstlevel=",Game.currentLevel)
			//balautils.remove(menu_mc);
			removeAllPagesButNotOne(gg);
			gg.loadMyLevelForPreview(gg.allLevels[Game.currentLevel]);
			gg.addChild(footer);
			var popup11:PopUpmc2 = new PopUpmc2();
			popup11.x = 129.95;
			popup11.y = 199.25;
			addChild(popup11);
			popup11.gotoAndPlay(2);
		}
		
		private function showLevelComp(e:Event):void{
			trace("all score",gg.enemyCount*1000);
			Game.totalScore = Game.totalScore+Game.levelScore;
			Game.trying = 0;
			
			if(Game.currentLevel<30){
				removeAllPagesButNotOne(levelComplete_mc);
				//score update in key frame..
				
				levelComplete_mc.next_btn.addEventListener(MouseEvent.CLICK,nextSlectLevelfun,false,0,true);
				
				if(Starter.fromSharedObj<=Game.currentLevel){
					Starter.fromSharedObj = Game.currentLevel+1;
					MySharedObject.data.lev = Game.currentLevel+1;
					MySharedObject.flush();
				}
				SoundM.me.playSound(SoundM.LCOMP,true);
				
			}else{
				removeAllPagesButNotOne(gameWin_mc);
				SoundM.me.playSound(SoundM.GAME_WIN,true);
			}
		}
		
		//for testing..
		public function nextSlectLevelfun(e:MouseEvent = null,refresh:Boolean = false):void{
			if(refresh == false){
				Game.currentLevel++;
			}else{
				Game.trying++;
			}
			
			if(Game.trying<Game.canTryUpto){
				removeAllPagesButNotOne(gg);
				gg.loadMyLevelForPreview(gg.allLevels[Game.currentLevel]);
				gg.addChild(footer);
				addChild(gg);
			}else{
				removeAllPagesButNotOne(gameOver_mc);
				SoundM.me.playSound(SoundM.GAME_OVER,true);
				gameOver_mc.playAgain_btn.addEventListener(MouseEvent.CLICK,showMenu,false,0,true);
			}
			
		}
		
		private function selectedLevelfun(e:Event):void{
			Game.currentLevel = e.currentTarget.level;
			trace("selected level=",Game.currentLevel)
			removeAllPagesButNotOne(gg);
			gg.loadMyLevelForPreview(gg.allLevels[Game.currentLevel]);
			gg.addChild(footer);
			addChild(gg);
		}
		
		private function showhelpfun(e:MouseEvent):void{
			removeAllPagesButNotOne(help_mc);
			SoundM.me.playSound(SoundM.HELP,true);
		}
		
		private function showlevelfun(e:MouseEvent):void{
			removeAllPagesButNotOne(selectLevel_mc);
			SoundM.me.playSound(SoundM.MENU,true);
		}
		
		private function hostfun(e:MouseEvent):void{
			navigateToURL(new URLRequest("http://www.slungo.com/zombiediehard2.zip"),"blank");
		}
		
		private function walkThrough(e:MouseEvent):void{
			navigateToURL(new URLRequest("http://www.slungo.com/walkthrough/zombiediehard2/"),"blank");
		}
		
		private function pagesCreation():void{
			menu_mc = new MenuMC();
			
			tryAgain_mc = new TryagainMC();
			
			levelComplete_mc = new LevelcompleteMC();
			
			selectLevel_mc = new SelectlevelMC();
			
			selectLevel_mc.addEventListener("selected",selectedLevelfun);
			
			help_mc = new HelpMC();
			help_mc.play_btn.addEventListener(MouseEvent.CLICK,playGame);
			
			gameWin_mc = new GamewinMC();
			gameOver_mc = new GameoverMC();
		}
		
		
		private function footerCreation():void{
			footer = new FooterMC();
			footer.y = 480-footer.height;
			footer.more.addEventListener(MouseEvent.CLICK,morefun);
			footer.reset.addEventListener(MouseEvent.CLICK,resetFun);
			footer.levelTxt;
			footer.livesTxt;
			footer.scoreTxt;
			footer.selectl.addEventListener(MouseEvent.CLICK,showlevelfun);
			footer.walk.addEventListener(MouseEvent.CLICK,walkThrough);
			footer.sound.addEventListener(MouseEvent.CLICK,soundFun);
		}
		
		private function resetFun(e:MouseEvent=null):void{
			nextSlectLevelfun(null,true);
		}
		public function removeAllPagesButNotOne(mc:MovieClip):void{
			for(var k:int = 0; k<allPages.length; k++){
				if(k != allPages.indexOf(mc)){
					balautils.remove(allPages[k],2);
				}
			}
			addChild(mc);
			balautils.addSlow(mc,0.8,0.1);
			trace("removeAllPagesButNotOne addSlow",mc)
		}
		
		private function keyDownf(e:KeyboardEvent):void{
			switch(e.keyCode)
			{
				case Keyboard.R:
				{
					resetFun();
					break;
				}
			}
		}
		
		private function soundFun(e:MouseEvent):void{
			if(footer.sound.currentFrame == 1){
				footer.sound.gotoAndStop(2);
			}else{
				footer.sound.gotoAndStop(1);
			}
		}
		
		public static function set canPlaySND(vals:Boolean):void{
			_canPlaySND = vals;
			
		}
		
		public static function get canPlaySND():Boolean{
			return _canPlaySND;
		}
		
		private function clickOnStage(e:MouseEvent):void{
			if(e.target is MGBtn){
				morefun();
			}
		}
		
		private function checkYouBala(e:Event):void{
			trace("r u bala?=",balaTxt.text);
			
			if(balaTxt.text == gg.levelDataXML.@balapass){
				trace("hey.. you are bala..");
				MainGame.testing = true;
				gg.createDummyNext();
			}
		}
		
	}
}