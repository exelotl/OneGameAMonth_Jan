package entities.slots {
	import net.flashpunk.Entity;
	import net.flashpunk.graphics.Image;
	
	/**
	 * A slot of land, which can be upgraded.
	 */
	public class Land extends Slot {
		
		private var
			image:Image;
		
		public function Land(x:Number = 0, y:Number = 0, health:uint = 0) {
			super(x, y);
			currentUpgrade = Upgrade.LAND;
			image = new Image(Sprites.LAND);
			graphic = image;
			setHitbox(200, 200);
		}
		
		override public function get upgrades():Array {
			return [Upgrade.TOWER, Upgrade.TRAP];
		}
	}
}