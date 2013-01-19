package entities.slots {
	import net.flashpunk.Entity;
	
	/**
	 * Base class for all upgradable structures.
	 */
	public class Slot extends Entity {
		
		public var
			health:uint,
			maxHealth:uint;
		
		public function Slot(x:Number = 0, y:Number = 0, health:uint = 0) {
			super(x, y);
			this.health = health;
			this.maxHealth = health;
			layer = Layers.SLOT;
		}
		
		/**
		 * Called when this slot is an upgrade from another slot.
		 * Override if needed.
		 */
		public function inherit(parent:Slot):void {
			x = parent.x;
			y = parent.y;
		}
		
		/**
		 * @return Array of all possible upgrades for this type.
		 */
		public function get upgrades():Array {
			return [];
		}
		
		/**
		 * @return a new slot, based on the given upgrade.
		 */
		public function upgrade(u:Upgrade):Slot {
			return Upgrade.createSlot(this, u);
		}
		
		public function damage(damage:uint):void {
			health -= damage;
		}
		
		public function repair(repair:uint):void {
			health += repair;
			if (health > maxHealth) health = maxHealth;
		}
		
	}

}