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
		, ?FrameHeight : Float, ?graphicFileLocation : String, IsAnimated : Bool = false, ?theLayer : DisplayObjectContainer ) 
	{
		super(xPos, yPos, FrameWidth, FrameHeight, graphicFileLocation, IsAnimated, theLayer);
		
		addAnimation("idle", [ 0, 1, 2, 3], 150 );
		addAnimation("run", [4, 5, 6, 7, 8, 9, 10, 11], 150 );
		addAnimation("jump", [ 12, 13, 14, 15, 16, 17, 18], 150 );		
	}	
}