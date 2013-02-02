package {

	public class PauseWave extends Wave {
		
		public function PauseWave() {
			super({
				name: "Rest time",
				note: "Have a cup of tea.",
				time: 10,
				canSkip: true,
				timeOfDay: Wave.DAY
			});
		}
	}
}