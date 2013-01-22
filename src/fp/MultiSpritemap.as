package fp {
	import flash.display.BitmapData;
	import flash.geom.Point;
	import net.flashpunk.Graphic;
	import net.flashpunk.graphics.Anim;
	import net.flashpunk.graphics.Spritemap;
	
	/**
	 * Allows animated spritemaps to be layered on top of each other.
	 * Split into background, middle, and foreground, for easier arrangement.
	 */
	public class MultiSpritemap extends Graphic {
		
		public var
			currentAnim:String = "";
		
		private var
			bgMaps:/*Spritemap*/Array = [],
			midMaps:/*Spritemap*/Array = [],
			fgMaps:/*Spritemap*/Array = [];
		
		public function MultiSpritemap() {
			active = true;
		}
		
		public function addMid(map:Spritemap):void {
			midMaps.push(map);
		}
		public function addBg(map:Spritemap):void {
			bgMaps.push(map);
		}
		public function addFg(map:Spritemap):void {
			fgMaps.push(map);
		}
		
		public function remove(map:Spritemap):void {
			var i:int = midMaps.indexOf(map);
			if (i !== -1) midMaps.splice(i, 1);
			
			i = bgMaps.indexOf(map);
			if (i !== -1) bgMaps.splice(i, 1);
			
			i = fgMaps.indexOf(map);
			if (i !== -1) fgMaps.splice(i, 1);
		}
		
		public function play(name:String="", reset:Boolean=false, frame:int=0):void {
			var map:Spritemap;
			currentAnim = name;
			for each(map in bgMaps) map.play(name, reset, frame);
			for each(map in midMaps) map.play(name, reset, frame);
			for each(map in fgMaps) map.play(name, reset, frame);
		}
		
		override public function update():void {
			var map:Spritemap;
			for each(map in bgMaps) map.update();
			for each(map in midMaps) map.update();
			for each(map in fgMaps) map.update();
		}
		
		override public function render(target:BitmapData, point:Point, camera:Point):void {
			var map:Spritemap;
			_point.x = point.x + x;
			_point.y = point.y + y;
			for each(map in bgMaps) map.render(target, _point, camera);
			for each(map in midMaps) map.render(target, _point, camera);
			for each(map in fgMaps) map.render(target, _point, camera);
		}
		
	}

}