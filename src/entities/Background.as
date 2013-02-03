package entities {
	import net.flashpunk.Entity;
	import net.flashpunk.graphics.Backdrop;
	import net.flashpunk.graphics.Graphiclist;
	import net.flashpunk.graphics.Image;
	
	public class Background extends Entity {
			
		[Embed(source="../assets/mountain.png")]
		private static const IMG_MOUNTAIN:Class;
		
		[Embed(source="../assets/webtreats-seamless-cloud-1.jpg")]
		private static const IMG_DAY_SKY:Class;
		
		[Embed(source="../assets/daysky_overlay.png")]
		private static const IMG_DAY_SKY_OVERLAY:Class;
		
		[Embed(source="../assets/nightsky.png")]
		private static const IMG_NIGHTSKY:Class;
		
		[Embed(source="../assets/nightsky_overlay.png")]
		private static const IMG_NIGHTSKY_OVERLAY:Class;
		
		private var
			daysky:Backdrop = new Backdrop(IMG_DAY_SKY),
			nightsky:Image = new Image(IMG_NIGHTSKY),
			mountain:Backdrop = new Backdrop(IMG_MOUNTAIN),
			nightskyOverlay:Image = new Image(IMG_NIGHTSKY_OVERLAY),
			dayskyOverlay:Image = new Image(IMG_DAY_SKY_OVERLAY),
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
			//daysky.visible = true;
			nightsky.visible = false;
			mountain.visible = true;
			nightskyOverlay.visible = false;
			dayskyOverlay.visible = true;
		}
		
		public function setNighttime():void {
			//daysky.visible = true;
			nightsky.visible = true;
			mountain.visible = true;
			nightskyOverlay.visible = true;
			dayskyOverlay.visible = false;
		}
		
	}

}