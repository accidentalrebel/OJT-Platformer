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
		Registry.game = this;
		
		super();		
		bgLayer = new JKLayer(stage);
		fgLayer = new JKLayer(stage);		
		
		map = new Map(bgLayer);		
		
		Registry.object2 = new Tile(5, 8, 40, 40, "img/mapTiles.png", bgLayer, 1);
		
		player = new Player(200, 200, 40, 50, "img/player.png", true, fgLayer);
		player.play("idle");
	}	
}