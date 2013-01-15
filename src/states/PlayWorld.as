package states {
	import entities.Ground;
	import entities.Player;
	import net.flashpunk.World;
	
	/**
	 * @author geckojsc
	 */
	public class PlayWorld extends World {
		
		private var player:Player;
		
		public function PlayWorld() {
			player = new Player(100, 100);
			add(player);
			for (var i:int = 0; i < 20; i++) {
				add(new Ground(i * 20, 300));
			}
		}
		
	}
}