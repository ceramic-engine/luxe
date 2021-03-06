package luxe.importers.tiled;

import luxe.importers.tiled.TiledObjectGroup;
import luxe.importers.tiled.TiledTileset;
import luxe.importers.tiled.TiledLayer;
import luxe.importers.tiled.TiledObjectGroup;

import luxe.importers.tiled.TiledUtil.valid_element;
import luxe.importers.tiled.TiledUtil.orientation_from_string;

import luxe.tilemaps.Tilemap;


class TiledMapData {

    public var version : String = '';
    public var background_color : String = '';

        //The map width in tiles
    public var width:Int;
        //The map height in tiles
    public var height:Int;
        //TILED orientation: Orthogonal or Isometric
    public var orientation:TilemapOrientation;
        //The tile width
    public var tile_width:Int;
        //The tile height
    public var tile_height:Int;
        //All tilesets the map is using
    public var tilesets:Array<TiledTileset>;
        //Contains all layers from this map
    public var layers:Array<TiledLayer>;
        //All objectgroups
    public var object_groups:Array<TiledObjectGroup>;
        //All imagelayers
    public var image_layers:Array<TiledImageLayer>;
        //All map properties
    public var properties:Map<String, String>;

    public function new() {

        width = 0;
        height = 0;
        tile_width = 0;
        tile_height = 0;

        orientation = TilemapOrientation.none;
        tilesets = [];
        layers = [];
        properties = new Map();
        object_groups = [];
        image_layers = [];

    }

    function toString() {
        return "TiledMap : layers(" + layers.length + ") tilesets(" + tilesets.length + ")" + " tilew,tileh(" + tile_width + "," + tile_height + ")" ;
    }

    public function parseFromXML( xml:Xml ) {

        var root = xml.firstElement();

        version = root.get("version");
        background_color = root.get("backgroundcolor");
        width = Std.parseInt(root.get("width"));
        height = Std.parseInt(root.get("height"));
        orientation = orientation_from_string( root.get("orientation") );
        tile_width = Std.parseInt(root.get("tilewidth"));
        tile_height = Std.parseInt(root.get("tileheight"));

        for (child in root) {
            if(valid_element(child)) {
                switch( child.nodeName ) {

                    case "tileset" : {
                        var tileset:TiledTileset = new TiledTileset();

                            if (child.get("source") != null) {
                                // tileset.from_xml( Helper.getText(child.get("source")) );
                                trace("tilesets from other sources are not available right now? " + child.get('source'));
                            } else {
                                tileset.from_xml( child );
                            }

                            tileset.first_id = Std.parseInt(child.get("firstgid"));

                        tilesets.push(tileset);

                    }

                    case "properties" : {
                        for (property in child) {

                            if (!valid_element(property)) {
                                continue;
                            } //!valid

                            properties.set(property.get("name"), property.get("value"));

                        } //for each property
                    }

                    case "layer" : {

                        var layer : TiledLayer = new TiledLayer( this );
                            layer.from_xml( child );

                        layers.push(layer);

                    }

                    case "objectgroup" : {

                        var object_group : TiledObjectGroup = new TiledObjectGroup( this );
                            object_group.from_xml( child );

                        object_groups.push( object_group );

                    }

                    case "imagelayer" : {

                        var image_layer : TiledImageLayer = new TiledImageLayer( this );
                            image_layer.from_xml( child );

                        image_layers.push( image_layer );

                    }

                } //switch child nodename
            } //if valid element
        } //for each child in root

    }

    public function parseFromJSON( json:Dynamic ) {

        version = Reflect.field(json, "version");
        background_color = Reflect.field(json, "backgroundcolor");
        width = Std.parseInt( Reflect.field(json, "width") );
        height = Std.parseInt( Reflect.field(json, "height"));
        orientation = orientation_from_string( Reflect.field(json, "orientation") );
        tile_width = Std.parseInt( Reflect.field(json, "tilewidth"));
        tile_height = Std.parseInt( Reflect.field(json, "tileheight"));

        var fields = Reflect.fields(json);
        for( nodename in fields ) {

            var child = Reflect.field(json, nodename);

            switch( nodename ) {

                case "tilesets" : {

                    var list:Array<Dynamic> = cast child;
                    for(_tileset_json in list) {

                        var tileset:TiledTileset = new TiledTileset();

                            tileset.from_json( _tileset_json );
                            tileset.first_id = Std.parseInt(Reflect.field(_tileset_json, "firstgid"));

                        tilesets.push(tileset);

                    } //each tileset json

                }

                case "properties" : {
                    var child_fields = Reflect.fields(child);
                    for (property_name in child_fields) {
                        properties.set(property_name, Reflect.field(child, property_name));
                    } //for each property
                }

                case "layers" : {

                    var list:Array<Dynamic> = cast child;
                    for(_layer_json in list) {

                        var type : String = Reflect.field(_layer_json, "type");
                        switch(type) {

                            case "tilelayer" : {
                                var layer : TiledLayer = new TiledLayer( this );
                                    layer.from_json( _layer_json );

                                layers.push(layer);
                            }

                            case "objectgroup" : {
                                var object_group : TiledObjectGroup = new TiledObjectGroup( this );
                                    object_group.from_json( _layer_json );

                                object_groups.push( object_group );
                            }

                            case "imagelayer" : {
                                var image_layer : TiledImageLayer = new TiledImageLayer( this );
                                    image_layer.from_json( _layer_json );

                                image_layers.push( image_layer );
                            }

                        } //switch type
                    } //each layer json

                }

            } //switch child nodename
        } //for each child in root
    }

} // TiledMap



class TiledPropertyTile {

    public var id:Int;
    public var properties:Map<String, String>;

    public function new(_id:Int, _properties:Map<String, String>) {
        id = _id;
        properties = _properties;
    }

}