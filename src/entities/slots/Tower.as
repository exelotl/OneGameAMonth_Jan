package entities.slots {
	import net.flashpunk.graphics.Image;

	public class Tower extends Slot {
		
		[Embed(source="../../assets/tower.png")]
		private static const IMG_TOWER:Class;
		
		public function Tower(x:Number = 0, y:Number = 0, health:uint = 0) {
			super(x, y, health);
			graphic = new Image(IMG_TOWER);
			graphic.y = -200;
			width = 200;
			height = 200;
			type = "ground";
		}
		
	}
}