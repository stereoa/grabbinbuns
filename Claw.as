package 
{
	import flash.display.MovieClip;
	import flash.events.Event;

	public class Claw extends MovieClip
	{
		//clawState - 0 = ready to drop, 1 is rising with nothing, 2 is dropping, , 3 is hit bottom, 4 is lifting item
		public static const READY:uint = 0;
		public static const RISING:uint = 1;
		public static const DROPPING:uint = 2;
		public static const AT_BOTTOM:uint = 3;
		public var clawState:int = Claw.READY;
		public var prizeCarrying:Prize;
		
		private var hasItem:Boolean = false;
		private var speed:Number = .09;
		
		public var vx:Number;
		public function Claw()
		{
			super();
			gotoAndStop(1);
		}
		public function tick()
		{
			if (clawState<3)
			{
				vx = (stage.mouseX - x) * speed;
				x += vx;
			}
			if (clawState == Claw.DROPPING)
			{
				if (y < stage.stageHeight - 100)
				{
					y +=  speed * 200;
				}
				else
				{
					tryGrab();
				}
			}
			if (clawState == Claw.RISING)
			{
				if (y > 250)
				{
					if (hasItem)
					{
						y -=  speed * 50;
						if (prizeCarrying.prizeType <= Prize.BunsMaxIndex)
						{
							y -=  speed * 300;
						}
					}
					else
					{
						y -=  speed * 200;
					}
				}
				else
				{
					if (hasItem)
					{
						removeChild(prizeCarrying);
						hasItem = false;
						
						prizeCarrying = null;
					}
					clawState = Claw.READY;
					gotoAndStop(1);
				}

			}
		}

		public function speedUp()
		{
			speed*=2;
		}
		public function slowDown()
		{
			speed/=2;
		}

		public function drop()
		{
			if (clawState != Claw.RISING)
			{
				clawState = Claw.DROPPING;
			}
		}
		
		public function grab(prizeToCheck:Prize)
		{
			prizeCarrying = prizeToCheck;
			hasItem = true;
		}
		private function tryGrab()
		{
			gotoAndStop(2);
			clawState = Claw.AT_BOTTOM;
		}
	}
}