package entities {
	import flash.display.BitmapData;
	import net.flashpunk.Entity;
	import net.flashpunk.graphics.Image;

	public class FireParticle extends Entity {
		
		private static var bitmap:BitmapData = new BitmapData(2, 2, false, 0xffff5500);
		
		public function FireParticle(x:Number, y:Number) {
			super(x, y, new Image(bitmap));
		}
		
		override public function update():void {
			x += Math.random() * 4 - 2;
			y += Math.random() * 4 - 2;
			if (Math.random() < 0.05)
				world.remove(this);
		}
	}

}