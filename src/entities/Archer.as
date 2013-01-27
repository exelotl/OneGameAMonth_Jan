package entities {
	import comps.ai.FleeRectAI;
	import comps.ai.RangeDetectAI;
	import comps.items.Bow;
	import comps.ai.WanderAI;
	import comps.items.Bow;
	import fp.MultiSpritemap;
	import net.flashpunk.Entity;
	import net.flashpunk.FP;
	import net.flashpunk.graphics.Spritemap;
	import net.flashpunk.Tween;
	import net.flashpunk.tweens.misc.Alarm;
	import net.flashpunk.utils.Input;
	import net.flashpunk.utils.Key;
	
	public class Archer extends LivingEntity {
		
		[Embed(source="../assets/knight.png")]
		private static const IMG_KNIGHT:Class;
		
		private var
			target:LivingEntity,
			bow:Bow,
			targetDetect:RangeDetectAI,
			flee:FleeRectAI,
			wander:WanderAI,
			anim:Spritemap = new Spritemap(IMG_KNIGHT, 20, 20),
			sprites:MultiSpritemap = new MultiSpritemap();
		
		private var
			fireArrowTimer:Tween;
		
		public function Archer(x:Number=0, y:Number=0) {
			super(x, y);
			setHitbox(20, 20);
			physics.maxVelX = 1.4;
			
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
			sprites.addMid(anim);
			graphic = sprites;
			
			addComponent("bow", bow = new Bow());
			addComponent("wander", wander = new WanderAI());
			
			targetDetect = new RangeDetectAI(EntityTypes.ENEMIES, 200, 100);
			addComponent("target_detect", targetDetect);
			
			targetDetect.onEnterRange = function(self:Entity, e:Entity):void {
				if (e is LivingEntity
				&& !(flags & Flags.FLEEING)
				&& !(flags & Flags.ATTACKING)) {
					pickTarget(e as LivingEntity);
				}
			};
			
			flee = new FleeRectAI();
			flee.active = false;
			addComponent("flee", flee);
			
			flee.onDone = function():void {
				if (target && (flags & Flags.FLEEING)) {
					trace("finished fleeing!");
					flags &= ~Flags.FLEEING;
					faceTowards(target);
					drawArrow();
					wander.active = false;
				}
			};
			
			addTween(fireArrowTimer = new Tween(1, 0, fireArrow));
			
			type = "archer";
		}
		
		override public function update():void {
			super.update();
			if (Math.random()<0.01)
				targetDetect.forceCheck();
		}
		
		private function pickTarget(e:LivingEntity):void {
			target = e;
			wander.active = false;
			flee.setRect(e.centerX-250, e.centerY-40, 500, 80);
			flee.active = true;
			flags |= Flags.FLEEING;
			trace("found target "+target.toString());
		}
		
		public function drawArrow():void {
			trace("drawing arrow");
			physics.accX = 0;
			physics.sweep = true;
			sprites.play("drawarrow_"+direction);
			flags |= Flags.ATTACKING;
			fireArrowTimer.start();
		}
		
		public function fireArrow():void {
			trace("firing arrow!");
			sprites.play("firearrow_"+direction);
			
			var gravity:Number = 0.5;
			var diffX:Number = target.centerX - centerX;
			var diffY:Number = target.centerY - centerY-2;
			var velX:Number = FP.sign(diffX)*8;
			var c:Number = diffX / velX;
			var velY:Number = -(triangularNumber(c) * gravity - diffY) / c;
			bow.fire(velX, velY);
			
			flags &= ~Flags.ATTACKING;
			wander.active = true;
		}
		
		private function triangularNumber(n:int):Number {
			return (n * (n + 1) / 2);
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
		
		override public function idle():void {
			super.idle();
			physics.accX = 0;
			flags &= ~Flags.ATTACKING;
			sprites.play("idle_"+direction);
		}
		
	}
}