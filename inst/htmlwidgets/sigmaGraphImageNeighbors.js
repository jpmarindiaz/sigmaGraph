HTMLWidgets.widget({

    name: "sigmaGraphImageNeighbors",

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
        var sig = new sigma(el.id);

        // return it as part of our instance data
        return {
            sig: sig
        };
    },

    renderValue: function(el, x, instance) {
        

        
        //No need for HTMLWidgets.dataframeToD3 since it is computed before.
        var g = x.data;

        // Image settings
        for (var i = 0; i < g.nodes.length; i++) {
            g.nodes[i].image = {};
            g.nodes[i].image.url = g.nodes[i].imageUrl;
            g.nodes[i].image.scale = 2;
            g.nodes[i].image.clip = 1.5
        }
        console.log(g)

        instance.sig.graph.read(g);

        // apply settings
        for (var name in x.settings)
            instance.sig.settings(name, x.settings[name]);


        //image
        //sigma.utils.pkg('sigma.canvas.nodes');

        //Custom shapes
        CustomShapes.init(instance.sig);

        // update the sigma instance
        instance.sig.refresh();


        // Click handling taken from neighbors
        // We first need to save the original colors of our
        // nodes and edges, like this:
        instance.sig.graph.nodes().forEach(function(n) {
            n.originalColor = n.color;
        });
        instance.sig.graph.edges().forEach(function(e) {
            e.originalColor = e.color;
        });

        // When a node is clicked, we check for each node
        // if it is a neighbor of the clicked one. If not,
        // we set its color as grey, and else, it takes its
        // original color.
        // We do the same for the edges, and we only keep
        // edges that have both extremities colored.
        instance.sig.bind('clickNode', function(e) {
            var edgeNotSelectedColor = "#ccc";

            var nodeId = e.data.node.id,
                toKeep = instance.sig.graph.neighbors(nodeId);
            toKeep[nodeId] = e.data.node;

            instance.sig.graph.nodes().forEach(function(n) {
                if (toKeep[n.id])
                    n.color = n.originalColor;
                else
                    n.color = edgeNotSelectedColor;
                    // n.color = "#AAA";

            });

            instance.sig.graph.edges().forEach(function(e) {
                if (toKeep[e.source] && toKeep[e.target])
                    e.color = e.originalColor;
                else
                    e.color = edgeNotSelectedColor;
                    // e.color = "#AAA";
            });

            // Since the data has been modified, we need to
            // call the refresh method to make the colors
            // update effective.
            instance.sig.refresh();
        });

        // When the stage is clicked, we just color each
        // node and edge with its original color.
        instance.sig.bind('clickStage', function(e) {
            instance.sig.graph.nodes().forEach(function(n) {
                n.color = n.originalColor;
            });

            instance.sig.graph.edges().forEach(function(e) {
                e.color = e.originalColor;
            });

            // Same as in the previous event:
            instance.sig.refresh();
        });

    },

    resize: function(el, width, height, instance) {

        // forward resize on to sigma renderers
        //for (var name in instance.sig.renderers)
        //  instance.sig.renderers[name].resize(width, height);  
    }
});
