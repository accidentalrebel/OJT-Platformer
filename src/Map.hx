package ;
import jkEngine.JKTileMap;
import nme.display.DisplayObjectContainer;

/**
 * ...
 * @author Karlo
 */

class Map extends JKTileMap
{
	var mapData : String =
		"1111111111111111" +
		"1000000000000001" +
		"1000000000000001" +
		"1000000000000001" +
		"1000000000000001" +
		"1111100001111001" +
		"1000000000000011" +
		"1000000000000111" +
		"1111110000111111" +
		"1111111111111111" ;
		

	public function new(theLayer : DisplayObjectContainer) 
	{
		super(16, 10, theLayer);
		loadMap(mapData);
	}
	
	override public function loadMap(MapData: String)
	{
		for ( j in 0...arrayHeight )
		{
			for ( i in 0...arrayWidth )
			{	
				set(new Tile(i, j, 50, 50, "img/mapTiles.png", theLayer, Std.parseInt(MapData.charAt(( j * arrayWidth ) + i ))), i, j);
			}
		}
	}
}