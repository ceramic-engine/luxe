package luxe;

import luxe.Engine;

@:allow(luxe.Engine)
class IO {

    public var core : Engine;

    function new( _core:Engine ) {
        core = _core;
    }

//Path specifics
#if luxe_native
    public var app_path (get,never) : String;
    public var app_path_prefs (get,never) : String;
#end

//Utility features

        /** Open the system default browser with the given URL.
            supported: mac/window/linux/iOS/web
            pending: android https://github.com/underscorediscovery/snow/issues/25 */
    public inline function url_open( _url:String ) {

        core.app.io.url_open( _url );

    }

        /** Save a string value by key, with an optional slot.
            To remove a saved key, pass value in as null.
            Works on all targets as a simple save/load mechanism.
            Data saved is plain text but obscured with basic encoding.
            Any further obfuscation can be done on the value prior to saving.
            Returns false if the save failed, errors being logged. */
    public inline function string_save( _key:String, _value:String, _slot:Int = 0 ) : Bool {

        return core.app.io.string_save(_key, _value, _slot);

    }

        /** Load a string value by key, with an optional slot.
            Works on all targets as a simple save/load mechanism.
            Returns the string or null if the key was invalid, or the slot was not found. */
    public inline function string_load( _key:String, _slot:Int = 0 ) : String {

        return core.app.io.string_load(_key, _slot);

    }

        /** Destroy a specific string slot, removing all values stored.
            Does not ask for confirmation. Returns true if successful, false otherwise. */
    public inline function string_destroy( _slot:Int = 0 ) : Bool {

        return core.app.io.string_destroy(_slot);

    }

//Internal

#if luxe_native

    function get_app_path() {

        return core.app.io.module.app_path();

    }

    function get_app_path_prefs() {

        return core.app.io.module.app_path_prefs();

    }

#end

    function init() {

    }

}
