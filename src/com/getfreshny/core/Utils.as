package com.getfreshny.core
{
	import flash.display.BitmapData;
	import flash.display.StageQuality;
	import flash.geom.Point;
	import flash.utils.Dictionary;
	
	import starling.display.Image;
	import starling.textures.Texture;
	
	
	public class Utils
	{
		public function Utils()
		{
		}
		
		/**
		 * Blit a displayobject into a starling image
		 *  
		 * @param obj
		 * @param scale
		 * @return 
		 * 
		 */		
		public static function blit(obj:*, scale:Number = 1):Image
		{
			var bmd:BitmapData;
			
			if(obj is BitmapData)
			{
				bmd = obj as BitmapData;				
			}
			else
			{
				bmd = new BitmapData(obj.width*scale, obj.height*scale, true, 0x0);			
			}
			
			// draw with high quality
			bmd.drawWithQuality(obj, null, null, null, null, false, StageQuality.BEST);
			
			// dont generate mipmaps
			var texture:Texture = Texture.fromBitmapData(bmd, false);
			var img:Image = new Image(texture);
			
			return img;
		}
		
		/**
		 * Tile a starling image
		 *  
		 * @param image
		 * @param horizontal
		 * @param vert
		 * @return 
		 * 
		 */		
		public static function tile(image:Image, horizontal:int, vert:int):Image
		{
			//Tiles texture, give number of horizontal and vertical tiles
			image.setTexCoords(1, new Point(horizontal,0));
			image.setTexCoords(2, new Point(0, vert));
			image.setTexCoords(3, new Point(horizontal, vert));
			
			return image;
		}
		
		/**
		 * return random Float from min - max
		 *  
		 * @param min
		 * @param max
		 * @return 
		 * 
		 */		
		public static function random(min:Number, max:Number = NaN):Number
		{
			if ( isNaN(max) )
			{
				max = min;
				min = 0;
			}
			
			return Math.random() * ( max - min ) + min;
		}
		
		/**
		 * Angle between 2 Point objects
		 *  
		 * @param x1
		 * @param y1
		 * @param x2
		 * @param y2
		 * @return 
		 * 
		 */		
		public static function getAngle(pt1:Point, pt2:Point):Number
		{
			var dx:Number = pt2.x - pt1.x;
			var dy:Number = pt2.y - pt1.y;
			
			return Math.atan2(dy, dx);
		}
		
		/**
		 * Round float number with a percision
		 *  
		 * @param num
		 * @param precision
		 * @return 
		 * 
		 */		
		public static function round(num:Number, precision:int):Number
		{
			var decimal:Number = Math.pow(10, precision);
			return Math.round(decimal* num) / decimal;
		}
		
		
		/**
		 * Random number with weight strength value and ranges
		 * 
		 * Usage:
		 * rand(100)                   //return random number 0-100 INCLUSIVE
		 * rand(10, -5)                //return random number between -5 and 10
		 * rand(10, -5, 2)             //return random number between -5.00 and 10.00
		 * rand(10, 6, 0, [0,5], 0.9)  //90% chance of returning number between 0-5, 10% chance of returning number between 6-10
		 * 
		 */
		public static function weightedRandom(to:Number, from=0, decimalPlaces=0, weightedRange=0, weightStrength=0):Number
		{
			var ret:Number;
			
			if(to == from){ return to; }
			
			if(weightedRange && Math.random()<=weightStrength){
				ret = round( Math.random()*(weightedRange[1]-weightedRange[0]) + weightedRange[0], decimalPlaces )
			}else{
				ret = round( Math.random()*(to-from)+from, decimalPlaces )
			}
			
			return ret;
		}
		
		/**
		 * Count # of dictionary keys 
		 * @param dict
		 * @return 
		 * 
		 */		
		public static function countKeys(dict:Dictionary):int 
		{
			var n:int = 0;
			
			for (var key:* in dict)
				n++;
			
			return n;
		}
		
		
		/**
		 * Make first letter uppercase in a string
		 *  
		 * @param str
		 * @return 
		 * 
		 */		
		public static function upperCase(str:String):String
		{
			var firstChar:String = str.substr(0, 1);
			var restOfString:String = str.substr(1, str.length);
			
			return firstChar.toUpperCase()+restOfString.toLowerCase();
		}
				
		
	} // END CLASS
} // END MAX