class MinCut
  # def pick_edge(graph)
  #   p graph.nodes
  #   node = graph.nodes.sample
  #   puts node
  #   link = graph.edges_for_node(node).sample
  #   p graph.edges_for_node(node)
  #   puts link
  #   puts ''
  #   [node, link]
  # end

  def pick_edge(graph)
    node = graph.nodes.sample
    link = graph.edges_for_node(node).sample
    [node, link]
  end

  def compute_cut(g)
    graph = g.clone
    while graph.nodes.size > 2
      v1, v2 = pick_edge(graph)
      graph.contract_edge v1, v2
    end
    # puts graph
    graph
  end

end