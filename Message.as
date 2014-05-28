package 
{

	public class Message
	{

		public var lifeSpan:uint = 0;
		public var text:String = "";
		public function Message(lifeSpan:uint,messageType:uint)
		{
			this.lifeSpan = lifeSpan;
			var randomNum:int = Tool.randomRange(0,3);

			switch (messageType)
			{
				case Prize.CinnaBun :
				case Prize.GirlHairBun :
				case Prize.HamBun :
				case Prize.JeanBun :
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


			}
		}

	}

}