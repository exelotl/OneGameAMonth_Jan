package entities {
	import comps.input.PlayerInput;
	import comps.items.Crown;
	import comps.items.Weapon;
	import fp.MultiSpritemap;
	import net.flashpunk.Entity;
	import net.flashpunk.graphics.Spritemap;
	import net.flashpunk.Tween;
	
	public class Player extends LivingEntity {
		
		[Embed(source="../assets/player.png")]
		private static const IMG_PLAYER:Class;
		
		private var
			sprites:MultiSpritemap = new MultiSpritemap(),
			anim:Spritemap,
			control:PlayerInput,
			stopStrikeTimer:Tween;
		
		public function Player(x:Number=0, y:Number=0) {
			super(x, y);
			setHitbox(8, 12, -12, -8);
			
			health = maxHealth = 100;
			
			control = new PlayerInput();
			addComponent("control", control);
			
			
			anim = new Spritemap(IMG_PLAYER, 20, 20);
			anim.add("idle_l", [0], 30, false);
			anim.add("idle_r", [4], 30, false);
			anim.add("run_l", [0,1,2,3], 15, true);
			anim.add("run_r", [4,5,6,7], 15, true);
			anim.add("jump_l", [1], 30, false);
			anim.add("jump_r", [5], 30, false);
			anim.add("strike_l", [8,9,10,11], 15, false);
			anim.add("strike_r", [12, 13, 14, 15], 15, false);
			
			sprites.addMid(anim);
			graphic = sprites;
			addComponent("crown", new Crown());
			
			addTween(stopStrikeTimer = new Tween(0.2, 0, idle));
			
			layer = Layers.PLAYER;
			name = "player";
			type = "player";
		}
		
		override public function jump():void {
			super.jump();
			physics.velY = -5;
			sprites.play("jump_"+direction);
			Audio.stop(Audio.FOOTSTEP);
			Audio.play(Audio.JUMP);
		}
		
		override public function land():void {
			super.land();
			if (physics.accX === 0) {
				sprites.play("idle_"+direction);
			} else {
				sprites.play("run_"+direction);
				Audio.loop(Audio.FOOTSTEP, 0.3);
			}
		}
		
		override public function runRight():void {
			super.runRight();
			physics.accX = 5;
			sprites.play("run_r");
			Audio.loop(Audio.FOOTSTEP, 0.3);
		}
		
		override public function runLeft():void {
			super.runLeft();
			physics.accX = -5;
			sprites.play("run_l");
			Audio.loop(Audio.FOOTSTEP, 0.3);
		}
		
		override public function idle():void {
			super.idle();
			physics.accX = 0;
			flags &= ~Flags.ATTACKING;
			sprites.play("idle_"+direction);
			Audio.stop(Audio.FOOTSTEP);
		}
		
		override public function strike():void {
			if (flags & Flags.ATTACKING)
				return;
			var weapon:Weapon = getComponent("weapon");
			if (weapon) weapon.strike();
			
			sprites.play("strike_"+direction);
			flags |= Flags.ATTACKING;
			stopStrikeTimer.start();
		}
		
		override public function fire():void {
			
		}
		
		override public function damage(amount:uint, source:Entity):void {
			super.damage(amount, source);
			Audio.play(Audio.PLAYER_HURT);
		}
		
		override public function die():void {
			super.die();
			Audio.stop(Audio.FOOTSTEP);
			world.remove(this);
		}
		
	}
}