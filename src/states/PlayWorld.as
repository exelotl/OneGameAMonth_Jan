package states {
	import comps.items.Sword;
	import entities.*;
	import entities.slots.*;
	import net.flashpunk.FP;
	import net.flashpunk.Signal;
	import net.flashpunk.World;
	import entities.ui.MenuItem;
	import entities.ui.UpgradeMenu;
	
	public class PlayWorld extends World {
		
		public var
			mobSpawner:MobSpawner,
			upgradeMenu:UpgradeMenu,
			player:Player,
			slots:/*Slot*/Array,
			ui:GUI,
			money:int = 50,
			onEntityDead:Signal = new Signal();
		
		private var archer:Archer;
			
		public function PlayWorld() {
			FP.screen.color = 0xccccff;
			var i:int;
			onEntityDead.add(function (entity:LivingEntity):void {
				money += entity.price;
			});
			add(new GUI());
			
			slots = [
				new Land(0, 200),
				new Land(200, 200),
				new Castle(400, 200),
				new Land(600, 200),
				new Land(800, 200)
			];
			for each (var slot:Slot in slots) {
				slot.onEdit.add(openUpgradeMenu);
				slot.onRequestUpgrade.add(applyUpgrade);
				add(slot);
			}
			for (i = -6; i < 0; i++) add(new FillerSlot(i*200, 200));
			for (i = 5; i < 10; i++) add(new FillerSlot(i*200, 200));
			
			add(player = new Player(80, 100));
			player.addComponent("weapon", new Sword());
			add(new Ninja(1000, 100));
			add(new Enemy(100, 100));
			add(archer = new Archer(300, 100));
			//add(new Knight(140, 100));
			
			mobSpawner = new MobSpawner();
			add(mobSpawner);
		}
		
		override public function update():void {
			super.update();
			FP.camera.x = Math.floor(FP.camera.x - ((FP.camera.x+FP.halfWidth) - player.x) / 14);
			FP.camera.y = Math.floor(FP.camera.y - ((FP.camera.y+FP.halfHeight) - player.y) / 80);
		}
		
		private function openUpgradeMenu(slot:Slot):void {
			if (upgradeMenu !== null) {
				remove(upgradeMenu);
				if (upgradeMenu.slot == slot) {
					upgradeMenu = null;
					return;
				}
			}
			upgradeMenu = new UpgradeMenu(slot);
			add(upgradeMenu);
			upgradeMenu.x = slot.x + 20;
			upgradeMenu.y = slot.y + -200;
		}
		
		private function applyUpgrade(slot:Slot, u:Upgrade):void {
			var newSlot:Slot = Upgrade.createSlot(slot, u)
			newSlot.inherit(slot);
			newSlot.onEdit.add(openUpgradeMenu);
			newSlot.onRequestUpgrade.add(applyUpgrade);
			
			remove(slot);
			add(newSlot);
			openUpgradeMenu(newSlot);
		}
	}
}