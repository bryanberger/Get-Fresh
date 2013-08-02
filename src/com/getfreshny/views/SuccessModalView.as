package com.getfreshny.views
{
	import com.greensock.OverwriteManager;
	import com.greensock.TweenLite;
	import com.greensock.easing.Expo;
	
	import starling.core.Starling;
	import starling.display.Image;
	import starling.display.Sprite;
	import starling.textures.Texture;
	
	public class SuccessModalView extends Sprite
	{
		private var _graphic:Image;
		private var _overlay:Image;
		
		public function SuccessModalView()
		{
			super();
			init();
		}
		
		private function init():void
		{		
			touchable = false;
			
			OverwriteManager.init(OverwriteManager.CONCURRENT);
			
			var oTexture:Texture = Texture.fromColor(640, 1136, 0xFF000000);
			_overlay = new Image(oTexture);
			_overlay.x = _overlay.y = 0;
			_overlay.alpha = 0.8;
			addChild(_overlay);
			
			_graphic = new Image( MainView.am.getTexture('modalSuccess') );
			_graphic.x = (Starling.current.stage.stageWidth - _graphic.width) >> 1;
			_graphic.y = 1400;
			addChild(_graphic);
			
		}
		
		public function show():void
		{
			trace('show');
			_overlay.alpha = 0.8;
			
			TweenLite.to(_graphic, 0.8, {y: 275, ease:Expo.easeOut});
			TweenLite.to(_graphic, 0.8, {delay:3, y: 1400, ease:Expo.easeIn});
			TweenLite.to(_overlay, 0.25, {delay:4, alpha: 0, onComplete:function():void {
				//parent.removeChild(this);
				//this.removeFromParent(false);
			}});
			
			// bye
			//TweenLite.to(_graphic, 0.5, {delay:5, y:1400});
			//TweenLite.to(_overlay, 0.25, {delay:3000, alpha:0, onComplete:function():void {
			//	this.removeFromParent(false);
			//} });
			
			
		}
		
	}
}