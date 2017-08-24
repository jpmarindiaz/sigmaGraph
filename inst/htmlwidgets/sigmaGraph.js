HTMLWidgets.widget({

    name: "sigmaGraph",

    type: "output",

    initialize: function(el, width, height) {

        // Add a method to the graph model that returns an
        // object with every neighbors of a node inside:
        // sigma.classes.graph.addMethod('neighbors', function(nodeId) {
        //   console.log("IN neighbors",nodeId)
        //     var k,
        //         neighbors = {},
        //         index = this.allNeighborsIndex[nodeId] || {};
        //         console.log("THIS",this.allNeighborsIndex)
        //     for (k in index)
        //         neighbors[k] = this.nodesIndex[k];
        //     return neighbors;
        // });

        // https://github.com/jacomyal/sigma.js/issues/715
        sigma.classes.graph.addMethod('neighbors', function(nodeId) {
            var i,
                neighbors = {},
                index = this.allNeighborsIndex.get(nodeId).keyList() || {};
            for (i = 0; i < index.length; i++) {
                neighbors[index[i]] = this.nodesIndex.get(index[i]);
            }
            return neighbors;
        });


        // Initialize packages:
        sigma.utils.pkg('sigma.canvas.labels');

        //Canvas renderer for edges shape
        sigma.renderers.def = sigma.renderers.canvas;


        // create our sigma object and bind it to the element
        var sig = new sigma(
            el.id
        );

        // return it as part of our instance data
        return {
            sig: sig
        };
    },

    renderValue: function(el, x, instance) {

        sigma.renderers.linkurious;

        var settings = x.settings;
        var g = x.data;
        if (x.debug) {
            console.log("settings", settings)
            console.log("graph", g)
        }
        var nodes = HTMLWidgets.dataframeToD3(x.data.nodes);
        var edges = HTMLWidgets.dataframeToD3(x.data.edges);
        var g = { nodes: nodes, edges: edges };

        if (settings.plugins.images) {
            for (var i = 0; i < g.nodes.length; i++) {
                var imgUrl = g.nodes[i].image;
                g.nodes[i].image = {};
                g.nodes[i].image.url = imgUrl;
                g.nodes[i].image.scale = 2;
                g.nodes[i].image.clip = 1.5;
            }
        }

        // Clear the graph
        instance.sig.graph.clear();

        // Read graph
        instance.sig.graph.read(g);

        // Apply settings
        instance.sig.settings(settings.sigma);

        if (x.debug) {
            console.log("sigma instance", instance.sig)
        }

        // Handle node clicks

        instance.sig.bind('clickNode', function(e) {
            if(x.debug){
                console.log('clicked node', e.data.node.id)            
            }
            if (typeof Shiny != "undefined") {
                Shiny.onInputChange('sigmaGraph_clicked_node', e.data.node.id)
            }
        });

        // Plug-ins

        // Drag nodes
        if (settings.plugins.dragNodes) {
            sigma.plugins.dragNodes(instance.sig, instance.sig.renderers[0]);
        }

        // Update the sigma instance
        instance.sig.refresh();

        // forceAtlas
        if (settings.plugins.forceAtlas) {
            var forceAtlasTime = settings.plugins.forceAtlasTime || 2000;
            var forceAtlasConfig = settings.plugins.forceAtlasConfig || {};
            // https://github.com/jacomyal/sigma.js/tree/master/plugins/sigma.layout.forceAtlas2
            instance.sig.startForceAtlas2(forceAtlasConfig);
            setTimeout(function() {
                instance.sig.stopForceAtlas2();
            }, forceAtlasTime)
        }


        // Plug in neighbors
        if (settings.plugins.neighbors) {
            // We first need to save the original colors of our
            // nodes and edges, like this:
            instance.sig.graph.nodes().forEach(function(n) {
                n.originalColor = n.color;
            });
            instance.sig.graph.edges().forEach(function(e) {
                e.originalColor = e.csolor;
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
                // console.log(instance.sig.graph.allNeighborsIndex[nodeId])
                console.log("to keep", toKeep)
                toKeep[nodeId] = e.data.node;
                console.log("to keep", toKeep)
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
        }

    },

    resize: function(el, width, height, instance) {

        // forward resize on to sigma renderers
        for (var name in instance.sig.renderers)
         instance.sig.renderers[name].resize(width, height);  
    }
});