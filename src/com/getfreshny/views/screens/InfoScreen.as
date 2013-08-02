package com.getfreshny.views.screens
{
	import com.getfreshny.views.MainView;
	
	import flash.text.TextFormat;
	
	import feathers.controls.Label;
	import feathers.controls.Screen;
	import feathers.controls.ScrollContainer;
	import feathers.controls.Scroller;
	import feathers.layout.HorizontalLayout;
	import feathers.layout.VerticalLayout;
	
	import starling.display.Button;
	import starling.display.Image;
	import starling.events.Event;
	
	[Event(name="showHome",type="starling.events.Event")]	
	public class InfoScreen extends Screen
	{
		public static const SHOW_HOME:String = "showHome";

		public var informationText:String;
		public var informationText2:String;
		
		private var _header:Image;
		private var _title:Label;
		private var _btnBack:Button;
		private var _vContainer:ScrollContainer;
		
		public function InfoScreen()
		{
			super();
		}
		
		override protected function initialize():void
		{
			trace(this, 'init');
			setupHeader();
			setupTextContainer();
		}
		
		private function setupHeader():void
		{
			_header = new Image(MainView.am.getTexture('detailHeader'));
			addChild(_header);
			
			_title = new Label();
			_title.x = 225;
			_title.y = 35;
			_title.text = 'INFORMATION';
			_title.textRendererProperties.textFormat = new TextFormat( "PompiereRegular", 40, 0x84c89f );
			_title.textRendererProperties.embedFonts = true;
			_title.textRendererProperties.isHTML = true;
			addChild(_title);
			
			_btnBack = new Button(MainView.am.getTexture('btnBackArrow'));
			_btnBack.y = 20;
			_btnBack.x = 20;
			_btnBack.addEventListener(Event.TRIGGERED, handleBack);
			addChild(_btnBack);
		}
		
		private function setupTextContainer():void
		{
			// scroll container
			var layout:VerticalLayout = new VerticalLayout();
			layout.gap = 30;
			layout.useVirtualLayout = false;
			layout.hasVariableItemDimensions = true;
			layout.horizontalAlign = HorizontalLayout.HORIZONTAL_ALIGN_CENTER;
			layout.verticalAlign = HorizontalLayout.VERTICAL_ALIGN_TOP;
			
			_vContainer = new ScrollContainer();
			_vContainer.scrollerProperties.verticalScrollPolicy = Scroller.SCROLL_POLICY_ON;
			_vContainer.scrollerProperties.snapScrollPositionsToPixels = true;
			_vContainer.layout = layout;
			addChild(_vContainer);
			
			// label wordWrap
			var txt:Label = new Label();
			txt.text = informationText;
			txt.width = 544;
			txt.textRendererProperties.textFormat = new TextFormat( "KelsonSansRegular", 26, 0x999999, null, null, null, null, null, null, null, null, null, 18 );
			txt.textRendererProperties.embedFonts = true;
			txt.textRendererProperties.isHTML = true;
			txt.textRendererProperties.wordWrap = true;
			_vContainer.addChild(txt);
			
			var txt2:Label = new Label();
			txt2.text = informationText2;
			txt2.width = 544;
			txt2.textRendererProperties.textFormat = new TextFormat( "KelsonSansRegular", 26, 0x999999, null, null, null, null, null, null, null, null, null, 18 );
			txt2.textRendererProperties.embedFonts = true;
			txt2.textRendererProperties.isHTML = true;
			txt2.textRendererProperties.wordWrap = true;
			_vContainer.addChild(txt2);
			
			// add it
		}
		
		override protected function draw():void
		{
			_vContainer.y = this._header.height+14;
			_vContainer.width = this.actualWidth;
			_vContainer.height = this.actualHeight - _vContainer.y+14;
		}
		
		private function handleBack():void
		{
			this.dispatchEventWith( SHOW_HOME );
		}
		
		
	} // END CLASS
} // END PACKAGE