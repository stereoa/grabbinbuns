package
{
	public class Tool
	{
		public function Tool()
		{
		}
		public static function randomRange(minNum:Number, maxNum:Number):int
		{
			return (Math.floor(Math.random() * (maxNum - minNum + 1)) + minNum);
		}
		
		public static function rollADie(sides:int):int
		{
			return Tool.randomRange(1,sides);
		}
	}
}