package bala{
	import com.Game;
	
	import flash.display.MovieClip;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	import flash.events.ContextMenuEvent;
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.events.MouseEvent;
	import flash.media.Sound;
	import flash.media.SoundChannel;
	import flash.media.SoundMixer;
	import flash.net.LocalConnection;
	import flash.net.SharedObject;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	import flash.net.navigateToURL;
	import flash.ui.ContextMenu;
	import flash.ui.ContextMenuItem;
	
	/*Game ID: 428200
	GUID: ee8cf9b333734fbc
	API Key: e02a5a246b314e2e9b1c47223ba8ff
	*/
	
	public class Starter extends MovieClip
	{
		public var MySharedObject:SharedObject;
		private var pages:MovieClip;
		private var sounds:Sound
		private var firesounds:Sound
		private var scalmodd:StageScaleMode
		private var myroot:MainGame
		
		public function Starter(_myroot:MainGame)
		{
			myroot = _myroot;
			addEventListener(Event.ENTER_FRAME,preloader);
			//var mymenu:ContextMenu=new ContextMenu();
			//mymenu.hideBuiltInItems();
			//this.contextMenu = mymenu;
			//var iteam_1:ContextMenuItem = new ContextMenuItem("More Games");
			//mymenu.customItems.push(iteam_1);
			//iteam_1.addEventListener(ContextMenuEvent.MENU_ITEM_SELECT,doSomething);
			
			//PlayTomic Code
			var Local:LocalConnection= new LocalConnection();
			if (Local.domain != "localhost")
			{
				//Log.View(428200,"ee8cf9b333734fbc","e02a5a246b314e2e9b1c47223ba8ff",root.loaderInfo.loaderURL);
			}
			
			//SharedObjectCode
			MySharedObject = SharedObject.getLocal("DR3D");
			if(MySharedObject.data.lev == undefined)
			{
				trace("no shared data")
				//MySharedObject.data.lev = Game.currentLevel;
			}
			else
			{
				if (Number(MySharedObject.data.lev) <= 0)
				{
					trace("Starter=shared data",MySharedObject.data.lev)
					Game.currentLevel = 1;
				}else{
					GameStatics.fromSharedObj = MySharedObject.data.lev;
					trace("got from local saved data",Game.currentLevel);
				}
			}
		}
		
		private function preloader(e:Event){
			var loads:Number = this.loaderInfo.bytesLoaded;
			var total:Number = this.loaderInfo.bytesTotal;
			var loaded:Number = Math.floor(loads / total * 100);
			//trace(loaded+"SWF this is loading");
			
			if(loaded==100){
				removeEventListener(Event.ENTER_FRAME,preloader);
				myroot.loading_mc.gotoAndStop(2);
				var str:String = this.loaderInfo.url;
				trace("LoaderInfo==",str);
				if(str.indexOf("file")>=0){
					var lb:URLLoader = new URLLoader();
					lb.addEventListener(Event.COMPLETE,loadedXML);
					lb.addEventListener(IOErrorEvent.IO_ERROR,failLoadXML);
					lb.load(new URLRequest("bala/BalaLevelData.xml"));
					trace("loading local xml...");
					GameStatics.testing = true;
				}else{
					trace("Embeded XML")
					loadingDone();
				}
			}else{
				myroot.loading_mc.loader_txt.text=String((loaded+1)+"%")
				myroot.loading_mc.bar.gotoAndStop(loaded+1);
			}
		}
		
		private function loadedXML(e:Event):void{
			loadingDone(XML(e.target.data));
		}
		
		private function failLoadXML(e:IOErrorEvent):void{
			GameStatics.testing = false;
			loadingDone();
		}
		
		public function loadingDone(_xml:XML = null):void{
			
		}
		
		
		/*private function doSomething(e:ContextMenuEvent):void {
			morefun();
		}*/
		
		/*public function HostGame(e:MouseEvent)
		{
			trace("hosted")
			var urld:URLRequest = new URLRequest("http://www.as3bala.in/");
			navigateToURL(urld,"_blank");
		}*/
		
		public function morefun(e:MouseEvent = null):void{
			navigateToURL(new URLRequest("http://www.racinggames9.com/?utm_source=9games&utm_medium=ingame&utm_campaign=desertrage3d"),"blank");
		}
		
		public static function morefun(e:MouseEvent = null):void{
			navigateToURL(new URLRequest("http://www.racinggames9.com/?utm_source=9games&utm_medium=ingame&utm_campaign=desertrage3d"),"blank");
		}
		
	}
	
}