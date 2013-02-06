package entities {
	import net.flashpunk.FP;
	import net.flashpunk.graphics.Image;
	import net.flashpunk.graphics.Spritemap;
	
	public class Parachuter extends LivingEntity {
		
		private var img:Image = new Image(Sprites.PARACHUTER_ZOMBIE);
		
		public function Parachuter(x:Number = 0, y:Number = 0) {
			super(x, y);
			setHitbox(10, 20, -10, -8);
			health = maxHealth = 20;
			type = "parachuter";
			graphic = img;
			
			physics.maxVelX = 0.5;
			physics.maxVelY = 1;
			physics.accX = FP.sign(Math.random() - 0.5) / 2;
			price = 10;
			if (FP.sign(physics.accX) == 1) img.flipped  = true;
		}
		
		override public function update():void {
			super.update();
			
			if (isOnFloor) {
				var zombie:Zombie = new Zombie(x, y+6);
				zombie.health = this.health;
				zombie.maxHealth = this.maxHealth;
				world.remove(this);
				world.add(zombie);
			}
		}
	}

}