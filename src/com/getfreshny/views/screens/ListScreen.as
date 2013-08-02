package com.getfreshny.views.screens
{
	import com.getfreshny.views.MainView;
	import com.getfreshny.views.renderers.JuiceListItemRenderer;
	import com.getfreshny.vo.JuiceVO;
	
	import feathers.controls.List;
	import feathers.controls.Screen;
	import feathers.data.ListCollection;
	
	import starling.display.Button;
	import starling.display.Image;
	import starling.events.Event;
	
	[Event(name="showHome",type="starling.events.Event")]
	[Event(name="showDetail",type="starling.events.Event")]
	public class ListScreen extends Screen
	{
		public static const SHOW_HOME:String = "showHome";
		public static const SHOW_DETAIL:String = "showDetail";

		public var juices:Vector.<JuiceVO>;
				
		private var _header:Image;
		private var _btnBack:Button;
		private var _list:List;
		
		public function ListScreen()
		{
			super();
			
			addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		
		private function init():void
		{
			removeEventListener(Event.ADDED_TO_STAGE, init);
			
			setupUI();
			setupList();
		}
		
		private function setupUI():void
		{
			_header = new Image(MainView.am.getTexture('listHeader'));
			addChild(_header);
			
			_btnBack = new Button(MainView.am.getTexture('btnBackArrow'));
			_btnBack.y = 20;
			_btnBack.x = 20;
			_btnBack.addEventListener(Event.TRIGGERED, handleBack);
			addChild(_btnBack);
		}
		
		private function setupList():void
		{
			_list = new List();
			_list.dataProvider = new ListCollection( juices );
			_list.typicalItem = {name:'String', desc:'String', price:'String', quantity:'String', ingredients:'String', servingSize:'String', img:juices[0].img};
			_list.isSelectable = true;
			_list.scrollerProperties.hasElasticEdges = true;
			_list.scrollerProperties.elasticSnapDuration = 0.4;
			_list.itemRendererType = JuiceListItemRenderer;
			
			_list.addEventListener(Event.CHANGE, list_changeHandler);
			addChild(_list);
		}
		
		override protected function draw():void
		{		
			_list.y = this._header.height+14;
			_list.width = this.actualWidth;
			_list.height = this.actualHeight - _list.y;
		}
		
		private function list_changeHandler(event:Event):void
		{
			trace("List onChange:", _list.selectedItem);
			this.dispatchEventWith( SHOW_DETAIL, false, _list.selectedItem );
		}
		
		private function handleBack():void
		{
			this.dispatchEventWith( SHOW_HOME, false );
		}
		
		
	} // END CLASS
} // END PACKAGE