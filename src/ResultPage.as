package {
	import flash.display.Sprite;
	
	import starling.core.Starling;
	[SWF(width = "640", height = "1136", frameRate = "30", backgroundColor = "#FFFFFF")]
	public class ResultPage extends Sprite {

		public function ResultPage() {
			starlingInit()
			

		}
		
		private function starlingInit():void {
			var _starling:Starling = new Starling(Page, stage);
			_starling.showStats = true;
			_starling.start();
			
		}
	}
}
import dragonBones.objects.DataParser;
import dragonBones.textures.StarlingTextureAtlas;

import starling.display.Sprite;
import starling.textures.Texture;

class Page extends Sprite{
	import flash.events.Event;
	
	import dragonBones.Armature;
	import dragonBones.animation.WorldClock;
	import dragonBones.factorys.StarlingFactory;
	
	import starling.display.Sprite;
	import starling.events.EnterFrameEvent;

	private var _factory:StarlingFactory;
	private var _armature:Armature;
	[Embed(source = "../assets/game-result.dbswf", mimeType = "application/octet-stream")]
	public static const ResourcesData:Class;

	[Embed(source = "../assets/game-result/skeleton.json", mimeType = "application/octet-stream")]
	public static const DSkeleton:Class;
	[Embed(source = "../assets/game-result/texture.json", mimeType = "application/octet-stream")]
	public static const DTextureAtlas:Class;
	[Embed(source = "../assets/game-result/texture.png")]
	public static const DTexture:Class;

	function Page():void{
		_factory = new StarlingFactory();
		testSWFPage();
	}
	
	private function testSWFPage():void{
		_factory.parseData(new ResourcesData());
		_factory.addEventListener(Event.COMPLETE, onAssetLoadedHandler);
	}
	
	private function testJsonPage():void{
		_factory.addSkeletonData(DataParser.parseData(JSON.parse(new DSkeleton())));	
		_factory.addTextureAtlas(new StarlingTextureAtlas(Texture.fromBitmapData(new DTexture().bitmapData, true, false, 1), JSON.parse(new DTextureAtlas())));

		_armature = _factory.buildArmature("results-page2");
		_armature.animation.timeScale = 0.5;
		_armature.animation.gotoAndPlay("GameResultsIntro");
		WorldClock.clock.add(_armature);
		
		addChild(_armature.display as Sprite);
		
		addEventListener(EnterFrameEvent.ENTER_FRAME, onEnterFrameHandler);

	}
		
	
	private function onAssetLoadedHandler(e:Event):void{
		_factory.removeEventListener(Event.COMPLETE, onAssetLoadedHandler);
		_armature = _factory.buildArmature("results-page2");
		_armature.animation.timeScale = 0.5;
		_armature.animation.gotoAndPlay("GameResultsIntro");
		WorldClock.clock.add(_armature);
		
		addChild(_armature.display as Sprite);
		
		
		addEventListener(EnterFrameEvent.ENTER_FRAME, onEnterFrameHandler);
	}
	
	private function onEnterFrameHandler(_e:EnterFrameEvent):void {
		WorldClock.clock.advanceTime(-1);
	}
}