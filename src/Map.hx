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
		"10000000000011100011" +
		"10000000000000000011" +
		"10000000000000000111" +
		"11111100000000000111" +
		"11111100001100011111" +
		"11111000111100011111" +
		"11111111111111111111" ;

	public function new(theLayer : DisplayObjectContainer) 
	{
		super(20, 12, theLayer);
		loadMap(mapData);
	}
	
	override public function loadMap(MapData: String)
	{
		for ( j in 0...arrayHeight )
		{
			for ( i in 0...arrayWidth )
			{	
				set(new Tile(i, j, 40, 40, "img/mapTiles.png", theLayer, Std.parseInt(MapData.charAt(( j * arrayWidth ) + i ))), i, j);
			}
		}
	}
}