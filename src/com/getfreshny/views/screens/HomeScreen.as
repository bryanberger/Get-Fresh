package com.getfreshny.views.screens
{
	import com.getfreshny.views.MainView;
	import com.getfreshny.views.components.CustomTileList;
	
	import flash.text.TextFormat;
	
	import feathers.controls.Label;
	import feathers.controls.Screen;
	
	import starling.display.Button;
	import starling.display.Image;
	import starling.display.Sprite;
	import starling.events.Event;
	
	[Event(name="showInfo",type="starling.events.Event")]
	[Event(name="showList",type="starling.events.Event")]	
	[Event(name="showSuggest",type="starling.events.Event")]	
	public class HomeScreen extends Screen
	{
		public static const SHOW_LIST:String = "showList";
		public static const SHOW_INFO:String = "showInfo";
		public static const SHOW_SUGGEST:String = "showSuggest";
				
		private var _header:Image;
		private var _btnSuggest:Button;
		private var _btnInfo:Button;
		private var _btnGo:Button;
		private var _cta:Image;
		private var _ingreds:Sprite;
		private var _footer:Sprite;
		private var _tileList:CustomTileList;
		
		public function HomeScreen()
		{
			trace(this, 'init');
			super();
			
			addEventListener(Event.ADDED_TO_STAGE, setupUI);
		}
		
		public var ingredients:Array;
		
		private function setupUI():void
		{
			removeEventListener(Event.ADDED_TO_STAGE, setupUI);
			
			_header = new Image(MainView.am.getTexture('homeHeader'));
			addChild(_header);
			
			_btnSuggest = new Button(MainView.am.getTexture('btnSuggest'), '', MainView.am.getTexture('btnSuggest'));
			_btnSuggest.x = 547;
			_btnSuggest.y = 7;
			_btnSuggest.addEventListener(Event.TRIGGERED, handleBtnSuggest);
			addChild(_btnSuggest);
			
			_btnInfo = new Button(MainView.am.getTexture('btnInfo'), '', MainView.am.getTexture('btnInfo'));
			_btnInfo.x = 460;
			_btnInfo.y = _btnSuggest.y;
			_btnInfo.addEventListener(Event.TRIGGERED, handleBtnInfo);
			addChild(_btnInfo);
			
			
			_tileList = new CustomTileList();
			_tileList.y = _header.height;
			addChild(_tileList);
			
//			_cta = new Image(MainView.am.getTexture('cta'));
//			_cta.y = _header.height;
//			addChild(_cta);
			
			// _ingreds list
			_ingreds = new Sprite();
			_ingreds.y = _header.height - 16;
			var overlayIngred:Image = new Image(MainView.am.getTexture('overlayIngred'));
			
			var ingredLabel:Label = new Label();
			ingredLabel.y = 72;
			ingredLabel.x = 40;
			ingredLabel.width = 338;
			ingredLabel.height = 252;
			ingredLabel.textRendererProperties.textFormat = new TextFormat( "KelsonSansRegular", 48, 0xFFFFFF, null, null, null, null, null, null, null, null, null, 14 );
			ingredLabel.textRendererProperties.embedFonts = true;
			ingredLabel.textRendererProperties.isHTML = true;
			ingredLabel.textRendererProperties.wordWrap = true;
			var str:String = '';
			for each(var item:String in ingredients)
			{
				str += item + "\n";
				ingredLabel.text = str;
			}
			
			_ingreds.addChild(overlayIngred);
			_ingreds.addChild(ingredLabel);
			addChild(_ingreds);
			
			// footer
			_footer = new Sprite();
			_footer.y = _header.height + _tileList.height;
			
			var footerBg:Image = new Image(MainView.am.getTexture('homeFooter'));
			_footer.addChild(footerBg);
			
			_btnGo = new Button(MainView.am.getTexture('btnArrow'));
			_btnGo.x = 518;
			_btnGo.y = 75;
			_btnGo.addEventListener(Event.TRIGGERED, handleGo);
			_footer.addChild(_btnGo);
			
			addChild(_footer);
		}
		
		private function handleBtnInfo():void
		{
			this.dispatchEventWith( SHOW_INFO );
		}
		
		private function handleBtnSuggest():void
		{
			this.dispatchEventWith( SHOW_SUGGEST );
		}

		private function handleGo():void
		{
			// go to LIST PAGE
			this.dispatchEventWith( SHOW_LIST );
		}
		
		
	} // END CLASS
} // END PACKAGE