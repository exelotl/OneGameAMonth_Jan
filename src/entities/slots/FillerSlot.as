package entities.slots {
	import net.flashpunk.graphics.Image;
	
	/**
	 * Non-upgradable slot, used to fill the rest of the world.
	 */
	public class FillerSlot extends Slot {
		
		[Embed(source="../../assets/land_empty.png")]
		private static const IMG_LAND_EMPTY:Class;
		
		public function FillerSlot(x:Number, y:Number) {
			super(x, y)
			setHitbox(200, 200);
			graphic = new Image(IMG_LAND_EMPTY);
			type = "ground";
		}
		
	}

}