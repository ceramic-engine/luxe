

class RunTests extends luxe.Game {

    override function config( config:luxe.GameConfig ) {

        return config;

    }

    override function ready() {

            //run tests
        new transform.Transforms();

        Luxe.shutdown();

    }

} //RunTests