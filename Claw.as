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
		public var hasItem:Boolean = false;
		public var prizeCarrying:Prize;
		public var isHurt:Boolean = false;
		public var hurtTime:int = 0;
		private var flickerWait:int = 0;
		public function Claw()
		{
			super();
			gotoAndStop(1);
		}
		public function tick()
		{
			if (isHurt)
			{
				//TODO: generate and simulate blood particle in area x:-200 to 50 and y: -100 to 50
				if (hurtTime>0)
				{
					hurtTime--
					flickerWait++;
					if (flickerWait == 5)
					{
						if (this.visible)
						{
							this.visible = false;
						}
						else
						{
							this.visible = true;
						}
						flickerWait = 0;
					}
				}
				else 
				{
					isHurt = false;
					hurtTime = 0;
					
			
				}
			}
			if (clawState<3)
			{
				x += (stage.mouseX - x) * .09;
			}
			if (clawState == Claw.DROPPING)
			{
				if (y < stage.stageHeight - 100)
				{
					y +=  15;
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
						y -=  5;
						if (prizeCarrying.prizeType <= Prize.BunsMaxIndex)
						{
							y -=  30;
						}
					}
					else
					{
						y -=  15;
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
		public function hurt(frames:int)
		{
			bloodAnim.visible = true;
			hurtTime = frames;
			isHurt = true;
		}
		
		public function drop()
		{
			if (clawState != Claw.RISING)
			{
				clawState = Claw.DROPPING;
			}
		}
		
		private function tryGrab()
		{
			gotoAndStop(2);
			clawState = Claw.AT_BOTTOM;
		}
	}
}