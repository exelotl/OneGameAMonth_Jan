package states {
	import comps.items.Sword;
	import entities.*;
	import entities.slots.*;
	import entities.ui.MoneySplash;
	import entities.ui.PlayerHealthBar;
	import entities.ui.ScreenFade;
	import entities.ui.WaveClock;
	import flash.display.BlendMode;
	import net.flashpunk.Entity;
	import net.flashpunk.FP;
	import net.flashpunk.Signal;
	import net.flashpunk.utils.Input;
	import net.flashpunk.utils.Key;
	import net.flashpunk.World;
	import entities.ui.MenuItem;
	import entities.ui.UpgradeMenu;
	
	public class PlayWorld extends World {
		
		public var
			onGameOver:Signal = new Signal(),
			onEntityDead:Signal = new Signal(),
			waveScheduler:WaveScheduler,
			waveClock:WaveClock,
			mobSpawner:MobSpawner,
			background:Background,
			upgradeMenu:UpgradeMenu,
			player:Player,
			playerHealthBar:PlayerHealthBar,
			slots:/*Slot*/Array,
			ui:GUI,
			money:int = 50;
			
		public function PlayWorld() {
			FP.screen.color = 0xccccff;
			add(background = new Background());
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
			var i:int;
			for (i = -6; i < 0; i++) add(new FillerSlot(i*200, 200));
			for (i = 5; i < 10; i++) add(new FillerSlot(i*200, 200));
			
			add(new CaveLeft(-8 * 200, 200));
			add(new CaveRight(10 * 200, 200));
			
			add(player = new Player(490, 160));
			player.addComponent("weapon", new Sword());
			
			add(playerHealthBar = new PlayerHealthBar(80, 0, player));
			
			waveScheduler = new WaveScheduler();
			add(waveScheduler);
			waveClock = new WaveClock(waveScheduler, 518, 6);
			add(waveClock);
			onEntityDead.add(entityDied);
		}
		
		public function getSlotAt(entity:Entity):Slot {
			return slots[Math.floor(entity.centerX / 200)];
		}
		
		private function gameOver():void {
			var fade:ScreenFade = new ScreenFade(3, 0x000000, 0xffffff, 1, 1, onGameOver.dispatch);
			fade.blend = BlendMode.SUBTRACT;
			add(fade);
		}
		
		private function entityDied(entity:LivingEntity):void {
			money += entity.price;
			if (entity.price > 0) 
				add(new MoneySplash(entity));
			if (entity.name == "player")
				gameOver();
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
			money -= u.cost;
			
			remove(slot);
			add(newSlot);
			
			var index:int = slots.indexOf(slot);
			slots[index] = newSlot;
			
			if (u == Upgrade.DESTROY) {
				if (slot.type == "castle") {
					gameOver();
					add(new Explosion(slot.centerX, slot.y-40, 140, 4, 25));
				} else {
					add(new Explosion(slot.centerX, slot.y-40));
				}
			} else if (upgradeMenu) {
				openUpgradeMenu(newSlot);
			}
		}
	}
}