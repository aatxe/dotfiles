atom.keymaps.partialMatchTimeout = 140
atom.commands.dispatch(atom.views.getView(atom.workspace), 'atom-hide-tabs:toggle')

atom.commands.add 'atom-text-editor', 'awe:cycle-pane', ->
  atom.commands.dispatch(atom.views.getView(atom.workspace), 'pane:show-next-recently-used-item')
  atom.commands.dispatch(atom.views.getView(atom.workspace), 'pane:move-active-item-to-top-of-stack')
