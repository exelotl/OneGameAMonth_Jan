package  {
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	
	public class Sprites {
		
		[Embed(source="assets/battle_tower.png")] private static const IMG_BATTLE_TOWER:Class;
		[Embed(source="assets/bow.png")] private static const IMG_BOW:Class;
		[Embed(source="assets/btn_skip.png")] private static const IMG_BTN_SKIP:Class;
		[Embed(source="assets/castle.png")] private static const IMG_CASTLE:Class;
		[Embed(source="assets/cave_l.png")] private static const IMG_CAVE_L:Class;
		[Embed(source="assets/cave_l_overlay.png")] private static const IMG_CAVE_L_OVERLAY:Class;
		[Embed(source="assets/cave_r.png")] private static const IMG_CAVE_R:Class;
		[Embed(source="assets/cave_r_overlay.png")] private static const IMG_CAVE_R_OVERLAY:Class;
		[Embed(source="assets/clock.png")] private static const IMG_CLOCK:Class;
		[Embed(source="assets/coin_spin.png")] private static const IMG_COIN_SPIN:Class;
		[Embed(source="assets/crown_sheet.png")] private static const IMG_CROWN:Class;
		[Embed(source="assets/daysky_overlay.png")] private static const IMG_DAYSKY_OVERLAY:Class;
		[Embed(source="assets/dragon.png")] private static const IMG_DRAGON:Class;
		[Embed(source="assets/fireball.png")] private static const IMG_FIREBALL:Class;
		[Embed(source="assets/gameover.png")] private static const IMG_GAMEOVER:Class;
		[Embed(source="assets/heart.png")] private static const IMG_HEART:Class;
		[Embed(source="assets/helmet.png")] private static const IMG_HELMET:Class;
		[Embed(source="assets/keep.png")] private static const IMG_KEEP:Class;
		[Embed(source="assets/keep_roof.png")] private static const IMG_KEEP_ROOF:Class;
		[Embed(source="assets/knight.png")] private static const IMG_KNIGHT:Class;
		[Embed(source="assets/land.png")] private static const IMG_LAND:Class;
		[Embed(source="assets/land_empty.png")] private static const IMG_LAND_EMPTY:Class;
		[Embed(source="assets/mountain.png")] private static const IMG_MOUNTAIN:Class;
		[Embed(source="assets/nightsky.png")] private static const IMG_NIGHTSKY:Class;
		[Embed(source="assets/nightsky_overlay.png")] private static const IMG_NIGHTSKY_OVERLAY:Class;
		[Embed(source="assets/ninja.png")] private static const IMG_NINJA:Class;
		[Embed(source="assets/parachuter_zombie.png")] private static const IMG_PARACHUTER_ZOMBIE:Class;
		[Embed(source="assets/player.png")] private static const IMG_PLAYER:Class;
		[Embed(source="assets/rat.png")] private static const IMG_RAT:Class;
		[Embed(source="assets/shield.png")] private static const IMG_SHIELD:Class;
		[Embed(source="assets/star.png")] private static const IMG_STAR:Class;
		[Embed(source="assets/sword.png")] private static const IMG_SWORD:Class;
		[Embed(source="assets/title_screen.png")] private static const IMG_TITLE_SCREEN:Class;
		[Embed(source="assets/tower.png")] private static const IMG_TOWER:Class;
		[Embed(source="assets/trap.png")] private static const IMG_TRAP:Class;
		[Embed(source="assets/trap_spikes.png")] private static const IMG_TRAP_SPIKES:Class;
		[Embed(source="assets/webtreats-seamless-cloud-1.jpg")] private static const IMG_CLOUDS:Class;
		[Embed(source="assets/zombie.png")] private static const IMG_ZOMBIE:Class;

		public static var BATTLE_TOWER:BitmapData = new IMG_BATTLE_TOWER().bitmapData;
		public static var BOW:BitmapData = new IMG_BOW().bitmapData;
		public static var BTN_SKIP:BitmapData = new IMG_BTN_SKIP().bitmapData;
		public static var CASTLE:BitmapData = new IMG_CASTLE().bitmapData;
		public static var CAVE_L:BitmapData = new IMG_CAVE_L().bitmapData;
		public static var CAVE_L_OVERLAY:BitmapData = new IMG_CAVE_L_OVERLAY().bitmapData;
		public static var CAVE_R:BitmapData = new IMG_CAVE_R().bitmapData;
		public static var CAVE_R_OVERLAY:BitmapData = new IMG_CAVE_R_OVERLAY().bitmapData;
		public static var CLOCK:BitmapData = new IMG_CLOCK().bitmapData;
		public static var COIN_SPIN:BitmapData = new IMG_COIN_SPIN().bitmapData;
		public static var CROWN:BitmapData = new IMG_CROWN().bitmapData;
		public static var DAYSKY_OVERLAY:BitmapData = new IMG_DAYSKY_OVERLAY().bitmapData;
		public static var DRAGON:BitmapData = new IMG_DRAGON().bitmapData;
		public static var FIREBALL:BitmapData = new IMG_FIREBALL().bitmapData;
		public static var GAMEOVER:BitmapData = new IMG_GAMEOVER().bitmapData;
		public static var HEART:BitmapData = new IMG_HEART().bitmapData;
		public static var HELMET:BitmapData = new IMG_HELMET().bitmapData;
		public static var KEEP:BitmapData = new IMG_KEEP().bitmapData;
		public static var KEEP_ROOF:BitmapData = new IMG_KEEP_ROOF().bitmapData;
		public static var KNIGHT:BitmapData = new IMG_KNIGHT().bitmapData;
		public static var LAND:BitmapData = new IMG_LAND().bitmapData;
		public static var LAND_EMPTY:BitmapData = new IMG_LAND_EMPTY().bitmapData;
		public static var MOUNTAIN:BitmapData = new IMG_MOUNTAIN().bitmapData;
		public static var NIGHTSKY:BitmapData = new IMG_NIGHTSKY().bitmapData;
		public static var NIGHTSKY_OVERLAY:BitmapData = new IMG_NIGHTSKY_OVERLAY().bitmapData;
		public static var NINJA:BitmapData = new IMG_NINJA().bitmapData;
		public static var PARACHUTER_ZOMBIE:BitmapData = new IMG_PARACHUTER_ZOMBIE().bitmapData;
		public static var PLAYER:BitmapData = new IMG_PLAYER().bitmapData;
		public static var RAT:BitmapData = new IMG_RAT().bitmapData;
		public static var SHIELD:BitmapData = new IMG_SHIELD().bitmapData;
		public static var STAR:BitmapData = new IMG_STAR().bitmapData;
		public static var SWORD:BitmapData = new IMG_SWORD().bitmapData;
		public static var TITLE_SCREEN:BitmapData = new IMG_TITLE_SCREEN().bitmapData;
		public static var TOWER:BitmapData = new IMG_TOWER().bitmapData;
		public static var TRAP:BitmapData = new IMG_TRAP().bitmapData;
		public static var TRAP_SPIKES:BitmapData = new IMG_TRAP_SPIKES().bitmapData;
		public static var CLOUDS:BitmapData = new IMG_CLOUDS().bitmapData;
		public static var ZOMBIE:BitmapData = new IMG_ZOMBIE().bitmapData;

	}

}