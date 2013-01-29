package {
	
	public class Wave {
		
		public static var gameSequence:Array = [
			{
				name: "Welcome",
				note: "Arrows to move, X to jump!",
				time: 10,
				canSkip: true
			},
			{
				name: "Build Something",
				note: "On a patch of land, use Z to open a menu.\nPress Up/Down and Enter to select.",
				time: 30,
				canSkip: true
			},
			{
				name: "Zombies",
				note: "Press C to swipe your sword, defend the castle!",
				time: 60,
				spawns: ["zombie"],
				difficulty: 1
			},
			{
				name: "Wave over",
				note: "Now would be a good time to apply some upgrades.",
				time: 30,
				canSkip: true
			},
			{
				name: "That's it for now."
			},
		];
		
		public static const
			DAY:uint = 1,
			NIGHT:uint = 1;
		
		public var
			name:String,
			note:String,
			time:Number,
			spawns:Array,
			difficulty:Number,
			canSkip:Boolean;
		
		public function Wave(data:Object=null) {
			if (data == null) data = {};
			name = data.name || "";
			note = data.note || "";
			time = data.time || 60;
			spawns = data.spawns || [];
			difficulty = data.difficulty || 1;
			canSkip = data.canSkip || false;
		}
		
	}
}