
element = "cy_zipWith"

node = (id, label, type, x, y) ->
  data:
    id: id
    label: label
    type: type
  position:
    x: x * 20 * 1.25
    y: y * 20
  size: 1

arc = (src, dst, type='') ->
  data:
    id: src+"->"+dst
    source: src
    target: dst
    type: type


window.mycytoscape
  container: document.getElementById element
  elements: [
    node "x1", "x1", "input", 1, 1
    node "x2", "x2", "input", 3, 1
    node "x3", "x3", "input", 5, 1
    node "x4", "x4", "input", 7, 1
    node "x5", "x5", "input", 9, 1

    node "y1", "y1", "input", 2, 1
    node "y2", "y2", "input", 4, 1
    node "y3", "y3", "input", 6, 1
    node "y4", "y4", "input", 8, 1

    node "f1", "f", "box", 1.5, 2
    node "f2", "f", "box", 3.5, 2
    node "f3", "f", "box", 5.5, 2
    node "f4", "f", "box", 7.5, 2

    node "z1", "z1", "output", 1.5, 3
    node "z2", "z2", "output", 3.5, 3
    node "z3", "z3", "output", 5.5, 3
    node "z4", "z4", "output", 7.5, 3

    arc "x1", "f1"
    arc "y1", "f1"
    arc "f1", "z1"

    arc "x2", "f2"
    arc "y2", "f2"
    arc "f2", "z2"

    arc "x3", "f3"
    arc "y3", "f3"
    arc "f3", "z3"

    arc "x4", "f4"
    arc "y4", "f4"
    arc "f4", "z4"

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
      selector: 'edge[type="right"]'
      style:
        'source-endpoint': '90deg'
    }
  ]
  layout:
    name: 'preset'
