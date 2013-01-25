package ;
import jkEngine.JKGame;
import jkEngine.JKLayer;

/**
 * ...
 * @author Karlo
 */

class Game extends JKGame
{
	var map : Map;
	var player : Player;	
	public var fgLayer : JKLayer;
	public var bgLayer : JKLayer;
	
	public function new() 
	{	
		super();		
		bgLayer = new JKLayer(stage);
		fgLayer = new JKLayer(stage);		
		
		map = new Map(bgLayer);		
		player = new Player(10, 10, "img/player.png", fgLayer);
	}	
}