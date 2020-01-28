package phoenix;


class Circle {

    public var x: Float;
    public var y: Float;
    public var r: Float;

    public inline function new( _x:Float, _y:Float, _r:Float) {

        x = _x;
        y = _y;
        r = _r;

    }

    inline function toString() {

        return "{ x:"+x + ", y:" + y + ", r:" + r + " }" ;

    }

    public inline function point_inside(_x:Float, _y:Float) {

        var _dx = _x - x;
        var _dy = _y - y;
        var _len = Math.sqrt(_dx*_dx + _dy*_dy);

        return _len <= r;

    }

    public inline function clone() {

        return new Circle(x, y, r);

    }

    public inline function set(_x:Float, _y:Float, _r:Float) {

        x = _x;
        y = _y;
        r = _r;

    }

    public inline function set_xy(_x:Float, _y:Float) {

        x = _x;
        y = _y;

    }

}
