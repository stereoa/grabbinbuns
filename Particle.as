package 
{
	import flash.display.Sprite;

	public class Particle extends Sprite
	{
		public static var Blood:uint = 0;
		public static var Confetti:uint = 1;
		public var particleType:uint;
		public var vx:Number = 0;
		public var vy:Number = 20;

		//confetti based var
		private var xLine:uint;
		private var lineNumber:Number;

		public function Particle(particleType:uint,x:uint,y:uint)
		{
			this.particleType = particleType;
			switch (particleType)
			{
				case Particle.Blood :
					graphics.beginFill(0xFF0000,1);
					graphics.drawCircle(0,0,5);
					graphics.endFill();
					break;
				case Particle.Confetti :
					xLine = x;
					lineNumber = Math.random() * 5;
					graphics.beginFill(Math.random() * 0xFFFFFF,1);
					graphics.drawRect(0,0,5,5);
					graphics.endFill();
					vy = 5;
					break;
			}
			this.x = x;
			this.y = y;
		}

		public function tick()
		{
			switch (particleType)
			{
				case Particle.Blood :
					x +=  vx;
					y +=  vy;
					break;
				case Particle.Confetti :
					lineNumber +=  .1;
					x = xLine + Math.sin(lineNumber) * 20;
					y +=  vy;
					this.rotation+=20;
					break;
			}

		}

	}

}