/**
 * @author Clemente Gomez.
 * @email zomegpro@gmail.com.
 * @link http://blog.kreativeking.com.
 * @build 3.4 (04-13-09)
 * @description Assists Loaders, URLLoaders and URLStreams in passing extra parameters to functions
 * 
 * @public properies:
 * 					progress:ProgressEvent
 * 					event:Event
 * 					getLoader:*
 * 
 * @public methods: 
 * 					LoaderHelper($loader:URLLoader, $parameter:*)) - Constructor.
 */

package bala.Utils
{
	import bala.Utils;

	import flash.display.Loader;
	import flash.events.ErrorEvent;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.IOErrorEvent;
	import flash.events.ProgressEvent;
	import flash.events.SecurityErrorEvent;
	import flash.net.URLLoader;
	import flash.net.URLStream;

	public class LoaderHelper extends EventDispatcher
	{
		private static const LOADER : String = "loader";
		private static const URLLOADER : String = "urlLoader";
		private static const URLSTREAM : String = "urlStream";
		private var parameter : *;
		private var urlStream : URLStream;
		private var urlLoader : URLLoader;
		private var loader : Loader;
		private var progressEvent : ProgressEvent;
		private var completeEvent : Event;
		private var currentLoader : String;

		public function LoaderHelper($loader : *, $parameter : * = null)
		{
			if($loader is URLLoader)
			{
				currentLoader = URLLOADER;
				initURL($loader, $parameter);
			}
			else if($loader is Loader)
			{
				currentLoader = LOADER;
				initLoader($loader, $parameter);
			}
			else if($loader is URLStream)
			{
				currentLoader = URLSTREAM;
				initStream($loader, $parameter);
			}
			else
			{
				throw new Error("Must pass a Loader or URLLoader or URLStream");
			}
		}

		private function initURL($loader : URLLoader, $parameter : *) : void
		{
			parameter = $parameter;
			urlLoader = $loader;
			urlLoader.addEventListener(Event.COMPLETE, dispatchHelp);
			urlLoader.addEventListener(ProgressEvent.PROGRESS, dispatchProgress);
			urlLoader.addEventListener(IOErrorEvent.IO_ERROR, onError);
			urlLoader.addEventListener(SecurityErrorEvent.SECURITY_ERROR, onError);
		}

		private function initLoader($loader : Loader, $parameter : *) : void
		{
			parameter = $parameter;
			loader = $loader;
			loader.contentLoaderInfo.addEventListener(Event.COMPLETE, dispatchHelp);
			loader.contentLoaderInfo.addEventListener(ProgressEvent.PROGRESS, dispatchProgress);
		}

		private function initStream($loader : URLStream, $parameter : *) : void
		{
			parameter = $parameter;
			urlStream = $loader;
			urlStream.addEventListener(Event.COMPLETE, dispatchHelp);
			urlStream.addEventListener(ProgressEvent.PROGRESS, dispatchProgress);
			urlStream.addEventListener(IOErrorEvent.IO_ERROR, onError);
			urlStream.addEventListener(SecurityErrorEvent.SECURITY_ERROR, onError);
		}

		private function dispatchHelp(e : Event) : void
		{
			completeEvent = e;
			dispatchEvent(new ParamEvent(ParamEvent.PARAM, parameter));
			if(currentLoader == LOADER)
			{
				loader.contentLoaderInfo.removeEventListener(Event.COMPLETE, dispatchHelp);
				loader.contentLoaderInfo.removeEventListener(ProgressEvent.PROGRESS, dispatchProgress);
			}
			else if(currentLoader == URLLOADER)
			{
				urlLoader.removeEventListener(Event.COMPLETE, dispatchHelp);
				urlLoader.removeEventListener(ProgressEvent.PROGRESS, dispatchProgress);
				urlLoader.removeEventListener(IOErrorEvent.IO_ERROR, onError);
				urlLoader.removeEventListener(SecurityErrorEvent.SECURITY_ERROR, onError);
			}
			else if(currentLoader == URLSTREAM)
			{
				urlStream.removeEventListener(Event.COMPLETE, dispatchHelp);
				urlStream.removeEventListener(ProgressEvent.PROGRESS, dispatchProgress);
				urlStream.removeEventListener(IOErrorEvent.IO_ERROR, onError);
				urlStream.removeEventListener(SecurityErrorEvent.SECURITY_ERROR, onError);
			}
		}

		private function onError(e : ErrorEvent) : void
		{
			dispatchEvent(new ParamEvent(ParamEvent.ERROR, parameter));
		}

		private function dispatchProgress(e : ProgressEvent) : void
		{
			progressEvent = e;
			dispatchEvent(new ParamEvent(ParamEvent.PERCENT, parameter));
		}

		/**
		 * Returns the <code>ProgressEvent</code> associated with the LoaderHelper's target
		 * 
		 * @return <code>ProgressEvent</code>
		 */
		public function get progress() : ProgressEvent
		{
			return progressEvent;
		}

		/**
		 * Returns the <code>Event</code> associated with the LoaderHelper's target
		 * 
		 * @return <code>Event</code>
		 */
		public function get event() : Event
		{
			return completeEvent;
		}

		/**
		 * Returns the <code>Loader/code>, <code>URLLoader/code> or <code>URLStream/code> associated with the
		 * <code>LoaderHelper/code>
		 * 
		 * @return <code>Object</code>
		 */
		public function get getLoader() : *
		{
			if(currentLoader == LOADER)
			{
				return loader;
			}
			else if(currentLoader == URLLOADER)
			{
				return urlLoader;
			}
			else if(currentLoader == URLSTREAM)
			{
				return urlStream;
			}
		}
	}
}