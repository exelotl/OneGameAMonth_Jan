package {
	import entities.LivingEntity;
	import flash.display.Sprite;
	import flash.display.StageQuality;
	import flash.events.Event;
	import net.flashpunk.Engine;
	import net.flashpunk.FP;
	import states.GameOverWorld;
	import states.MenuWorld;
	import states.PlayWorld;
	import states.SplashWorld;
	
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
			splashWorld:SplashWorld,
			menuWorld:MenuWorld,
			playWorld:PlayWorld,
			gameOverWorld:GameOverWorld;
		
		public function Main() {
			super(600, 400, 60);
		}
		
		override public function init():void {
			stage.quality = StageQuality.LOW;
			
			splashWorld = new SplashWorld();
			splashWorld.onComplete.add(switchToMenu);
			
			menuWorld = new MenuWorld();
			menuWorld.onPlay.add(startNewGame);
			
			gameOverWorld = new GameOverWorld();
			gameOverWorld.onPlayAgain.add(startNewGame);
			
			FP.world = splashWorld;
		}
		
		private function startNewGame():void {
			playWorld = new PlayWorld();
			playWorld.onGameOver.add(switchToGameOver);
			FP.world = playWorld;
		}
		
		private function switchToMenu():void {
			FP.world = menuWorld;
		}
		
		private function switchToGameOver():void {
			FP.world = gameOverWorld;
		}
	}
}