package entities.slots {
	import net.flashpunk.graphics.Image;
	
	/**
	 * Non-upgradable slot, used to fill the rest of the world.
	 */
	public class FillerSlot extends Slot {
		
		public function FillerSlot(x:Number, y:Number) {
			super(x, y)
			setHitbox(200, 200);
			graphic = new Image(Sprites.LAND_EMPTY);
		}
		
	}

}