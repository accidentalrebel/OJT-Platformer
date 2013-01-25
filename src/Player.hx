package ;
import jkEngine.JKSprite;
import nme.display.DisplayObjectContainer;
/**
 * ...
 * @author Karlo
 */

class Player extends JKSprite
{

	public function new( xPos : Float = 0, yPos : Float = 0, ?FrameWidth : Float
		, ?FrameHeight : Float, ?graphicFileLocation : String, ?theLayer : DisplayObjectContainer ) 
	{
		super(xPos, yPos, FrameWidth, FrameHeight, graphicFileLocation, theLayer);
	}
	
}