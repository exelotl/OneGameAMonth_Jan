package entities.slots {
	import entities.Knight;
	import net.flashpunk.graphics.Image;

	public class Tower extends Slot {
		
		[Embed(source="../../assets/tower.png")]
		private static const IMG_TOWER:Class;
		
		public function Tower(x:Number = 0, y:Number = 0, health:uint = 0) {
			super(x, y, health);
			currentUpgrade = Upgrade.TOWER;
			graphic = new Image(IMG_TOWER);
			graphic.y = -200;
			width = 200;
			height = 200;
		}
		
		override public function update():void {
			super.update();
			if (Math.random() < 0.001) {
				world.add(new Knight(x+width/2, y-21));
			}
		}
		
	}
}