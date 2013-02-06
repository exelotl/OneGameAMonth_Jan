package entities {
	import flash.display.BlendMode;
	import net.flashpunk.Entity;
	import net.flashpunk.graphics.Backdrop;
	import net.flashpunk.graphics.Graphiclist;
	import net.flashpunk.graphics.Image;
	
	public class Background extends Entity {
			
		private var
			daysky:Backdrop = new Backdrop(Sprites.CLOUDS),
			nightsky:Image = new Image(Sprites.NIGHTSKY),
			mountain:Backdrop = new Backdrop(Sprites.MOUNTAIN),
			nightskyOverlay:Image = new Image(Sprites.NIGHTSKY_OVERLAY),
			dayskyOverlay:Image = new Image(Sprites.DAYSKY_OVERLAY),
			graphiclist:Graphiclist = new Graphiclist();
		
		public function Background() {
			
			daysky.scrollX = 0.1;
			daysky.scrollY = 0.1;
			nightsky.scrollX = 0;
			nightsky.scrollY = 0;
			mountain.y = 300;
			mountain.scrollX = 0.2;
			mountain.scrollY = 0.2;
			nightskyOverlay.scrollX = 0;
			nightskyOverlay.scrollY = 0;
			dayskyOverlay.scrollX = 0;
			dayskyOverlay.scrollY = 0;
			dayskyOverlay.alpha = 0.2;
			
			graphiclist.add(daysky);
			graphiclist.add(nightsky);
			graphiclist.add(dayskyOverlay);
			graphiclist.add(mountain);
			graphiclist.add(nightskyOverlay);
			
			setDaytime();
			
			graphic = graphiclist;
			layer = Layers.BACKGROUND;
		}
		
		override public function update():void {
			daysky.x += 0.1;
		}
		
		public function setDaytime():void {
			daysky.blend = BlendMode.NORMAL;
			nightsky.visible = false;
			daysky.color = 0xffffff;
			mountain.visible = true;
			nightskyOverlay.visible = false;
			dayskyOverlay.visible = true;
		}
		
		public function setNighttime():void {
			daysky.blend = BlendMode.SUBTRACT;
			daysky.color = 0xffffcc;
			nightsky.visible = true;
			mountain.visible = true;
			nightskyOverlay.visible = true;
			dayskyOverlay.visible = false;
		}
		
	}

}