package {
	
	public class Wave {
		
		public static var sequence:Array = [
			{
				name: "Welcome",
				note: "Arrows to move, X to jump!",
				time: 10,
				canSkip: true,
			},
			{
				name: "Build Something",
				note: "On a patch of land, use Z to open a menu.\nPress Up/Down and Enter to select.",
				time: 30,
				canSkip: true,
			}
			{
				name: "Zombies",
				note: "Press C to swipe your sword, defend the castle!",
				time: 60,
				spawn: ["zombie"],
				difficulty: 1,
			},
			{
				name: "Wave over",
				note: "Now would be a good time to apply some upgrades."
				time: 30,
				canSkip: true,
			},
			{
				name: "That's it for now."
			},
		];
		
		
		public function Wave() {
			
		}
		
	}
}