package entities.slots {
	import net.flashpunk.graphics.Image;
	
	public class Castle extends Slot {
		
		[Embed(source="../../assets/castle.png")]
		private static const IMG_CASTLE:Class;
		
		public function Castle(x:Number=0, y:Number=0) {
			super(x, y);
			health = maxHealth = 100;
			currentUpgrade = Upgrade.CASTLE;
			graphic = new Image(IMG_CASTLE);
			graphic.y = -200;
			width = 200;
			height = 200;
			name = "castle";
		}
		
	}
}