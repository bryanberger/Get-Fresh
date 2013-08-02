package com.getfreshny.vo
{
	import starling.display.Image;

	public class JuiceVO
	{
		public var name:String;
		public var desc:String;
		public var price:String;
		public var priceFloat:Number;
		public var quantity:String;
		public var ingredients:String;
		public var servingSize:String;
		public var img:Image;
		public var id:int;
		
		public var subTotal:Number;
		
		public function JuiceVO(id:int, name:String, desc:String, price:String, priceFloat:Number, quantity:String, ingredients:String, servingSize:String, img:Image) {
			this.id = id;
			this.name = name;
			this.desc = desc;
			this.price = price;
			this.priceFloat = priceFloat;
			this.quantity = quantity;
			this.ingredients = ingredients;
			this.servingSize = servingSize;
			this.img = img;
		}
	}
}