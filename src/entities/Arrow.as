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
			inAir:Boolean = true,
			image:Image,
			physics:Physics;
		
		public function Arrow(x:Number, y:Number, velX:Number, velY:Number, targetTypes:Array) {
			super(x, y);
			setHitbox(8, 6, -4, 0);
			this.targetTypes = targetTypes;
			
			physics = new Physics(EntityTypes.PROJECTILES_SOLIDS);
			physics.sweep = true;
			physics.velX = velX;
			physics.velY = velY;
			physics.accY = 0.5;
			addComponent("physics", physics);
			
			image = new Image(new BitmapData(1,8,false,0xff221100));
			image.y = 3;
			graphic = image;
			
			type = "arrow";
			layer = Layers.PROJECTILES;
		}
		
		override public function update():void {
			if (inAir) {
				if (collideTypes(EntityTypes.SOLIDS, x, y+2)) {
					removeComponent("physics");
					addTween(new Tween(2, Tween.ONESHOT, removeSelf), true);
					inAir = false;
				} else {
					image.angle = 90 + FP.DEG * Math.atan2(physics.velY, physics.velX);
					collideEach(targetTypes, x, y, onHit);
					collideEach(targetTypes, x+physics.velX*0.5, y+physics.velY*0.5, onHit);
				}
			}
		}
		
		private function onHit(e:Entity):void {
			if (e is LivingEntity)
				(e as LivingEntity).damage(15, this);
		}
		
		private function removeSelf():void {
			world.remove(this);
		}
		
	}

}