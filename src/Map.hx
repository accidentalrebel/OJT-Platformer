package ;
import jkEngine.JKTileMap;

/**
 * ...
 * @author Karlo
 */

class Map extends JKTileMap
{

	public function new() 
	{
		super(20, 20);
	}
	
	override private function populateTileMap():Void 
	{		
		for ( i in 0...arrayWidth )
		{
			for ( j in 0...arrayHeight )
			{	
				set(new Tile(i, j, "img/tile.png"), i, j);
			}
		}	
	}	
}