package {
	
	/**
	 * Groups for various categories of entity go here.
	 */
	public class EntityTypes {
		
		public static const
			LIVING_ENTITIES:Array = ["zombie","player","parachuter","knight","archer","ninja","dragon"],
			FRIENDLY:Array = ["player","knight","archer"],
			ENEMIES:Array = ["zombie","parachuter","ninja","rat","dragon"],
			TRAPPABLE:Array = ["zombie","ninja","rat"],
			SOLIDS:Array = ["ground","roof","tower","trap","keep","battle tower","castle"],
			PROJECTILES_SOLIDS:Array = ["ground","tower","trap","keep","battle tower","castle"],
			ATTACKABLE_SLOTS:Array = ["tower","keep","battle tower","castle"];
	}
}