package ui {
	import net.flashpunk.Entity;
	import net.flashpunk.Graphic;
	import net.flashpunk.graphics.Canvas;
	import net.flashpunk.graphics.Graphiclist;
	import net.flashpunk.graphics.Text;

	public class UpgradeSelector extends Entity {
		
		private static const LINE_HEIGHT:int = 12;
		
		private var
			graphicList:Graphiclist,
			background:Canvas,
			highlight:Canvas,
			items:/*MenuItem*/Array = [],
			textGraphics:/*Text*/Array = [];
			
		
		public function UpgradeSelector(x:Number=0, y:Number=0) {
			super(x, y);
			width = 160;
			height = 160;
			graphicList = new Graphiclist();
			graphic = graphicList;
			
			background = new Canvas(width, height);
			highlight = new Canvas(width, LINE_HEIGHT);
			graphicList.add(background);
			graphicList.add(highlight);
		}
		
		override public function update():void {
			
		}
		
		public function addItem(item:MenuItem):void {
			items.push(item);
			var properties:Object = {
				font: "atari",
				size: 8,
				align: "left",
				wordWrap: true,
				resizable: false,
				width: this.width,
				height: LINE_HEIGHT,
				color: 0xffffff,
				alpha: 1
			};
			
			textGraphics.push(new Text(item.text,0, items.length * LINE_HEIGHT, properties));
		}
		
	}

}