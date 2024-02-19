const PACKAGE_DIR = joinpath(dirname(dirname(pathof(PowerSystemCaseBuilder))))
const DATA_DIR_KEY = "PSB_DATA_DIR"  # Environment variable to check for data directory

# Gets evaluated at compile time to find the data directory. To re-evaluate, force
# recompilation with `Base.compilecache(Base.identify_package("PowerSystemCaseBuilder"))`
function get_data_dir()
    if haskey(ENV, DATA_DIR_KEY)
        candidate = ENV[DATA_DIR_KEY]
        if isdir(candidate)
            @debug "Using PSB data dir $candidate from environment variable"
            return candidate
        else
            error(
                "The directory specified by the environment variable $DATA_DIR_KEY, $candidate, does not exist.",
            )
        end
    else
        candidate = joinpath(LazyArtifacts.artifact"CaseData", "PowerSystemsTestData-2.0")
        if isdir(candidate)
            @debug "Using default PSB data dir $candidate"
            return candidate
        else
            error(
                "No data dir specified by environment variable $DATA_DIR_KEY, and the default, $candidate, does not exist.",
            )
        end
    end
end

const DATA_DIR = get_data_dir()
const RTS_DIR = joinpath(LazyArtifacts.artifact"rts", "RTS-GMLC-0.2.2")

const SYSTEM_DESCRIPTORS_FILE = joinpath(PACKAGE_DIR, "src", "system_descriptor.jl")

const SERIALIZED_DIR = joinpath(PACKAGE_DIR, "data", "serialized_system")
const SERIALIZE_NOARGS_DIR = joinpath(PACKAGE_DIR, "data", "serialized_system", "NoArgs")
const SERIALIZE_FORECASTONLY_DIR =
    joinpath(PACKAGE_DIR, "data", "serialized_system", "ForecastOnly")
const SERIALIZE_RESERVEONLY_DIR =
    joinpath(PACKAGE_DIR, "data", "serialized_system", "ReserveOnly")
const SERIALIZE_FORECASTRESERVE_DIR =
    joinpath(PACKAGE_DIR, "data", "serialized_system", "ForecastReserve")

const SEARCH_DIRS = [
    SERIALIZE_NOARGS_DIR,
    SERIALIZE_FORECASTONLY_DIR,
    SERIALIZE_RESERVEONLY_DIR,
    SERIALIZE_FORECASTRESERVE_DIR,
]

const SERIALIZE_FILE_EXTENSIONS =
    [".json", "_validation_descriptors.json", "_time_series_storage.h5"]

const ACCEPTED_PSID_TEST_SYSTEMS_KWARGS = [:avr_type, :tg_type, :pss_type, :gen_type]
const AVAILABLE_PSID_PSSE_AVRS_TEST =
    ["AC1A", "AC1A_SAT", "EXAC1", "EXST1", "SEXS", "SEXS_noTE"]

const AVAILABLE_PSID_PSSE_TGS_TEST = ["GAST", "HYGOV", "TGOV1"]

const AVAILABLE_PSID_PSSE_GENS_TEST = [
    "GENCLS",
    "GENROE",
    "GENROE_SAT",
    "GENROU",
    "GENROU_NoSAT",
    "GENROU_SAT",
    "GENSAE",
    "GENSAL",
]

const AVAILABLE_PSID_PSSE_PSS_TEST = ["STAB1", "IEEEST", "IEEEST_FILTER"]
