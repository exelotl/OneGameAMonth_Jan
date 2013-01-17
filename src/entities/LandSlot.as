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
			image:Image;
		
		public function LandSlot() {
			image = new Image(IMG_LAND_SLOT);
			graphic = image;
			setHitbox(80, 40);
		}
		
	}
}