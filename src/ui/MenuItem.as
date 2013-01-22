package ui {
	import net.flashpunk.Signal;
	
	/**
	 * Doesn't display any graphics itself, but can be used by MenuWorld, UpgradeSelector etc.
	 */
	public class MenuItem {
		
		public var text:String;
		public var isSelectable:Boolean;
		public var onSelect:Signal = new Signal();
		
		public function MenuItem(text:String, callback:Function=null, isSelectable:Boolean=true) {
			this.text = text;
			this.isSelectable = isSelectable;
			if (callback !== null)
				onSelect.add(callback);
		}
		
		public function select():void {
			if (isSelectable)
				onSelect.dispatch();
		}
		
	}

}