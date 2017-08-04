HTMLWidgets.widget({

    name: "sigmaGraphSimple",

    type: "output",

    initialize: function(el, width, height) {

        //Canvas renderer for edges shape
        sigma.renderers.def = sigma.renderers.canvas;

        // create our sigma object and bind it to the element
        var sig = new sigma(el.id);

        // return it as part of our instance data
        return {
            sig: sig
        };
    },

    renderValue: function(el, x, instance) {
        //No need for HTMLWidgets.dataframeToD3 since it is computed before.
        var g = x.data;
        instance.sig.graph.read(g);
        // apply settings
        for (var name in x.settings)
            instance.sig.settings(name, x.settings[name]);

        //Custom shapes
        CustomShapes.init(instance.sig);

        // update the sigma instance
        instance.sig.refresh();

    },

    resize: function(el, width, height, instance) {

        // forward resize on to sigma renderers
        //for (var name in instance.sig.renderers)
        //  instance.sig.renderers[name].resize(width, height);  
    }
});
