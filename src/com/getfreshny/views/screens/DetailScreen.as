package com.getfreshny.views.screens
{
	import com.getfreshny.core.Utils;
	import com.getfreshny.views.MainView;
	import com.getfreshny.views.components.CustomPickerList;
	import com.getfreshny.vo.JuiceVO;
	import com.getfreshny.vo.OrderVO;
	import com.greensock.TweenLite;
	import com.greensock.easing.Strong;
	
	import flash.text.TextFormat;
	import flash.text.TextFormatAlign;
	
	import feathers.controls.Label;
	import feathers.controls.Panel;
	import feathers.controls.Screen;
	import feathers.controls.ScrollContainer;
	import feathers.data.ListCollection;
	import feathers.layout.HorizontalLayout;
	import feathers.layout.VerticalLayout;
	
	import starling.display.Button;
	import starling.display.Image;
	import starling.display.Sprite;
	import starling.events.Event;
	import starling.textures.Texture;
	
	[Event(name="processOrder",type="starling.events.Event")]
	public class DetailScreen extends Screen
	{
		public static const SHOW_LIST:String = "showList";
		public static const PROCESS_ORDER:String = "processOrder";
		
		public var details:JuiceVO;
		public var preparations:Array;
		
		private var _header:Image;
		private var _btnBack:Button;
		private var _cta:Image;
		private var _title:Label;
		
		private var _vContainer:ScrollContainer;
		private var _panel:Panel;
		private var _overlay:Image;
		private var _pHowCombo:CustomPickerList;
		private var _pMethodCombo:CustomPickerList;
		
		private var _descriptionContainer:Sprite;
		private var _ingredContainer:Sprite;
		private var _servingContainer:Sprite;
		private var _priceBox:Sprite;
		
		private var _headTF:TextFormat = new TextFormat( "PompiereRegular", 40, 0x84c89f );
		private var _copyTF:TextFormat = new TextFormat( "KelsonSansRegular", 26, 0x999999 );
		private var _boldBuyTF:TextFormat = new TextFormat( "PompiereRegular", 60, 0xFFFFFF );
		private var _boldPriceTF:TextFormat = new TextFormat( "KelsonSansBold", 30, 0xFFFFFF );
		
		private var _btnBuy:Button;
		
		public function DetailScreen()
		{
			super();
		}
		
		
		override protected function initialize():void
		{
			setupUI();
			setupPanel();
			//setupProgressBar();
		}
		
		private function setupHeader():void
		{
			_header = new Image(MainView.am.getTexture('detailHeader'));
			addChild(_header);
			
			_title = new Label();
			_title.x = 225;
			_title.y = 35;
			_title.text = MainView.curSelectedVO.name.toString().toUpperCase();
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
		
		private function setupUI():void
		{			
			// VCONTAINER BLOCK
			var layout:VerticalLayout = new VerticalLayout();
			layout.gap = 30;
			layout.useVirtualLayout = false;
			layout.hasVariableItemDimensions = true;
			layout.horizontalAlign = HorizontalLayout.HORIZONTAL_ALIGN_CENTER;
			layout.verticalAlign = HorizontalLayout.VERTICAL_ALIGN_MIDDLE;
			layout.typicalItemHeight = 110;
			_vContainer = new ScrollContainer();
			//_vContainer.verticalScrollPolicy = ScrollContainer.SCROLL_POLICY_ON;
			_vContainer.scrollerProperties.snapScrollPositionsToPixels = true;
			_vContainer.layout = layout;
			addChild(_vContainer);
			
			// add the header after the vC
			setupHeader();
			
			_cta = new Image(MainView.am.getTexture('ctaDetail' + MainView.curSelectedVO.id));
			_vContainer.addChild(_cta);
			
//			// descriptions
			//_descriptionContainer = new Sprite();
			var dTitle:Label = new Label();
			dTitle.width = 544;

			//dTitle.x = 34;
			dTitle.textRendererProperties.textFormat = _headTF;
			dTitle.textRendererProperties.embedFonts = true;
			dTitle.textRendererProperties.isHTML = true;
			dTitle.text = 'DESCRIPTION';
			_vContainer.addChild(dTitle);
			
			var dCopy:Label = new Label();
//			dCopy.x = 34;
//			dCopy.y = 55;
			dCopy.width = 544;
			dCopy.text = MainView.curSelectedVO.desc;
			dCopy.textRendererProperties.textFormat = _copyTF;
			dCopy.textRendererProperties.embedFonts = true;
			dCopy.textRendererProperties.isHTML = true;
			dCopy.textRendererProperties.wordWrap = true;
			//_descriptionContainer.addChild(dTitle);
			//_descriptionContainer.addChild(dCopy);
			_vContainer.addChild(dCopy);
//			
//			// ingredients
//			_ingredContainer = new Sprite();
			var iTitle:Label = new Label();
			iTitle.width = 544;
//			iTitle.x = 34;
			iTitle.textRendererProperties.textFormat = _headTF;
			iTitle.textRendererProperties.embedFonts = true;
			iTitle.textRendererProperties.isHTML = true;
			iTitle.text = 'INGREDIENTS';
			_vContainer.addChild(iTitle);
			
			var iCopy:Label = new Label();
//			iCopy.x = 34;
//			iCopy.y = 55;
			iCopy.width = 544;
			iCopy.text = MainView.curSelectedVO.ingredients;
			iCopy.textRendererProperties.textFormat = _copyTF;
			iCopy.textRendererProperties.embedFonts = true;
			iCopy.textRendererProperties.isHTML = true;
			iCopy.textRendererProperties.wordWrap = true;
			_vContainer.addChild(iCopy);
//			_ingredContainer.addChild(iTitle);
//			_ingredContainer.addChild(iCopy);
//			
//			// serving size
//			_servingContainer = new Sprite();
			var sTitle:Label = new Label();
//			sTitle.x = 34;
			sTitle.width = 544;
			sTitle.textRendererProperties.textFormat = _headTF;
			sTitle.textRendererProperties.embedFonts = true;
			sTitle.textRendererProperties.isHTML = true;
			sTitle.text = 'SERVING SIZE';
			_vContainer.addChild(sTitle);
			
			var sCopy:Label = new Label();
//			sCopy.x = 34;
//			sCopy.y = 55;
			sCopy.width = 544;
			sCopy.text = MainView.curSelectedVO.servingSize;
			sCopy.textRendererProperties.textFormat = _copyTF;
			sCopy.textRendererProperties.embedFonts = true;
			sCopy.textRendererProperties.isHTML = true;
			sCopy.textRendererProperties.wordWrap = true;
			_vContainer.addChild(sCopy);
//			_ingredContainer.addChild(sCopy);
//			
			_btnBuy = new Button(MainView.am.getTexture('bgDetailFooter'), '', MainView.am.getTexture('bgDetailFooter'));
			var btnBuyLabel:Label = new Label();
			btnBuyLabel.y = 63;
			btnBuyLabel.width = 640;			
			btnBuyLabel.textRendererProperties.textFormat = _boldBuyTF;
			btnBuyLabel.textRendererProperties.textFormat.align = TextFormatAlign.CENTER;
			btnBuyLabel.textRendererProperties.embedFonts = true;
			btnBuyLabel.textRendererProperties.isHTML = true;
			btnBuyLabel.text = 'BUY';
			_btnBuy.addChild(btnBuyLabel);
			var btnPriceLabel:Label = new Label();
			btnPriceLabel.y = 135;
			btnPriceLabel.width = 640;			
			btnPriceLabel.textRendererProperties.textFormat = _boldPriceTF;
			btnPriceLabel.textRendererProperties.textFormat.align = TextFormatAlign.CENTER;
			btnPriceLabel.textRendererProperties.embedFonts = true;
			btnPriceLabel.textRendererProperties.isHTML = true;
			btnPriceLabel.text = MainView.curSelectedVO.price;
			_btnBuy.addChild(btnPriceLabel);
			
			_btnBuy.addEventListener(Event.TRIGGERED, handleBtnBuy);
			_vContainer.addChild(_btnBuy);
		}
		
		private function setupPanel():void
		{
			_panel = new Panel();
			_panel.width = 548;
			_panel.y = -1000;
			
			var oTexture:Texture = Texture.fromColor(640, 1136, 0xFF000000);
			_overlay = new Image(oTexture);
			_overlay.alpha = 0;
			
			var bgTexture:Texture = Texture.fromColor(546, 728, 0xFFFFFFFF);
			var bgPanel:Image = new Image(bgTexture);
			_panel.addChild(bgPanel);
			
			var btnPanelClose:Button = new Button(MainView.am.getTexture('btnClose'), '', MainView.am.getTexture('btnClose'));
			btnPanelClose.x = 548-btnPanelClose.width-2;
			btnPanelClose.addEventListener(Event.TRIGGERED, handleClose);
			_panel.addChild(btnPanelClose);

			// TEXTS
			var pTitle:Label = new Label();
			pTitle.y = 60;
			pTitle.width = 548;
			pTitle.textRendererProperties.textFormat = new TextFormat( "PompiereRegular", 40, 0x84c89f );
			pTitle.textRendererProperties.textFormat.align = TextFormatAlign.CENTER;
			pTitle.textRendererProperties.embedFonts = true;
			pTitle.textRendererProperties.isHTML = true;
			pTitle.text = MainView.curSelectedVO.name.toString().toUpperCase();
			_panel.addChild(pTitle);
			
			// HOW PREP
			var pHow:Label = new Label();
			pHow.y = pTitle.y + pTitle.height + 100;
			pHow.width = 548;
			pHow.textRendererProperties.textFormat = new TextFormat( "KelsonSansRegular", 30, 0x999999 );;
			pHow.textRendererProperties.textFormat.align = TextFormatAlign.CENTER;
			pHow.text = 'How would you like your juice?';
			_panel.addChild(pHow);
			
			_pHowCombo = new CustomPickerList();
			_pHowCombo.y = pHow.y + 60;
			_pHowCombo.x = 90;
			_pHowCombo.dataProvider = new ListCollection(preparations);
			_panel.addChild(_pHowCombo);
			
			// PICK UP OR DELIV
			var pMethod:Label = new Label();
			pMethod.y = _pHowCombo.y + 120;
			pMethod.width = 548;
			pMethod.textRendererProperties.textFormat = new TextFormat( "KelsonSansRegular", 30, 0x999999 );;
			pMethod.textRendererProperties.textFormat.align = TextFormatAlign.CENTER;
			pMethod.text = 'PickUp or Delivery?';
			_panel.addChild(pMethod);
			
			_pMethodCombo = new CustomPickerList();
			_pMethodCombo.y = pMethod.y + 60;
			_pMethodCombo.x = 90;
			_pMethodCombo.dataProvider = new ListCollection(['Delivery', 'PickUp']);
			_panel.addChild(_pMethodCombo);
			
			
			
			
			// PRICE BOX
			_priceBox = new Sprite();
			_priceBox.y = _pMethodCombo.y + 120;
			_priceBox.x = 120;
			_panel.addChild(_priceBox);
			
			
			// price // tax // total
			var price:Label = new Label();
			price.textRendererProperties.textFormat = new TextFormat( "KelsonSansRegular", 24, 0x999999 );;
			price.text = 'PRICE';
			_priceBox.addChild(price);
			
			var priceInput:Label = new Label();
			priceInput.x = 225;
			priceInput.textRendererProperties.textFormat = new TextFormat( "KelsonSansBold", 30, 0x84c89f );;
			priceInput.text = MainView.curSelectedVO.price;
			_priceBox.addChild(priceInput);
			
			
			// tax
			var tax:Label = new Label();
			tax.y = price.y + 60;
			tax.textRendererProperties.textFormat = new TextFormat( "KelsonSansRegular", 24, 0x999999 );;
			tax.text = 'TAX';
			_priceBox.addChild(tax);
			
			var taxInput:Label = new Label();
			taxInput.x = priceInput.x;
			taxInput.y = tax.y;
			taxInput.textRendererProperties.textFormat = new TextFormat( "KelsonSansBold", 30, 0x84c89f );
			var taxAmount:Number = Utils.round(MainView.curSelectedVO.priceFloat*0.0825, 2);
			MainView.curSelectedVO.subTotal = MainView.curSelectedVO.priceFloat + taxAmount;
			taxInput.text = '$' + taxAmount;
			_priceBox.addChild(taxInput);
			
			
			//hairline
			var hairline:Image = new Image( MainView.am.getTexture('orderHairline'));
			hairline.y = tax.y + 60;
			hairline.x = -30;
			_priceBox.addChild(hairline);
			
			
			//subtotal
			var subtotal:Label = new Label();
			subtotal.y = hairline.y + 30;
			subtotal.textRendererProperties.textFormat = new TextFormat( "KelsonSansRegular", 24, 0x999999 );;
			subtotal.text = 'SUBTOTAL';
			_priceBox.addChild(subtotal);
			
			var subTotalInput:Label = new Label();
			subTotalInput.x = priceInput.x;
			subTotalInput.y = subtotal.y - 6;
			subTotalInput.textRendererProperties.textFormat = new TextFormat( "KelsonSansBold", 30, 0x84c89f );
			subTotalInput.text = '$' + MainView.curSelectedVO.subTotal;
			_priceBox.addChild(subTotalInput);
			
			
			var btnCompleteOrder:Button = new Button(MainView.am.getTexture('btnCompleteOrder'), '', MainView.am.getTexture('btnCompleteOrder'));
			btnCompleteOrder.y = 728;
			btnCompleteOrder.addEventListener(Event.TRIGGERED, handleBtnCompleteOrder);
			_panel.addChild(btnCompleteOrder);
			
		}
		
		override protected function draw():void
		{
			_title.validate();
			_title.x = ((this.actualWidth - _title.width) >> 1) + 10;
			
			_panel.x = (this.actualWidth - _panel.width) >> 1;
			
			//_pHowCombo.validate();
			//_pHowCombo.x = (this.actualWidth - _pHowCombo.width) >> 1;
			
			_vContainer.paddingTop = _header.height+10;
			_vContainer.setSize(this.actualWidth, this.actualHeight);
		}
		
		private function handleClose():void
		{
			// close overlay
			_overlay.touchable = _panel.touchable = false;
			
			TweenLite.killTweensOf(_panel);
			TweenLite.killTweensOf(_overlay);

			
			TweenLite.to(_panel, 0.8, {alpha:0, onComplete:function():void {
				removeChild(_overlay);
				removeChild(_panel);
			}});
			TweenLite.to(_overlay, 0.6, {alpha:0});
		}
		
		private function handleBtnCompleteOrder(e:Event):void
		{
			trace(this, 'handleBtnCompleteOrder');
			
			Button(e.currentTarget).touchable = false;
			
			TweenLite.killTweensOf(_panel);
			TweenLite.to(_panel, 0.5, {alpha:0.70});

			// dispatch this to main view and handle paypal stuff there and return with a response.
			this.dispatchEventWith( PROCESS_ORDER, false, new OrderVO() );
		}
		
		private function handleBtnBuy():void
		{
			trace('handleBtnBuy');
			
			_overlay.touchable = _panel.touchable = true;
			
			addChild(_overlay);
			addChild(_panel);
			_panel.alpha = 1;
			TweenLite.killTweensOf(_panel);
			TweenLite.killTweensOf(_overlay);
			TweenLite.to(_panel, 0.8, {y: 100, ease:Strong.easeOut});
			TweenLite.to(_overlay, 0.25, {alpha: 0.8});
		}
				
		private function handleBack():void
		{
			this.dispatchEventWith( SHOW_LIST );
		}
		
		
	} // END CLASS
} // END PACKAGE