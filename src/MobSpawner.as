package {
	
	import entities.Parachuter;
	import entities.Zombie;
	import net.flashpunk.Entity;
	import net.flashpunk.FP;
	
	public class MobSpawner extends Entity {
		
		public function MobSpawner() {
			
		}
		
		override public function update():void {
			if (Math.random() < 0.004) {
				spawnAtEdge(new Zombie());
			}
			if (Math.random() < 0.002) {
				spawnAtTop(new Parachuter());
			}
		}
		
		public function spawnAtTop(e:Entity):void {
			e.x = 500 + (200 + Math.random() * 400) * FP.sign(Math.random() - 0.5);
			e.y = -100;
			world.add(e);
		}
		 
		public function spawnAtEdge(e:Entity):void {
			e.x = 250 + 1400*(Math.random() < 0.5 ? 1 : -1);
			e.y = 190-e.height;
			world.add(e);
		}
		
	}
}