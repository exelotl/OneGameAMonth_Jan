package entities.slots {
	import entities.Archer;

	public class Keep extends Tower {
		
		public function Keep(x:Number = 0, y:Number = 0, health:uint = 0) {
			super(x, y, health);
			currentUpgrade = Upgrade.KEEP;
			//graphic = new Image(IMG_KEEP);
			graphic.y = -200;
			width = 200;
			height = 200;
		}
		
		override public function update():void {
			super.update();
			if (Math.random() < 0.0005) {
				world.add(new Archer(x+width/2, y-221));
			}
		}
	}
}