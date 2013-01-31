package entities.slots {
	import entities.Archer;
	import net.flashpunk.masks.Hitbox;
	import net.flashpunk.masks.Masklist;

	public class Keep extends Tower {
		
		private var
			masks:Masklist = new Masklist()
		
		public function Keep(x:Number = 0, y:Number = 0, health:uint = 0) {
			super(x, y, health);
			currentUpgrade = Upgrade.KEEP;
			//graphic = new Image(IMG_KEEP);
			graphic.y = -200;
			width = 200;
			height = 200;
			mask = masks;
			masks.add(new Hitbox(1, 1,61, -162));
			masks.add(new Hitbox(1, 1, 143, -162));
			masks.add(new Hitbox(80, 20, 62, -161));
			masks.add(new Hitbox(200, 20, 0, 0));
			type = "tower";
		}
		
		override public function update():void {
			super.update();
			if (Math.random() < 0.001) {
				world.add(new Archer(x+width/2, y-221));
			}
		}
		
		override public function get upgrades():Array {
			return [];
		}
	}
}