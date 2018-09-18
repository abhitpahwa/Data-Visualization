#IGRAPH 

library(igraph)

#Read the given adjacency matrix into R 
adj<-read.csv("dataset_lab5_adjacency.csv",sep = ",",header = TRUE,row.names = 1,check.names = FALSE)

#Read the given edge matrix into R
edges<-read.csv("dataset_lab5_edges.csv",sep = ",",header = TRUE)

#Create and plot the graph from the adjacency matrix and edge matrix 
adj_matrix=as.matrix(adj)
graph_adj<-graph.adjacency(adj_matrix,mode="directed",weighted=TRUE,diag = FALSE)
plot.igraph(graph_adj,vertex.label=V(graph_adj)$name,layout=layout.fruchterman.reingold,edge.arrow.size=0.5)
edges[,1]=as.character(edges[,1])
edges[,2]=as.character(edges[,2])
edges=as.matrix(edges)
graph_edge<-graph.edgelist(edges[,1:2])
plot.igraph(graph_edge)

#Display the edges & vertices, the network as matrix and the names of vertices
edges_graph_adj<-get.edgelist(graph_adj)
edges_graph_edge<-get.edgelist(graph_edge)
vertices_graph_adj<-V(graph_adj)
vertices_graph_edge<-V(graph_edge)
matrix_graph_adj<-get.adjacency(graph_adj)
matrix_graph_edge<-get.adjacency(graph_edge)
vertices_name_graph_adj<-V(graph_adj)$name
vertices_name_graph_edge<-V(graph_edge)$name

#Find the count of vertices and edges of the created graph
vertex_count_graph_adj<-vcount(graph_adj)
vertext_count_graph_edge<-vcount(graph_edge)
edge_count_graph_adj<-ecount(graph_adj)
edge_count_graph_edges<-ecount(graph_edge)

#Display the adjacency vertices of each vertex(individual) in the created graph
adj_vertices_graph_adj<-adjacent_vertices(graph_adj,V(graph_adj),mode=c("all"))
adj_vertices_graph_edge<-adjacent_vertices(graph_edge,V(graph_edge),mode=c("all"))

#Find the min and max degree of the created graph
min_degree_graph_adj<-min(degree(graph_adj))
min_degree_graph_edge<-min(degree(graph_edge))
max_degree_graph_adj<-max(degree(graph_adj))
max_degree_graph_edge<-max(degree(graph_edge))

#Create & set vertex attribute property named profit and values("+", "-", "+", "-", "+", "-","+", "-", "+")
graph_adj<-set.vertex.attribute(graph_adj,name="profit",value = c("+", "-", "+", "-", "+", "-","+", "-", "+","-","+"))
graph_edge<-set.vertex.attribute(graph_edge,name="profit",value = c("+", "-", "+", "-", "+", "-","+", "-", "+"))

#Create & set vertex attribute property named type and values(either leap or non-leap year)
graph_adj<-set.vertex.attribute(graph_adj,name="type",value=ifelse(as.numeric(V(graph_adj)$name)%%4==0,"leap","non-leap"))
graph_adj<-set.vertex.attribute(graph_edge,name="type",value=ifelse(as.numeric(V(graph_edge)$name)%%4==0,"leap","non-leap"))
get.vertex.attribute(graph_adj,name="type",V(graph_adj))
get.vertex.attribute(graph_edge,name="type",V(graph_edge))

#Create & set edge attribute named weight and values (if edge exits in between leap year vertices then 5 else 1 )
check_leap_year<-function(year){
  ifelse(((year%%4==0) & (year%%100!=0)) | (year%%400==0),return(TRUE),return(FALSE))
}
get_weight<-function(year1,year2){
  ifelse(check_leap_year(year1) & check_leap_year(year2),return(5),return(1))
}
for(i in seq(1,length(edges[,1]))){
  E(graph_edge)[i]$weight=get_weight(as.numeric(edges[i,1]),as.numeric(edges[i,2]))
  print(E(graph_edge)[i]$weight)
}

#Convert the created un-directed graph into directed graph based on the following rule:
#a.edge directed towards high value vertex
#b.if any one of the vertex is leap year then put the reverse edge with same weight
new_edge_list=c()
for(i in seq(1,length(edges[,1]))){
  if(edges[i,1]>edges[i,2]){
    temp<-c(edges[i,2],edges[i,1])
  }
  else{
    temp<-c(edges[i,1],edges[i,2])
  }
  if(check_leap_year(as.numeric(edges[i,1]))==TRUE | check_leap_year(as.numeric(edges[i,2]))){
    temp<-rev(temp)
  }
  new_edge_list<-c(new_edge_list,temp)
}
new_directed_graph=make_graph(as.character(new_edge_list),directed=TRUE)
plot(new_directed_graph)

#Display the adjacency matrix of the resultant directed graph
get.adjacency(new_directed_graph)

#Display the in-degree and out-degree of each vertex of resultant directed graph
print("In-degrees: ")
degree(new_directed_graph,V(new_directed_graph),mode=c("in"))
print("Out-degrees: ")
degree(new_directed_graph,V(new_directed_graph),mode=c("out"))
