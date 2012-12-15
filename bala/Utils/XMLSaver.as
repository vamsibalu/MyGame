package bala.Utils
{
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.IEventDispatcher;
	import flash.net.FileReference;
	import flash.utils.ByteArray;
	
	/**
	 * @author : Balakrishna.
	 * @email  : vamsibalu@gmail.com
	 * @version: 5.0
	 */
	
	public class XMLSaver extends EventDispatcher
	{
		public static var me:XMLSaver;
		public function XMLSaver()
		{
			super();
			me = this;
			var mainXML:XML = new XML( <main/> );
			
			/*var LevelData:XML = new XML(<level>{"hello 1"}</level>);
			LevelData.@id = 1;
			mainXML.appendChild(LevelData);
			toXMLSave(mainXML,"ok got it",2);*/  // <level id="3">ok got it</level>
		}
		
		public function toXMLSave(original:XML,levelNodeString:String,levelNo:int,toDisk:Boolean):XML
		{
			var replaced:Boolean = false;
			
			var LevelData:XML = new XML(<level>{levelNodeString}</level>);
			LevelData.@id = levelNo;
			
			for each (var node:XML in original.children().(attribute("id") == levelNo)){
				original.replace(node.childIndex(), LevelData);
				replaced = true;
			}
			
			if(replaced == false){
				original.appendChild(LevelData);
			}
			
			//trace("LevelData modified=",original)
			if(toDisk == true){
				savData(original);
			}
			return original;
		}
		
		private function savData(_xml:XML):void{
			var ba:ByteArray = new ByteArray();
			ba.writeUTFBytes(_xml);
			//ba.
			
			var fr:FileReference = new FileReference();
			fr.addEventListener(Event.SELECT, _onRefSelect);
			fr.addEventListener(Event.CANCEL, _onRefSelect);
			fr.save(ba, "BalaLevelData.xml");
		}
		
		private function _onRefSelect(e:Event):void{
			
		}
		
		//get your data based on level number
		public function getLevelAt(original:XML,levelNo:int):XML{
			var foundxml:XML;
			if(original){
				for each (var node:XML in original.children().(attribute("id") == levelNo)){
					foundxml = node;
				}
			}
			return foundxml;
		}
	}
}