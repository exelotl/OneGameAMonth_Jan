package entities.slots {
	import comps.SlotControl;
	import net.flashpunk.Entity;
	import net.flashpunk.Signal;
	
	/**
	 * Base class for all upgradable structures.
	 */
	public class Slot extends Entity {
		
		public var
			currentUpgrade:Upgrade,
			onEdit:Signal = new Signal(),
			onRequestUpgrade:Signal = new Signal(),
			health:uint,
			maxHealth:uint;
		
		public function Slot(x:Number = 0, y:Number = 0, health:uint = 0) {
			super(x, y);
			this.health = health;
			this.maxHealth = health;
			layer = Layers.SLOT;
			addComponent("control", new SlotControl());
			type = "ground";
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
		 * Dispatch a request for the current world to replace this slot with a new one.
		 */
		public function requestUpgrade(u:Upgrade):void {
			onRequestUpgrade.dispatch(this, u);
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