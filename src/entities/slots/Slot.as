package entities.slots {
	import comps.input.SlotInput;
	import entities.ui.SlotHealthBar;
	import flash.display.BlendMode;
	import net.flashpunk.Entity;
	import net.flashpunk.graphics.Image;
	import net.flashpunk.Signal;
	import net.flashpunk.tweens.misc.NumTween;
	import net.flashpunk.utils.Ease;
	
	/**
	 * Base class for all upgradable structures.
	 */
	public class Slot extends Entity {
		
		public var
			currentUpgrade:Upgrade,
			onEdit:Signal = new Signal(),
			onRequestUpgrade:Signal = new Signal(),
			health:uint = 0,
			maxHealth:uint = 0;
			
		protected var
			flashTween:NumTween,
			healthBar:SlotHealthBar;
		
		public function Slot(x:Number = 0, y:Number = 0) {
			super(x, y);
			layer = Layers.SLOT;
			addComponent("control", new SlotInput());
			type = "ground";
			
			addTween(flashTween = new NumTween());
		}
		
		override public function added():void {
			if (maxHealth > 0) {
				healthBar = new SlotHealthBar(this);
				world.add(healthBar);
			}
		}
		
		override public function removed():void {
			if (healthBar) {
				world.remove(healthBar);
				healthBar = null;
			}
		}
		
		override public function update():void {
			if (graphic is Image) {
				(graphic as Image).tintMode = Image.TINTING_COLORIZE;
				(graphic as Image).tinting = flashTween.value;
			}
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
			flashTween.tween(0.7, 0.0, 1, Ease.expoOut);
			if (health <= 0)
				requestUpgrade(Upgrade.DESTROY);
		}
		
		public function repair(repair:uint):void {
			health += repair;
			if (health > maxHealth) health = maxHealth;
		}
		
	}

}