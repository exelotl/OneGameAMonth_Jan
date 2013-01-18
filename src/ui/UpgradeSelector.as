package ui {
	import flash.geom.Rectangle;
	import net.flashpunk.Entity;
	import net.flashpunk.Graphic;
	import net.flashpunk.graphics.Canvas;
	import net.flashpunk.graphics.Graphiclist;
	import net.flashpunk.graphics.Text;
	import net.flashpunk.utils.Input;

	public class UpgradeSelector extends Entity {
		
		private static const
			MARGIN_TOP:int = 54,
			TITLE_HEIGHT:int = 20,
			LINE_HEIGHT:int = 17;
		
		private var
			graphicList:Graphiclist,
			background:Canvas,
			highlight:Canvas,
			titleText:Text,
			commentText:Text,
			items:/*MenuItem*/Array = [],
			textGraphics:/*Text*/Array = [];
			
		public function UpgradeSelector(x:Number=0, y:Number=0, title:String="", comment:String="") {
			super(x, y);
			width = 160;
			height = 160;
			graphicList = new Graphiclist();
			graphic = graphicList;
			
			background = new Canvas(width, height);
			background.fill(new Rectangle(0,0,width,height), 0xaaaaaa);
			
			highlight = new Canvas(width, LINE_HEIGHT);
			highlight.fill(new Rectangle(0,0,width,LINE_HEIGHT), 0xcccccc);
			
			titleText = new Text(title, 0, 0, {
				font: "title_font",
				size: 8,
				align: "center",
				resizable: false,
				width: width,
				height: TITLE_HEIGHT,
				color: 0x444444,
				alpha: 1
			});
			commentText = new Text(comment, 6, 20, {
				font: "normal_font",
				size: 8,
				align: "left",
				wordWrap: true,
				resizable: false,
				width: width-12,
				height: LINE_HEIGHT*2,
				color: 0x666666,
				alpha: 1
			});
			
			graphicList.add(background);
			graphicList.add(highlight);
			graphicList.add(titleText);
			graphicList.add(commentText);
		}
		
		public function get title():String {
			return titleText.text;
		}
		public function set title(val:String):void {
			titleText.text = val;
		}
		public function get comment():String {
			return commentText.text;
		}
		public function set comment(val:String):void {
			commentText.text = val;
		}
		
		override public function update():void {
			var line:int = ((Input.mouseY + y) - MARGIN_TOP) / LINE_HEIGHT
			
			if (Input.mouseX > x && Input.mouseX < x+width
			&& line >= 0 && line < items.length) {
				
				highlight.visible = true;
				highlight.y = MARGIN_TOP + line*LINE_HEIGHT;
				if (Input.mousePressed) {
					items[line].select();
				}
				
			} else {
				highlight.visible = false;
			}
		}
		
		public function addItem(item:MenuItem):void {
			var properties:Object = {
				font: "normal_font",
				size: 8,
				align: "left",
				wordWrap: true,
				resizable: false,
				width: width-20,
				height: LINE_HEIGHT,
				color: 0x000000,
				alpha: 1
			};
			var text:Text = new Text(item.text, 10, MARGIN_TOP + items.length*LINE_HEIGHT, properties);
			items.push(item);
			textGraphics.push(text);
			graphicList.add(text);
		}
		
	}

}