
element = "cy_expr1"
if not document.getElementById element then return
console.log element


ctr = 0
addIds = (t) ->
  t.id = ++ctr
  if not t.leaf?
    addIds t.node.left
    addIds t.node.right


tree2str = (t) ->
  if t.leaf?
    return "<" + t.leaf.label + ">"
  else
    return "(" + t.node.label + "," + (tree2str t.node.left) + "," + (tree2str t.node.right) + ")"


tree2elements = (t, lft=0, rgt=15, y=0) ->
  mid = (lft+rgt)/2
  if t.leaf?
    elems = [node t.id, t.leaf.label, "input", mid, y]
    if t.leaf.under?
      elems.push node t.id*100, t.leaf.under, "under", mid, y+0.45
  else
    nods = [node t.id, t.node.label, "input", mid, y]
    lfts = tree2elements t.node.left,  lft, mid, y+1
    rgts = tree2elements t.node.right, mid, rgt, y+1
    arc1 = arc t.id, t.node.left.id
    arc2 = arc t.id, t.node.right.id
    elems = nods.concat lfts.concat rgts.concat [arc1, arc2]
    if t.node.under?
      elems.push node t.id*100, t.node.under, "under", mid, y+0.45
  return elems


node = (id, label, type, x, y) ->
  data:
    id: id
    label: label
    type: type
  position:
    x: x * 20 * 1.5
    y: y * 30
  size: 1



arc = (src, dst, type='') ->
  data:
    id: src+"->"+dst
    source: src
    target: dst
    type: type


tree =
  node:
    label: '@'
    left:
      node:
        label: 'λ'
        left:
            leaf:
              label: 'y'
        right:
          node:
            label: '@'
            left:
                leaf:
                  label: 'x'
            right:
              node:
                label: '@'
                left:
                    leaf:
                      label: 'y'
                right:
                  leaf:
                    label: 'z'

    right:
      node:
        label: '@'
        left:
            leaf:
              label: 'a'
        right:
          leaf:
            label: 'b'

addIds tree

if 0
  console.log (tree2str tree)
  console.log (tree2elements tree)


window.mycytoscape
  container: document.getElementById element
  elements: tree2elements tree
  style: [
    {
      selector: 'node'
      style:
        'text-halign': 'center'
        'text-valign': 'center'
        'color': 'black'
        'label': 'data(label)'
        'width': '0.75em'
        'height': '0.75em'
        'font-size': '0.4em'
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
        'border-color': 'SeaGreen'
        'background-color': 'White'
        'shape': 'round-rectangle'
    }
    {
      selector: 'edge'
      style:
        'width': '0.035em'
        'line-color': 'IndianRed'
        'target-arrow-color': 'IndianRed'
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

