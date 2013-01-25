package ;
import jkEngine.JKTile;
import nme.display.DisplayObjectContainer;
import nme.Lib;

/**
 * ...
 * @author Karlo
 */

class Tile extends JKTile
{	
	public function new( XCoord : Int = 0, YCoord : Int = 0, ?TileWidth : Float
		, ?TileHeight : Float, ?graphicFileLocation : String, ?theLayer : DisplayObjectContainer, TileValue : Int = 0 ) 
	{
		super(XCoord, YCoord, TileWidth, TileHeight, graphicFileLocation, theLayer, TileValue);		
		setTileGraphic(TileValue);
	}
	
	function setTileGraphic(TileValue : Int)
	{
		currentFrame = TileValue;
		updateGraphicRect();
	}
}