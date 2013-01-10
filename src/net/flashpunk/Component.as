package net.flashpunk {
	import flash.display.BitmapData;
	import flash.geom.Point;
	
	public class Component {
		
		public var
			name:String,
			active:Boolean = true,
			entity:Entity; /// set when the component is added
		
		public function reset():void {}
		public function added():void {}
		public function removed():void {}
		public function update():void {}
		public function moveCollideX(e:Entity):void {}
		public function moveCollideY(e:Entity):void {}
	}
	
}