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
	public function new( XCoord : Int = 0, YCoord : Int = 0, ?theWidth : Float
		, ?theHeight : Float, ?graphicFileLocation : String, ?theLayer : DisplayObjectContainer, TileValue : Int = 0 ) 
	{
		Lib.trace(XCoord + "," + YCoord + " my value is " + TileValue);
		super(XCoord, YCoord, theWidth, theHeight, graphicFileLocation, theLayer, TileValue);
	}
}