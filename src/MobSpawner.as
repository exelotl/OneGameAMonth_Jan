package {
	
	import entities.Ninja;
	import entities.Parachuter;
	import entities.Zombie;
	import net.flashpunk.Entity;
	import net.flashpunk.FP;
	import net.flashpunk.Tween;
	import states.PlayWorld;
	
	public class MobSpawner extends Entity {
		
		public var
			timer:Tween;
		
		private var
			mobs:Array,
			wave:Wave,
			amountOfMobs:int = 0;
			
		public function MobSpawner(entities:Array, wave:Wave) {
			mobs = entities;
			this.wave = wave;
			for (var i:int = 0; i < mobs.length; i++) {
				amountOfMobs += mobs[i].amount;
			}
			if (amountOfMobs) {
				timer = new Tween((wave.time -10)/ amountOfMobs, Tween.LOOPING, spawn);
			}
		}
		
		private function spawn():void {
			var i:int = getRandomIndex();
			if (i < 0) {
				stop();
			} else {
				switch (mobs[i].type) {
					case "zombie":
						spawnAtEdge(new Zombie());
						break;
					case "ninja":
						spawnAtEdge(new Ninja());
						break;
					case "parachuter":
						spawnAtTop(new Parachuter());
						break;
				}
				mobs[i].amount--;
			}
		}	
		
		public function start():void {
			if (amountOfMobs) {
				addTween(timer, true);
			}
		}
		
		public function stop():void {
			if (timer != null) {
				if (timer.active) {
					timer.cancel();
					//removeTween(timer);
				}
			}
		}
		
		private function getRandomIndex():int {
			if (noIndexLeft()) return -1;
			var i:int = Math.floor(Math.random() * mobs.length);
			if (mobs[i].amount < 1) return getRandomIndex();
			else return i;
		}
		
		private function noIndexLeft():Boolean {
			for (var i:int = 0; i < mobs.length; i++) {
				if (mobs[i].amount) return false;
			}
			return true;
		}
		
		private function spawnAtTop(e:Entity):void {
			e.x = 500 + (200 + Math.random() * 400) * FP.sign(Math.random() - 0.5);
			e.y = -100;
			world.add(e);
		}
		 
		private function spawnAtEdge(e:Entity):void {
			e.x = 250 + 1400*(Math.random() < 0.5 ? 1 : -1);
			e.y = 190-e.height;
			world.add(e);
		}
	}
}