
element = "cy_scanr"


node = (id, label, type, x, y, parent=null) ->
  data:
    id: id
    label: label
    type: type
    parent: parent
  position:
    x: x * 20
    y: y * 20


list = (id, label, type, x, y) ->
  data:
    id: id
    label: label
    type: type


arc = (src, dst, type='') ->
  data:
    id: src+"->"+dst
    source: src
    target: dst
    type: type



window.mycytoscape
  container: document.getElementById element
  elements: [
    list "xs", "", "list", 2.5, 1
    list "ys", "", "list", 2.5, 3
    node "x1", "x1", "input", 1, 1, "xs"
    node "x2", "x2", "input", 2, 1, "xs"
    node "x3", "x3", "input", 3, 1, "xs"
    node "x4", "x4", "input", 4, 1, "xs"
    node "x0",  "x0", "input", 5, 2
    node "f1", "f", "box", 1, 2
    node "f2", "f", "box", 2, 2
    node "f3", "f", "box", 3, 2
    node "f4", "f", "box", 4, 2
    node "y0",  "y0", "output", 0, 3, "ys"
    node "y1",  "y1", "output", 1, 3, "ys"
    node "y2",  "y2", "output", 2, 3, "ys"
    node "y3",  "y3", "output", 3, 3, "ys"
    node "y4",  "y4", "output", 4, 3, "ys"

    arc "x0", "f4"
    arc "f4", "f3"
    arc "f3", "f2"
    arc "f2", "f1"

    arc "x1", "f1"
    arc "x2", "f2"
    arc "x3", "f3"
    arc "x4", "f4"

    arc "x0", "y4", "left"
    arc "f4", "y3", "left"
    arc "f3", "y2", "left"
    arc "f2", "y1", "left"
    arc "f1", "y0", "left"
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
        'shape': 'round-rectangle'
    }
    {
      selector: 'edge'
      style:
        'width': '0.035em'
        'line-color': 'SeaGreen'
        'target-arrow-color': 'SeaGreen'
        'target-arrow-shape': 'triangle'
        'arrow-scale': 0.4
        "curve-style": "bezier"
    }
    {
      selector: 'edge[type="left"]'
      style:
        'source-endpoint': '270deg'
    }
    {
      selector: 'node[type="list"]'
      style:
        'border-color': 'IndianRed'
        'background-color': 'LightGray'
        padding: 1.5
    }
  ]
  layout:
    name: 'preset'
