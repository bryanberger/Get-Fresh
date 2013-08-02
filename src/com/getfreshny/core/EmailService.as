package com.getfreshny.core
{
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	import flash.net.URLRequestMethod;

	public class EmailService
	{
		public function EmailService()
		{
		}
		
		public static function recordIdea(str:String):void
		{
			// hit endpoint with str as param
			trace('recordIdea');
			
			var url:String = "http://getfreshny.com/api/mail.php";
			var request:URLRequest = new URLRequest(url);
			request.method = URLRequestMethod.POST;     
			request.data = "payload=" + str;

			var loader:URLLoader = new URLLoader();
			loader.addEventListener(Event.COMPLETE, function():void{
				trace('complete');
			});
			
			loader.addEventListener(IOErrorEvent.IO_ERROR, function():void{
				trace('fail');
			});
			
			loader.load(request);
			
		
		}
	} // END CALSS
} // END PACKAGE