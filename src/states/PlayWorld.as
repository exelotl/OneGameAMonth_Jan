package states {
	import entities.Enemy;
	import entities.FollowingEnemy;
	import entities.Ground;
	import entities.LandSlot;
	import entities.Player;
	import net.flashpunk.FP;
	import net.flashpunk.World;
	
	/**
	 * @author geckojsc
	 */
	public class PlayWorld extends World {
		
		private var
			player:Player,
			slots:Array/*LandSlot*/;
		
		public function PlayWorld() {
			FP.screen.color = 0xbada55;
			slots = new Array();
			for (var i:int = 0; i < 4; i++) add(slots[i] = new LandSlot(50 + 100 * i, 300));
			add(player = new Player(100, 100));
			for (i = -10; i < 40; i++) add(new Ground(i * 20, 300));
		}
	}
}