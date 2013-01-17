package entities {
	import net.flashpunk.Entity;
	import net.flashpunk.graphics.Image;
	
	/**
	 * A slot of land, which can be upgraded.
	 */
	public class LandSlot extends Entity {
		
		[Embed(source="../assets/land_slot.png")]
		private static const IMG_LAND_SLOT:Class;
		
		private var
			image:Image,
			health:uint,
			maxHealth:uint;
		
		public function LandSlot(x:Number = 0, y:Number = 0, health:uint = 0) {
			super(x, y);
			this.health = health;
			this.maxHealth = health;
			image = new Image(IMG_LAND_SLOT);
			graphic = image;
			setHitbox(80, 40);
		}
		
		public function damage(damage:uint)uint {
			health -= damage;
			return health;
		}
		
		public function repair(repair:uint):uint {
			health += repair;
			if (health > maxHealth) health = maxHealth;
			return health;
		}
		
		public function upgrade():void { }
	}
}