class MinCut
  def pick_edge(graph)
    node = graph.nodes.sample
    link = graph.edges_for_node(node).sample
    [node, link]
  end

  def compute_cut(graph)
    nil
  end

end