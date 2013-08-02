package com.getfreshny.views.screens
{
	import com.getfreshny.core.Utils;
	import com.getfreshny.views.MainView;
	
	import flash.display.Shape;
	import flash.text.TextFormat;
	
	import feathers.controls.Label;
	import feathers.controls.Screen;
	import feathers.controls.ScrollContainer;
	import feathers.controls.Scroller;
	import feathers.controls.TextInput;
	import feathers.controls.text.StageTextTextEditor;
	import feathers.core.ITextEditor;
	import feathers.layout.HorizontalLayout;
	import feathers.layout.VerticalLayout;
	
	import starling.display.Button;
	import starling.display.Image;
	import starling.display.Sprite;
	import starling.events.Event;
	
	[Event(name="showHome",type="starling.events.Event")]
	[Event(name="showHomeAndSubmit",type="starling.events.Event")]
	public class SuggestScreen extends Screen
	{
		public static const SHOW_HOME:String = "showHome";
		public static const SHOW_HOME_AND_SUBMIT:String = "showHomeAndSubmit";
		
		private var _header:Image;
		private var _title:Label;
		private var _btnBack:Button;
		private var _btnSubmit:Button;
		private var _vContainer:ScrollContainer;
		private var _textInput:TextInput;
		
		public function SuggestScreen()
		{
			super();
		}
		
		override protected function initialize():void
		{
			trace(this, 'init');
			
			setupHeader();
			setupContainer();
		}
		
		private function setupHeader():void
		{
			_header = new Image(MainView.am.getTexture('detailHeader'));
			addChild(_header);
			
			_title = new Label();
			_title.x = 185;
			_title.y = 35;
			_title.text = 'SUGGEST JUICE IDEAS';
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
		
		private function setupContainer():void
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
			
			// DESC
			var desc:Label = new Label();
			desc.text = 'The Seasonal Ingredients are: Strawberries, Blueberries, Raspeberries. Have any ideas for additional seasonal ingredients and combinations?';
			desc.width = 544;
			desc.textRendererProperties.textFormat = new TextFormat( "KelsonSansRegular", 30, 0x999999, null, null, null, null, null, null, null, null, null, 16 );
			desc.textRendererProperties.embedFonts = true;
			desc.textRendererProperties.isHTML = true;
			desc.textRendererProperties.wordWrap = true;
			_vContainer.addChild(desc);
			
			
			var tContainer:Sprite = new Sprite();
			
			var g:Shape = new Shape();
			g.graphics.beginFill(0xf3f2f2);
			g.graphics.drawRect(0, 0, 544, 400);
			g.graphics.lineStyle(2, 0xCCCCCC);
			g.graphics.endFill();
			
			var img:Image = Utils.blit(g);
			//img.y = 44;
			tContainer.addChild(img);
			
//			var txt2:Label = new Label();
//			txt2.text = 'YOUR IDEA';
//			txt2.width = 544;
//			txt2.textRendererProperties.textFormat = new TextFormat( "KelsonSansRegular", 20, 0x999999 );
//			txt2.textRendererProperties.embedFonts = true;
//			txt2.textRendererProperties.isHTML = true;
//			tContainer.addChild(txt2);
			
			_textInput = new TextInput();
			_textInput.padding = 20;
			_textInput.promptProperties.textFormat = new TextFormat( "KelsonSansRegular", 40, 0x666666 );
			_textInput.textEditorProperties.textFormat = new TextFormat( "KelsonSansRegular", 40, 0x666666 );
			_textInput.width = 544;
			_textInput.height = 350;
			//textInput.y = 44;
			//textInput.prompt = 'Your Idea';
			_textInput.textEditorFactory = function():ITextEditor
			{
				var editor:StageTextTextEditor = new StageTextTextEditor();
				editor.fontFamily = "KelsonSansRegular";
				editor.multiline = true;
				editor.fontSize = 36;
				editor.color = 0x666666;
				
				return editor;
			}
			tContainer.addChild(_textInput);
			
			// add shit
			_vContainer.addChild(tContainer);
			
			// BTN
			_btnSubmit = new Button(MainView.am.getTexture('btnSuggestSubmit'), '', MainView.am.getTexture('btnSuggestSubmit'));
			_btnSubmit.addEventListener(Event.TRIGGERED, handleSubmit);
			_vContainer.addChild(_btnSubmit);
		}
		
		override protected function draw():void
		{
			_vContainer.y = this._header.height+14;
			_vContainer.width = this.actualWidth;
			_vContainer.height = this.actualHeight - _vContainer.y+14;
		}
		
		private function handleSubmit():void
		{
			this.dispatchEventWith( SHOW_HOME_AND_SUBMIT, false,  _textInput.text);
		}
		
		private function handleBack():void
		{
			this.dispatchEventWith( SHOW_HOME );
		}
		
		
	} // END CLASS
} // END PACKAGE