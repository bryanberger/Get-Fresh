package com.getfreshny.views.components
{
	import com.getfreshny.core.DataSet;
	import com.getfreshny.views.MainView;
	
	import flash.text.TextFormat;
	
	import feathers.controls.Button;
	import feathers.controls.Label;
	import feathers.controls.List;
	import feathers.controls.renderers.DefaultListItemRenderer;
	import feathers.controls.renderers.IListItemRenderer;
	import feathers.layout.TiledRowsLayout;
	
	import starling.core.Starling;
	import starling.display.Sprite;
	import starling.events.Event;

	public class CustomTileList extends Sprite
	{
		private var _list:List;
		
		public function CustomTileList()
		{
			super();
			init();
		}
		
		private function init():void
		{
			
			const listLayout:TiledRowsLayout = new TiledRowsLayout();
			listLayout.paging = TiledRowsLayout.PAGING_HORIZONTAL;
			listLayout.useSquareTiles = false;
			listLayout.tileHorizontalAlign = TiledRowsLayout.TILE_HORIZONTAL_ALIGN_CENTER;
			listLayout.horizontalAlign = TiledRowsLayout.HORIZONTAL_ALIGN_CENTER;
			listLayout.manageVisibility = true;
			
			this._list = new List();
			this._list.dataProvider = MainView.dataSet.tileListCollection;
			this._list.layout = listLayout;
			this._list.snapToPages = true;
			this._list.scrollBarDisplayMode = List.SCROLL_BAR_DISPLAY_MODE_NONE;
			this._list.horizontalScrollPolicy = List.SCROLL_POLICY_ON;
			this._list.itemRendererFactory = tileListItemRendererFactory;
			//this._list.addEventListener(Event.SCROLL, handleScroll);
			this.addChild(this._list);
			
			this.layout();
		}
		
		protected function layout():void
		{
			const shorterSide:Number = Math.min(Starling.current.stage.stageWidth, Starling.current.stage.stageHeight);
			const layout:TiledRowsLayout = TiledRowsLayout(this._list.layout);
			
			this._list.width = Starling.current.stage.stageWidth;
			this._list.height = Starling.current.stage.stageHeight - 340; // -footerHeight
			this._list.validate();
			
			//this._pageIndicator.pageCount = this._list.horizontalPageCount;
		}
		
		protected function tileListItemRendererFactory():IListItemRenderer
		{
			const renderer:DefaultListItemRenderer = new DefaultListItemRenderer();
			//renderer.defaultLabelProperties.textFormat = new TextFormat('myriad',0,0x0);
			renderer.iconSourceField = "texture";
			renderer.iconPosition = Button.ICON_POSITION_TOP;
			return renderer;
		}
		
//		private function handleScroll(e:Event):void
//		{
//			
//		}
		
	} // END CLASS
} // END PACKAGE