package entities {
	import comps.ai.RangeDetectAI;
	import entities.ui.NinjaStar;
	import fp.MultiSpritemap;
	import net.flashpunk.Entity;
	import net.flashpunk.graphics.Spritemap;
	import net.flashpunk.Tween;
	import net.flashpunk.tweens.misc.Alarm;
	import net.flashpunk.FP;
	
	public class Ninja extends LivingEntity {
		
		[Embed(source="../assets/ninja.png")]
		private static var IMG_NINJA:Class;
		
		private var
			target:LivingEntity,
			anim:Spritemap = new Spritemap(IMG_NINJA, 20, 20),
			sprites:MultiSpritemap = new MultiSpritemap(),
			detectFriendly:RangeDetectAI,
			strikeTimer:Tween,
			idleTimer:Tween,
			fireTimer:Tween;
		
		public function Ninja(x:Number=0, y:Number=0) {
			super(x, y);
			setHitbox(8, 12, -12, -8);
			health = maxHealth = 30;
			physics.maxVelX = 1.8;
			price = 15;
			anim = new Spritemap(IMG_NINJA, 20, 20);
			anim.add("idle_l", [0], 30, false);
			anim.add("idle_r", [4], 30, false);
			anim.add("run_l", [0,1,2,3], 10, true);
			anim.add("run_r", [4,5,6,7], 10, true);
			anim.add("throw_l", [8], 15, true);
			anim.add("throw_r", [9], 15, true);
			anim.add("die_l", [10], 30, false);
			anim.add("die_r", [11], 30, false);
			sprites.addMid(anim);
			graphic = sprites;
			detectFriendly = new RangeDetectAI(EntityTypes.FRIENDLY, 250, 100);
			addComponent("detect_friendly", detectFriendly);
			detectFriendly.onEnterRange = function(e:Entity):void {
				if (e is LivingEntity
				&& !(flags & Flags.FLEEING)
				&& !(flags & Flags.ATTACKING)) {
					beginAttack(e as LivingEntity);
				}
			};
			addTween(strikeTimer = new Tween(0.5, 0, strike));
			addTween(idleTimer = new Tween(1.6, 0, idle));
			addTween(fireTimer = new Tween(1, 0, fire));
			type = "ninja";
		}
		
		override public function update():void {
			super.update();
			if (dead) return;
			if (flags & Flags.ATTACKING) {
				var e:Entity = collideTypes(EntityTypes.FRIENDLY, x, y);
				if (e is LivingEntity) {
					(e as LivingEntity).damage(10, this);
				}
			}
			if (!(flags & Flags.RUNNING)) {
				added();
			}
		}
		
		private function beginAttack(e:LivingEntity):void {
			target = e;
			detectFriendly.active = false;
			flags |= Flags.FLEEING;
			fireTimer.start();
			if (target == null || target.type == "dead") {
				endAttack();
				return;
			}
		}
		
		private function endAttack():void {
			detectFriendly.active = true;
			flags &= ~Flags.ATTACKING;
			flags &= ~Flags.FLEEING;
			fireTimer.cancel();
			addTween(fireTimer);
			idle();
		}
		
		override public function added():void {
			super.added();
			if (x < 500) runRight();
			else runLeft();
		}
		
		override public function idle():void {
			super.idle();
			sprites.play("idle_"+direction);
			flags &= ~Flags.ATTACKING;
			detectFriendly.forceCheck();
		}
		override public function runLeft():void {
			super.runLeft();
			physics.accX = -5;
			sprites.play("run_l");
		}
		override public function runRight():void {
			super.runRight();
			physics.accX = 5;
			sprites.play("run_r");
		}
		
		override public function fire():void {
			if (target == null || target.type == "dead") {
				endAttack();
				return;
			}
			physics.accX = 0;
			faceTowards(target);
			sprites.play("throw_" + direction);
			flags |= Flags.ATTACKING;
			if (target.centerX == centerX) {
				endAttack();
				return;
			}
			var gravity:Number = 0.5;
			var diffX:Number = target.centerX - centerX;
			var diffY:Number = target.top - centerY;
			var velX:Number = FP.sign(diffX) * Math.max(Math.abs(diffX)/20, 10);
			var c:Number = diffX / velX;
			var velY:Number = -(triangularNumber(c) * gravity - diffY) / c;
			world.add(new NinjaStar(this.centerX, this.centerY - 6, velX, Math.min(velY, -3), EntityTypes.FRIENDLY));
			endAttack();
		}
		
		private function triangularNumber(n:int):Number {
			return (n * (n + 1) / 2);
		}
		
		override public function strike():void {
			// stabbing
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
			addTween(new Alarm(2, removeSelf), true);
		}
		
	}
}