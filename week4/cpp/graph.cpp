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

using namespace std;

NotImplementedException::NotImplementedException() throw() {
}
const char* NotImplementedException::what() const throw() {
	return "Method not implemented.";
}

Graph::Graph() {
}
Graph::~Graph() {
}
void Graph::ensure_node(int node) {
	if (node > adj.size()) {
		adj.resize(node + 1);
	}
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
void Graph::load_from_file(char **path) {
	throw new NotImplementedException();
}
int* Graph::nodes(int& size) {
	int* vertices = new int[adj.size()];
	size = adj.size();
	for (int i = 0; i < size; i++) {
		vertices[i] = i;
	}
	return vertices;	
}
int* Graph::bfs(int& size) {
	return NULL;	
}
int* Graph::dfs(int& size) {
	return NULL;
}
