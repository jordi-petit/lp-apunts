
element = "cy_infer5"
if not document.getElementById element then return
console.log element


ctr = 0
addIds = (t) ->
  t.id = ++ctr
  if not t.leaf?
    if t.node.left?
      addIds t.node.left
    if t.node.center?
      addIds t.node.center
    if t.node.right?
      addIds t.node.right


addXs = (t, x=1) ->
  if t.leaf?
    t.x = x
    return x+1
  else
    if t.node.left?
      x = addXs t.node.left, x
    t.x = x
    if t.node.center?
      x = addXs t.node.center, x
    else
      ++x
    if t.node.right?
      x = addXs t.node.right, x
    return x


addYs = (t, y=1) ->
  t.y = y
  if not t.leaf?
    if t.node.left?
      addYs t.node.left, y+1
    if t.node.center?
      addYs t.node.center, y+1
    if t.node.right?
      addYs t.node.right, y+1


tree2str = (t) ->
  if t.leaf?
    return "<" + t.leaf.label + ">"
  else
    return "(" + t.node.label + "," + (tree2str t.node.left) + "," + (tree2str t.node.right) + ")"


tree2elements = (t) ->
  if t.leaf?
    elems = [node t.id, t.leaf.label, "input", t.x, t.y]
    if t.leaf.under?
      elems.push node t.id*100, t.leaf.under, "under", t.x, t.y+0.45
  else
    nods = [node t.id, t.node.label, "input", t.x, t.y]
    lfts = tree2elements t.node.left
    if t.node.center?
      cnts = tree2elements t.node.center
      cnts.push arc t.id, t.node.center.id
    else
      cnts = []
    rgts = tree2elements t.node.right
    arc1 = arc t.id, t.node.left.id
    arc2 = arc t.id, t.node.right.id
    elems = cnts.concat nods.concat lfts.concat rgts.concat [arc1, arc2]
    if t.node.under?
      elems.push node t.id*100, t.node.under, "under", t.x, t.y+0.45
  return elems


node = (id, label, type, x, y) ->
  data:
    id: id
    label: label
    type: type
  position:
    x: x * 20 * 1
    y: y * 20 * 1.5
  size: 1



arc = (src, dst, type='') ->
  data:
    id: src+"->"+dst
    source: src
    target: dst
    type: type


tree =
  node:
    label: 'λ'
    left:
      leaf: label: 'f'
    right:
      node:
        label: 'λ'
        left:
          node:
            label: '@'
            left:
              node:
                label: '@'
                left:
                  leaf: label: ':'
                right:
                  leaf: label: 'x'
            right:
              leaf: label: 'xs'
        right:
          node:
            label: '@'
            left:
              node:
                label: '@'
                left:
                  leaf: label: ':'
                right:
                  node:
                    label: '@'
                    left:
                      leaf: label: 'f'
                    right:
                      leaf: label: 'x', under: ' ' # dummy under
            right:
              node:
                label: '@'
                left:
                  node:
                    label: '@'
                    left:
                      leaf: label: 'map'
                    right:
                      leaf: label: 'f'
                right:
                  leaf: label: 'xs'


addIds tree
addXs tree
addYs tree

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
      selector: 'node[type="under"]'
      style:
        'border-width': '0'
        'background-opacity': '0'
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

