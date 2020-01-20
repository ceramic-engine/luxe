package phoenix;

import snow.modules.opengl.GL;
import phoenix.Batcher;
import phoenix.Texture;
import phoenix.Renderer.RenderTarget;

import luxe.Log.*;
import luxe.options.ResourceOptions;
import luxe.resource.Resource;
import luxe.Resources;


    //A render texture just extends texture so it can be assigned to meshes etc
class RenderTexture extends Texture implements RenderTarget {

    inline static var DEPTH24_STENCIL8_OES = 0x88F0;

        //These are for RenderTarget interface
    public var framebuffer : GLFramebuffer;
    public var renderbuffer : GLRenderbuffer;
        //You generally don't want this to be anything other than 0.
    public var viewport_scale : Float = 1;

    public var stencil_enabled(default, null) : Bool;

    public function new( _options:RenderTextureOptions ) {

        _options.resource_type = ResourceType.render_texture;

        super( _options );

        def(_options.width, Std.int(Luxe.screen.w));
        def(_options.height, Std.int(Luxe.screen.h));

            //Width and height of this texture item
        width = width_actual = _options.width;
        height = height_actual = _options.height;

        stencil_enabled = _options.render_stencil != null ? _options.render_stencil : false;

            //super creates the texture id
            //and binds the texture id for us

            //Create the actual texture storage in gpu memory
        if(_options.texture != null) {
            submit(null);
        }
            //these must be set to be texture complete
        apply_props();

            //Create the framebuffer
        framebuffer = GL.createFramebuffer();
            //Bind it
        bindBuffer();

            //create the renderbuffer
        renderbuffer = GL.createRenderbuffer();
            //Bind it so we can attach stuff
        bindRenderBuffer();

            //Create storage for the depth/stencil buffer
        if (stencil_enabled) {
            #if (ios || android)
            GL.renderbufferStorage(GL.RENDERBUFFER, DEPTH24_STENCIL8_OES, width, height);
            #else
            GL.renderbufferStorage(GL.RENDERBUFFER, GL.DEPTH_STENCIL, width, height);
            #end
        }
        else {
            #if (web || mobile || tvos)
            GL.renderbufferStorage(GL.RENDERBUFFER, GL.DEPTH_COMPONENT16, width, height);
            #else
            GL.renderbufferStorage(GL.RENDERBUFFER, GL.DEPTH_COMPONENT, width, height);
            #end
        }
            //Attach the framebuffer texture to the buffer
        GL.framebufferTexture2D( GL.FRAMEBUFFER, GL.COLOR_ATTACHMENT0, GL.TEXTURE_2D, texture, 0 );
            //Attach the depth/stencil buffer to the render buffer
        if (stencil_enabled) {
            GL.framebufferRenderbuffer( GL.FRAMEBUFFER, GL.DEPTH_STENCIL_ATTACHMENT, GL.RENDERBUFFER, renderbuffer);
        }
        else {
            GL.framebufferRenderbuffer( GL.FRAMEBUFFER, GL.DEPTH_ATTACHMENT, GL.RENDERBUFFER, renderbuffer);
        }

        var status = GL.checkFramebufferStatus( GL.FRAMEBUFFER );

        switch (status) {

            case GL.FRAMEBUFFER_COMPLETE:

            case GL.FRAMEBUFFER_INCOMPLETE_ATTACHMENT:
                throw("Incomplete framebuffer: FRAMEBUFFER_INCOMPLETE_ATTACHMENT");

            case GL.FRAMEBUFFER_INCOMPLETE_MISSING_ATTACHMENT:
                throw("Incomplete framebuffer: FRAMEBUFFER_INCOMPLETE_MISSING_ATTACHMENT");

            case GL.FRAMEBUFFER_INCOMPLETE_DIMENSIONS:
                throw("Incomplete framebuffer: FRAMEBUFFER_INCOMPLETE_DIMENSIONS");

            case GL.FRAMEBUFFER_UNSUPPORTED:
                throw("Incomplete framebuffer: FRAMEBUFFER_UNSUPPORTED");

            default:
                throw("Incomplete framebuffer: " + status);
        }

            //no lingering
        unbindBuffer(#if snow_web null #else 0 #end);
        unbindRenderBuffer(#if snow_web null #else 0 #end);

            //add to the resource system
        system.add(this);

    } //new

    override function clear() {

        super.clear();

        if(framebuffer != #if snow_web null #else 0 #end) {
            GL.deleteFramebuffer(framebuffer);
        }

        if(renderbuffer != #if snow_web null #else 0 #end) {
            GL.deleteRenderbuffer(renderbuffer);
        }

    } //clear

    @:noCompletion public function bindBuffer() {

        Luxe.renderer.state.bindFramebuffer(framebuffer);

    } //bind

    @:noCompletion public function unbindBuffer( _other:GLFramebuffer ) {

        Luxe.renderer.state.bindFramebuffer( _other );

    } //unbind

    @:noCompletion public function bindRenderBuffer() {

        Luxe.renderer.state.bindRenderbuffer( renderbuffer );

    } //bind

    @:noCompletion public function unbindRenderBuffer( _other:GLRenderbuffer ) {

        Luxe.renderer.state.bindRenderbuffer( _other );

    } //unbind


} //RenderTexture