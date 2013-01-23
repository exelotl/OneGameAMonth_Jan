package comps.items {
	import fp.MultiSpritemap;
	import net.flashpunk.Component;
	import net.flashpunk.graphics.Spritemap;
	
	/**
	 * Note that the entity's graphics component must be set to a
	 * MultiSpritemap for the sword graphics to take effect.
	 */
	public class Sword extends Component {
		
		[Embed(source="../../assets/sword.png")]
		private static const IMG_SWORD:Class;
		
		private var
			anim:Spritemap = new Spritemap(IMG_SWORD, 20, 20);
		
		public function Sword() {
			anim.add("idle_l", [0], 30, false);
			anim.add("idle_r", [4], 30, false);
			anim.add("run_l", [0,1,2,3], 15, true);
			anim.add("run_r", [4,5,6,7], 15, true);
			anim.add("jump_l", [1], 30, false);
			anim.add("jump_r", [5], 30, false);
			anim.add("strike_l", [8,9,10,10,11], 30, false);
			anim.add("strike_r", [12,13,14,14,15], 30, false);
		}
		
		override public function added():void {
			if (entity.graphic is MultiSpritemap) {
				var sprites:MultiSpritemap = entity.graphic as MultiSpritemap;
				sprites.addBg(anim);
			}
		}
		
		override public function removed():void {
			if (entity.graphic is MultiSpritemap) {
				var sprites:MultiSpritemap = entity.graphic as MultiSpritemap;
				sprites.remove(anim);
			}
		}
	}
}