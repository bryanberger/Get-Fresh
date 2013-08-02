package com.getfreshny.core
{
	import com.getfreshny.vo.OrderVO;
	
	import flash.events.Event;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	
	import starling.events.EventDispatcher;

	[Event(name="status",type="starling.events.Event")]
	public class PayPalAPI extends EventDispatcher
	{
		private static const endPoint:String = 'http://getfreshny.com/api/payment.php';
		private var _urlLoader:URLLoader;
		
		public function PayPalAPI()
		{
		}
		
		
		
		public function makePurchase(payload:OrderVO):void
		{
			trace(this, 'makePurchase');

			var req:URLRequest = new URLRequest( endPoint );
			_urlLoader = new URLLoader();
			_urlLoader.addEventListener(Event.COMPLETE, handleComplete);
			_urlLoader.load( req );	
		}
		
		private function handleComplete(e:Event):void
		{
			var obj:Object = JSON.parse(e.target.data);	

			if(obj.data != null)
			{
				if(obj.data.state != null)
				{
					this.dispatchEventWith('status', false, true);
				}
				else
				{
					this.dispatchEventWith('status', false, false);
				}
			}
			else
			{
				this.dispatchEventWith('status', false, false);
			}
		}
		
	} // END CLASS
} // END PACKAGE