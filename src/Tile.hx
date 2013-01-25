package ;
import jkEngine.JKTile;
import nme.display.DisplayObjectContainer;

/**
 * ...
 * @author Karlo
 */

class Tile extends JKTile
{	
	public function new( XCoord : Int = 0, YCoord : Int = 0, ?theWidth : Float
		, ?theHeight : Float, ?graphicFileLocation : String, ?theLayer : DisplayObjectContainer ) 
	{
		super(XCoord, YCoord, theWidth, theHeight, graphicFileLocation, theLayer);
	}
}