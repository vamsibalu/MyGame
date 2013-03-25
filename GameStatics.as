package
{
	import flash.events.EventDispatcher;
	import flash.events.MouseEvent;
	import flash.net.URLRequest;
	import flash.net.navigateToURL;

	public class GameStatics extends EventDispatcher
	{
		public static var currentLevelScore:Number = 0;
		public static var totalScore:Number = 0;
		
		public static function morefun(e:MouseEvent = null):void{
			navigateToURL(new URLRequest("http://www.racinggames9.com/?utm_source=9games&utm_medium=ingame&utm_campaign=desertrage3d"),"blank");
		}
		
		public static var testing:Boolean = false;
		
		public static var canPlaySND:Boolean = false;
		
		public static var fromSharedObj:Number = 1;
		
		//public static var _canPlaySND:Boolean = true;
	}
}