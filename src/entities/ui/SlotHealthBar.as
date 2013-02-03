package entities.ui {
	import entities.slots.Slot;
	import flash.display.BitmapData;
	import flash.geom.Rectangle;
	import net.flashpunk.Entity;
	import net.flashpunk.graphics.Canvas;
	import net.flashpunk.graphics.Image;
	import net.flashpunk.Tween;
	import net.flashpunk.tweens.misc.ColorTween;
	
	/**
	 * @author geckojsc
	 */
	public class SlotHealthBar extends Entity {
		
		private var
			barColor:ColorTween,
			slot:Slot,
			barBg:Canvas = new Canvas(182, 6),
			bar:Image = new Image(new BitmapData(180, 2, false, 0xffffffff));
		
		public function SlotHealthBar(slot:Slot) {
			super(slot.x + 10, slot.y + 60);
			this.slot = slot;
			layer = Layers.SLOT_GUI;
			
			barBg.x = -1;
			barBg.y = -2;
			barBg.fill(new Rectangle(0,0,182,8), 0xaaccff);
			addGraphic(barBg);
			addGraphic(bar);
			
			addTween(barColor = new ColorTween(null, Tween.LOOPING));
			barColor.tween(99, 0xff0000, 0x00ff00);
			bar.color = 0xff00ff00;
		}
		
		override public function update():void {
			barColor.percent = slot.health/slot.maxHealth;
			bar.color = 0xff000000 + barColor.color;
			bar.scaleX = slot.health/slot.maxHealth;
		}
		
	}

}