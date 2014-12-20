/*
 * =====================================================================================
 *
 *       Filename:  graph.cpp
 *
 *    Description:  
 *
 *        Version:  1.0
 *        Created:  29/11/14 11:32:38
 *       Revision:  none
 *       Compiler:  gcc
 *
 *         Author:  Dragan Glumac (draganglumac), dragan.glumac@gmail.com
 *   Organization:  
 *
 * =====================================================================================
 */

#include "graph.h"
#include <algorithm>
#include <stack>
#include <queue>

using namespace std;

// *** Exceptions ***

NotImplementedException::NotImplementedException() throw()
{}
const char* NotImplementedException::what() const throw()
{
	return "Method not implemented.";
}
InvalidNodeException::InvalidNodeException() throw()
{}
const char* InvalidNodeException::what() const throw()
{
	return "This is not a valid node for this graph.";
}

// *** Graph class implementation ***

Graph::Graph() {
}
Graph::~Graph() {
}
void Graph::ensure_node(int node) {
	if (node >= adj.size()) {
		adj.resize(node + 1);
	}
}
void Graph::add_node(int node) {
	ensure_node(node);
}
void Graph::add_edge_to_node(int node, int edge) {
	ensure_node(node);
	if (edge != node && !is_edge_in_graph(node, edge)) {
		adj[node].push_back(edge);
	}
}
bool Graph::is_edge_in_graph(int src, int sink) {
	ensure_node(src);
	return (find(adj[src].begin(), adj[src].end(), sink) != adj[src].end());	
}
int Graph::num_nodes() {
	return adj.size();	
}
list<int>& Graph::edges_for_node(int node) {
	if (node < num_nodes()) {
		return adj[node];
	}
	else {
		throw new InvalidNodeException();
	}
}
void Graph::dfs(int start_node, vector<int>& order) {
	vector<bool> visited(adj.size());
	queue<int> depth_queue;
	int next;

	depth_queue.push(start_node);
	while(depth_queue.size() != 0) {
		next = depth_queue.front(); 
		depth_queue.pop();
		if(!visited[next]) {
			visited[next] = true;
			order.push_back(next);
			for(list<int>::iterator it=adj[next].begin(); it != adj[next].end(); it++) {
				depth_queue.push(*it);
			}
		}
	}
}
void Graph::bfs(int start_node, vector<int>& order) {
	// ToDo
}
