require 'stack'

class DFS
  def nodes_reachable_from(graph, start_node)
    dfs_stack graph, start_node
    # dfs graph, start_node
  end

  def topological_ordering(graph)
    visited = {}
    current_position = graph.nodes.size
    topological_order = [nil]
    graph.nodes.each do |node|
      if visited[node].nil?
        visited = dfs_recursive(graph, node, visited) do |n|
          topological_order[n] = current_position
          current_position -= 1
        end
      end
    end
    topological_order
  end

  private
  def dfs_stack(graph, start_node)
    visited = {}
    stack = Stack.new
    stack.push start_node
    until stack.empty?
      node = stack.top
      visited[node] = true unless visited[node]
      graph.edges_for_node(node).each do |e|
        unless visited[e]
          stack.push e
          break
        end
      end
      stack.pop if node == stack.top
    end
    visited.keys.sort!
  end

  def dfs(graph, start_node)
    visited = dfs_recursive(graph, start_node, lambda {})
    visited.keys.sort
  end

  def dfs_recursive(graph, start_node, visited, &block)
    if visited[start_node].nil?
      visited[start_node] = true
      edges = graph.edges_for_node start_node
      edges.each do |e|
        visited = dfs_recursive graph, e, visited, &block
      end
      block.call start_node
    end
    visited
  end
end
