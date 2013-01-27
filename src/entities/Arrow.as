package entities {
	
	import comps.Physics;
	import flash.display.BitmapData;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	import net.flashpunk.Entity;
	import net.flashpunk.FP;
	import net.flashpunk.graphics.Canvas;
	import net.flashpunk.graphics.Image;
	import net.flashpunk.Tween;
	
	public class Arrow extends Entity {
		
		private var
			targetTypes:Array,
			hasLanded:Boolean = false,
			image:Image,
			physics:Physics;
		
		public function Arrow(x:Number, y:Number, velX:Number, velY:Number, targetTypes:Array) {
			super(x, y);
			setHitbox(6, 6, -1, -1);
			this.targetTypes = targetTypes;
			
			physics = new Physics(EntityTypes.SOLIDS);
			physics.velX = velX;
			physics.velY = velY;
			physics.accY = 0.5;
			addComponent("physics", physics);
			
			image = new Image(new BitmapData(1,8,false,0xff221100));
			image.centerOrigin();
			image.y += 4;
			graphic = image;
			
			type = "arrow";
		}
		
		override public function update():void {
			if (!hasLanded) {
				if (collideTypes(EntityTypes.SOLIDS, x, y+2)) {
					removeComponent("physics");
					addTween(new Tween(2, Tween.ONESHOT, removeSelf), true);
					hasLanded = true;
				} else {
					var hyp:Number = Math.sqrt(physics.velX*physics.velX + physics.velY*physics.velY);
					image.angle = FP.DEG * Math.acos(physics.velY/hyp);
					collideEach(targetTypes, x, y, onHit);
				}
			}
		}
		
		private function onHit(e:Entity):void {
			if (e is LivingEntity)
				(e as LivingEntity).damage(20, this);
		}
		
		private function removeSelf():void {
			world.remove(this);
		}
		
	}

}