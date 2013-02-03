package {
	
	/**
	 * Groups for various categories of entity go here.
	 */
	public class EntityTypes {
		
		public static const
			LIVING_ENTITIES:Array = ["enemy","zombie","player","knight","archer","ninja"],
			FRIENDLY:Array = ["player","knight","archer"],
			ENEMIES:Array = ["enemy","zombie","ninja","rat"],
			SOLIDS:Array = ["ground","roof","tower","keep","battle tower","castle"],
			PROJECTILES_SOLIDS:Array = ["ground","tower","keep","battle tower","castle"],
			ATTACKABLE_SLOTS:Array = ["tower","keep","battle tower","castle"];
	}
}