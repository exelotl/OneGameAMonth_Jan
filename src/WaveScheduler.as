package  {
	import net.flashpunk.Entity;
	import net.flashpunk.graphics.Text;
	import net.flashpunk.Signal;
	import net.flashpunk.Tween;
	import net.flashpunk.tweens.misc.NumTween;
	import net.flashpunk.utils.Ease;
	
	public class WaveScheduler extends Entity {
		
		private var
			currentWave:Wave,
			waveName:Text = new Text("", 10, 20),
			waveNote:Text = new Text("", 10, 40),
			alphaTween:NumTween,
			onEndWave:Tween,
			waveIndex:int = -1;
		
		public function WaveScheduler() {
			waveName.scrollX = 0; waveName.scrollY = 0;
			waveNote.scrollX = 0; waveNote.scrollY = 0;
			waveName.alpha = 0;
			waveNote.alpha = 0;
			alphaTween = new NumTween();
			addTween(alphaTween);
		}
		
		
		private function startNewWave():void {
			if (onEndWave) {
				if (onEndWave.active) removeTween(onEndWave);
			}
			waveIndex++;
			if (waveIndex < Wave.gameSequence.length) {
				setWave(new Wave(Wave.gameSequence[waveIndex]));
				onEndWave = new Tween(currentWave.time, Tween.ONESHOT, startNewWave);
				if (!onEndWave.active) addTween(onEndWave, true);
			} else trace("bring us the random generated waves");
		}
		
		override public function added():void {
			addGraphic(waveName);
			addGraphic(waveNote);
			startNewWave();
		}
		
		override public function update():void {
			if (alphaTween) {
				waveName.alpha = alphaTween.value;
				waveNote.alpha = alphaTween.value;
			}
		}
		
		public function setWave(wave:Wave):void {
			currentWave = wave;
			waveName.text = currentWave.title;
			waveNote.text = currentWave.note;
			alphaTween.tween(0, 1, 2.0, Ease.backInOut);
			currentWave.startSpawning();
		}
	}
}