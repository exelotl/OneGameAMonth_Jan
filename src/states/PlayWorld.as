package states {
	import comps.Sword;
	import entities.Enemy;
	import entities.Ground;
	import entities.Player;
	import entities.slots.*;
	import net.flashpunk.FP;
	import net.flashpunk.World;
	import ui.MenuItem;
	import ui.UpgradeMenu;
	
	public class PlayWorld extends World {
		
		private var
			upgradeMenu:UpgradeMenu,
			player:Player,
			slots:/*Slot*/Array;
		
		public function PlayWorld() {
			FP.screen.color = 0xccccff;
			var i:int;
			
			slots = [
				new Land(0, 200),
				new Land(200, 200),
				new Castle(400, 200),
				new Land(600, 200),
				new Land(800, 200)
			];
			for each (var slot:Slot in slots) {
				slot.onEdit.add(openUpgradeMenu);
				add(slot);
			}
			for (i = -6; i < 0; i++) add(new FillerSlot(i*200, 200));
			for (i = 5; i < 10; i++) add(new FillerSlot(i*200, 200));
			
			add(player = new Player(100, 100));
			player.addComponent("sword", new Sword());
			
			add(new Enemy(100, 100));
			
			// upgrade a slot (test)
			remove(slots[3]);
			slots[3] = slots[3].upgrade(Upgrade.TOWER);
			add(slots[3]);
			
			//upgradeMenu = new UpgradeMenu(0,0);
			//upgradeMenu.disable();
			//upgradeMenu.title = "This is a test";
			//upgradeMenu.comment = "Click an item below and check the debug console";
			//upgradeMenu.addItem(new MenuItem("foo", function(){ trace("foo"); } ));
			//upgradeMenu.addItem(new MenuItem("bar", function(){ trace("bar"); } ));
			//upgradeMenu.addItem(new MenuItem("herp", function(){ trace("derp"); } ));
			//add(upgradeMenu);
		}
		
		private function openUpgradeMenu(slot:Slot):void {
			if (upgradeMenu !== null)
				remove(upgradeMenu);
			upgradeMenu = new UpgradeMenu(slot);
			add(upgradeMenu);
			upgradeMenu.x = slot.x + 20;
			upgradeMenu.y = slot.y - 200;
		}
		
		override public function update():void {
			super.update();
			FP.camera.x = Math.floor(FP.camera.x - ((FP.camera.x+FP.halfWidth) - player.x) / 14);
			FP.camera.y = Math.floor(FP.camera.y - ((FP.camera.y+FP.halfHeight) - player.y) / 40);
		}
	}
}