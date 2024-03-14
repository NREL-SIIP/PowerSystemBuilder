function verify_storage_dir(folder::AbstractString = SERIALIZED_DIR)
    directory = abspath(normpath(folder))
    if !isdir(directory)
        mkpath(directory)
    end
end

function check_serialized_storage()
    verify_storage_dir(SERIALIZED_DIR)
    for path in SEARCH_DIRS
        verify_storage_dir(path)
    end
    return
end

function clear_serialized_system(name::String)
    seralized_file_extension =
        [".json", "_validation_descriptors.json", "_time_series_storage.h5"]
    file_names = [name * ext for ext in SERIALIZE_FILE_EXTENSIONS]
    for dir in SEARCH_DIRS
        for file in file_names
            if isfile(joinpath(dir, file))
                @debug "Deleting file" file
                rm(joinpath(dir, file); force = true)
            end
        end
    end
    return
end

function clear_all_serialized_system()
    for dir in SEARCH_DIRS
        @debug "Deleting dir" dir
        rm(dir; force = true, recursive = true)
    end
    check_serialized_storage()
    return
end

function get_serialization_dir(has_forecasts::Bool, has_reserves::Bool)
    if has_forecasts && has_reserves
        return SERIALIZE_FORECASTRESERVE_DIR
    elseif has_forecasts
        return SERIALIZE_FORECASTONLY_DIR
    elseif has_reserves
        return SERIALIZE_RESERVEONLY_DIR
    else
        return SERIALIZE_NOARGS_DIR
    end
end

function get_serialization_dir(case_args::Dict{Symbol, <:Any})
    args_string = join(["$key=$value" for (key, value) in case_args], "_")
    hash_value = hash(args_string)
    return joinpath(PACKAGE_DIR, "data", "$hash_value")
end

get_serialized_filepath(name::String, has_forecasts::Bool, has_reserves::Bool) =
    joinpath(get_serialization_dir(has_forecasts, has_reserves), "$(name).json")

get_serialized_filepath(name::String, case_args::Dict{Symbol, <:Any}) =
    joinpath(get_serialization_dir(case_args), "$(name).json")

function is_serialized(name::String, has_forecasts::Bool, has_reserves::Bool)
    file_path = get_serialized_filepath(name, has_forecasts, has_reserves)
    if isfile(file_path)
        return true
    else
        return false
    end
end

function is_serialized(name::String, case_args::Dict{Symbol, <:Any})
    file_path = get_serialized_filepath(name, case_args)
    if isfile(file_path)
        return true
    else
        return false
    end
end

function get_raw_data(; kwargs...)
    if haskey(kwargs, :raw_data)
        return kwargs[:raw_data]
    else
        throw(ArgumentError("Raw data directory not passed in build function."))
    end
end

function filter_kwargs(; kwargs...)
    system_kwargs = filter(x -> in(first(x), PSY.SYSTEM_KWARGS), kwargs)
    return system_kwargs
end

function check_kwargs_psid(; kwargs...)
    psid_kwargs = filter(x -> in(first(x), ACCEPTED_PSID_TEST_SYSTEMS_KWARGS), kwargs)
    return psid_kwargs
end

function filter_case_kwargs(; kwargs...)
    case_kwargs = filter(x -> in(first(x), SUPPORTED_CASE_KWARGS), kwargs)
    return case_kwargs
end