package ;
import jkEngine.JKGame;
import jkEngine.JKSprite;

/**
 * ...
 * @author Karlo
 */

class Game extends JKGame
{
	var map : Map;
	var player : Player;	
	var gameLayer : JKSprite;
	
	public function new() 
	{	
		super();		
		gameLayer = new JKSprite();
		stage.addChild(gameLayer);
		
		//map = new Map();
		//gameLayer.addChild(map);
		
		player = new Player(10, 10, "img/player.png", stage);
	}	
}