/*
 * =====================================================================================
 *
 *       Filename:  string_graph.h
 *
 *    Description:  
 *
 *        Version:  1.0
 *        Created:  19/12/2014 09:24:57
 *       Revision:  none
 *       Compiler:  gcc
 *
 *         Author:  YOUR NAME (), 
 *   Organization:  
 *
 * =====================================================================================
 */

#ifndef __STRING_GRAPH_H__
#define __STRING_GRAPH_H__

#include <vector>
#include <map>
#include <string>

#include "graph.h"

class StringGraph
: public Graph
{
	public:
		StringGraph();
		~StringGraph();

		void add_nodes(std::vector<std::string>& nodes);
		void add_edge_to_node(std::string node, std::string edge);	
		
		void bfs(std::vector<std::string>& order);
		void dfs(std::vector<std::string>& order);

	private:
		std::vector<std::string> nodes
		std::vector<const std::string, int> names;
};

#endif // __STRING_GRAPH_H__
