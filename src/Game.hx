package ;
import jkEngine.JKGame;

/**
 * ...
 * @author Karlo
 */

class Game extends JKGame
{
	var map : Map;
	
	public function new() 
	{	
		super();		
		map = new Map();
	}	
}