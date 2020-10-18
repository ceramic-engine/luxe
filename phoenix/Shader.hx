package phoenix;

import luxe.options.ResourceOptions;
import luxe.resource.Resource;
import luxe.Resources;

import luxe.Log.*;

import phoenix.Vector;
import phoenix.Texture;
import phoenix.Matrix;
import phoenix.Batcher;

import snow.api.Promise;
import snow.api.buffers.Float32Array;
import snow.modules.opengl.GL;
import snow.types.Types.Error;
import snow.systems.assets.Asset;

#if !web
import ceramic.IntMap;
#end

@:allow(phoenix.Shader)
@:allow(phoenix.geometry.Geometry)
class Uniforms {

#if web
    var ints        : Map<String,Uniform<Int>>;
    var floats      : Map<String,Uniform<Float>>;
    var floatarrs   : Map<String,Uniform<Float32Array>>;
    var vector2s    : Map<String,Uniform<Vector>>;
    var vector2arrs : Map<String,Uniform<Float32Array>>;
    var vector3s    : Map<String,Uniform<Vector>>;
    var vector3arrs : Map<String,Uniform<Float32Array>>;
    var vector4s    : Map<String,Uniform<Vector>>;
    var vector4arrs : Map<String,Uniform<Float32Array>>;
    var matrix4s    : Map<String,Uniform<Matrix>>;
    var matrix4arrs : Map<String,Uniform<Float32Array>>;
    var colors      : Map<String,Uniform<Color>>;
    var textures    : Map<String,Uniform<Texture>>;
#else
    var ints        : IntMap<Uniform<Int>>;
    var floats      : IntMap<Uniform<Float>>;
    var floatarrs   : IntMap<Uniform<Float32Array>>;
    var vector2s    : IntMap<Uniform<Vector>>;
    var vector2arrs : IntMap<Uniform<Float32Array>>;
    var vector3s    : IntMap<Uniform<Vector>>;
    var vector3arrs : IntMap<Uniform<Float32Array>>;
    var vector4s    : IntMap<Uniform<Vector>>;
    var vector4arrs : IntMap<Uniform<Float32Array>>;
    var matrix4s    : IntMap<Uniform<Matrix>>;
    var matrix4arrs : IntMap<Uniform<Float32Array>>;
    var colors      : IntMap<Uniform<Color>>;
    var textures    : IntMap<Uniform<Texture>>;
#end

    var dirty_ints          : Array<Uniform<Int>>;
    var dirty_floats        : Array<Uniform<Float>>;
    var dirty_floatarrs     : Array<Uniform<Float32Array>>;
    var dirty_vector2s      : Array<Uniform<Vector>>;
    var dirty_vector2arrs   : Array<Uniform<Float32Array>>;
    var dirty_vector3s      : Array<Uniform<Vector>>;
    var dirty_vector3arrs   : Array<Uniform<Float32Array>>;
    var dirty_vector4s      : Array<Uniform<Vector>>;
    var dirty_vector4arrs   : Array<Uniform<Float32Array>>;
    var dirty_matrix4s      : Array<Uniform<Matrix>>;
    var dirty_matrix4arrs   : Array<Uniform<Float32Array>>;
    var dirty_colors        : Array<Uniform<Color>>;
    var dirty_textures      : Array<Uniform<Texture>>;

    public function new() {
        clear();
    }

    function destroy() {
        ints = null;
        floats = null;
        vector2s = null;
        vector2arrs = null;
        vector3s = null;
        vector3arrs = null;
        vector4s = null;
        vector4arrs = null;
        matrix4s = null;
        matrix4arrs = null;
        colors = null;
        textures = null;
        dirty_ints = null;
        dirty_floats = null;
        dirty_vector2s = null;
        dirty_vector2arrs = null;
        dirty_vector3s = null;
        dirty_vector3arrs = null;
        dirty_vector4s = null;
        dirty_vector4arrs = null;
        dirty_matrix4s = null;
        dirty_matrix4arrs = null;
        dirty_colors = null;
        dirty_textures = null;
    }

    function clear() {

        destroy();

#if web
        ints        = new Map();
        floats      = new Map();
        floatarrs   = new Map();
        vector2s    = new Map();
        vector2arrs = new Map();
        vector3s    = new Map();
        vector3arrs = new Map();
        vector4s    = new Map();
        vector4arrs = new Map();
        matrix4s    = new Map();
        matrix4arrs = new Map();
        colors      = new Map();
        textures    = new Map();
#else
        ints        = new IntMap();
        floats      = new IntMap();
        floatarrs   = new IntMap();
        vector2s    = new IntMap();
        vector2arrs = new IntMap();
        vector3s    = new IntMap();
        vector3arrs = new IntMap();
        vector4s    = new IntMap();
        vector4arrs = new IntMap();
        matrix4s    = new IntMap();
        matrix4arrs = new IntMap();
        colors      = new IntMap();
        textures    = new IntMap();
#end

        dirty_ints          = [];
        dirty_floats        = [];
        dirty_floatarrs     = [];
        dirty_vector2s      = [];
        dirty_vector2arrs   = [];
        dirty_vector3s      = [];
        dirty_vector3arrs   = [];
        dirty_vector4s      = [];
        dirty_vector4arrs   = [];
        dirty_matrix4s      = [];
        dirty_matrix4arrs   = [];
        dirty_colors        = [];
        dirty_textures      = [];

    }

    public inline function set_int( _name:String, _value:Int, _location:Location ) : Void {

        var _int = ints.get(#if web _name #else _location #end);

        if(_int != null) {
            _int.value = _value;
        } else {
            _int = new Uniform<Int>(_name, _value, _location);
            ints.set(#if web _name #else _location #end, _int);
        }

        dirty_ints.push(_int);

    }

    public inline function set_float( _name:String, _value:Float, _location:Location ) : Void {

        var _float = floats.get(#if web _name #else _location #end);

        if(_float != null) {
            _float.value = _value;
        } else {
            _float = new Uniform<Float>(_name, _value, _location);
            floats.set(#if web _name #else _location #end, _float);
        }

        dirty_floats.push(_float);

    }

    public inline function set_float_arr( _name:String, _value:Float32Array, _location:Location ) : Void {

        var _float = floatarrs.get(#if web _name #else _location #end);

        if(_float != null) {
            _float.value = _value;
        } else {
            _float = new Uniform<Float32Array>(_name, _value, _location);
            floatarrs.set(#if web _name #else _location #end, _float);
        }

        dirty_floatarrs.push(_float);

    }

    public inline function set_vector2( _name:String, _value:Vector, _location:Location ) : Void {

        var _vector2 = vector2s.get(#if web _name #else _location #end);

        if(_vector2 != null) {
            _vector2.value = _value;
        } else {
            _vector2 = new Uniform<Vector>(_name, _value, _location);
            vector2s.set(#if web _name #else _location #end, _vector2);
        }

        dirty_vector2s.push(_vector2);

    }

    public inline function set_vector2_arr( _name:String, _value:Float32Array, _location:Location ) : Void {

        var _vector2 = vector2arrs.get(#if web _name #else _location #end);

        if(_vector2 != null) {
            _vector2.value = _value;
        } else {
            _vector2 = new Uniform<Float32Array>(_name, _value, _location);
            vector2arrs.set(#if web _name #else _location #end, _vector2);
        }

        dirty_vector2arrs.push(_vector2);

    }

    public inline function set_vector3( _name:String, _value:Vector, _location:Location ) : Void {

        var _vector3 = vector3s.get(#if web _name #else _location #end);

        if(_vector3 != null) {
            _vector3.value = _value;
        } else {
            _vector3 = new Uniform<Vector>(_name, _value, _location);
            vector3s.set(#if web _name #else _location #end, _vector3);
        }

        dirty_vector3s.push(_vector3);

    }

    public inline function set_vector3_arr( _name:String, _value:Float32Array, _location:Location ) : Void {

        var _vector3 = vector3arrs.get(#if web _name #else _location #end);

        if(_vector3 != null) {
            _vector3.value = _value;
        } else {
            _vector3 = new Uniform<Float32Array>(_name, _value, _location);
            vector3arrs.set(#if web _name #else _location #end, _vector3);
        }

        dirty_vector3arrs.push(_vector3);

    }

    public inline function set_vector4( _name:String, _value:Vector, _location:Location ) : Void {

        var _vector4 = vector4s.get(#if web _name #else _location #end);

        if(_vector4 != null) {
            _vector4.value = _value;
        } else {
            _vector4 = new Uniform<Vector>(_name, _value, _location);
            vector4s.set(#if web _name #else _location #end, _vector4);
        }

        dirty_vector4s.push(_vector4);

    }

    public inline function set_vector4_arr( _name:String, _value:Float32Array, _location:Location ) : Void {

        var _vector4 = vector4arrs.get(#if web _name #else _location #end);

        if(_vector4 != null) {
            _vector4.value = _value;
        } else {
            _vector4 = new Uniform<Float32Array>(_name, _value, _location);
            vector4arrs.set(#if web _name #else _location #end, _vector4);
        }

        dirty_vector4arrs.push(_vector4);

    }

    public inline function set_matrix4( _name:String, _value:Matrix, _location:Location ) : Void {

        var _matrix4 = matrix4s.get(#if web _name #else _location #end);

        if(_matrix4 != null) {
            _matrix4.value = _value;
        } else {
            _matrix4 = new Uniform<Matrix>(_name, _value, _location);
            matrix4s.set(#if web _name #else _location #end, _matrix4);
        }

        dirty_matrix4s.push(_matrix4);

    }

    public inline function set_matrix4_arr( _name:String, _value:Float32Array, _location:Location ) : Void {

        var _matrix4 = matrix4arrs.get(#if web _name #else _location #end);

        if(_matrix4 != null) {
            _matrix4.value = _value;
        } else {
            _matrix4 = new Uniform<Float32Array>(_name, _value, _location);
            matrix4arrs.set(#if web _name #else _location #end, _matrix4);
        }

        dirty_matrix4arrs.push(_matrix4);

    }

    public inline function set_color( _name:String, _value:Color, _location:Location ) : Void {

        var _color = colors.get(#if web _name #else _location #end);

        if(_color != null) {
            _color.value = _value;
        } else {
            _color = new Uniform<Color>(_name, _value, _location);
            colors.set(#if web _name #else _location #end, _color);
        }

        dirty_colors.push(_color);

    }

    public inline function set_texture( _name:String, _value:Texture, _location:Location ) : Void {

        var _texture = textures.get(#if web _name #else _location #end);

        if(_texture != null) {
            _texture.value = _value;
        } else {
            _texture = new Uniform<Texture>(_name, _value, _location);
            textures.set(#if web _name #else _location #end, _texture);
        }

        dirty_textures.push(_texture);

    }

    //inline
    public function apply() {

        while(dirty_ints.length > 0) {
            var uf = dirty_ints.pop();
            GL.uniform1i(uf.location, uf.value);
        }

        while(dirty_floats.length > 0) {
            var uf = dirty_floats.pop();
            GL.uniform1f(uf.location, uf.value);
        }

        while(dirty_floatarrs.length > 0) {
            var uf = dirty_floatarrs.pop();
            GL.uniform1fv(uf.location, uf.value);
        }

        while(dirty_vector2s.length > 0) {
            var uf = dirty_vector2s.pop();
            GL.uniform2f(uf.location, uf.value.x, uf.value.y);
        }

        while(dirty_vector2arrs.length > 0) {
            var uf = dirty_vector2arrs.pop();
            GL.uniform2fv(uf.location, uf.value);
        }

        while(dirty_vector3s.length > 0) {
            var uf = dirty_vector3s.pop();
            GL.uniform3f(uf.location, uf.value.x, uf.value.y, uf.value.z);
        }

        while(dirty_vector3arrs.length > 0) {
            var uf = dirty_vector3arrs.pop();
            GL.uniform3fv(uf.location, uf.value);
        }

        while(dirty_vector4s.length > 0) {
            var uf = dirty_vector4s.pop();
            GL.uniform4f(uf.location, uf.value.x, uf.value.y, uf.value.z, uf.value.w);
        }

        while(dirty_vector4arrs.length > 0) {
            var uf = dirty_vector4arrs.pop();
            GL.uniform4fv(uf.location, uf.value);
        }

        while(dirty_colors.length > 0) {
            var uf = dirty_colors.pop();
            GL.uniform4f(uf.location, uf.value.r, uf.value.g, uf.value.b, uf.value.a);
        }

        while(dirty_textures.length > 0) {
            var uf = dirty_textures.pop();
            GL.uniform1i(uf.location, uf.value.slot); uf.value.bind();
        }

        while(dirty_matrix4s.length > 0) {
            var uf = dirty_matrix4s.pop();
            GL.uniformMatrix4fv(uf.location, false, uf.value.float32array());
        }

        while(dirty_matrix4arrs.length > 0) {
            var uf = dirty_matrix4arrs.pop();
            GL.uniformMatrix4fv(uf.location, false, uf.value);
        }

    }

}

class Shader extends Resource {

    public var log : String = '';

    public var vert_source : String;
    public var frag_source : String;
    public var vert_id : String = '';
    public var frag_id : String = '';

    public var vert_shader : GLShader = #if snow_web null #else 0 #end;
    public var frag_shader : GLShader = #if snow_web null #else 0 #end;
    public var program : GLProgram = #if snow_web null #else 0 #end;
    public var shader : GLShader = #if snow_web null #else 0 #end;

    public var no_default_uniforms : Bool = false;
    public var proj_attribute : Location;
    public var view_attribute : Location;

    public var uniforms:Uniforms;

    public function new( _options:ShaderOptions ) {

        assertnull(_options);

        _options.resource_type = ResourceType.shader;

        super( _options );

        frag_id = _options.frag_id;
        vert_id = _options.vert_id;
        no_default_uniforms = def(_options.no_default_uniforms, false);

        uniforms = new Uniforms();

    }

    public inline function activate() {

        use();

        uniforms.apply();

            //I dont remember what this was doing here exactly
        Luxe.renderer.state.activeTexture(GL.TEXTURE0);

    }

    public function use() {

        if(program != #if snow_web null #else 0 #end) {
            Luxe.renderer.state.useProgram( program );
        }

    }

    public inline function deactivate() {

        Luxe.renderer.state.useProgram( #if snow_web null #else 0 #end );

    }

        /** Create a new shader based on the source of this shader. */
    public function clone( _id:String ) {

        var _clone = new Shader({
            id: _id,
            frag_id: frag_id,
            vert_id: vert_id
        });

        _clone.from_string( vert_source, frag_source );

        return _clone;

    }

    public inline function set_int( _name:String, _value:Int ) : Void {
        uniforms.set_int(_name, _value, location(_name));
    }

    public inline function set_float( _name:String, _value:Float ) : Void {
        uniforms.set_float(_name, _value, location(_name));
    }

    public inline function set_float_arr( _name:String, _value:Float32Array ) : Void {
        uniforms.set_float_arr(_name, _value, location(_name));
    }

    public inline function set_vector2( _name:String, _value:Vector ) : Void {
        uniforms.set_vector2(_name, _value, location(_name));
    }

    public inline function set_vector2_arr( _name:String, _value:Float32Array ) : Void {
        uniforms.set_vector2_arr(_name, _value, location(_name));
    }

    public inline function set_vector3( _name:String, _value:Vector ) : Void {
        uniforms.set_vector3(_name, _value, location(_name));
    }

    public inline function set_vector3_arr( _name:String, _value:Float32Array ) : Void {
        uniforms.set_vector3_arr(_name, _value, location(_name));
    }

    public inline function set_vector4( _name:String, _value:Vector ) : Void {
        uniforms.set_vector4(_name, _value, location(_name));
    }

    public inline function set_vector4_arr( _name:String, _value:Float32Array ) : Void {
        uniforms.set_vector4_arr(_name, _value, location(_name));
    }

    public inline function set_matrix4( _name:String, _value:Matrix ) : Void {
        uniforms.set_matrix4(_name, _value, location(_name));
    }

    public inline function set_matrix4_arr( _name:String, _value:Float32Array ) : Void {
        uniforms.set_matrix4_arr(_name, _value, location(_name));
    }

    public inline function set_color( _name:String, _value:Color ) : Void {
        uniforms.set_color(_name, _value, location(_name));
    }

    public inline function set_texture( _name:String, _value:Texture ) : Void {
        uniforms.set_texture(_name, _value, location(_name));
    }


    public function compile( _type : Int, _source:String ) : GLShader {

        var _shader = GL.createShader( _type );

            GL.shaderSource( _shader,  _source);
            GL.compileShader(_shader);

        var _compile_log = GL.getShaderInfoLog(_shader);
        var _log = '';

        if(_compile_log.length > 0) {

            var _is_frag = (_type == GL.FRAGMENT_SHADER);
            var _type_name = (_is_frag) ? 'frag' : 'vert';
            var _type_id = (_is_frag) ? frag_id : vert_id;

            _log += '\n\t// start -- ($_type_name / $_type_id) compile log --\n';
            _log +=  format_log(_compile_log);
            _log += '\n\t// end --\n';

        } //_log.length

        if(GL.getShaderParameter(_shader, GL.COMPILE_STATUS) == 0) {

            add_log('\tFailed to compile shader `$id`:\n');
            add_log( _log.length == 0 ? format_log(GL.getShaderInfoLog(_shader)) : _log );

            GL.deleteShader(_shader);
            _shader = #if snow_web null #else 0 #end;

            return #if snow_web null #else 0 #end;

        }

        return _shader;
    }

    public function link() : Bool {

        program = GL.createProgram();

        GL.attachShader(program, vert_shader);
        GL.attachShader(program, frag_shader);

            //Now we want to ensure that our locations are static
        GL.bindAttribLocation( program, Batcher.vert_attribute,    'vertexPosition');
        GL.bindAttribLocation( program, Batcher.tcoord_attribute,  'vertexTCoord');
        GL.bindAttribLocation( program, Batcher.color_attribute,   'vertexColor');
        GL.bindAttribLocation( program, Batcher.normal_attribute,  'vertexNormal');

        GL.linkProgram(program);

        if( GL.getProgramParameter(program, GL.LINK_STATUS) == 0) {
            add_log("\tFailed to link shader program:");
            add_log( format_log(GL.getProgramInfoLog(program)) );
            GL.deleteProgram(program);
            program = #if snow_web null #else 0 #end;
            return false;
        }

            //first bind it
        use();

            //:todo: this is being refactored for the new
            //way more flexible shaders and rendering :}

                //Matrices
            if(!no_default_uniforms) {

                proj_attribute = location('projectionMatrix');
                view_attribute = location('modelViewMatrix');

                var _tex0_attribute = location( 'tex0' );
                var _tex1_attribute = location( 'tex1' );
                var _tex2_attribute = location( 'tex2' );
                var _tex3_attribute = location( 'tex3' );
                var _tex4_attribute = location( 'tex4' );
                var _tex5_attribute = location( 'tex5' );
                var _tex6_attribute = location( 'tex6' );
                var _tex7_attribute = location( 'tex7' );

                if(_tex0_attribute != #if snow_web null #else 0 #end) GL.uniform1i( _tex0_attribute, 0 );
                if(_tex1_attribute != #if snow_web null #else 0 #end) GL.uniform1i( _tex1_attribute, 1 );
                if(_tex2_attribute != #if snow_web null #else 0 #end) GL.uniform1i( _tex2_attribute, 2 );
                if(_tex3_attribute != #if snow_web null #else 0 #end) GL.uniform1i( _tex3_attribute, 3 );
                if(_tex4_attribute != #if snow_web null #else 0 #end) GL.uniform1i( _tex4_attribute, 4 );
                if(_tex5_attribute != #if snow_web null #else 0 #end) GL.uniform1i( _tex5_attribute, 5 );
                if(_tex6_attribute != #if snow_web null #else 0 #end) GL.uniform1i( _tex6_attribute, 6 );
                if(_tex7_attribute != #if snow_web null #else 0 #end) GL.uniform1i( _tex7_attribute, 7 );

            }

        return true;

    }

    public inline function location( _name : String ) : Location {
        return GL.getUniformLocation( program, _name );
    }

//Resource

    override function clear() {

        if( vert_shader != #if snow_web null #else 0 #end ) GL.deleteShader( vert_shader );
        if( frag_shader != #if snow_web null #else 0 #end ) GL.deleteShader( frag_shader );
        if( program != #if snow_web null #else 0 #end )     GL.deleteProgram( program );

        vert_source = null;
        frag_source = null;

        uniforms.clear();

    }

    override public function reload() {

        assert(state != ResourceState.destroyed);

        clear();

        return new Promise(function(resolve, reject) {

            state = ResourceState.loading;

            switch(frag_id) {
                case 'default':  frag_source = Luxe.renderer.shaders.plain.source.frag;
                case 'textured': frag_source = Luxe.renderer.shaders.textured.source.frag;
            }

            switch(vert_id) {
                case 'default': vert_source = Luxe.renderer.shaders.plain.source.vert;
            }

            function _onfail(_err:Dynamic) {
                state = ResourceState.failed;
                reject(_err);
            }

                //one for the default shaders, already resolved
            var _wait = [ Promise.resolve() ];

            if(frag_source == null) {

                var _frag = Luxe.snow.assets.text(frag_id);

                _frag.then(function(_asset:AssetText) {
                    frag_source = _asset.text;
                });

                _wait.push(_frag);

            } //frag_source == null

            if(vert_source == null) {

                var _vert = Luxe.snow.assets.text(vert_id);

                _vert.then(function(_asset:AssetText) {
                    vert_source = _asset.text;
                });

                _wait.push(_vert);

            }

            Promise.all(_wait).then(function(){

                #if luxe_no_shader_prefix
                        //:todo:hxsw: this must go
                    var prefixes = #if luxe_web "precision mediump float;\n" #else '' #end;
                    frag_source = prefixes + frag_source;
                #end //luxe_no_shader_prefix

                if(from_string(vert_source, frag_source)) {
                    state = ResourceState.loaded;
                    resolve(this);
                } else {
                    _onfail(Error.error('`$id` failed to create :\n\n$log'));
                }

            }).error(function(err) {
                _onfail(Error.error('`$id` failed to create :\n\t\t$err\n'));
            });

        }); //promise

    }

        /** Loads shaders from a string, compiles, and links them */
    public function from_string( _vert_source:String, _fragment_source:String ) {

        inline function dump_log() {
            if(log.length > 0) {
                luxe.Log.log(log);
            }
        }

        clear();

        frag_source = _fragment_source;
        vert_source = _vert_source;

            //compile the sources
        vert_shader = compile( GL.VERTEX_SHADER, vert_source );
        frag_shader = compile( GL.FRAGMENT_SHADER, frag_source );

        if( vert_shader == #if snow_web null #else 0 #end || frag_shader == #if snow_web null #else 0 #end ) {
            dump_log();
            return false;
        }

            //Link shader
        if(!link()) {
            dump_log();
            return false;
        }

        return true;

    } //

    inline function add_log( _log:String ) {
        log += _log;
    }

    override function toString() {
        return 'Shader($id) vert:$vert_id / frag: $frag_id';
    }

//Internal

    inline function format_log(_log:String) {
        var _items = _log.split('\n');
        _items = _items.filter(function(s) { return StringTools.trim(s) != ''; });
        _items = _items.map(function(s) { return '\t\t' + StringTools.trim(s); });
        return _items.join('\n');
    }

}

@:generic
private class Uniform<T> {

    public var name : String;
    public var value : T;
    public var location : Location;

    inline public function new(_name:String, _value:T, _location:Location) {
        name = _name;
        value = _value;
        location = _location;
    }

}

private typedef Location = GLUniformLocation;


