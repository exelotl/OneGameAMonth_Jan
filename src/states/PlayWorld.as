package states {
	import entities.Ground;
	import entities.LandSlot;
	import entities.Player;
	import net.flashpunk.FP;
	import net.flashpunk.World;
	import ui.MenuItem;
	import ui.UpgradeSelector;
	
	public class PlayWorld extends World {
		
		private var
			player:Player,
			slots:/*LandSlot*/Array;
		
		public function PlayWorld() {
			FP.screen.color = 0xbada55;
			slots = new Array();
			for (var i:int = 0; i < 4; i++) add(slots[i] = new LandSlot(50 + 100 * i, 300));
			add(player = new Player(100, 100));
			for (i = -10; i < 40; i++) add(new Ground(i * 20, 300));
			
			var upgrades:UpgradeSelector = new UpgradeSelector(0,0);
			upgrades.title = "This is a test";
			upgrades.comment = "Click an item below and check the debug console";
			upgrades.addItem(new MenuItem("foo", function(){ trace("foo"); } ));
			upgrades.addItem(new MenuItem("bar", function(){ trace("bar"); } ));
			upgrades.addItem(new MenuItem("herp", function(){ trace("derp"); } ));
			add(upgrades);
		}
	}
}