package states {
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
		}
		
	}
}