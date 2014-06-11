package 
{

	public class Message
	{

		public var lifeSpan:uint = 0;
		public var text:String = "";
		public function Message(lifeSpan:uint,messageType:uint)
		{
			this.lifeSpan = lifeSpan;
			var randomNum:int;


			switch (messageType)
			{
				case Prize.CinnaBun :
				case Prize.GirlHairBun :
				case Prize.HamBun :
				case Prize.JeanBun :
					randomNum = Tool.randomRange(0,3);
					switch (randomNum)
					{
						case 0 :
							this.text = "BUNS BUNS BUNS BUNS";
							break;
						case 1 :
							this.text = "ALRIGHT AL BUN-DY!";
							break;
						case 2 :
							this.text = "BUNTASTIC!";
							break;
						case 3 :
							this.text = "BUNS ALL DAY!";
							break;

					}
					break;
				case Prize.BunB :
					randomNum = Tool.randomRange(0,1);
					switch (randomNum)
					{
						case 0 :
							this.text = "BUN BASED GOD";
							break;
						case 1 :
							this.text = "SUPERBUN";
							break;
					}
					break;
				case Prize.CameraImg :
					randomNum = Tool.randomRange(0,3);
					switch (randomNum)
					{
						case 0 :
							this.text = "BUT FIRST! LEMME TAKE A SELFIE!";
							break;
						case 1 :
							this.text = "FREEZE FRAME!";
							break;
						case 2 :
							this.text = "I'M READY FOR MY CLOSEUP!";
							break;
						case 3 :
							this.text = "EVERYONE POSE!";
							break;

					}
					break;

				case Prize.Cheese :
					randomNum = Tool.randomRange(0,3);
					switch (randomNum)
					{
						case 0 :
							this.text = "WHO CUT THE CHEESE!?";
							break;
						case 1 :
							this.text = "THIS STINKS!";
							break;
						case 2 :
							this.text = "IF ONLY IT WAS A CHEESE BUN...";
							break;
						case 3 :
							this.text = "PRAISE CHEESUS!";
							break;

					}
					break;

				case Prize.Corn :
					randomNum = Tool.randomRange(0,3);
					switch (randomNum)
					{
						case 0 :
							this.text = "AWW SHUCKS!";
							break;
						case 1 :
							this.text = "I CORN'T BELIEVE ITS NOT A BUN";
							break;
						case 2 :
							this.text = "THAT'S CORN... I WANT BUNS!";
							break;
						case 3 :
							this.text = "CORNY";
							break;

					}
					break;
				case Prize.Beaker :
					randomNum = Tool.randomRange(0,5);
					switch (randomNum)
					{
						case 0 :
							this.text = "SCIENCE BITCH!";
							break;
						case 1 :
							this.text = "OK, WALTER WHITE. THAT'S NOT A BUN!";
							break;
						case 2 :
							this.text = "IS IT A DRINKABLE BUN?";
							break;
						case 3 :
							this.text = "I DON'T THINK I SHOULD DRINK THIS..";
							break;
						case 4 :
							this.text = "I'M FREAKING OUT MAN!!";
							break;
						case 5 :
							this.text = "I'LL TELL YOU WHEN I'VE HAD ENOUGH!";
					}
					break;
				case Prize.Grape :
					randomNum = Tool.randomRange(0,2);
					switch (randomNum)
					{
						case 0 :
							this.text = "GET GRAPED!";
							break;
						case 1 :
							this.text = "JUST GRAPE!";
							break;
						case 2 :
							this.text = "FAR FROM A RAISIN BUN!!";
							break;
					}
					break;
				case Prize.Hair :
					randomNum = Tool.randomRange(0,1);
					switch (randomNum)
					{
						case 0 :
							this.text = "HAVE YOU EVEN SEEN A BUN?!";
							break;
						case 1 :
							this.text = "I'M GONNA WIG OUT!";
							break;
					}
					break;
				case Prize.HotDog :
					randomNum = Tool.randomRange(0,2);
					switch (randomNum)
					{
						case 0 :
							this.text = "HOT DOG!!";
							break;
						case 1 :
							this.text = "IT BELONGS IN A BUN!!";
							break;
						case 2 :
							this.text = "THAT'S A WEINER, DAWG....";
							break;
					}
					break;
				case Prize.Shark :
				case Prize.Cactus :
					randomNum = Tool.randomRange(0,2);
					switch (randomNum)
					{
						case 0 :
							this.text = "OUCH!!";
							break;
						case 1 :
							this.text = "THAT HURTS!!!!!";
							break;
						case 2 :
							this.text = "WHAT A BLOODY MESS!!! AAGGHH!";
							break;
					}
					break;
			}
		}

	}

}