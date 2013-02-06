package {
	
	import entities.Dragon;
	import entities.Ninja;
	import entities.Parachuter;
	import entities.Rat;
	import entities.slots.CaveLeft;
	import entities.slots.CaveRight;
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
			if (amountOfMobs > 1) {
				timer = new Tween((wave.time-10) / (amountOfMobs*2), Tween.LOOPING, spawn);
			} else if (amountOfMobs == 1) {
				timer = new Tween(0.1, Tween.LOOPING, spawn);
			}
		}
		
		private function spawn():void {
			var i:int = getRandomIndex();
			if (i < 0) {
				stop();
			} else {
				switch (mobs[i].type) {
					case "zombie":
						spawnAtEdge(new Zombie()); break;
					case "rat":
						spawnAtEdge(new Rat()); break;
					case "ninja":
						spawnAtEdge(new Ninja()); break;
					case "parachuter":
						spawnAtTop(new Parachuter()); break;
					case "dragon":
						world.add(new Dragon(1900, -1000)); break;
						//world.add(new Dragon(1060, -1000)); break;
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
				}
			}
			world.remove(this);
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
			if (Math.random() < 0.5) {
				var caveL:CaveLeft = world.getInstance("cave_l");
				e.x = caveL.spawnX;
				e.y = caveL.spawnY - e.height;
			} else {
				var caveR:CaveRight = world.getInstance("cave_r");
				e.x = caveR.spawnX;
				e.y = caveR.spawnY - e.height;
			}
			world.add(e);
		}
	}
}