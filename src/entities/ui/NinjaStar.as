package entities.ui {
	import comps.Physics;
	import entities.LivingEntity;
	import entities.slots.Slot;
	import net.flashpunk.Entity;
	import net.flashpunk.graphics.Image;
	import net.flashpunk.Tween;
	import net.flashpunk.FP;
	/**
	 * ...
	 * @author Simon Marynissen
	 */
	public class NinjaStar extends Entity {
		
		[Embed(source="../../assets/star.png")]
		private static var IMG_STAR:Class;
		
		private var
			targetTypes:Array,
			inAir:Boolean = true,
			image:Image,
			physics:Physics;
		
		public function NinjaStar(x:Number, y:Number, velX:Number, velY:Number, targetTypes:Array){
			super(x, y);
			setHitbox(4, 4, -2, -2);
			this.targetTypes = targetTypes;
			
			physics = new Physics(EntityTypes.PROJECTILES_SOLIDS);
			physics.sweep = true;
			physics.velX = velX;
			physics.velY = velY;
			physics.accY = 0.2;
			addComponent("physics", physics);
			
			image = new Image(IMG_STAR);
			image.originX = image.originY = 4;
			image.x = image.y = 4
			graphic = image;
			
			type = "ninjastar";
		}
		
		override public function update():void {
			if (inAir) {
				var hitSolid:Entity = collideTypes(EntityTypes.SOLIDS, x, y+2);
				if (hitSolid) {
					if (EntityTypes.ATTACKABLE_SLOTS.indexOf(hitSolid.type) != -1) {
						(hitSolid as Slot).damage(5);
					}
					removeComponent("physics");
					addTween(new Tween(1.5, Tween.ONESHOT, removeSelf), true);
					inAir = false;
				} else {
					image.angle = Math.random() * 360;
					collideEach(targetTypes, x, y, onHit);
					collideEach(targetTypes, x + physics.velX * 0.5, y + physics.velY * 0.5, onHit);
				}
			}
		}
		
		private function onHit(e:Entity):void {
			if (e is LivingEntity) (e as LivingEntity).damage(5, this);
		}
		
		private function removeSelf():void {
			world.remove(this);
		}
	}
}