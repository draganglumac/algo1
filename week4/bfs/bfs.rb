require 'thread'

class BFS
  def nodes_reachable_from(graph, start_node)
    queue = Queue.new
    reachable = []
    queue.push start_node
    until queue.empty?
      head = queue.pop
      reachable << head unless reachable.include? head
      graph.edges_for_node(head).each do |e|
        queue.push e unless reachable.include? e
      end
    end
    reachable.sort
  end

  def shortest_path(graph, source, dest)
    queue = Queue.new
    visited = []
    distance_to_dest = 0

    queue.push [source, 0]
    until queue.empty?
      current, level = queue.pop
      visited << [current, level] unless explored?(visited, current)

      if current == dest
        distance_to_dest = level
        break
      end

      graph.edges_for_node(current).each do |e|
        queue.push [e, level + 1] unless explored?(visited, e)
      end
    end

    path = [dest]
    current = dest
    previous_level = level_for_node(visited, current) - 1
    until current == source
      graph.edges_for_node(current).each do |e|
        if explored?(visited, e) and level_for_node(visited, e) == previous_level
          current = e
          previous_level -= 1
          path << current
          break
        end
      end
    end

    [distance_to_dest, path.reverse]
  end

  def explored?(nodes_and_levels, node)
    (nodes_and_levels.map { |e| e.first }).include? node
  end

  def level_for_node(nodes_and_levels, node)
    i = (nodes_and_levels.map { |e| e.first }).index node
    nodes_and_levels[i].last
  end
end