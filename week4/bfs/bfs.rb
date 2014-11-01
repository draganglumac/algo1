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

end