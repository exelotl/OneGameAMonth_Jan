package {
	import flash.display.Sprite;
	import flash.events.Event;
	import net.flashpunk.Engine;
	import net.flashpunk.FP;
	import states.MenuWorld;
	import states.PlayWorld;
	
	[SWF(width='600', height='400', frameRate='60')]
	
	/**
	 * @author SimonM, geckojsc, allyally
	 */
	public class Main extends Engine {
		
		[Embed(source="assets/Schoenecker1055.ttf", fontFamily="title_font", embedAsCFF="false")]
		public static const TITLE_FONT:String;
		[Embed(source="assets/Mono0755.ttf", fontFamily="normal_font", embedAsCFF="false")]
		public static const NORMAL_FONT:String;
		
		private var
			menuWorld:MenuWorld,
			playWorld:PlayWorld;
		
		public function Main() {
			super(600, 400, 60);
		}
		
		override public function init():void {
			menuWorld = new MenuWorld();
			playWorld = new PlayWorld();
			menuWorld.onPlay.add(switchToPlayWorld);
			FP.world = playWorld;
		}
		
		private function switchToPlayWorld():void {
			FP.world = playWorld;
		}
	}
}