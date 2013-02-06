package comps.items {
	import entities.LivingEntity;
	import fp.MultiSpritemap;
	import net.flashpunk.Component;
	import net.flashpunk.graphics.Spritemap;
	
	/**
	 * Note that the entity's graphics component must be set to a
	 * MultiSpritemap for the sword graphics to take effect.
	 */
	public class Sword extends Weapon {
		
		private var
			anim:Spritemap = new Spritemap(Sprites.SWORD, 20, 20);
		
		public function Sword() {
			anim.add("idle_l", [0], 30, false);
			anim.add("idle_r", [4], 30, false);
			anim.add("run_l", [0,1,2,3], 15, true);
			anim.add("run_r", [4,5,6,7], 15, true);
			anim.add("jump_l", [1], 30, false);
			anim.add("jump_r", [5], 30, false);
			anim.add("strike_l", [8,9,10,10,11], 30, false);
			anim.add("strike_r", [12,13,14,14,15], 30, false);
		}
		
		private static var hitEntities:Array = [];
		
		override public function update():void {
			if (entity.flags & Flags.ATTACKING) {
				var offsetX:Number = user.direction=="r" ? 8 : -8;
				entity.collideTypesInto(EntityTypes.ENEMIES, user.x+offsetX, user.y, hitEntities);
				for each (var e:LivingEntity in hitEntities)
					e.damage(10, user);
				
				hitEntities.length = 0;
			}
		}
		
		override public function strike():void {
			if (user.name=="player") {
				Audio.play(Audio.SWIPE, Math.random()*0.4+0.6);
			} else {
				Audio.play(Audio.SWIPE, Math.random()*0.2+0.2);
			}
		}
		
		override public function added():void {
			super.added();
			if (entity.graphic is MultiSpritemap) {
				var sprites:MultiSpritemap = entity.graphic as MultiSpritemap;
				sprites.addBg(anim);
			}
		}
		
		override public function removed():void {
			if (entity.graphic is MultiSpritemap) {
				var sprites:MultiSpritemap = entity.graphic as MultiSpritemap;
				sprites.remove(anim);
			}
		}
	}
}