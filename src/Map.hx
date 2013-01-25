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
		"10000000000000000000" +
		"01000000000000000010" +
		"00000000000000000000" +
		"00000000000000000000" +
		"00000000000000000000" +
		"00000000000000000000" +
		"00000000000000000000" +
		"00000000000000000000" +
		"00000000000000000000" +
		"00000000000000000000" +
		"00000000000000000000" +
		"00000000000000000000" +
		"00000000000000000000" +
		"00000000000000000000" +
		"00000000000000000000" +
		"00000000000000000000" +
		"00000000000000000000" +
		"00000000000000000000" +
		"00000000000000000000" +
		"00000000000000000000" +
		"00000000000000000000";

	public function new(theLayer : DisplayObjectContainer) 
	{
		super(20, 20, theLayer);
		loadMap(mapData);
	}
	
	override public function loadMap(MapData: String)
	{
		for ( i in 0...arrayWidth )
		{
			for ( j in 0...arrayHeight )
			{	
				set(new Tile(i, j, theLayer, Std.parseInt(MapData.charAt(
					( i * arrayHeight ) + j ))
					), i, j);
			}
		}
	}
}