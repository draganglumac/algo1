/*
 * =====================================================================================
 *
 *       Filename:  graph.h
 *
 *    Description:  Adjacency list implementation of a Graph ADT
 *
 *        Version:  1.0
 *        Created:  27/11/2014 06:00:08
 *       Revision:  none
 *       Compiler:  gcc
 *
 *         Author:  Dragan Glumac (DG), 
 *   Organization:  
 *
 * =====================================================================================
 */

#ifndef __GRAPH_H__
#define __GRAPH_H__

#include <vector>
#include <list>
#include <exception>

struct NotImplementedException : public std::exception {
	NotImplementedException() throw();
	virtual const char* what() const throw();
};

struct InvalidNodeException : public std::exception {
	InvalidNodeException() throw();
	virtual const char* what() const throw();
};

class Graph
{
	public:
	Graph();
	~Graph();
	
	const int num_nodes() const;
	const std::list<int>& edges_for_node(int node) const;

	void bfs(std::vector<int>& order);
	void dfs(std::vector<int>& order);	
	
	private:
	std::vector<std::list<int> > adj;

	void ensure_node(int node); 
	bool is_edge_in_graph(int src, int sink);
	void add_edge_to_node(int node, int edge);
};

#endif
