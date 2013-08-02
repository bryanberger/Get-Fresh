package com.getfreshny.views
{
	import com.getfreshny.core.Assets;
	import com.getfreshny.core.DataSet;
	import com.getfreshny.core.EmailService;
	import com.getfreshny.core.PayPalAPI;
	import com.getfreshny.views.screens.DetailScreen;
	import com.getfreshny.views.screens.HomeScreen;
	import com.getfreshny.views.screens.InfoScreen;
	import com.getfreshny.views.screens.ListScreen;
	import com.getfreshny.views.screens.SuggestScreen;
	import com.getfreshny.vo.JuiceVO;
	import com.getfreshny.vo.OrderVO;
	import com.greensock.TweenLite;
	
	import flash.display.Loader;
	import flash.filesystem.File;
	import flash.filesystem.FileMode;
	import flash.filesystem.FileStream;
	import flash.text.TextFormat;
	import flash.utils.ByteArray;
	
	import feathers.controls.ScreenNavigator;
	import feathers.controls.ScreenNavigatorItem;
	import feathers.controls.text.TextFieldTextRenderer;
	import feathers.core.FeathersControl;
	import feathers.core.ITextRenderer;
	import feathers.motion.transitions.ScreenSlidingStackTransitionManager;
	
	import starling.core.Starling;
	import starling.display.Sprite;
	import starling.events.Event;
	import starling.utils.AssetManager;
	
	public class MainView extends Sprite
	{
		private static const HOME_SCREEN:String = "homeScreen";
		private static const LIST_SCREEN:String = "listScreen";
		private static const DETAIL_SCREEN:String = "detailScreen";
		private static const INFO_SCREEN:String = "infoScreen";
		private static const SUGGEST_SCREEN:String = "suggestScreen";
		
		private var _navigator:ScreenNavigator;
		private var _transitionManager:ScreenSlidingStackTransitionManager;
		private var _paypal:PayPalAPI;		
		private var _sModal:SuccessModalView;
		
		public var dataSet:DataSet;
		public static var dataSet:DataSet;
		public static var am:AssetManager;
		public static var curSelectedVO:JuiceVO;
		public static var curOrderPayload:OrderVO;
		
		private var _launchImage:Loader;
		
		public function MainView()
		{
			addEventListener(Event.ADDED_TO_STAGE, init);
		}
					
		private function init(event:Event):void
		{
			trace(this, 'init');
			
			this._navigator = new ScreenNavigator();
			this.addChild(this._navigator);
			
			_paypal = new PayPalAPI();
			_paypal.addEventListener('status', handlePaypalStatus);
					
			// LOAD ASSETS
			am = new AssetManager(1, false);
			am.enqueue(Assets);
			am.loadQueue(handleLoadProgress);	
			
			continueShowingLoadImage();
		}
		
		private function setupNavigator():void
		{
			
			// SCREENS
			var home:ScreenNavigatorItem = new ScreenNavigatorItem(HomeScreen, 
				{showList:handleShowList, showInfo:handleShowInfo, showSuggest:handleShowSuggest},{'ingredients': dataSet.ingredients}
			);
			
			var list:ScreenNavigatorItem = new ScreenNavigatorItem(ListScreen, 
				{showDetail:handleShowDetail, showHome:handleShowHome}, {'juices': dataSet.juices}
			);
			
			var detail:ScreenNavigatorItem = new ScreenNavigatorItem(DetailScreen,
				{showList:handleShowList, processOrder:handleProcessOrder}, {'details': dataSet.curSelectedVO, 'preparations': dataSet.preparations}
			);
			
			var info:ScreenNavigatorItem = new ScreenNavigatorItem(InfoScreen,
				{showHome:handleShowHome}, {'informationText': dataSet.informationText, 'informationText2': dataSet.informationText2}
			);
			
			var suggest:ScreenNavigatorItem = new ScreenNavigatorItem(SuggestScreen,
				{showHome:handleShowHome, showHomeAndSubmit:handleSubmitEmail}, {}
			);
			
			_navigator.addScreen(HOME_SCREEN, home);
			_navigator.addScreen(LIST_SCREEN, list);
			_navigator.addScreen(DETAIL_SCREEN, detail);
			_navigator.addScreen(INFO_SCREEN, info);
			_navigator.addScreen(SUGGEST_SCREEN, suggest);
			
			// default screen
			_navigator.showScreen( HOME_SCREEN );
			
			_transitionManager = new ScreenSlidingStackTransitionManager( _navigator );
			_transitionManager.duration = 0.4;
		}
		
		private function continueShowingLoadImage():void
		{
			var file:File = File.applicationDirectory.resolvePath('Default-568h@2x.png');
			if(file.exists)
			{
				var bytes:ByteArray = new ByteArray();
				var stream:FileStream = new FileStream();
				stream.open(file, FileMode.READ);
				stream.readBytes(bytes, 0, stream.bytesAvailable);
				stream.close();
				this._launchImage = new Loader();
				this._launchImage.loadBytes(bytes);
				Starling.current.nativeStage.addChild(this._launchImage);
			}
		}
		
		private function removeLoadImage():void
		{
			if(this._launchImage)
			{
				TweenLite.to(_launchImage, 0.5, {alpha:0, onComplete:function():void {
					Starling.current.nativeStage.removeChild(_launchImage);
					_launchImage.unloadAndStop(true);
					_launchImage = null;
				}});
				//Starling.current.nativeStage.removeChild(_launchImage);
				
			}
		}
		
		private function setupDefaultTextRenderer():void
		{
			FeathersControl.defaultTextRendererFactory = function():ITextRenderer
			{
				var tf:TextFieldTextRenderer = new TextFieldTextRenderer();
				tf.textFormat = new TextFormat( "KelsonSansRegular", 32, 0x999999 );
				return tf;
			};
		}
		
		private function showApproved():void
		{
			trace('approved');
			
			_navigator.showScreen( LIST_SCREEN );
			
			// show modal success
			addChild(_sModal);
			_sModal.show();
		}
		
		private function showNotApproved():void
		{
			trace('not approved');
			
			_navigator.showScreen( LIST_SCREEN );
			
			// show modal success
			addChild(_sModal);
			_sModal.show();
		}
		
		private function handlePaypalStatus(isApproved:Boolean):void
		{
			trace(this, 'handlePaypalStatus');
			
			if(isApproved)
				showApproved();
			else
				showNotApproved();
		}
		
		private function handleProcessOrder(payload:Object):void
		{
			trace(this, 'handleProcessOrder');
			
			MainView.curOrderPayload = payload.data as OrderVO;

			_paypal.makePurchase( payload.data );
		}
				
		private function handleLoadProgress(ratio:Number):void
		{
			trace("Loading assets, progress:", ratio);
			
			if (ratio == 1.0)
			{					
				dataSet = MainView.dataSet = new DataSet();
				
				setupDefaultTextRenderer();
				setupNavigator();
				_sModal = new SuccessModalView();
				removeLoadImage();
			}
		}
		
		private function handleComplete():void
		{
			trace('handleComplete');
		}
		
		private function handleShowList():void
		{
			_navigator.showScreen( LIST_SCREEN );
		}
		
		private function handleShowDetail(payload:Object):void
		{
			MainView.curSelectedVO = payload.data as JuiceVO;
			dataSet.curSelectedVO = payload.data as JuiceVO;
			_navigator.showScreen( DETAIL_SCREEN );
		}
		
		private function handleSubmitEmail(payload:Object):void
		{
			handleShowHome();
			
			// call a service	
			EmailService.recordIdea( payload.data.toString() );
		}
		
		private function handleShowHome():void
		{
			_navigator.showScreen( HOME_SCREEN );
		}
		
		private function handleShowInfo():void
		{
			_navigator.showScreen( INFO_SCREEN );
		}
		
		private function handleShowSuggest():void
		{
			_navigator.showScreen( SUGGEST_SCREEN );
		}
		
		
	} // END CLASS
} // END PACKAGE