HTMLWidgets.widget({

    name: "sigmaGraphNeighbors",

    type: "output",

    initialize: function(el, width, height) {

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

        var sig = new sigma(el.id);

        // return it as part of our instance data
        return {
            sig: sig
        };
    },

    renderValue: function(el, x, instance) {


        var g = x.data;
        instance.sig.graph.read(g);

        for (var name in x.settings)
            instance.sig.settings(name, x.settings[name]);

        // update the sigma instance
        instance.sig.refresh();

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
            var nodeId = e.data.node.id,
                toKeep = instance.sig.graph.neighbors(nodeId);
            toKeep[nodeId] = e.data.node;

            instance.sig.graph.nodes().forEach(function(n) {
                if (toKeep[n.id])
                    n.color = n.originalColor;
                else
                    n.color = '#eee';
            });

            instance.sig.graph.edges().forEach(function(e) {
                if (toKeep[e.source] && toKeep[e.target])
                    e.color = e.originalColor;
                else
                    e.color = '#eee';
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
