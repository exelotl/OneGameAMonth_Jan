package comps {
	import entities.Player;
	import net.flashpunk.Component;
	import net.flashpunk.Sfx;
	
	public class PlayerSound extends Component {
		
		[Embed(source="../assets/sfx_footstep.mp3")]
		private static const SFX_FOOTSTEP:Class;
		
		[Embed(source="../assets/sfx_swipe_1.mp3")]
		private static const SFX_SWIPE_1:Class;
		
		[Embed(source="../assets/sfx_swipe_2.mp3")]
		private static const SFX_SWIPE_2:Class;
		
		[Embed(source="../assets/sfx_swipe_3.mp3")]
		private static const SFX_SWIPE_3:Class;
		
		[Embed(source="../assets/sfx_swipe_4.mp3")]
		private static const SFX_SWIPE_4:Class;
		
		private var
			player:Player,
			sfxFootstep:Sfx = new Sfx(SFX_FOOTSTEP),
			sfxSwipe:/*Sfx*/Array = [
				new Sfx(SFX_SWIPE_1),
				new Sfx(SFX_SWIPE_2),
				new Sfx(SFX_SWIPE_3),
				new Sfx(SFX_SWIPE_4)
			];
			
		
		public function PlayerSound() {
			
		}
		
		override public function added():void {
			player = entity as Player;
		}
		
		private var playingSwipe:Boolean = false;
		
		override public function update():void {
			var canPlayFootsteps:Boolean = (player.flags & Flags.RUNNING) && !(player.flags & Flags.JUMPING);
			
			if (sfxFootstep.playing) {
				if (!canPlayFootsteps)
					sfxFootstep.stop();
			} else {
				if (canPlayFootsteps)
					sfxFootstep.loop(0.2);
			}
			
			if (player.flags & Flags.ATTACKING) {
				if (!playingSwipe) {
					sfxSwipe[int(Math.random()*4)].play(Math.random()*0.2+0.4);
					playingSwipe = true;
				}
			} else {
				if (playingSwipe) playingSwipe = false;
			}
		}
		
	}
}