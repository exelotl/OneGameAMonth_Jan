package states {
	import comps.Sword;
	import entities.Ground;
	import entities.Player;
	import entities.slots.*;
	import net.flashpunk.FP;
	import net.flashpunk.World;
	import ui.MenuItem;
	import ui.UpgradeSelector;
	
	public class PlayWorld extends World {
		
		private var
			player:Player,
			slots:/*Slot*/Array;
		
		public function PlayWorld() {
			FP.screen.color = 0xccccff;
			var i:int;
			
			slots = new Array();
			for (i = -5; i < 0; i++) add(new FillerSlot(i*200, 200));
			for (i = 0; i < 4; i++) add(slots[i] = new Land(i*200, 200));
			for (i = 4; i < 9; i++) add(new FillerSlot(i*200, 200));
			
			add(player = new Player(100, 100));
			player.addComponent("sword", new Sword());
			
			// upgrade a slot (test)
			remove(slots[2]);
			slots[2] = slots[2].upgrade(Upgrade.TOWER);
			add(slots[2]);
			
			var upgrades:UpgradeSelector = new UpgradeSelector(0,0);
			upgrades.title = "This is a test";
			upgrades.comment = "Click an item below and check the debug console";
			upgrades.addItem(new MenuItem("foo", function(){ trace("foo"); } ));
			upgrades.addItem(new MenuItem("bar", function(){ trace("bar"); } ));
			upgrades.addItem(new MenuItem("herp", function(){ trace("derp"); } ));
			add(upgrades);
		}
		
		override public function update():void {
			super.update();
			FP.camera.x = Math.floor(FP.camera.x - ((FP.camera.x+FP.halfWidth) - player.x) / 14);
			FP.camera.y = Math.floor(FP.camera.y - ((FP.camera.y+FP.halfHeight) - player.y) / 40);
		}
	}
}