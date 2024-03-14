mutable struct SystemDescriptor <: PowerSystemCaseBuilderType
    name::AbstractString
    description::AbstractString
    category::Type{<:SystemCategory}
    raw_data::AbstractString
    build_function::Function
    download_function::Union{Nothing, Function}
    stats::Union{Nothing, SystemBuildStats}
    supported_arguments::Dict{Symbol, Any}
end

function SystemDescriptor(;
    name,
    description,
    category,
    build_function,
    raw_data = "",
    download_function = nothing,
    stats = nothing,
    supported_arguments = Dict{Symbol, Any}()
)
    return SystemDescriptor(
        name,
        description,
        category,
        raw_data,
        build_function,
        download_function,
        stats,
        supported_arguments
    )
end

get_name(v::SystemDescriptor) = v.name
get_description(v::SystemDescriptor) = v.description
get_category(v::SystemDescriptor) = v.category
get_raw_data(v::SystemDescriptor) = v.raw_data
get_build_function(v::SystemDescriptor) = v.build_function
get_download_function(v::SystemDescriptor) = v.download_function
get_stats(v::SystemDescriptor) = v.stats
get_supported_arguments(v::SystemDescriptor) = v.supported_arguments

set_name!(v::SystemDescriptor, value::String) = v.name = value
set_description!(v::SystemDescriptor, value::String) = v.description = value
set_category!(v::SystemDescriptor, value::Type{<:SystemCategory}) = v.category = value
set_raw_data!(v::SystemDescriptor, value::String) = v.raw_data = value
set_build_function!(v::SystemDescriptor, value::Function) = v.build_function = value
set_download_function!(v::SystemDescriptor, value::Function) = v.download_function = value
set_stats!(v::SystemDescriptor, value::SystemBuildStats) = v.stats = value

update_stats!(v::SystemDescriptor, deserialize_time::Float64) =
    update_stats!(v.stats, deserialize_time)
