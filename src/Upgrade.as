package {
	import entities.slots.*;
	
	public class Upgrade {
		
		public var
			name:String,
			cost:int,
			description:String;
		
		public static const
			LAND:Upgrade = new Upgrade("Land", 0, "You probably want to upgrade this."),
			TOWER:Upgrade = new Upgrade("Tower", 10, "Provides shelter for knights!");
		
		public static function createSlot(prev:Slot, upgrade:Upgrade):Slot {
			var slot:Slot;
			switch (upgrade) {
				case TOWER: slot = new Tower(); break;
				default: return null;
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