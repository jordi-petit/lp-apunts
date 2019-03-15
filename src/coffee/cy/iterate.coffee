
element = "cy_iterate"


node = (id, label, type, x, y, parent=null) ->
  data:
    id: id
    label: label
    type: type
    parent: parent
  position:
    x: x * 20
    y: y * 20
  size: 1



list = (id, label, type, x, y) ->
  data:
    id: id
    label: label
    type: type


arc = (src, dst, type) ->
  data:
    id: src+"->"+dst
    source: src
    target: dst
    type: type


window.mycytoscape
  container: document.getElementById element
  elements: [

    list "ys", "", "list", 2.5, 1

    node "x",  "x", "input", 0, 1
    node "f1", "f", "box", 1, 1
    node "f2", "f", "box", 2, 1
    node "f3", "f", "box", 3, 1
    node "f4", "f", "box", 4, 1
    node "fn", "...", "blank", 5, 1
    node "y0",  "y0", "output", 1, 2, "ys"
    node "y1",  "y1", "output", 2, 2, "ys"
    node "y2",  "y2", "output", 3, 2, "ys"
    node "y3",  "y3", "output", 4, 2, "ys"
    node "y4",  "y4", "output", 5, 2, "ys"
    node "yn",  "...", "blank", 6, 2, "ys"
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
        'border-opacity': 0
        'background-opacity': 0
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
      selector: 'node[type="list"]'
      style:
        'border-color': 'IndianRed'
        'background-color': 'LightGray'
        padding: 1.5
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
