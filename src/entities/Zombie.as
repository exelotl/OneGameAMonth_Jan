package entities {
	import comps.ai.AIUtils;
	import comps.ai.RangeDetectAI;
	import entities.slots.Slot;
	import fp.MultiSpritemap;
	import net.flashpunk.Entity;
	import net.flashpunk.graphics.Spritemap;
	import net.flashpunk.Tween;
	import net.flashpunk.tweens.misc.Alarm;
	import states.PlayWorld;
	
	/**
	 * braaaaaaaains
	 */
	public class Zombie extends LivingEntity {
		
		private var
			sprites:MultiSpritemap = new MultiSpritemap(),
			detectFriendly:RangeDetectAI,
			detectSlot:RangeDetectAI,
			anim:Spritemap = new Spritemap(Sprites.ZOMBIE, 20, 20),
			currentSlot:Slot,
			strikeTimer:Tween,
			idleTimer:Tween,
			jumpTimer:Tween;
		
		public function Zombie(x:Number=0, y:Number=0) {
			super(x, y);
			setHitbox(8, 14, -12, -6);
			health = maxHealth = 15;
			physics.maxVelX = 0.6;
			price = 5;
			
			detectFriendly = new RangeDetectAI(EntityTypes.FRIENDLY, 100, 40);
			detectFriendly.onEnterRange = pickTarget;
			addComponent("detect_friendly", detectFriendly);
			
			detectSlot = new RangeDetectAI(EntityTypes.ATTACKABLE_SLOTS, 50, 40);
			detectSlot.onEnterRange = pickSlot;
			addComponent("detect_slot", detectSlot);
			
			anim.add("idle_l", [0], 30, false);
			anim.add("idle_r", [4], 30, false);
			anim.add("run_l", [0,1,2,3], 10, true);
			anim.add("run_r", [4,5,6,7], 10, true);
			anim.add("strike_l", [9,10], 15, true);
			anim.add("strike_r", [13,14], 15, true);
			anim.add("die_l", [11], 30, false);
			anim.add("die_r", [15], 30, false);
			anim.add("target_l", [8], 30, false);
			anim.add("target_r", [12], 30, false);
			sprites.addMid(anim);
			graphic = sprites;
			
			addTween(strikeTimer = new Tween(0.5, 0, strike));
			addTween(idleTimer = new Tween(1.6, 0, idle));
			addTween(jumpTimer = new Tween(1, 0, jump)).percent = 1;
			
			type = "zombie";
		}
		
		override public function added():void {
			if (centerX > 500) runLeft();
			else runRight();
		}
		
		override public function update():void {
			super.update();
			if (dead) return;
			if (flags & Flags.ATTACKING) {
				var e:Entity = collideTypes(EntityTypes.FRIENDLY, x, y);
				if (e is LivingEntity) {
					(e as LivingEntity).damage(20, this);
				}
			}
			if (!(flags & Flags.RUNNING)) {
				added();
			}
			
			currentSlot = (world as PlayWorld).getSlotAt(this);
			
			if (canAttackCurrentSlot && jumpTimer.percent == 1) {
				jumpTimer.start();
			}
			
		}
		
		override public function idle():void {
			super.idle();
			sprites.play("idle_"+direction);
			flags &= ~Flags.ATTACKING;
			physics.accX = 0;
			physics.maxVelX = 0.6;
			detectFriendly.forceCheck();
		}
		
		public function get canAttackCurrentSlot():Boolean {
			return currentSlot != null
				&& EntityTypes.ATTACKABLE_SLOTS.indexOf(currentSlot.type) != -1;
		}
		
		override public function jump():void {
			idle();
			super.jump();
			physics.velY = -3;
		}
		
		override public function land():void {
			super.land();
			if (canAttackCurrentSlot) {
				currentSlot.damage(5);
			}
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
		
		// Stare menacingly...
		private function pickTarget(target:Entity):void {
			if (!(flags & Flags.ATTACKING)) {
				flags |= Flags.ATTACKING;
				physics.accX = 0;
				sprites.play("target_"+direction);
				strikeTimer.start();
			}
		}
		
		private function pickSlot(target:Entity):void {
			
		}
		
		// Chaaarge!
		override public function strike():void {
			sprites.play("strike_"+direction);
			physics.maxVelX = 1;
			physics.accX = direction=="r" ? 5 : -5;
			idleTimer.start();
		}
		
		override public function damage(amount:uint, source:Entity):void {
			if (!getComponent("knockback")) {
				super.damage(amount, source);
				Audio.play(Audio.ENEMY_HURT);
			}
		}
		
		override public function die():void {
			super.die();
			physics.maxVelX = 0;
			direction = Math.random()<0.5 ? "l" : "r";
			anim.play("die_"+direction);
			clearTweens();
			removeComponent("detect_friendly");
			removeComponent("detect_slot");
			addTween(new Alarm(2, removeSelf), true);
		}
		
	}
}