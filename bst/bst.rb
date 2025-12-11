require_relative 'lib/tree'

arr = (Array.new(15) { rand(1..100) })
tree = Tree.new(arr)

p tree.balanced?
tree.pretty_print

p tree.level_order

p tree.inorder
p tree.preorder
p tree.postorder

tree.insert(200)
tree.insert(300)
tree.insert(400)
tree.insert(500)

p tree.balanced?
tree.rebalance
p tree.balanced?


p tree.level_order

p tree.inorder
p tree.preorder
p tree.postorder