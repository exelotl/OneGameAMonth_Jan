package states {
	import entities.Enemy;
	import entities.FollowingEnemy;
	import entities.Ground;
	import entities.Player;
	import net.flashpunk.FP;
	import net.flashpunk.World;
	
	/**
	 * @author geckojsc
	 */
	public class PlayWorld extends World {
		
		private var player:Player;
		
		public function PlayWorld() {
			FP.screen.color = 0xbada55;
			player = new Player(100, 100);
			add(player);
			var enemy:Enemy = new Enemy(150, 100);
			add(enemy);
			var enemy2:FollowingEnemy = new FollowingEnemy(200, 200, player);
			add(enemy2);
			for (var i:int = 0; i < 20; i++) {
				add(new Ground(i * 20, 300));
			}
			add(new Ground(0, 280));
			add(new Ground(380, 280));
			add(new Ground(0, 260));
			add(new Ground(380, 260));
			add(new Ground(20, 240));
			add(new Ground(360, 240));
		}
		
	}
}