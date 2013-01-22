package ui {
	import entities.slots.Slot;
	import flash.geom.Rectangle;
	import net.flashpunk.Entity;
	import net.flashpunk.FP;
	import net.flashpunk.Graphic;
	import net.flashpunk.graphics.Canvas;
	import net.flashpunk.graphics.Graphiclist;
	import net.flashpunk.graphics.Text;
	import net.flashpunk.tweens.misc.NumTween;
	import net.flashpunk.utils.Input;
	
	public class UpgradeMenu extends Entity {
		
		private static const
			MARGIN_TOP:int = 54,
			TITLE_HEIGHT:int = 20,
			LINE_HEIGHT:int = 17;
		
		private var
			slot:Slot,
			currentUpgrade:Upgrade,
			graphicList:Graphiclist,
			background:Canvas,
			highlight:Canvas,
			titleText:Text,
			commentText:Text,
			items:/*MenuItem*/Array = [],
			textGraphics:/*Text*/Array = [];
			
		public function UpgradeMenu(slot:Slot) {
			this.slot = slot;
			currentUpgrade = slot.currentUpgrade;
			width = 160;
			height = 160;
			graphicList = new Graphiclist();
			graphic = graphicList;
			
			background = new Canvas(width, height);
			background.fill(new Rectangle(0,0,width,height), 0xaaaaff, 0.9);
			
			highlight = new Canvas(width, LINE_HEIGHT);
			highlight.fill(new Rectangle(0,0,width,LINE_HEIGHT), 0xeeeeee, 0.5);
			
			titleText = new Text(currentUpgrade.name, 0, 0, {
				font: "title_font",
				size: 8,
				align: "center",
				resizable: false,
				width: width,
				height: TITLE_HEIGHT,
				color: 0x000000,
				alpha: 0.8
			});
			commentText = new Text(currentUpgrade.description, 6, 20, {
				font: "normal_font",
				size: 8,
				align: "left",
				wordWrap: true,
				resizable: false,
				width: width-12,
				height: LINE_HEIGHT*2,
				color: 0x000000,
				alpha: 0.6
			});
			
			graphicList.add(background);
			graphicList.add(highlight);
			graphicList.add(titleText);
			graphicList.add(commentText);
			
			for each (var u:Upgrade in slot.upgrades) {
				addUpgrade(u);
			}
			
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
		
		// TODO: keyboard-based input, move input to a separate component
		override public function update():void {
			var mX:Number = Input.mouseX + FP.camera.x;
			var mY:Number = Input.mouseY + FP.camera.y - MARGIN_TOP;
			var line:int = (mY + y) / LINE_HEIGHT
			
			if (mX > x && mX < x+width && line >= 0 && line < items.length) {
				highlight.visible = true;
				highlight.y = MARGIN_TOP + line*LINE_HEIGHT;
				if (Input.mousePressed) {
					items[line].select();
				}
			} else {
				highlight.visible = false;
			}
		}
		
		public function addUpgrade(upgrade:Upgrade):void {
			addItem(new MenuItem(upgrade.name, function ():void {
				slot.requestUpgrade(upgrade);
			}));
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