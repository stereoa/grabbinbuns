package 
{
	import flash.display.BitmapData;
	import flash.display.Bitmap;
	import flash.display.Sprite;
	import flash.events.Event;
	public class Prize extends Sprite
	{
		public static var GirlHairBun:int = 0;
		public static var JeanBun:int = 1;
		public static var CinnaBun:int = 2;
		public static var HamBun:int = 3;
		
		public static var BunsMaxIndex = 3;
		
		public static var Beaker:int = 4;
		public static var BowlerHat:int = 5;
		public static var CameraImg:int = 6;
		public static var Cheese:int = 7;
		public static var Corn:int = 8;
		public static var Grape:int = 9;
		public static var Hair:int = 10;
		public static var HotDog:int = 11;
		public static var PartyHat:int = 12;
		public static var Shark:int = 13;
		public static var Sunglasses:int = 14;
		public static var Vest:int = 15;
		
		public var beingLifted:Boolean = false;
		private var xVel:int = Tool.randomRange(1,20);
		public var prizeType:int;

		public function Prize(image:Bitmap,prizeType:int)
		{
			super();
			this.prizeType = prizeType;
			addChild(image);
		}
		public function tick()
		{
			if (! beingLifted)
			{
				if ((x>stage.stageWidth) || (x<0))
				{
					xVel *=  -1;
					if (x>stage.stageWidth)
					{
						x = stage.stageWidth;
					}
					else
					{
						x = 0;
					}
				}
				x +=  xVel;
			}
		}
	}
}