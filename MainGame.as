package
{
	import bala.BodyContacts;
	import bala.SoundM;
	import bala.Starter;
	import bala.Utils.BalaUtils;
	
	import com.Game;
	import com.Stats;
	
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
		public var footerM:FooterMC;
		private var sndManager:SoundM;
		public function MainGame()
		{
			super(this);
			me = this;
			balautils= new BalaUtils();
			addFrameScript(1,keyFrame2);
		}
		
		
		private var tempXML:XML;
		public override function loadingDone(_xml:XML = null):void{
			//testing...
			trace("loading done in MainGAme.")
			if(_xml){
				Game.currentLevel = Number(_xml.@level);
				GameStatics.testing = true;
			}
			tempXML = _xml;
			//this.addFrameScript(1,keyFrame2());
			gotoAndStop(2);
		}
		
		
		private function keyFrame2():void{
			trace("KeyFrame2codeCrated.")
			footerCreation();
			pagesCreation();
			allPages.push(menu_mc,tryAgain_mc,levelComplete_mc,selectLevel_mc,help_mc,gameOver_mc,gameWin_mc);
			stage.addEventListener(MouseEvent.CLICK,clickOnStage);
			
			menu_mc.addFrameScript(menu_mc.totalFrames-1,addListeners);
			menu_mc.play_btn.addEventListener(MouseEvent.CLICK,showhelpfun);
			menu_mc.gotoAndPlay(1);
			gg = new Game(tempXML);
			gg.addEventListener(Game.NEXT_LEVEL,showLevelComp);
			gg.addEventListener(Game.LEVEL_FAIL,levelFail);
			stage.addEventListener(KeyboardEvent.KEY_DOWN,keyDownf);
			stage.addEventListener(KeyboardEvent.KEY_UP,keyUpf);
			BodyContacts.setGame(gg);
			sndManager = new SoundM();
			trace("keyFrame2 New Game Createdd.... Danger..")
			addFrameScript(1,keyFrameDummy);
		}
		
		private function keyFrameDummy():void{
			stop();
		}
		
		private function levelFail(e:Event):void{
			Game.trying++;
			trace("Level failed.tryagain");
			if(Game.trying<Game.canTryUpto){
				removeAllPagesButNotOne(tryAgain_mc);
				//balautils.addSlow(next_mc,1,3);
				//tryAgain_mc.try_btn.addEventListener(MouseEvent.CLICK,retryLevel,false,0,true);
				SoundM.me.playSound(SoundM.LFail,true);
			}else{
				removeAllPagesButNotOne(gameOver_mc);
				SoundM.me.playSound(SoundM.GAME_OVER,true);
				//gameOver_mc.playAgain_btn.addEventListener(MouseEvent.CLICK,showMenu,false,0,true);
			}
		}
		
		//level fail mc will call this upon continue.
		public function retryLevel(e:MouseEvent):void{
			nextSlectLevelfun(null,true);
		}
		
		public function showMenuf(e:MouseEvent):void{
			Game.trying = 0;
			GameStatics.totalScore = 0;
			Game.levelScore = 0;
			Game.currentLevel = 1;
			gotoAndStop(2);
			trace("menu=",menu_mc)
			removeAllPagesButNotOne(menu_mc);
			SoundM.me.playSound(SoundM.MENU,true);
			
			stage.focus = balaTxt;
			balaTxt.addEventListener(Event.CHANGE, checkYouBala);
		}
		
		private function addListeners():void{
			trace("add listeners..")
			menu_mc.help_btn.addEventListener(MouseEvent.CLICK,showhelpfun);
			menu_mc.levels_btn.addEventListener(MouseEvent.CLICK,showlevelfun);
			menu_mc.more_btn.addEventListener(MouseEvent.CLICK,morefun);
			//menu_mc.host_btn.addEventListener(MouseEvent.CLICK,hostfun);
		}
		
		//help page will call
		public function playGame(e:MouseEvent):void{
			//load my first level
			Game.currentLevel = 1;
			trace("play firstlevel=",Game.currentLevel)
			//balautils.remove(menu_mc);
			removeAllPagesButNotOne(gg);
			gg.loadMyLevelForPreview(gg.allLevels[Game.currentLevel]);
			addChild(footerM);
			//var popup11:PopUpmc2 = new PopUpmc2();
			//popup11.x = 300;
			//popup11.y = 217;
			/*addChild(popupMC);
			popupMC.gotoAndPlay(2);*/
		}
		
		private function showLevelComp(e:Event):void{
			trace("all score",gg.enemyCount*1000);
			GameStatics.totalScore = GameStatics.totalScore+GameStatics.currentLevelScore;
			Game.trying = 0;
			
			if(Game.currentLevel<5){
				removeAllPagesButNotOne(levelComplete_mc);
				//score update in key frame..
				
				//levelComplete_mc.next_btn.addEventListener(MouseEvent.CLICK,nextSlectLevelfun,false,0,true);
				
				if(GameStatics.fromSharedObj<=Game.currentLevel){
					GameStatics.fromSharedObj = Game.currentLevel+1;
					MySharedObject.data.lev = Game.currentLevel+1;
					MySharedObject.flush();
				}
				SoundM.me.playSound(SoundM.LCOMP,true);
				
			}else{
				removeAllPagesButNotOne(gameWin_mc);
				SoundM.me.playSound(SoundM.GAME_WIN,true);
			}
		}
		
		//level completmc or retry button will can this
		public function nextSlectLevelfun(e:MouseEvent = null,refresh:Boolean = false):void{
			trace("next button clicked refresh=",refresh)
			if(refresh == false){
				Game.currentLevel++;
			}
			
			removeAllPagesButNotOne(gg);
			gg.loadMyLevelForPreview(gg.allLevels[Game.currentLevel]);
			addChild(footerM);
			footerM.gotoAndPlay(2);
			//addChild(gg);
		}
		
		private function selectedLevelfun(e:Event):void{
			Game.currentLevel = e.currentTarget.level;
			trace("selected level=",Game.currentLevel)
			removeAllPagesButNotOne(gg);
			gg.loadMyLevelForPreview(gg.allLevels[Game.currentLevel]);
			
			if(Game.currentLevel ==1){
				var popupMC:PopUpmc2 = new PopUpmc2();
				popupMC.x = 301;
				popupMC.y = 190;
				addChild(popupMC);
				popupMC.gotoAndPlay(2);
			}
			//addChild(footer);
			//addChild(gg);
		}
		
		private function showhelpfun(e:MouseEvent):void{
			removeAllPagesButNotOne(selectLevel_mc);
			SoundM.me.playSound(SoundM.MENU,true);
		}
		
		private function showlevelfun(e:MouseEvent):void{
			removeAllPagesButNotOne(selectLevel_mc);
			SoundM.me.playSound(SoundM.MENU,true);
		}
		
		/*private function walkThrough(e:MouseEvent):void{
		navigateToURL(new URLRequest("http://www.slungo.com/walkthrough/zombiediehard2/"),"blank");
		}*/
		
		private function pagesCreation():void{
			menu_mc = new MenuMC();
			/*menu_mc.x = 320;
			menu_mc.y = 231;*/
			tryAgain_mc = new TryagainMC();
			/*tryAgain_mc.x = 320;
			tryAgain_mc.y = 240;*/
			
			levelComplete_mc = new LevelcompleteMC();
			/*levelComplete_mc.x = 320;
			levelComplete_mc.y = 240;*/
			
			selectLevel_mc = new SelectlevelMC();
			/*selectLevel_mc.x = 320;
			selectLevel_mc.y = 240;*/
			selectLevel_mc.addEventListener("selected",selectedLevelfun);
			
			help_mc = new HelpMC();
			/*help_mc.x = 320;
			help_mc.y = 240;*/
			trace("help_mc.play_btn",help_mc.play_btn)
			//help_mc.play_btn.addEventListener(MouseEvent.CLICK,playGame);
			
			gameWin_mc = new GamewinMC();
			/*gameWin_mc.x = 320;
			gameWin_mc.y = 240;*/
			
			//gameWin_mc.gameWincontinue.addEventListener(MouseEvent.CLICK,showMenu);
			gameOver_mc = new GameoverMC();
			/*gameOver_mc.x = 320;
			gameOver_mc.y = 240;*/
		}
		
		
		private function footerCreation():void{
			footerM = new FooterMC();
			//footer.y = //footer.height;
			//footer.more.addEventListener(MouseEvent.CLICK,morefun);
			trace("footerM",footerM,footerM.reset)
			footerM.reset.addEventListener(MouseEvent.CLICK,resetFun);
			footerM.levelTxt;
			footerM.livesTxt;
			footerM.scoreTxt;
			footerM.selectl.addEventListener(MouseEvent.CLICK,showlevelfun);
			//footerM.walk.addEventListener(MouseEvent.CLICK,walkThrough);
			
			/*var sts:Stats = new Stats();
			addChild(sts);*/
		}
		
		private function resetFun(e:MouseEvent=null):void{
			trace("reset fun")
			Game.trying++;
			nextSlectLevelfun(null,true);
		}
		public function removeAllPagesButNotOne(mc:MovieClip):void{
			for(var k:int = 0; k<allPages.length; k++){
				if(k != allPages.indexOf(mc)){
					balautils.remove(allPages[k],0);
				}
			}
			addChild(mc);
			balautils.addSlow(mc,0.2,0);
			trace("removeAllPagesButNotOne addSlow",mc)
		}
		
		private function keyDownf(e:KeyboardEvent):void{
			switch(e.keyCode)
			{
				case Keyboard.R:
					resetFun();
					break;
			}
			
			if(gg && gg.heroBike){
				gg.heroBike.keyDown(e);
			}
		}
		
		private function keyUpf(e:KeyboardEvent):void{
			if(gg && gg.heroBike){
				gg.heroBike.keyUp(e);
			}
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
				GameStatics.testing = true;
				gg.createDummyNext();
				gg.debugDraw = gg.sp;
				
				gg.addChild(gg.sp);
				var sts:Stats = new Stats();
				addChild(sts);
			}
		}
		
	}
}