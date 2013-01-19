package entities.slots {
	import net.flashpunk.Entity;
	import net.flashpunk.graphics.Image;
	
	/**
	 * A slot of land, which can be upgraded.
	 */
	public class Land extends Slot {
		
		[Embed(source="../../assets/land.png")]
		private static const IMG_LAND_SLOT:Class;
		
		private var
			image:Image;
		
		public function Land(x:Number = 0, y:Number = 0, health:uint = 0) {
			super(x, y);
			image = new Image(IMG_LAND_SLOT);
			graphic = image;
			setHitbox(200, 200);
			type = "ground";
		}
		
		override public function get upgrades():Array {
			return [Upgrade.TOWER];
		}
	}
}