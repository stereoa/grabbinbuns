//TODO
/*Particles
Blood
Confetti
Blood level effect
Camera flash effect
Sound
Music
Hot cross buns remix?
Effects
Use prizeType to play corresponding sound.
Game over screen
Timer
Party mode OD
If catch things reveal what you caught and apply bonus points
*/



package 
{
	import flash.display.Bitmap;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.*;
	import flash.text.*;
	import fl.motion.Color;

	public class GrabbinBuns extends MovieClip
	{
		//IMAGES
		[Embed('/Images/GirlHairBun.png')]
		var GirlHairBun:Class;
		[Embed('/Images/JeanBun.png')]
		var JeanBun:Class;
		[Embed('/Images/CinnaBun.png')]
		var CinnaBun:Class;
		[Embed('/Images/HamBun.png')]
		var HamBun:Class;
		[Embed('/Images/BunB.png')]
		var BunB:Class;

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
		[Embed('/Images/Cactus.png')]
		var Cactus:Class;

		public var images:Array = new Array(CinnaBun,GirlHairBun,HamBun,JeanBun,BunB,Beaker,BowlerHat,CameraImg,Cheese,Corn,Grape,Hair,HotDog,PartyHat,Shark,Sunglasses,Vest,Cactus);
		public var prizes:Array = new Array  ;
		public var soundManager:SoundManager = new SoundManager  ;
		public var effectManager:EffectManager = new EffectManager(stage.stageWidth,stage.stageHeight);
		public var score:int;
		public var daClaw:Claw;
		private var scoreTextField:TextField = new TextField  ;
		private var messageTextField:TextField = new TextField  ;
		private var entityLayer:MovieClip = new MovieClip  ;
		private var effectLayer:MovieClip = new MovieClip  ;
		private var messageTimer:uint;

		public function GrabbinBuns()
		{
			stage.addEventListener(MouseEvent.MOUSE_DOWN,startGame);
		}

		public function startGame(e:MouseEvent)
		{
			stage.removeEventListener(MouseEvent.MOUSE_DOWN,startGame);
			TitleScreen.visible = false;
			//for holding all the entities on screen
			stage.addChild(entityLayer);

			//for drawing effects on stage
			stage.addChild(effectLayer);

			//add the claw
			stage.addEventListener(MouseEvent.MOUSE_DOWN,handleClick);
			daClaw = new Claw  ;
			daClaw.x = stage.mouseX;
			daClaw.y = 250;
			entityLayer.addChild(daClaw);

			//reset score;
			score = 0;

			//prep font
			var brainFlowerFont = new BrainFlower  ;
			var brainFlowerFormat = new TextFormat  ;
			brainFlowerFormat.font = brainFlowerFont.fontName;
			brainFlowerFormat.bold = true;
			brainFlowerFormat.color = 0xFFFFFF;
			brainFlowerFormat.size = 48;

			//create score field
			scoreTextField.defaultTextFormat = brainFlowerFormat;
			scoreTextField.selectable = false;
			scoreTextField.text = "Score: " + score.toString();
			scoreTextField.x = 0;
			scoreTextField.y = 0;
			stage.addChild(scoreTextField);

			//create message field
			brainFlowerFormat.size = 72;
			messageTextField.defaultTextFormat = brainFlowerFormat;
			messageTextField.selectable = false;
			messageTextField.x = stage.stageWidth / 2;
			messageTextField.y = stage.stageHeight / 2;
			messageTextField.multiline = true;
			stage.addChild(messageTextField);

			//add main frame update
			stage.addEventListener(Event.ENTER_FRAME,update);
		}
		public function update(e:Event)
		{
			//handle the claw if needed
			if (daClaw.clawState == Claw.AT_BOTTOM)
			{
				checkClaw();
			}
			//spawn new items if needed
			if (prizes.length < 5)
			{
				spawnNewItems(Tool.randomRange(1,3));
			}
			//tick the player
			daClaw.tick();

			//tick all prizes
			if (effectManager.freezeTimer == 0)
			{
				for each (var prize in prizes)
				{
					prize.tick();
				}

			}

			//do effects
			effectManager.tick(daClaw,prizes,effectLayer);

			//displaying messages;
			if ((messageTimer > 0))
			{
				messageTimer--;
				//shake effect
				messageTextField.x = stage.stageWidth / 2 - messageTextField.width / 2 + Tool.randomRange(-2,2);
				messageTextField.y = stage.stageHeight / 2 - messageTextField.height / 2 + Tool.randomRange(-2,2);
			}
			else
			{
				messageTextField.visible = false;
			}
		}



		public function spawnNewItems(amount:uint)
		{
			var bunsPresent:Boolean = false;
			for each (var prize in prizes)
			{
				if (prize.prizeType <= Prize.BunsMaxIndex)
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
					if ((randomNum == 4))
					{
						randomNum = Tool.randomRange(0,Prize.BunsMaxIndex);
					}
				}
				else
				{
					randomNum = Tool.randomRange(0,Prize.BunsMaxIndex);

				}
				//randomNum = Prize.Cactus;
				var bmp:Bitmap = new images[randomNum  ];
				var newItem:Prize = new Prize(bmp,randomNum);
				prizes.push(newItem);
				entityLayer.addChild(newItem);
				newItem.x = Tool.randomRange(0,stage.stageWidth);
				newItem.y = stage.stageHeight - newItem.height;

			}

		}

		public function spawnSpecificItems(type:uint,amount:uint)
		{
			for (var i = 0; i < amount; i++)
			{
				var bmp:Bitmap = new images[type  ];
				var newItem:Prize = new Prize(bmp,type);
				prizes.push(newItem);
				entityLayer.addChild(newItem);

				newItem.x = Tool.randomRange(0,stage.stageWidth);
				newItem.y = stage.stageHeight - newItem.height;
			}

		}

		public function handleClick(e:Event)
		{
			daClaw.drop();
			soundManager.playSound(Sounds.Claws);
		}

		public function checkClaw()
		{
			if (daClaw.clawState == Claw.AT_BOTTOM)
			{
				for (var i:int = 0; i < prizes.length; i++)
				{
					var prizeToCheck:Prize = prizes[i];
					if (Math.abs(prizeToCheck.x + prizeToCheck.width / 2 - daClaw.x) < 50)
					{
						entityLayer.removeChild(prizeToCheck);
						daClaw.addChild(prizeToCheck);
						prizeToCheck.x = prizeToCheck.width / 2 * -1;
						prizeToCheck.y = 0;
						prizeToCheck.beingLifted = true;

						daClaw.grab(prizeToCheck);
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
							case Prize.BunB :
								setScore(500);
								break;
							case Prize.PartyHat :
								effectManager.startParty();
								spawnSpecificItems(Prize.PartyHat,1);

								break;
							case Prize.Cactus :
							case Prize.Shark :
								effectManager.startHurt();
								break;
							case Prize.CameraImg :
								effectManager.startFreeze();
								break;
							case Prize.Cheese :
								effectManager.startGas();
							case Prize.Corn :
								break;
							case Prize.Beaker :
								effectManager.startFast(daClaw);
								break;
							default :
								setScore(-10);
						}
						var messageToDisplay = new Message(60,daClaw.prizeCarrying.prizeType);
						displayMessage(messageToDisplay);
						break;


					}
				}
				daClaw.clawState = Claw.RISING;
			}
		}

		public function gameOver()
		{

		}


		public function displayMessage(messageToDisplay:Message)
		{
			messageTimer = messageToDisplay.lifeSpan;
			messageTextField.text = messageToDisplay.text;
			messageTextField.visible = true;
			messageTextField.height = messageTextField.textHeight;
			messageTextField.width = messageTextField.textWidth;
		}
		public function setScore(amount:int)
		{
			score +=  amount;
			scoreTextField.text = "Score: " + score.toString();
			scoreTextField.width = scoreTextField.textWidth;
		}
	}
}