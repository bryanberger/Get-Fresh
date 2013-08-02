package com.getfreshny.views.renderers
{
	import com.getfreshny.views.MainView;
	
	import flash.geom.Point;
	import flash.text.TextFormat;
	
	import feathers.controls.Label;
	import feathers.controls.List;
	import feathers.controls.renderers.IListItemRenderer;
	import feathers.core.FeathersControl;
	
	import starling.display.Image;
	import starling.display.Sprite;
	import starling.events.Event;
	import starling.events.Touch;
	import starling.events.TouchEvent;
	import starling.events.TouchPhase;
	
	public class JuiceListItemRenderer extends FeathersControl implements IListItemRenderer
	{
		protected var touchPointID:int = -1;
		private static const HELPER_POINT:Point = new Point();
		
		protected var itemLabel:Label;
		protected var itemDesc:Label;
		protected var itemQuantity:Label;
		protected var itemPrice:Label;
		protected var arrow:Image;
		
		protected var textContainer:Sprite;
		
		protected var _index:int = -1;
		
		public function JuiceListItemRenderer()
		{
			this.setSizeInternal(640, 458, false);
			
			this.addEventListener(TouchEvent.TOUCH, touchHandler);
			this.addEventListener(Event.REMOVED_FROM_STAGE, removedFromStageHandler);
		}
		
		
		
		public function get index():int
		{
			return this._index;
		}
		
		public function set index(value:int):void
		{
			if(this._index == value)
			{
				return;
			}
			this._index = value;
			this.invalidate(INVALIDATION_FLAG_DATA);
		}
		
		protected var _owner:List;
		
		public function get owner():List
		{
			return List(this._owner);
		}
		
		public function set owner(value:List):void
		{
			if(this._owner == value)
			{
				return;
			}
			this._owner = value;
			this.invalidate(INVALIDATION_FLAG_DATA);
		}
		
		protected var _data:Object;
		
		public function get data():Object
		{
			return this._data;
		}
		
		public function set data(value:Object):void
		{
			if(this._data == value)
			{
				return;
			}
			this._data = value;
			this.invalidate(INVALIDATION_FLAG_DATA);
		}
		
		protected var _isSelected:Boolean;
		
		public function get isSelected():Boolean
		{
			return this._isSelected;
		}
		
		public function set isSelected(value:Boolean):void
		{
			if(this._isSelected == value)
			{
				return;
			}
			this._isSelected = value;
			this.invalidate(INVALIDATION_FLAG_SELECTED);
			this.dispatchEventWith(Event.CHANGE);
		}
		
		override protected function initialize():void
		{
			if(!this.itemLabel && !this.itemDesc)
			{
				textContainer = new Sprite();
				textContainer.x = 230;
				textContainer.y = 65;
				//addChild(textContainer);
				
				arrow = new Image(MainView.am.getTexture('icnItemArrow'));
				arrow.x = 587;
				arrow.y = 170;
				addChild(arrow);
				
				itemLabel = new Label();
				itemLabel.textRendererProperties.textFormat = new TextFormat( "PompiereRegular", 40, 0x84c89f );
				//this.itemDesc.textRendererProperties.textFormat.align = TextFormatAlign.CENTER;
				itemLabel.textRendererProperties.embedFonts = true;
				itemLabel.textRendererProperties.isHTML = true;
				textContainer.addChild(this.itemLabel);
				
				itemDesc = new Label();
				itemDesc.y = 70;
				itemDesc.width = 350;
				itemDesc.textRendererProperties.textFormat = new TextFormat( "KelsonSansRegular", 32, 0x999999 );
				//this.itemDesc.textRendererProperties.textFormat.align = TextFormatAlign.CENTER;
				itemDesc.textRendererProperties.embedFonts = true;
				itemDesc.textRendererProperties.isHTML = true;
				itemDesc.textRendererProperties.wordWrap = true;
				textContainer.addChild(this.itemDesc);
				
				itemQuantity = new Label();
				itemQuantity.y = 290;
				itemQuantity.textRendererProperties.textFormat = new TextFormat( "KelsonSansRegular", 30, 0x84c89f );
				itemQuantity.textRendererProperties.embedFonts = true;
				itemQuantity.textRendererProperties.isHTML = true;
				textContainer.addChild(this.itemQuantity);
				
				itemPrice = new Label();
				itemPrice.y = 290;
				itemPrice.x = 250;
				itemPrice.textRendererProperties.textFormat = new TextFormat( "KelsonSansBold", 30, 0x999999 );
				itemPrice.textRendererProperties.embedFonts = true;
				itemPrice.textRendererProperties.isHTML = true;
				textContainer.addChild(itemPrice);
				
				
				addChild(textContainer);
				//textContainer.flatten();				
			}
		}
		
		override protected function draw():void
		{
			const dataInvalid:Boolean = this.isInvalid(INVALIDATION_FLAG_DATA);
			const selectionInvalid:Boolean = this.isInvalid(INVALIDATION_FLAG_SELECTED);
			var sizeInvalid:Boolean = this.isInvalid(INVALIDATION_FLAG_SIZE);
			
			if(dataInvalid)
			{
				this.commitData();
			}
//			
//			sizeInvalid = this.autoSizeIfNeeded() || sizeInvalid;
//			
//			if(dataInvalid || sizeInvalid)
//			{
//				this.layout();
//			}
		}
		
//		protected function autoSizeIfNeeded():Boolean
//		{
////			const needsWidth:Boolean = isNaN(this.explicitWidth);
////			const needsHeight:Boolean = isNaN(this.explicitHeight);
////			if(!needsWidth && !needsHeight)
////			{
////				return false;
////			}
////			
////			this.itemLabel.width = NaN;
////			this.itemLabel.height = NaN;
////			this.itemLabel.validate();
////			
////			
////			
////			var newWidth:Number = this.explicitWidth;
////			if(needsWidth)
////			{
////				newWidth = this.itemLabel.width;
////			}
////			var newHeight:Number = this.explicitHeight;
////			if(needsHeight)
////			{
////				newHeight = this.itemLabel.height;
////			}
////			
//
//			return this.setSizeInternal(640, 458, false);
//		}
		
		protected function commitData():void
		{
			if(this._data)
			{
				this.itemLabel.text = String(this._data.name).toUpperCase();
				this.itemDesc.text = this._data.desc;
				this.addChild(this._data.img);
				
				this.itemQuantity.text = this._data.quantity;
				this.itemPrice.text = this._data.price;
			}
			else
			{
				this.itemLabel.text = "";
				this.itemDesc.text = "";
				this.itemQuantity.text = "";
				this.itemDesc.text = "";
				this.itemPrice.text = "";
				//this.removeChild(this._data.img);
			}
		}
		
		protected function layout():void
		{
			//this.itemLabel.width = this.actualWidth;
			//this.itemLabel.height = this.actualHeight;
			//this.itemQuantity.y = itemLabel.height + itemDesc.height + 40;
		}
		
		
		
		
		// on select
		
		
		protected function touchHandler(event:TouchEvent):void
		{
			const touches:Vector.<Touch> = event.getTouches(this);
			if(touches.length == 0)
			{
				//hover has ended
				return;
			}
			if(this.touchPointID >= 0)
			{
				var touch:Touch;
				for each(var currentTouch:Touch in touches)
				{
					if(currentTouch.id == this.touchPointID)
					{
						touch = currentTouch;
						break;
					}
				}
				if(!touch)
				{
					return;
				}
				if(touch.phase == TouchPhase.ENDED)
				{
					this.touchPointID = -1;
					
					touch.getLocation(this.stage, HELPER_POINT);
					//check if the touch is still over the target
					const isInBounds:Boolean = this.contains(this.stage.hitTest(HELPER_POINT, true));
					if(isInBounds)
					{
						this.isSelected = true;
					}
					return;
				}
			}
			else
			{
				for each(touch in touches)
				{
					if(touch.phase == TouchPhase.BEGAN)
					{
						this.touchPointID = touch.id;
						return;
					}
				}
			}
		}
		
		protected function removedFromStageHandler(event:Event):void
		{
			this.touchPointID = -1;
		}
		
	} // END CLASS
} // END PACKAGE