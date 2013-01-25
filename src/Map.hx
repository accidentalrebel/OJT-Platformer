package ;
import jkEngine.JKTileMap;
import nme.display.DisplayObjectContainer;

/**
 * ...
 * @author Karlo
 */

class Map extends JKTileMap
{

	public function new(theLayer : DisplayObjectContainer) 
	{
		super(20, 20, theLayer);
	}
	
	override private function populateTileMap(theLayer : DisplayObjectContainer):Void 
	{		
		for ( i in 0...arrayWidth )
		{
			for ( j in 0...arrayHeight )
			{	
				set(new Tile(i, j, "img/tile.png", theLayer), i, j);
			}
		}	
	}	
}