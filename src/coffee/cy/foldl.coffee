
element = "cy_foldl"


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


arc = (src, dst) ->
  data:
    id: src+"->"+dst
    source: src
    target: dst


window.mycytoscape
  container: document.getElementById element
  elements: [
    list "xs", "", "list", 2.5, 1
    node "x1", "x1", "input", 1, 1, "xs"
    node "x2", "x2", "input", 2, 1, "xs"
    node "x3", "x3", "input", 3, 1, "xs"
    node "x4", "x4", "input", 4, 1, "xs"
    node "x0",  "x0", "input", 0, 2
    node "f1", "f", "box", 1, 2
    node "f2", "f", "box", 2, 2
    node "f3", "f", "box", 3, 2
    node "f4", "f", "box", 4, 2
    node "y",  "y", "output", 5, 2
    arc "x0", "f1"
    arc "f1", "f2"
    arc "f2", "f3"
    arc "f3", "f4"
    arc "f4", "y"
    arc "x1", "f1"
    arc "x2", "f2"
    arc "x3", "f3"
    arc "x4", "f4"
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
      selector: 'node[type="list"]'
      style:
        'border-color': 'IndianRed'
        'background-color': 'LightGray'
        padding: 1.5
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
        "curve-style": "bezier",
    }
  ]
  layout:
    name: 'preset'
