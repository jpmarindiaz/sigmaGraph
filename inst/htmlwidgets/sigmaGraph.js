HTMLWidgets.widget({

    name: "sigmaGraph",

    type: "output",

    initialize: function(el, width, height) {

        //Canvas renderer for edges shape
        sigma.renderers.def = sigma.renderers.canvas;

        // Add a method to the graph model that returns an
        // object with every neighbors of a node inside:
        sigma.classes.graph.addMethod('neighbors', function(nodeId) {
            var k,
                neighbors = {},
                index = this.allNeighborsIndex[nodeId] || {};

            for (k in index)
                neighbors[k] = this.nodesIndex[k];

            return neighbors;
        });

        // create our sigma object and bind it to the element
        console.log(el.id)
        var sig = new sigma(
            el.id
        );

        // return it as part of our instance data
        return {
            sig: sig
        };
    },

    renderValue: function(el, x, instance) {

        var settings = x.settings;
        var g = x.data;
        var nodes = HTMLWidgets.dataframeToD3(x.data.nodes);
        var edges = HTMLWidgets.dataframeToD3(x.data.edges);
        var g = { nodes: nodes, edges: edges };

        // Read graph
        console.log(g)
        instance.sig.graph.read(g);

        // Apply settings
        for (var name in x.settings)
            instance.sig.settings(name, x.settings[name]);

        // Image settings
        for (var i = 0; i < g.nodes.length; i++) {
            g.nodes[i].image = {};
            g.nodes[i].image.url = g.nodes[i].imageUrl;
            g.nodes[i].image.scale = 2;
            g.nodes[i].image.clip = 1.5
        }

        // Plug-ins
        if (settings.plugins.dragNodes) {
            sigma.plugins.dragNodes(instance.sig, instance.sig.renderers[0]);
        }

        if (settings.plugins.forceAtlas) {
            var forceAtlasTime = settings.plugins.forceAtlasTime || 2000;
            instance.sig.startForceAtlas2();
            setTimeout(function() {
                instance.sig.stopForceAtlas2();
            }, forceAtlasTime)
        }


        // update the sigma instance
        instance.sig.refresh();

    },

    resize: function(el, width, height, instance) {

        // forward resize on to sigma renderers
        //for (var name in instance.sig.renderers)
        //  instance.sig.renderers[name].resize(width, height);  
    }
});