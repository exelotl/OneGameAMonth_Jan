package entities {
	import comps.ai.RangeDetectAI;
	import comps.Impulse;
	import entities.slots.Slot;
	import net.flashpunk.Entity;
	import net.flashpunk.graphics.Spritemap;
	import net.flashpunk.Tween;
	import states.PlayWorld;
	/**
	 * ...
	 * @author geckojsc
	 */
	public class Dragon extends LivingEntity {
		
		[Embed(source="../assets/dragon.png")]
		private static const IMG_DRAGON:Class;
		
		private var
			attackTimer:Tween = new Tween(8, Tween.LOOPING, randomAttack),
			jumpTimer:Tween = new Tween(1.4, Tween.PERSIST, jump),
			fireTimer:Tween = new Tween(1, Tween.PERSIST, fire),
			spawnFireballTimer:Tween = new Tween(0.3, Tween.PERSIST, spawnFireball),
			runTimer:Tween = new Tween(2, Tween.PERSIST, runLeft),
			remainingJumps:int = 0,
			remainingFires:int = 0,
			detectFriendly:RangeDetectAI = new RangeDetectAI(EntityTypes.FRIENDLY, 100, 40),
			anim:Spritemap = new Spritemap(IMG_DRAGON, 50, 30);
		
		public function Dragon(x:Number=0, y:Number=0) {
			super(x, y);
			health = maxHealth = 700;
			
			setHitbox(30, 20, -16, -10);
			type = "dragon";
			
			addTween(attackTimer, true);
			addTween(jumpTimer);
			addTween(fireTimer);
			addTween(spawnFireballTimer);
			addTween(runTimer);
			
			anim.add("idle_l", [8], 30, false);
			anim.add("charge_l", [0,1,2,3,4,5,6,7], 30, true);
			anim.add("run_l", [0,1,2,3,4,5,6,7], 10, true);
			anim.add("roar_l", [8,8,9,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,9,9,9,8], 30, false);
			graphic = anim;
			
			runLeft();
		}
		
		override public function update():void {
			super.update();
			if (dead) return;
			
			var e:Entity = collideTypes(EntityTypes.FRIENDLY, x, y);
			if (e is LivingEntity) {
				(e as LivingEntity).damage(Math.abs(physics.velX)*60, this);
			}
			
			var slot:Slot = (world as PlayWorld).getSlotAt(this);
			
			if (slot && slot.health > 0 && EntityTypes.ATTACKABLE_SLOTS.indexOf(slot.name)) {
				slot.damage(999);
			}
		}
		
		override public function idle():void {
			anim.play("idle_l");
			physics.accX = 0;
		}
		
		override public function jump():void {
			super.jump();
			physics.velY = -5;
			addComponent("propulsion", new Impulse(-3, 0, 0.2, 0));
		}
		
		override public function land():void {
			super.land();
			world.add(new Explosion(centerX, bottom, 1, 0.5, 3));
			if (--remainingJumps > 0) {
				jumpTimer.start();
			}
		}
		
		override public function fire():void {
			idle();
			anim.play("roar_l");
			if (remainingFires-- > 0) {
				fireTimer.start();
				spawnFireballTimer.start();
			} else {
				runLeft();
			}
		}
		
		public function spawnFireball():void {
			world.add(new Fireball(x, y+10, -1 - Math.random()*2, -2));
		}
		
		override public function runLeft():void {
			super.runLeft();
			anim.play("run_l");
			physics.maxVelX = 0.3;
			physics.accX = -1;
		}
		
		private function chargeLeft():void {
			anim.play("charge_l");
			physics.maxVelX = 1;
			physics.accX = -1;
		}
		
		private function randomAttack():void {
			trace(health);
			switch (int(Math.random()*3)) {
				case 0:
					remainingJumps = 3;
					jumpTimer.start();
					break;
				case 1:
					remainingFires = 3;
					fire();
					break;
				case 2:
					chargeLeft();
					runTimer.start();
					break;
			}
		}
		
	}

}