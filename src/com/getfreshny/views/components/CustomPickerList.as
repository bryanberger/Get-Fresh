package com.getfreshny.views.components
{
	import com.getfreshny.views.MainView;
	
	import feathers.controls.Button;
	import feathers.controls.List;
	import feathers.controls.PickerList;
	import feathers.controls.popups.DropDownPopUpContentManager;
	import feathers.layout.VerticalLayout;
	
	import starling.display.Image;
	
	public class CustomPickerList extends PickerList
	{
		public function CustomPickerList()
		{
			super();
			
			buttonFactory = function():feathers.controls.Button
			{
				var button:feathers.controls.Button = new feathers.controls.Button();
				button.defaultSkin = new Image( MainView.am.getTexture('bgPickerList') );
				button.downSkin = new Image( MainView.am.getTexture('bgPickerList') );
				
				return button;
			};
			popUpContentManager = new DropDownPopUpContentManager();
			listFactory = function():List
			{
				var list:List = new List();
				list.backgroundSkin = new Image( MainView.am.getTexture('bgPickerList_List') );
				
				var layout:VerticalLayout = new VerticalLayout();
				layout.verticalAlign = VerticalLayout.VERTICAL_ALIGN_TOP;
				layout.horizontalAlign = VerticalLayout.HORIZONTAL_ALIGN_CENTER;
				layout.gap = 44;
				layout.paddingTop = layout.paddingBottom = 22;
				list.layout = layout;
				
				return list;
			};
		}
		
		
	}
}