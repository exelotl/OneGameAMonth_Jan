package comps {
	
	import entities.Player;
	import entities.slots.Slot;
	import net.flashpunk.Component;
	import net.flashpunk.utils.Input;
	import net.flashpunk.utils.Key;
	import net.flashpunk.World;
	
	public class SlotControl extends Component {
		
		private var
			slot:Slot;
		
		public function SlotControl() {
			
		}
		
		override public function added():void {
			slot = entity as Slot;
			slot.onEdit.add(function(s:Slot):void{trace(s.x);});
		}
		
		override public function update():void {
			if (Input.pressed(Key.X)) {
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