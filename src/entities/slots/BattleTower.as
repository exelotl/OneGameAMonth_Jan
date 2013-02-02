package entities.slots {
	import entities.ProKnight;
	/**
	 * ...
	 * @author geckojsc
	 */
	public class BattleTower extends Tower {
		
		public function BattleTower(x:Number=0, y:Number=0) {
			super(x, y);
			health = maxHealth = 100;
			currentUpgrade = Upgrade.BATTLE_TOWER;
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
		
	}

}