package {
	
	import entities.Zombie;
	import net.flashpunk.Entity;
	
	public class MobSpawner extends Entity {
		
		public function MobSpawner() {
			
		}
		
		override public function update():void {
			if (Math.random() < 0.004) {
				spawnAtEdge(new Zombie());
			}
		}
		
		/**
		 * Add an entity at the edge of the world
		 */
		public function spawnAtEdge(e:Entity):void {
			e.x = 1000*(Math.random() < 0.5 ? 1 : -1);
			e.y = -e.height-2;
			world.add(e);
		}
		
	}

}