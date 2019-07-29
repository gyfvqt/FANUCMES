$.extend(Developr, {
    TreeView: {

        enableNodes: function (treeview) {
            var _selectedNode = treeview.select();
            treeview.enable(_selectedNode, true);
        },

        disableNode: function (treeview) {
            var _selectedNode = treeview.select();
            treeview.enable(_selectedNode, false);
        },

        removeNode: function (treeview) {
            var _selectedNode = treeview.select();
            treeview.remove(_selectedNode, false);
        },

        expandAllNodes: function (treeview) {
            treeview.expand(".k-item");
        },

        collapseAllNodes: function (treeview) {
            treeview.collapse(".k-item");
        },

        appendNodes: function (treeview,text) {
            var _selectedNode = treeview.select();
            treeview.append({
                text: text
            }, _selectedNode);
        },
    }
});
