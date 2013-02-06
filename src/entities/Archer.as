package entities {
	import comps.ai.AIUtils;
	import comps.ai.FleeRectAI;
	import comps.ai.RangeDetectAI;
	import comps.items.Bow;
	import comps.ai.WanderAI;
	import comps.items.Bow;
	import entities.slots.Keep;
	import fp.MultiSpritemap;
	import net.flashpunk.Entity;
	import net.flashpunk.FP;
	import net.flashpunk.graphics.Spritemap;
	import net.flashpunk.Tween;
	import net.flashpunk.tweens.misc.Alarm;
	import net.flashpunk.utils.Input;
	import net.flashpunk.utils.Key;
	
	public class Archer extends LivingEntity {
		
		private var
			target:LivingEntity,
			bow:Bow,
			detectEnemy:RangeDetectAI,
			wander:WanderAI,
			anim:Spritemap = new Spritemap(Sprites.KNIGHT, 20, 20),
			sprites:MultiSpritemap = new MultiSpritemap();
		
		private var
			drawArrowTimer:Tween,
			fireArrowTimer:Tween,
			keep:Keep,
			onGround:Boolean;
		
		public function Archer(x:Number=0, y:Number=0, keep:Keep=null, onGround:Boolean=false) {
			super(x, y);
			setHitbox(8, 12, -12, -8);
			physics.maxVelX = 1.4;
			health = maxHealth = 10;
			this.keep = keep;
			this.onGround = onGround;
			
			anim.add("idle_l", [0], 30, false);
			anim.add("idle_r", [4], 30, false);
			anim.add("run_l", [0,1,2,3], 15, true);
			anim.add("run_r", [4,5,6,7], 15, true);
			anim.add("jump_l", [1], 30, false);
			anim.add("jump_r", [5], 30, false);
			anim.add("drawarrow_l", [16,16,17,18,19], 30, false);
			anim.add("drawarrow_r", [20,20,21,22,23], 30, false);
			anim.add("firearrow_l", [19,18,11,0], 15, false);
			anim.add("firearrow_r", [23,22,15,4], 15, false);
			anim.add("die_l", [25], 30, false);
			anim.add("die_r", [27], 30, false);
			sprites.addMid(anim);
			graphic = sprites;
			
			addComponent("weapon", bow = new Bow());
			addComponent("wander", wander = new WanderAI());
			
			detectEnemy = new RangeDetectAI(EntityTypes.ENEMIES, 250, 250);
			addComponent("detect_enemy", detectEnemy);
			
			detectEnemy.onEnterRange = function(e:Entity):void {
				if (e is LivingEntity
				&& !(flags & Flags.FLEEING)
				&& !(flags & Flags.ATTACKING)) {
					beginAttack(e as LivingEntity);
				}
			};
			
			addTween(drawArrowTimer = new Tween(1, 0, drawArrow));
			addTween(fireArrowTimer = new Tween(1, 0, fireArrow));
			
			type = "archer";
		}
		
		private function beginAttack(e:LivingEntity):void {
			target = e;
			wander.active = false;
			flags |= Flags.FLEEING;
			drawArrowTimer.start();
			
			if (target==null || target.type == "dead") {
				endAttack();
				return;
			}
			if (Math.abs(centerX - target.centerX) < 50) {
				if (centerX > e.centerX) {
					runRight();
				} else {
					runLeft();
				}
			}
		}
		
		private function endAttack():void {
			wander.active = true;
			flags &= ~Flags.ATTACKING;
			flags &= ~Flags.FLEEING;
			drawArrowTimer.cancel();
			fireArrowTimer.cancel();
			addTween(drawArrowTimer);
			addTween(fireArrowTimer);
			idle();
		}
		
		public function drawArrow():void {
			if (target==null || target.type == "dead") {
				endAttack();
				return;
			}
			physics.accX = 0;
			faceTowards(target);
			sprites.play("drawarrow_"+direction);
			flags |= Flags.ATTACKING;
			fireArrowTimer.start();
		}
		
		public function fireArrow():void {
			sprites.play("firearrow_"+direction);
			
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
			
			bow.fire(velX, Math.min(velY,-3));
			endAttack();
		}
		
		private function triangularNumber(n:int):Number {
			return (n * (n + 1) / 2);
		}
		
		override public function idle():void {
			super.idle();
			physics.accX = 0;
			flags &= ~Flags.ATTACKING;
			sprites.play("idle_"+direction);
			detectEnemy.forceCheck();
		}
		
		override public function runRight():void {
			super.runRight();
			physics.accX = 5;
			sprites.play("run_r");
			detectEnemy.forceCheck();
		}
		
		override public function runLeft():void {
			super.runLeft();
			physics.accX = -5;
			sprites.play("run_l");
			detectEnemy.forceCheck();
		}
		
		override public function die():void {
			super.die();
			if (keep) keep.archerIsKilled(onGround);
			drawArrowTimer.cancel();
			fireArrowTimer.cancel();
			removeComponent("wander");
			removeComponent("detect_enemy");
			removeComponent("weapon");
			physics.maxVelX = 0;
			anim.play("die_"+direction);
			addTween(new Tween(2, Tween.ONESHOT, removeSelf), true);
		}
		
	}
}