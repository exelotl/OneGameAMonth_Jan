package entities.slots {
	import entities.Archer;
	import net.flashpunk.masks.Hitbox;
	import net.flashpunk.masks.Masklist;

	public class Keep extends Tower {
		
		private static const
			maxArchers:uint = 2,
			maxArchersOnGround:uint = 4;
		private var
			masks:Masklist = new Masklist(),
			amountOfArchers:uint = 0,
			amountOfArchersOnGround:uint = 0;
		
		public function Keep(x:Number = 0, y:Number = 0, health:uint = 0) {
			super(x, y, health);
			currentUpgrade = Upgrade.KEEP;
			//graphic = new Image(IMG_KEEP);
			graphic.y = -200;
			width = 200;
			height = 200;
			type = "tower";
			mask = masks;
			masks.add(new Hitbox(1, 1,61, -162));
			masks.add(new Hitbox(1, 1, 143, -162));
			masks.add(new Hitbox(80, 20, 62, -161));
			masks.add(new Hitbox(200, 20, 0, 0));
		}
		
		override public function update():void {
			super.update();
			if (amountOfArchers < maxArchers) {
				if (Math.random() < 0.001) {
					world.add(new Archer(x + width / 2, y - 221, this));
					amountOfArchers++;
				}
			}
			if (amountOfArchersOnGround < maxArchersOnGround) {
				if (Math.random() < 0.001) {
					world.add(new Archer(x + width / 2, y - 21, this, true));
					amountOfArchersOnGround++;
				}
			}
		}
		
		override public function get upgrades():Array {
			return [];
		}
		
		public function archerIsKilled(onGround:Boolean):void {
			if (onGround) {
				amountOfArchersOnGround--;
			} else {
				amountOfArchers--;
			}
		}
	}
}