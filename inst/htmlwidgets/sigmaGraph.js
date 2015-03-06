HTMLWidgets.widget({

  name: "sigmaGraph",
  
  type: "output",
  
  initialize: function(el, width, height) {
   
    // create our sigma object and bind it to the element
    var sig = new sigma(el.id);
    
    // return it as part of our instance data
    return {
      sig: sig
    };
  },
  
  renderValue: function(el, x, instance) {
      
    // parse gexf data
    //var parser = new DOMParser();
    //var data = parser.parseFromString(x.data, "application/xml");
    //var nodes = x.data.nodes;
    //var g = eval(x.data);    
    
    var g = x.data;
    
    //var nodes = HTMLWidgets.dataframeToD3(x.data.nodes);
    //var edges = HTMLWidgets.dataframeToD3(x.data.edges);
    //var g = {nodes:nodes, edges:edges};
    
    //console.log(nodes)
    console.log(g)
    instance.sig.graph.read(g);
    //instance.sig.graph.nodes = nodes;
    //instance.sig.graph.edges = edges;
    //instance.sig.graph = eval(x.data);
    console.log(instance.sig)
    // apply settings
    for (var name in x.settings)
      instance.sig.settings(name, x.settings[name]);
    
    // update the sigma instance
    instance.sig.refresh();
    
  },
  
  resize: function(el, width, height, instance) {
    
    // forward resize on to sigma renderers
    //for (var name in instance.sig.renderers)
    //  instance.sig.renderers[name].resize(width, height);  
  }
});