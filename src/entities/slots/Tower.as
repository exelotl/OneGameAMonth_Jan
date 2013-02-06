package entities.slots {
	import entities.Knight;
	import net.flashpunk.graphics.Image;

	public class Tower extends Slot {
		
		protected var
			maxKnights:uint = 4,
			amountOfKnights:uint = 0;
		
		public function Tower(x:Number = 0, y:Number = 0) {
			super(x, y);
			health = maxHealth = 50;
			currentUpgrade = Upgrade.TOWER;
			graphic = new Image(Sprites.TOWER);
			graphic.y = -200;
			width = 200;
			height = 200;
			type = "tower";
		}
		
		override public function update():void {
			super.update();
			if (amountOfKnights < maxKnights) {
				if (Math.random() < 0.002) {
					world.add(new Knight(x + width / 2, y - 21, this));
					amountOfKnights++;
				}
			}
		}
		
		override public function get upgrades():Array {
			return [Upgrade.KEEP, Upgrade.BATTLE_TOWER];
		}
		
		public function knightIsKilled():void {
			amountOfKnights--;
		}
	}
}