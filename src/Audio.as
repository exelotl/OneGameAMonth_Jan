package {
	
	import net.flashpunk.Sfx;
	
	public class Audio {
		
		/**
		 * Play a given sound or a randomly chosen sound from an Array.
		 */
		public static function play(sound:*, vol:Number=1, pan:Number=0):void {
			if (sound is Sfx) {
				(sound as Sfx).play(vol, pan);
			}
			else if (sound is Array) {
				var n:int = Math.random() * (sound as Array).length;
				play(sound[n], vol, pan);
			}
		}
		
		public static function loop(sound:Sfx, vol:Number=1, pan:Number=0):void {
			sound.loop(vol, pan);
		}
		
		public static function stop(sound:Sfx):void {
			sound.stop();
		}
		
		[Embed(source="assets/sfx_footstep.mp3")] private static const SFX_FOOTSTEP:Class;
		[Embed(source="assets/sfx_jump.mp3")] private static const SFX_JUMP:Class;
		[Embed(source="assets/sfx_menu_blip.mp3")] private static const SFX_MENU_BLIP:Class;
		[Embed(source="assets/sfx_menu_open.mp3")] private static const SFX_MENU_OPEN:Class;
		[Embed(source="assets/sfx_player_hurt.mp3")] private static const SFX_PLAYER_HURT:Class;
		[Embed(source="assets/sfx_enemy_hurt_0.mp3")] private static const SFX_ENEMY_HURT_0:Class;
		[Embed(source="assets/sfx_enemy_hurt_1.mp3")] private static const SFX_ENEMY_HURT_1:Class;
		[Embed(source="assets/sfx_enemy_hurt_2.mp3")] private static const SFX_ENEMY_HURT_2:Class;
		[Embed(source="assets/sfx_swipe_0.mp3")] private static const SFX_SWIPE_0:Class;
		[Embed(source="assets/sfx_swipe_1.mp3")] private static const SFX_SWIPE_1:Class;
		[Embed(source="assets/sfx_swipe_2.mp3")] private static const SFX_SWIPE_2:Class;
		[Embed(source="assets/sfx_swipe_3.mp3")] private static const SFX_SWIPE_3:Class;
		[Embed(source="assets/sfx_spikes_expose.mp3")] private static const SFX_SPIKES_EXPOSE:Class;
		
		public static const ENEMY_HURT:Array = [
			new Sfx(SFX_ENEMY_HURT_0),
			new Sfx(SFX_ENEMY_HURT_1),
			new Sfx(SFX_ENEMY_HURT_2) ];
			
		public static const SWIPE:Array = [
			new Sfx(SFX_SWIPE_0),
			new Sfx(SFX_SWIPE_1),
			new Sfx(SFX_SWIPE_2),
			new Sfx(SFX_SWIPE_3) ];
		
		public static const FOOTSTEP:Sfx = new Sfx(SFX_FOOTSTEP);
		public static const JUMP:Sfx = new Sfx(SFX_JUMP);
		public static const MENU_OPEN:Sfx = new Sfx(SFX_MENU_OPEN);
		public static const MENU_BLIP:Sfx = new Sfx(SFX_MENU_BLIP);
		public static const PLAYER_HURT:Sfx = new Sfx(SFX_PLAYER_HURT);
		public static const SPIKES_EXPOSE:Sfx = new Sfx(SFX_SPIKES_EXPOSE);
		
	}
}