package {
	import entities.slots.*;
	
	public class Upgrade {
		
		public var
			name:String,
			cost:int,
			description:String;
		
		public static const
			DESTROY:Upgrade = new Upgrade("Destroy", 0, ""),
			LAND:Upgrade = new Upgrade("Land", 0, "You probably want to upgrade this."),
			CASTLE:Upgrade = new Upgrade("Castle", 0, "You probably want to defend this."),
			TOWER:Upgrade = new Upgrade("Tower", 20, "Provides shelter for knights!"),
			BATTLE_TOWER:Upgrade = new Upgrade("Battle Tower", 100, "Spawns well-trained knights!"),
			KEEP:Upgrade = new Upgrade("Keep", 100, "Provides shelter for archers and knights!"),
			TRAP:Upgrade = new Upgrade("Trap", 60, "Kills 5 enemies!");
		
		public static function createSlot(prev:Slot, upgrade:Upgrade):Slot {
			var slot:Slot;
			switch (upgrade) {
				case DESTROY: slot = new Land(); break;
				case LAND: slot = new Land(); break;
				case TOWER: slot = new Tower(); break;
				case BATTLE_TOWER: slot = new BattleTower(); break;
				case KEEP: slot = new Keep(); break;
				case TRAP: slot = new Trap(); break;
				default: throw new Error("No class exists for upgrade '"+upgrade.name+"'.");
			}
			
			slot.inherit(prev);
			return slot;
		}
		
		public function Upgrade(name:String, cost:int, desc:String) {
			this.name = name;
			this.cost = cost;
			this.description = desc;
		}
	}
}