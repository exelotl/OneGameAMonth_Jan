package entities.slots {
	import net.flashpunk.graphics.Image;
	
	public class Castle extends Slot {
		
		public function Castle(x:Number=0, y:Number=0) {
			super(x, y);
			health = maxHealth = 100;
			currentUpgrade = Upgrade.CASTLE;
			graphic = new Image(Sprites.CASTLE);
			graphic.y = -200;
			width = 200;
			height = 200;
			name = "castle";
			type = "castle";
		}
		
	}
}