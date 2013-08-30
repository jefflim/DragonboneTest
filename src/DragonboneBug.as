package {
	import flash.display.Sprite;
	
	import starling.core.Starling;
	[SWF(width = "640", height = "960", frameRate = "60", backgroundColor = "#FFFFFF")]
	public class DragonboneBug extends Sprite {
		public function DragonboneBug() {
			starlingInit()
		}
		
		private function starlingInit():void {
			var _starling:Starling = new Starling(StarlingGame, stage);
			_starling.showStats = true;
			_starling.start();
			
		}
	}
}
import flash.utils.setTimeout;

import dragonBones.Armature;
import dragonBones.animation.WorldClock;
import dragonBones.factorys.StarlingFactory;
import dragonBones.objects.DataParser;
import dragonBones.textures.StarlingTextureAtlas;

import starling.display.Sprite;
import starling.events.EnterFrameEvent;
import starling.events.Event;
import starling.textures.Texture;

class StarlingGame extends Sprite{
	[Embed(source = "../assets/Dragon/skeleton.json", mimeType = "application/octet-stream")]
	public static const DSkeleton:Class;
	[Embed(source = "../assets/Dragon/texture.json", mimeType = "application/octet-stream")]
	public static const DTextureAtlas:Class;
	[Embed(source = "../assets/Dragon/texture.png")]
	public static const DTexture:Class;

	private var _factory:StarlingFactory;
	private var _armature:Armature;
	public function StarlingGame():void{
		this.addEventListener(Event.ADDED_TO_STAGE, init);
	}
	private function init(e:Event):void{
		this.removeEventListener(Event.ADDED_TO_STAGE, init);
		_factory = new StarlingFactory();
		_factory.addSkeletonData(DataParser.parseData(JSON.parse(new DSkeleton())));	
		_factory.addTextureAtlas(new StarlingTextureAtlas(Texture.fromBitmapData(new DTexture().bitmapData, true, false, 1), JSON.parse(new DTextureAtlas())));
		_armature = _factory.buildArmature("Dragon");
		_armature.animation.gotoAndPlay("stand");
		_armature.display.x = 200;
		_armature.display.y = 500;
		addChild(_armature.display as Sprite);
		
		addEventListener(EnterFrameEvent.ENTER_FRAME, onEnterFrameHandler);
		setTimeout(function():void{
			WorldClock.clock.add(_armature);
			_armature.animation.gotoAndPlay("stand", 1, 1 ,1);
		},3000);
	}
	
	private function onEnterFrameHandler(_e:EnterFrameEvent):void {
		WorldClock.clock.advanceTime(-1);
	}
	
}