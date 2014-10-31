class MinCut
  def pick_edge(graph)
    node = graph.nodes.sample
    link = graph.edges_for_node(node).sample
    [node, link]
  end

  def compute_cut(graph)
    while graph.nodes.size > 2
      v1, v2 = pick_edge(graph)
      graph.contract_edge v1, v2
    end
  end

end