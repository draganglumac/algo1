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
#include <fstream>

class Graph
{
	std::vector<std::list> adjacent;

	void add_node(int node);
	void add_edge_to_node(int edge);

	public:
	Graph();
	~Graph();

	void load_from_file(char **path);

	int[] nodes();
	std::list& edges_for_node(int node);

	int[] bfs();
	int[] dfs();	
};

#endif
