package entities {
	import net.flashpunk.Entity;
	import net.flashpunk.graphics.Backdrop;
	import net.flashpunk.graphics.Graphiclist;
	import net.flashpunk.graphics.Image;
	
	public class Background extends Entity {
			
		[Embed(source="../assets/mountain.png")]
		private static const IMG_MOUNTAIN:Class;
		
		[Embed(source="../assets/nightsky.png")]
		private static const IMG_NIGHTSKY:Class;
		
		[Embed(source="../assets/nightsky_overlay.png")]
		private static const IMG_NIGHTSKY_OVERLAY:Class;
		
		private var
			nightsky:Image = new Image(IMG_NIGHTSKY),
			mountain:Backdrop = new Backdrop(IMG_MOUNTAIN),
			nightskyOverlay:Image = new Image(IMG_NIGHTSKY_OVERLAY),
			graphiclist:Graphiclist = new Graphiclist();
		
		public function Background() {
			
			nightsky.scrollX = 0;
			nightsky.scrollY = 0;
			mountain.y = 300;
			mountain.scrollX = 0.2;
			mountain.scrollY = 0.2;
			nightskyOverlay.scrollX = 0;
			nightskyOverlay.scrollY = 0;
			
			graphiclist.add(nightsky);
			graphiclist.add(mountain);
			graphiclist.add(nightskyOverlay);
			graphic = graphiclist;
			layer = Layers.BACKGROUND;
		}
		
	}

}