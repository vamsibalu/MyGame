/**
 * @author Clemente Gomez.
 * @email zomegpro@gmail.com.
 * @link http://blog.kreativeking.com.
 * @build 1.7 (04-13-09)
 * @description Paramerter Event allows the passing of extra parameters
 * 
 * @public methods: 
 * 					ParamEvent(type:String, param:* = null, bubbles:Boolean = false, cancelable:Boolean = false) - Constructor.
 */

package bala.Utils
{
	import flash.events.Event;

	public class ParamEvent extends Event
	{
		/**
		 * The ParamEvent.PARAM constant defines the value of the type property of an param ParamEvent object.
		 */
		public static const PARAM : String = "param";
		/**
		 * The ParamEvent.PERCENT constant defines the value of the type property of an percent ParamEvent object.
		 */
		public static const PERCENT : String = "percent";
		/**
		 * The ParamEvent.COMPLETE constant defines the value of the type property of an complete ParamEvent object.
		 */
		public static const COMPLETE : String = "finished";
		/**
		 * The ParamEvent.READY constant defines the value of the type property of an ready ParamEvent object.
		 */
		public static const READY : String = "ready";
		/**
		 * The ParamEvent.XML_LOADED constant defines the value of the type property of an xml loaded ParamEvent object.
		 */
		public static const XML_LOADED : String = "xml loaded";
		/**
		 * The ParamEvent.INITIALIZED constant defines the value of the type property of an initialized ParamEvent object.
		 */
		public static const INITIALIZED : String = "initialized";
		/**
		 * The ParamEvent.ERROR constant defines the value of the type property of an error ParamEvent object.
		 */
		public static const ERROR : String = "error";
		private var _param : *;

		public function ParamEvent(type : String, param : * = null, bubbles : Boolean = false, cancelable : Boolean = false)
		{
			super(type, bubbles, cancelable);
			_param = param;
		}

		public override function clone() : Event
		{
			return new ParamEvent(type, _param, bubbles, cancelable);
		}

		public function get parameter() : *
		{
			return _param;
		}
	}
}