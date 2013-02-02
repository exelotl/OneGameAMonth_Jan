package entities {
	import net.flashpunk.Entity;
	import net.flashpunk.graphics.Spritemap;
	import net.flashpunk.Tween;
	
	public class Rat extends LivingEntity {
		
		[Embed(source="../assets/rat.png")]
		private static const IMG_RAT:Class;
		
		private var
			anim:Spritemap = new Spritemap(IMG_RAT, 22, 16);
		
		public function Rat(x:Number=0, y:Number=0) {
			super(x, y);
			setHitbox(12, 10, -5, -6);
			physics.maxVelX = 3;
			price = 20;
			type = "rat";
			anim.add("idle_r", [0], 30, false);
			anim.add("idle_l", [6], 30, false);
			anim.add("run_r", [1,2,3,4,5], 30, true);
			anim.add("run_l", [7,8,9,10,11], 30, true);
			graphic = anim;
			maxHealth = 5;
			health = maxHealth;
		}
		
		override public function added():void {
			if (x < 500) runRight();
			else runLeft();
		}
		
		override public function update():void {
			super.update();
			if (Math.abs(physics.velX) == physics.maxVelX) {
				collideEach(EntityTypes.FRIENDLY, x, y, onCollideFriendly);
			}
		}
		
		public function onCollideFriendly(e:Entity):void {
			var friendly:LivingEntity = e as LivingEntity;
			friendly.damage(10, this);
			physics.velX = 0;
		}
		
		override public function idle():void {
			anim.play("idle_"+direction);
			physics.accX = 0;
		}
		
		override public function runLeft():void {
			anim.play("run_l");
			physics.accX = -0.1;
		}
		
		override public function runRight():void {
			anim.play("run_r");
			physics.accX = 0.1;
		}
		
		override public function die():void {
			super.die();
			idle();
			anim.scaleY = -1;
			anim.y = 22;
			anim.alpha = 0.6;
			addTween(new Tween(1, 0, removeSelf), true);
		}
		
	}

}