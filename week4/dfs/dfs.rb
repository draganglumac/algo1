require 'stack'

class DFS
  def nodes_reachable_from(graph, start_node)
    dfs_stack graph, start_node
    # dfs graph, start_node
  end

  private
  def dfs_stack(graph, start_node)
    visited = {}
    stack = Stack.new
    stack.push start_node
    until stack.empty?
      node = stack.pop
      if visited[node].nil?
        visited[node] = true
        graph.edges_for_node(node).each { |e| stack.push e }
      end
    end
    visited.keys.sort
  end

  def dfs(graph, start_node)
    visited = dfs_recursive(graph, start_node, {})
    visited.keys.sort
  end

  def dfs_recursive(graph, start_node, visited)
    if visited[start_node].nil?
      visited[start_node] = true
      edges = graph.edges_for_node start_node
      edges.each do |e|
        visited = dfs_recursive graph, e, visited
      end
    end
    visited
  end
end
