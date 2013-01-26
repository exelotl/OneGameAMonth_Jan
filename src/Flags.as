package {
	/**
	 * Game-specific flags that can be applied to entites.
	 * There can be up to 32 different flags.
	 * Usage:
	 * e.flags |= RUNNING        // set a flag
	 * e.flags &= ~RUNNING       // un-set a flag
	 * (e.flags & RUNNING)       // check if flag is set
	 * (e.flags & RUNNING) == 0  // check if flag is not set
	 */
	public class Flags {
		
		public static const
			RUNNING:uint   = 0x00000001,
			ATTACKING:uint = 0x00000002,
			JUMPING:uint   = 0x00000004,
			FLEEING:uint   = 0x00000008;
	}
}