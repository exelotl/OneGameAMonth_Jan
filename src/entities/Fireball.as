package entities {
	import comps.Physics;
	import net.flashpunk.Entity;
	import net.flashpunk.Graphic;
	import net.flashpunk.graphics.Spritemap;
	import net.flashpunk.Mask;
	
	public class Fireball extends Entity {
		
		[Embed(source="../assets/fireball.png")]
		private static const IMG_FIREBALL:Class;
		
		private var
			numBounces:Number = 0,
			anim:Spritemap = new Spritemap(IMG_FIREBALL, 8, 8),
			physics:Physics = new Physics(EntityTypes.SOLIDS);
		
		public function Fireball(x:Number, y:Number, velX:Number, velY:Number) {
			super(x, y, anim);
			layer = Layers.PROJECTILES;
			anim.add("a", [0,1,2], 15, true);
			anim.play("a");
			
			addComponent("physics", physics);
			physics.velX = velX;
			physics.velY = velY;
			physics.accY = Math.random()*0.5 + 0.3;
			physics.bounce = 5 + Math.random() * 2;
			setHitbox(10, 12, -2, 4);
		}
		
		override public function update():void {
			if (Math.random() < 0.2)
				world.add(new FireParticle(x, y));
			
			var e:Entity = collideTypes(EntityTypes.FRIENDLY, x, y);
			if (e is LivingEntity) {
				(e as LivingEntity).damage(30, this);
				explode();
			}
		}
		
		private function explode():void {
			world.remove(this);
			var e:Explosion = new Explosion(x, y, 40, 0.5, 4);
			e.damages = EntityTypes.FRIENDLY;
			world.add(e);
		}
		
		override public function moveCollideY(e:Entity):Boolean {
			if (++numBounces >= 10)
				explode();
			return true;
		}
		
	}

}
