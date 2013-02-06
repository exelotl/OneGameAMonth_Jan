package {
	import net.flashpunk.Tween;
	
	public class Wave {
		
		public static var gameSequence:Array = [
			{
				name: "Welcome",
				note: "You are the king of a small town.\nArrows to move, X to jump!",
				time: 30,
				canSkip: true,
				timeOfDay: DAY
			},
			{
				name: "Parachuting zombies!",
				note: "What is this madness?",
				time: 50,
				spawns: [{type:"parachuter", amount:20}],
				difficulty: 1
			}
			/*{
				name: "Welcome",
				note: "You are the king of a small town.\nArrows to move, X to jump!",
				time: 1,
				canSkip: true,
				timeOfDay: DAY
			},
			{
				name: "Build Something!",
				note: "Press Z to open an upgrade menu.\nUse Up/Down and Enter to choose an upgrade.",
				time: 20,
				canSkip: true,
				timeOfDay: DAY
			},
			{
				name: "Zombies",
				note: "Press C to swipe your sword, defend the castle!",
				time: 50,
				spawns: [{type:"zombie", amount:10}],
				difficulty: 1
			},
			{
				name: "Wave over",
				note: "Now would be a good time to apply some upgrades.",
				time: 20,
				canSkip: true,
				timeOfDay: DAY
			},
			{
				name: "Giant Rats",
				note: "We're just getting started.",
				time: 50,
				spawns: [{type:"rat", amount:20}],
				difficulty: 1
			},
			{
				name: "Wave over",
				note: "Give yourself a pat on the back.",
				time: 20,
				canSkip: true,
				timeOfDay: DAY
			},
			{
				name: "Parachuting zombies!",
				note: "What is this madness?",
				time: 50,
				spawns: [{type:"parachuter", amount:8}, {type:"zombie", amount:8}],
				difficulty: 1
			},
			{
				name: "Wave complete",
				note: "Your knights have spotted some pirates in the distance",
				time: 20,
				canSkip: true,
				timeOfDay: DAY
			},
			{
				name: "Ninja ambush!",
				note: "Those sneaky bastards.",
				time: 50,
				spawns: [{type:"ninja", amount:10}],
				difficulty: 1
			},
			{
				name: "The pirates were a lie.",
				note: "At least you killed the ninjas.",
				time: 20,
				canSkip: true,
				timeOfDay: DAY
			},
			{
				name: "Rats and zombies?",
				note: "Who's idea was this?",
				time: 50,
				spawns: [
					{type:"rat", amount:12},
					{type:"parachuter", amount:6},
					{type:"zombie", amount:10}
				],
				difficulty: 1
			},
			{
				name: "Wave complete",
				note: "Your knights can see some delicious cake in the distance",
				time: 20,
				canSkip: true,
				timeOfDay: DAY
			},
			{
				name: "Ninja revenge!",
				note: "Shiver me timbers!",
				time: 60,
				spawns: [{type:"ninja", amount:20}, {type:"rat", amount:6}],
				difficulty: 1
			},
			{
				name: "The cake is a lie. (see what I did there?)",
				note: "Your soliders have spotted a dragon in the distance.",
				time: 20,
				canSkip: true,
				timeOfDay: DAY
			},
			{
				name: "THE DRAGON WAS NOT A LIE!",
				note: "You're all doomed.",
				time: 60,
				spawns: [{type:"dragon", amount:1}],
				difficulty: 1
			},
			{
				name: "Wave complete!",
				note: "Oh, you're still here?",
				time: 20,
				canSkip: true,
				timeOfDay: DAY
			},
			{
				name: "Story mode over.",
				note: "Now see how far you can get with the random waves.",
				time: 5,
				timeOfDay: DAY
			}*/
		];
		
		public static const
			DAY:uint = 1,
			NIGHT:uint = 0;
		
		public var
			timeOfDay:uint,
			title:String,
			note:String,
			time:Number,
			spawns:Array,
			difficulty:Number,
			canSkip:Boolean,
			spawner:MobSpawner;
		
		public function Wave(data:Object = null) {
			if (data == null) data = {};
			title = data.name || "";
			note = data.note || "";
			time = data.time || 50;
			timeOfDay = data.timeOfDay || NIGHT;
			time += 10; // to make sure all mobs reached the castle
			spawns = data.spawns || [];
			difficulty = data.difficulty || 1;
			canSkip = data.canSkip || false;
			spawner = new MobSpawner(spawns, this);
		}
		
		public function startSpawning():void {
			spawner.start();
		}
	}
}