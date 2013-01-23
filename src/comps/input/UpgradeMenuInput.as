package comps.input {
	
	import entities.ui.UpgradeMenu;
	import net.flashpunk.Component;
	import net.flashpunk.utils.Input;
	import net.flashpunk.utils.Key;
	
	public class UpgradeMenuInput extends Component {
		
		private var menu:UpgradeMenu;
		
		public function UpgradeMenuInput() {
			
		}
		
		override public function added():void {
			menu = entity as UpgradeMenu;
		}
		
		override public function update():void {
			if (Input.pressed(Key.DOWN)) menu.next();
			if (Input.pressed(Key.UP)) menu.prev();
			if (Input.pressed(Key.ENTER)) menu.select();
			//if (Input.pressed(Key.Z)) menu.close();
		}
		
	}

}