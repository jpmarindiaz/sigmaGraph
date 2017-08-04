HTMLWidgets.widget({

  name: "sigmaGraph",
  
  type: "output",
  
  initialize: function(el, width, height) {
   
    // create our sigma object and bind it to the element
    console.log(el.id)
    var sig = new sigma(el.id);
    
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
    var g = {nodes:nodes, edges:edges};
    
    //console.log(nodes)
    console.log(g)
    instance.sig.graph.read(g);
    //instance.sig.graph.nodes = nodes;
    //instance.sig.graph.edges = edges;
    //instance.sig.graph = eval(x.data);
    console.log(instance.sig.graph)
    // apply settings
    for (var name in x.settings)
      instance.sig.settings(name, x.settings[name]);

    if(settings.plugins.dragNodes){
      sigma.plugins.dragNodes(instance.sig, instance.sig.renderers[0]);
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