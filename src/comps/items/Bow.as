package comps.items {
	import fp.MultiSpritemap;
	import net.flashpunk.graphics.Spritemap;
	
	public class Bow extends Weapon {
		
		[Embed(source="../../assets/bow.png")]
		private static const IMG_BOW:Class;
		
		private var
			sprites:MultiSpritemap,
			inBg:Boolean = true,
			anim:Spritemap = new Spritemap(IMG_BOW, 20, 20);
		
		public function Bow() {
			super();
			
			anim.add("idle_l", [0], 30, false);
			anim.add("idle_r", [4], 30, false);
			anim.add("run_l", [0,1,2,3], 15, true);
			anim.add("run_r", [4,5,6,7], 15, true);
			anim.add("jump_l", [1], 30, false);
			anim.add("jump_r", [5], 30, false);
			anim.add("strike_l", [8,9,10,11], 15, false);
			anim.add("strike_r", [12,13,14,15], 15, false);
			anim.add("drawarrow_l", [16,16,17,18,19], 30, false);
			anim.add("drawarrow_r", [20,20,21,22,23], 30, false);
			anim.add("firearrow_l", [19,18,11,0], 15, false);
			anim.add("firearrow_r", [23,22,15,4], 15, false);
		}
		
		private static const fgNames:Object = {
			"drawarrow_l": true,
			"drawarrow_r": true,
			"firearrow_l": true,
			"firearrow_r": true
		}
		
		override public function update():void {
			if (inBg && fgNames[anim.currentAnim]) {
				bringFront();
			} else if (!inBg && !fgNames[anim.currentAnim]) {
				sendBack();
			}
		}
		
		override public function added():void {
			if (entity.graphic is MultiSpritemap) {
				sprites = entity.graphic as MultiSpritemap;
				sprites.addBg(anim);
			}
		}
		
		override public function removed():void {
			if (sprites)
				sprites.remove(anim);
		}
		
		private function sendBack():void {
			inBg = true;
			sprites.remove(anim);
			sprites.addBg(anim);
		}
		private function bringFront():void {
			inBg = false;
			sprites.remove(anim);
			sprites.addFg(anim);
		}
		
	}
}