package entities 
{
	import net.flashpunk.FP;
	import net.flashpunk.graphics.Image;
	import net.flashpunk.graphics.Spritemap;
	/**
	 * ...
	 * @author Allyally
	 */
	public class Parachuter extends Enemy
	{
		[Embed(source = "../assets/parachuter_zombie.png")]
		private var IMG_PARACHUTE:Class;
		
		private var img:Image;
		
		public function Parachuter(x:Number = 0, y:Number = 0) 
		{
			super(x, y);
			
			img = new Image(IMG_PARACHUTE);
			graphic = img;
			
			physics.maxVelX = 0.5;
			physics.maxVelY = 1;
			physics.accX = FP.sign(Math.random() - 0.5) / 2;
			price = 10;
			if (FP.sign(physics.accX) == 1) img.flipped  = true;
			
			setHitbox(20, 30);
		}
		
		override public function update():void 
		{
			super.update();
			
			if (isOnFloor)
			{
				world.remove(this);
				world.add(new Zombie(x,y));
			}
		}
	}

}