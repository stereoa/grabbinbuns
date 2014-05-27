package 
{
	import flash.display.Bitmap;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.*;
	import flash.utils.getDefinitionByName;
	import flash.text.*;

	public class GrabbinBuns extends MovieClip
	{
		[Embed('/Images/GirlHairBun.png')]
		var GirlHairBun:Class;
		[Embed('/Images/JeanBun.png')]
		var JeanBun:Class;
		[Embed('/Images/CinnaBun.png')]
		var CinnaBun:Class;
		[Embed('/Images/HamBun.png')]
		var HamBun:Class;

		[Embed('/Images/Beaker.png')]
		var Beaker:Class;
		[Embed('/Images/BowlerHat.png')]
		var BowlerHat:Class;
		[Embed('/Images/CameraImg.png')]
		var CameraImg:Class;
		[Embed('/Images/Cheese.png')]
		var Cheese:Class;
		[Embed('/Images/Corn.png')]
		var Corn:Class;
		[Embed('/Images/Grape.png')]
		var Grape:Class;
		[Embed('/Images/Hair.png')]
		var Hair:Class;
		[Embed('/Images/HotDog.png')]
		var HotDog:Class;
		[Embed('/Images/PartyHat.png')]
		var PartyHat:Class;
		[Embed('/Images/Shark.png')]
		var Shark:Class;
		[Embed('/Images/Sunglasses.png')]
		var Sunglasses:Class;
		[Embed('/Images/Vest.png')]
		var Vest:Class;

		public var images:Array = new Array(CinnaBun,GirlHairBun,HamBun,JeanBun,Beaker,BowlerHat,CameraImg,Cheese,Corn,Grape,Hair,HotDog,PartyHat,Shark,Sunglasses,Vest);
		public var prizes:Array = new Array();
		public var score:int;
		public var partyTime:Boolean;
		public var daClaw:Claw;
		private var scoreTextField:TextField = new TextField();
		private var messageTextField:TextField = new TextField();
		private var entityLayer:MovieClip = new MovieClip();
		private var effectLayer:MovieClip = new MovieClip();
		private var freezeTimer:uint;
		private var messageTimer:uint;
		private var partyTimer:uint;
		private var partyIntenisty:Number = new Number(.2);
		public function GrabbinBuns()
		{
			stage.addEventListener(MouseEvent.MOUSE_DOWN, startGame);
		}

		public function startGame(e:MouseEvent)
		{
			stage.removeEventListener(MouseEvent.MOUSE_DOWN, startGame);
			TitleScreen.visible = false;
			//for holding all the entities on screen
			stage.addChild(entityLayer);

			//for drawing effects on stage
			stage.addChild(effectLayer);

			//spawn starting set
			spawnNewItems(10);

			//add the claw
			stage.addEventListener(MouseEvent.MOUSE_DOWN, handleClick);
			daClaw = new Claw();
			daClaw.x = stage.mouseX;
			daClaw.y = 250;
			entityLayer.addChild(daClaw);

			//reset score;
			score = 0;

			//prep font
			var brainFlowerFont = new BrainFlower();
			var brainFlowerFormat = new TextFormat();
			brainFlowerFormat.font = brainFlowerFont.fontName;
			brainFlowerFormat.size = 30;

			//create score field
			scoreTextField.defaultTextFormat = brainFlowerFormat;
			scoreTextField.text = "Score: " + score.toString();
			scoreTextField.x = 0;
			scoreTextField.y = 0;
			stage.addChild(scoreTextField);

			//create message field
			brainFlowerFormat.size = 72;
			messageTextField.defaultTextFormat = brainFlowerFormat;
			messageTextField.x = stage.stageWidth / 2;
			messageTextField.y = stage.stageHeight / 2;
			messageTextField.multiline = true;
			stage.addChild(messageTextField);

			//add main frame update
			stage.addEventListener(Event.ENTER_FRAME, update);
		}
		public function update(e:Event)
		{
			//handle the claw if needed
			if (daClaw.clawState == Claw.AT_BOTTOM)
			{
				checkClaw();
			}
			//spawn new items if needed
			if (prizes.length < 10)
			{
				spawnNewItems(Tool.randomRange(1,5));
			}
			//tick the player
			daClaw.tick();

			//tick all prizes
			if (freezeTimer >0)
			{
				freezeTimer--;
			}
			else
			{
				for each (var prize in prizes)
				{
					prize.tick();
				}

			}//handle special events
			//party mode
			if (partyTime)
			{
				doParty();
			}
			//displaying messages
			if (messageTimer>0)
			{
				messageTimer--;
				messageTextField.x = stage.stageWidth / 2 - messageTextField.width / 2 + Tool.randomRange(-2,2);
				messageTextField.y = stage.stageHeight / 2 - messageTextField.height / 2 + Tool.randomRange(-2,2);
			}
			else
			{
				messageTextField.visible = false;
			}
		}

		public function doParty()
		{
			//every third frame generate a random color overlay
			effectLayer.graphics.clear();
			partyTimer--;
			if (partyTimer>0)
			{
				if (partyTimer%3==0)
				{
					effectLayer.graphics.beginFill(Math.random() * 0xFFFFFF, .5);
					effectLayer.graphics.drawRect(0,0,stage.stageWidth,stage.stageHeight);
					effectLayer.graphics.endFill();

				}
			}
			else
			{
				partyTime = false;
			}
		}

		public function spawnNewItems(amount:int)
		{
			var bunsPresent:Boolean = false;
			for each (var prize in prizes)
			{
				if (prize.prizeType == "Bun")
				{
					bunsPresent = true;
					break;
				}
			}
			for (var i = 0; i < amount; i++)
			{
				var randomNum:int;
				if (bunsPresent)
				{
					randomNum = Tool.randomRange(0,images.length - 1);
				}
				else
				{
					randomNum = Tool.randomRange(0,Prize.BunsMaxIndex);

				}

				var bmp:Bitmap = new images[randomNum]();
				var newItem:Prize = new Prize(bmp,randomNum);
				prizes.push(newItem);
				entityLayer.addChild(newItem);

				newItem.x = Tool.randomRange(0,stage.stageWidth);
				newItem.y = stage.stageHeight - newItem.height;

			}

		}

		public function handleClick(e:Event)
		{
			daClaw.drop();
		}

		public function checkClaw()
		{
			if (daClaw.clawState == Claw.AT_BOTTOM)
			{
				for (var i:int = 0; i<prizes.length; i++)
				{
					var prizeToCheck:Prize = prizes[i];
					if (Math.abs(prizeToCheck.x + prizeToCheck.width / 2 - daClaw.x) < 50)
					{
						entityLayer.removeChild(prizeToCheck);
						daClaw.addChild(prizeToCheck);
						prizeToCheck.x = (prizeToCheck.width/2) * -1;
						prizeToCheck.y = 0;
						prizeToCheck.beingLifted = true;
						daClaw.clawState = Claw.RISING;
						daClaw.hasItem = true;
						daClaw.prizeCarrying = prizeToCheck;
						prizes.splice(prizes.indexOf(prizeToCheck),1);
						switch (daClaw.prizeCarrying.prizeType)
						{
								//buns
							case Prize.CinnaBun :
							case Prize.GirlHairBun :
							case Prize.HamBun :
							case Prize.JeanBun :
								setScore(50);
								break;
							case Prize.PartyHat :
								startParty(120);
								break;
							case Prize.BowlerHat :
								break;
							case Prize.CameraImg :
								freezeTimer = 120;
								break;
								//cover screen with gas
							case Prize.Cheese :
							case Prize.Corn :
							default :
							setScore(-10);
						}

						currentMessage = new Message(60,daClaw.prizeCarrying);
						break;


					}
				}
				daClaw.clawState = Claw.RISING;
			}
		}

		public function gameOver()
		{

		}

		public function startParty(frames:uint)
		{
			partyTime = true;
			partyTimer +=  frames;
			var messageText:String;
			var randomNum = Tool.randomRange(0,3);
		}

		public function setScore(amount:int)
		{
			score +=  amount;
			scoreTextField.text = "Score: " + score.toString();
		}
	}
}