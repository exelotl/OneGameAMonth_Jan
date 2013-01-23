package comps.input {
	
	import entities.Player;
	import entities.slots.Slot;
	import net.flashpunk.Component;
	import net.flashpunk.utils.Input;
	import net.flashpunk.utils.Key;
	import net.flashpunk.World;
	
	public class SlotInput extends Component {
		
		private var
			slot:Slot;
		
		public function SlotInput() {
			
		}
		
		override public function added():void {
			slot = entity as Slot;
		}
		
		override public function update():void {
			if (Input.pressed(Key.Z)) {
				var player:Player = slot.world.getInstance("player");
				if (player !== null
				&& player.x > slot.x
				&& player.x < slot.x + slot.width) {
					slot.onEdit.dispatch(slot);
				}
			}
		}
		
	}

}