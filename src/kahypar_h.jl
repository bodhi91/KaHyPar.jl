const kahypar_hypernode_id_t = Cuint
const kahypar_hyperedge_id_t = Cuint
const kahypar_hypernode_weight_t = Cint
const kahypar_hyperedge_weight_t = Cint
const kahypar_partition_id_t = Cuint

mutable struct kahypar_context_t
end

#Create a kaypar context.  Return a pointer to it.
function kahypar_context_new()
    context = ccall((:kahypar_context_new,libkahypar),Ptr{kahypar_context_t},())
    return context
end

#Configure the context from a file
function kahypar_configure_context_from_file(context::Ref{kahypar_context_t},filename::String)
    ccall((:kahypar_configure_context_from_file,libkahypar),
        Cvoid,
        (Ref{kahypar_context_t},Cstring),
        context,
        filename)
end

#Free the context
function kahypar_context_free(context::Ref{kahypar_context_t})
    ccall((:kahypar_context_free,libkahypar),
    Cvoid,
    (Ref{kahypar_context_t},),
    context)
end

function kahypar_set_custom_target_block_weights(num_blocks::kahypar_hypernode_id_t,block_weights::Vector{kahypar_hypernode_weight_t},kahypar_context::Ref{kahypar_context_t})

    ccall((:kahypar_set_custom_target_block_weights,libkahypar),
    Cvoid,
    (kahypar_partition_id_t,Ptr{kahypar_hypernode_weight_t},Ptr{kahypar_context_t}),
    num_blocks,block_weights,kahypar_context
    )
    return
end

#Perform kahypar partitioning given hypergraph information
function kahypar_partition(num_vertices, num_hyperedges, imbalance, num_blocks,
                          vertex_weights, hyperedge_weights, hyperedge_indices,
                          hyperedges,objective, context, partition)
    ccall((:kahypar_partition,libkahypar),
    Cvoid,
    (kahypar_hypernode_id_t,              #num vertices
    kahypar_hyperedge_id_t,               #num hyperedges
    Cdouble,                              #imbalance
    kahypar_partition_id_t,               #num blocks
    Ptr{kahypar_hypernode_weight_t},      #hypernode weights
    Ptr{kahypar_hyperedge_weight_t},      #hyperedge weights
    Ptr{Csize_t},                         #hyperedge indices
    Ptr{kahypar_hyperedge_id_t},          #hyperedges
    Ref{kahypar_hyperedge_weight_t},      #Reference to objective value
    Ptr{kahypar_context_t},               #context (Should this be a Ptr or a Ref?)
    Ref{kahypar_partition_id_t}),         #Parition
    num_vertices,
    num_hyperedges,
    imbalance,
    num_blocks,
    vertex_weights,
    hyperedge_weights,
    hyperedge_indices,
    hyperedges,
    objective,
    context,
    partition
    )
    return
end

#Improve hypergraph partition
function kahypar_improve_partition(num_vertices, num_hyperedges, imbalance, num_blocks,
                          vertex_weights, hyperedge_weights, hyperedge_indices,
                          hyperedges,input_partition,num_improvement_iterations,objective,context,partition)
    ccall((:kahypar_improve_partition,libkahypar),
    Cvoid,
    (kahypar_hypernode_id_t,              #num vertices
    kahypar_hyperedge_id_t,               #num hyperedges
    Cdouble,                              #imbalance
    kahypar_partition_id_t,               #num blocks
    Ptr{kahypar_hypernode_weight_t},      #hypernode weights
    Ptr{kahypar_hyperedge_weight_t},      #hyperedge weights
    Ptr{Csize_t},                         #hyperedge indices
    Ptr{kahypar_hyperedge_id_t},          #hyperedges
    Ptr{kahypar_partition_id_t},          #input partition
    Csize_t,                              #number of improvement iterations
    Ref{kahypar_hyperedge_weight_t},      #Reference to objective value
    Ptr{kahypar_context_t},               #context (Should this be a Ptr or a Ref?)
    Ref{kahypar_partition_id_t}),         #return Partition
    num_vertices,
    num_hyperedges,
    imbalance,
    num_blocks,
    vertex_weights,
    hyperedge_weights,
    hyperedge_indices,
    hyperedges,
    input_partition,
    num_improvement_iterations,
    objective,
    context,
    partition
    )
    return
end
