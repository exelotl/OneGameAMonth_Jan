package entities.slots {
	import entities.ProKnight;
	import net.flashpunk.graphics.Image;
	
	public class BattleTower extends Tower {
		
		[Embed(source="../../assets/battle_tower.png")]
		private static const IMG_BATTLE_TOWER:Class;
		
		private var
			maxProKnights:int = 5,
			amountOfProKnights:int = 0;
		
		public function BattleTower(x:Number=0, y:Number=0) {
			super(x, y);
			maxKnights = 2;
			health = maxHealth = 100;
			currentUpgrade = Upgrade.BATTLE_TOWER;
			var image:Image = new Image(IMG_BATTLE_TOWER);
			image.y = -200;
			graphic = image;
			type = "battle tower";
		}
		
		override public function update():void {
			if (amountOfKnights < maxKnights) {
				if (Math.random() < 0.001) {
					world.add(new ProKnight(x + width / 2, y - 21, this));
					amountOfKnights++;
				}
			}
		}
		
		override public function get upgrades():Array {
			return [];
		}
		
		override public function knightIsKilled():void {
			amountOfProKnights--;
		}
		
	}

}