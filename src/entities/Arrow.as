package entities {
	
	import comps.Physics;
	import flash.display.BitmapData;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	import net.flashpunk.Entity;
	import net.flashpunk.FP;
	import net.flashpunk.graphics.Canvas;
	import net.flashpunk.graphics.Image;
	
	public class Arrow extends Entity {
		
		private var
			image:Image,
			physics:Physics;
		
		//public static function getXYVel(x:Number, y:Number, targetX:Number, targetY:Number):Point {
			//var p:Point = new Point();
			//var aX:Number=0, aY:Number=0;
			//
			//if (targetY <= y) {
				//while (
				//while (true) {
					//aX = x; aY = y;
					//if (aY < targetY) {
						//if (
					//}
				//}
			//} else {
				//
			//}
			//
			//return p;
		//}
		
		public function Arrow(x:Number, y:Number, velX:Number, velY:Number) {
			super(x, y);
			setHitbox(6, 6, -1, -1);
			
			physics = new Physics();
			physics.velX = velY;
			physics.velY = velY;
			physics.accY = 0.5;
			addComponent("physics", physics);
			
			image = new Image(new BitmapData(1,8,false,0xff000000));
			graphic = image;
		}
		
		override public function update():void {
			image.angle = FP.DEG * Math.atan(physics.velX/physics.velY);
		}
		
		
	}

}