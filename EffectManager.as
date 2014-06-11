package 
{
	import flash.display.Stage;
	import flash.display.MovieClip;
	import flash.filters.*;
	
	public class EffectManager
	{

		public var freezeTimer:uint;
		private static var freezeMax = 240;
		private var gasTimer:uint;
		private var gasIntensity:Number;
		private var gasDuration:uint;

		private var partyTimer:uint;
		private var partyRandomRGB:Number = new Number(Math.random() * 0xFFFFFF);
		private var partyIntensity:Number = new Number(0);

		private var hurtTimer:uint;
		private var bloodLevel:Number = 0;
		private var flickerWait:int = 0;

		private var fastTimer:uint;
		private var clawBlur:BlurFilter;
		
		private var stageWidth:uint;
		private var stageHeight:uint;
		private var particles:Array = new Array  ;
		
		public function EffectManager(width:uint,height:uint)
		{
			this.stageHeight = height;
			this.stageWidth = width;

		}

		public function tick(daClaw:Claw,prizes:Array,effectLayer:MovieClip)
		{
			effectLayer.graphics.clear();

			if ((hurtTimer > 0))
			{
				hurtTimer--;
				/*if (((hurtTimer % 5) == 0))
				{
				if (daClaw.visible)
				{
				daClaw.visible = false;
				}
				else
				{
				daClaw.visible = true;
				}
				}*/
				var newBlood:Particle = new Particle(Particle.Blood,Tool.randomRange(daClaw.x - 50,daClaw.x + 50),Tool.randomRange(daClaw.y - 50,daClaw.y + 50));
				particles.push(newBlood);
				effectLayer.addChild(newBlood);
			}

			if ((bloodLevel > 0))
			{
				bloodLevel -=  .5;
				effectLayer.graphics.beginFill(0xFF0000,.9);
				effectLayer.graphics.drawRect(0,stageHeight - bloodLevel,stageWidth,stageHeight);
				effectLayer.graphics.endFill();
			}
			if ((fastTimer > 0))
			{
				fastTimer--;
				clawBlur.blurX = daClaw.vx*2000;
				if ((fastTimer == 0))
				{
					daClaw.slowDown();
					daClaw.filters.pop();
				}
			}
			if ((partyTimer > 0))
			{
				//every third frame generate a random color overlay
				partyTimer--;

				if (((partyTimer % 3) == 0))
				{
					partyRandomRGB = Math.random() * 0xFFFFFF;
				}

				for (var i:int = 0; i < 4; i++)
				{
					var newConfetti:Particle = new Particle(Particle.Confetti,Tool.randomRange(0,stageWidth),0);
					particles.push(newConfetti);
					effectLayer.addChild(newConfetti);
				}
				effectLayer.graphics.beginFill(partyRandomRGB,partyIntensity);
				effectLayer.graphics.drawRect(0,0,stageWidth,stageHeight);
				effectLayer.graphics.endFill();
				if ((partyTimer == 0))
				{
					partyIntensity = 0;
				}
			}

			if ((gasTimer > 0))
			{
				gasTimer--;

				gasIntensity = gasTimer / gasDuration;
				effectLayer.graphics.beginFill(0x99CC00,gasIntensity);
				effectLayer.graphics.drawRect(0,0,stageWidth,stageHeight);
				effectLayer.graphics.endFill();
			}
			if ((freezeTimer > 0))
			{
				freezeTimer--;
				if (((freezeMax - freezeTimer) < 20))
				{
					effectLayer.graphics.beginFill(0xFFFFFF,Math.abs(((((freezeMax - freezeTimer) - 20) * -1) / 20)));
					effectLayer.graphics.drawRect(0,0,stageWidth,stageHeight);
					effectLayer.graphics.endFill();

				}
			}
			for each (var particle in particles)
			{
				var needsRemoved:Boolean = false;
				particle.tick();
				if (particle.y > stageHeight)
				{
					needsRemoved = true;
					if (particle.particleType == Particle.Blood)
					{
						bloodLevel++;
					}
				}
				if (needsRemoved)
				{
					effectLayer.removeChild(particle);
					particles.splice(particles.indexOf(particle),1);
				}
			}
		}

		public function startParty()
		{
			partyTimer +=  300;
			partyIntensity +=  .2;
		}

		public function startGas()
		{
			gasTimer = 240;
			gasDuration = 240;
		}

		public function startFreeze()
		{
			freezeTimer = freezeMax;
		}
		public function startHurt()
		{
			hurtTimer = 120;
		}
		public function startFast(daClaw:Claw)
		{
			fastTimer = 100;
			daClaw.speedUp();
			clawBlur = new BlurFilter();
			daClaw.filters = [clawBlur];

		}
	}

}