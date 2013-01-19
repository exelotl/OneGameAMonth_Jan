package entities {
	import flash.geom.Rectangle;
	import net.flashpunk.Entity;
	import net.flashpunk.graphics.Canvas;

	public class Ground extends Entity {
		
		public function Ground(x:Number = 0, y:Number = 0) {
			super(x, y);
			width = 20;
			height = 20;
			type = "ground";
			
			var canvas:Canvas = new Canvas(20, 20);
			canvas.fill(new Rectangle(0,0,width,height), 0xbada55);
			graphic = canvas;
		}
	}
}