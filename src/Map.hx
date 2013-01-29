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
		"11111111111111111111" +
		"10000000000000000001" +
		"10000000000000000001" +
		"10000000000000000001" +
		"10000000000000000001" +
		"10000001100001100001" +
		"11100000000000000001" +
		"11100000000000000111" +
		"11111100000000000111" +
		"11111100000000011111" +
		"11111111100000011111" +
		"11111111111111111111" ;

	public function new(theLayer : DisplayObjectContainer) 
	{
		super(20, 12, theLayer);
		
		//populateTileMap(Tile, [0, 0, 40, 40, "img/mapTiles.png", theLayer, 1]);
		loadMap(mapData, Tile, [0, 0, 40, 40, "img/mapTiles.png", theLayer]);
	}
}