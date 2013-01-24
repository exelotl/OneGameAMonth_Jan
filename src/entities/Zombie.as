package entities {
	import fp.MultiSpritemap;
	import net.flashpunk.graphics.Spritemap;
	
	/**
	 * braaaaaaaains
	 */
	public class Zombie extends LivingEntity {
		
		[Embed(source="../assets/zombie.png")]
		private static const IMG_ZOMBIE:Class;
		
		private var
			sprites:MultiSpritemap = new MultiSpritemap(),
			anim:Spritemap = new Spritemap(IMG_ZOMBIE, 20, 20);
		
		public function Zombie() {
			setHitbox(20, 20);
			health = maxHealth = 20;
			physics.maxVelX = 0.8;
			
			anim.add("idle_l", [0], 30, false);
			anim.add("idle_r", [4], 30, false);
			anim.add("run_l", [0,1,2,3], 5, true);
			anim.add("run_r", [4,5,6,7], 5, true);
			sprites.addMid(anim);
			graphic = sprites;
			
			type = "zombie";
		}
		
		override public function added():void {
			if (x > 0) runLeft();
			else runRight();
		}
		
		override public function update():void {
			super.update();
		}
		
		override public function runRight():void {
			super.runRight();
			physics.accX = 5;
			sprites.play("run_r");
		}
		
		override public function runLeft():void {
			super.runLeft();
			physics.accX = -5;
			sprites.play("run_l");
		}
		
		override public function die():void {
			super.die();
			physics.removeCollideType("ground");
			physics.accY = 0.3;
			physics.velY = -4;
		}
		
	}

}