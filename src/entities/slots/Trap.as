package entities.slots {
	import comps.Physics;
	import entities.LivingEntity;
	import net.flashpunk.graphics.Image;
	import net.flashpunk.tweens.misc.Alarm;
	import net.flashpunk.tweens.misc.NumTween;
	import net.flashpunk.utils.Ease;

	public class Trap extends Slot {
		
		[Embed(source="../../assets/trap.png")]
		private static const IMG_TRAP_SLOT:Class;
		
		[Embed(source="../../assets/trap_spikes.png")]
		private static const IMG_TRAP_SPIKES:Class;
		
		private var
			spikesExposed:Boolean = false,
			spikeImg:Image,
			image:Image,
			spikeTween:NumTween = new NumTween(),
			timer:Alarm = new Alarm(2),
			killsLeft:int = 20;
			
		public function Trap(x:Number = 0, y:Number = 0, health:uint = 0) {
			super(x, y);
			setHitbox(200, 200);
			
			currentUpgrade = Upgrade.TRAP;
			spikeImg = new Image(IMG_TRAP_SPIKES);
			image = new Image(IMG_TRAP_SLOT);
			addGraphic(spikeImg);
			addGraphic(image);
			
			spikeTween.value = -3;
			addTween(spikeTween);
			addTween(timer, true);
		}
		
		override public function update():void {
			var enemy:LivingEntity;
			
			spikeImg.y = spikeTween.value;
			
			for (var i:int = 0; i < EntityTypes.ENEMIES.length; i++) {
				enemy = world.collideRect(EntityTypes.ENEMIES[i], x+20, y, 160, 200) as LivingEntity;
				if (enemy != null) break;
			}
			
			if (spikesExposed) {
				if (timer.remaining == 0)
					retractSpikes();
				if (spikesExposed && enemy != null) {
					if (Math.random()<0.06) nudgeEnemy(enemy);
					if (Math.random()<0.015) killEnemy(enemy);
				}
			} else if (timer.remaining == 0 && enemy != null) {
				exposeSpikes();
			}
			
		}
		
		private function retractSpikes():void {
			spikeTween.tween(-10, -3, 0.2, Ease.quadIn);
			spikeTween.complete = onSpikesRetracted;
			timer.start();
		}
		private function exposeSpikes():void {
			spikeTween.tween(-3, -10, 0.2);
			spikeTween.complete = onSpikesExposed;
			timer.start();
			Audio.play(Audio.SPIKES_EXPOSE);
		}
		
		private function onSpikesRetracted():void { spikesExposed = false; }
		private function onSpikesExposed():void { spikesExposed = true; }
		
		private function nudgeEnemy(enemy:LivingEntity):void {
			var physics:Physics = enemy.getComponent("physics");
			Audio.play(Audio.ENEMY_HURT, 0.5);
			if (physics)
				physics.velY = -3;
		}
		
		private function killEnemy(enemy:LivingEntity):void {
			enemy.die();
			nudgeEnemy(enemy);
			if (--killsLeft <= 0)
				requestUpgrade(Upgrade.LAND);
		}
	}
}