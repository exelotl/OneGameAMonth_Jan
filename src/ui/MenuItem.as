package ui {
	import net.flashpunk.Signal;
	
	/**
	 * Doesn't display any graphics itself, but can be used by MenuWorld, UpgradeSelector etc.
	 */
	public class MenuItem {
		
		public var text:String;
		public var onSelect:Signal;
		
		public function MenuItem(text:String, callback:Function=null) {
			this.text = text;
			if (callback)
				onSelect.add(callback);
		}
		
		public function select():void {
			onSelect.dispatch();
		}
		
	}

}