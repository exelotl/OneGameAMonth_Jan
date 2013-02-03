package entities.slots {
	import entities.Knight;
	import net.flashpunk.graphics.Image;

	public class Tower extends Slot {
		
		[Embed(source="../../assets/tower.png")]
		private static const IMG_TOWER:Class;
		
		protected var
			maxKnights:uint = 5,
			amountOfKnights:uint = 0;
		
		public function Tower(x:Number = 0, y:Number = 0) {
			super(x, y);
			health = maxHealth = 100;
			currentUpgrade = Upgrade.TOWER;
			graphic = new Image(IMG_TOWER);
			graphic.y = -200;
			width = 200;
			height = 200;
			type = "tower";
		}
		
		override public function update():void {
			if (amountOfKnights < maxKnights) {
				if (Math.random() < 0.001) {
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