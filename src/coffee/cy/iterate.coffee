
element = "cy_iterate"


node = (id, label, type, x, y) ->
  data:
    id: id
    label: label
    type: type
  position:
    x: x * 20
    y: y * 20
  size: 1


arc = (src, dst) ->
  data:
    id: src+"->"+dst
    source: src
    target: dst


window.mycytoscape
  container: document.getElementById element
  elements: [
    node "x",  "x", "input", 0, 1
    node "f1", "f", "box", 1, 1
    node "f2", "f", "box", 2, 1
    node "f3", "f", "box", 3, 1
    node "f4", "f", "box", 4, 1
    node "fn", "...", "blank", 5, 1
    node "y0",  "y0", "output", 1, 2
    node "y1",  "y1", "output", 2, 2
    node "y2",  "y2", "output", 3, 2
    node "y3",  "y3", "output", 4, 2
    node "y4",  "y4", "output", 5, 2
    node "yn",  "...", "blank", 6, 2
    arc "x", "f1"
    arc "x", "y0", "right"
    arc "f1", "f2"
    arc "f2", "f3"
    arc "f3", "f4"
    arc "f1", "y1", "right"
    arc "f2", "y2", "right"
    arc "f3", "y3", "right"
    arc "f4", "y4", "right"
    arc "f4", "fn", "right"
    arc "fn", "yn", "right"
  ]
  style: [
    {
      selector: 'node'
      style:
        'text-halign': 'center'
        'text-valign': 'center'
        'color': 'black'
        'label': 'data(label)'
        'width': '0.5em'
        'height': '0.5em'
        'font-size': '0.25em'
        'shape': 'ellipse'
        'border-width': '0.035em'
        'font-family': 'Ubuntu Mono'
    }
    {
      selector: 'node[type="input"]'
      style:
        'border-color': 'IndianRed'
        'background-color': 'PeachPuff'
    }
    {
      selector: 'node[type="blank"]'
      style:
        'border-color': 'white'
        'background-color': 'white'
    }
    {
      selector: 'node[type="output"]'
      style:
        'border-color': 'IndianRed'
        'background-color': 'PeachPuff'
    }
    {
      selector: 'node[type="box"]'
      style:
        'border-color': 'IndianRed'
        'background-color': 'PeachPuff'
        'shape': 'rectangle'
    }
    {
      selector: 'edge'
      style:
        'width': '0.035em'
        'line-color': 'SeaGreen'
        'target-arrow-color': 'SeaGreen'
        'target-arrow-shape': 'triangle'
        'arrow-scale': 0.4
        "curve-style": "bezier",
    }
    {
      selector: 'edge[type="right"]'
      style:
        'source-endpoint': '90deg'
    }
  ]
  layout:
    name: 'preset'
