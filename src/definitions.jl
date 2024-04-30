const PACKAGE_DIR = joinpath(dirname(dirname(pathof(PowerSystemCaseBuilder))))
# const DATA_DIR =
#     joinpath(LazyArtifacts.artifact"CaseData", "PowerSystemsTestData-3.0-alpha")
const DATA_DIR = get(ENV, "PSB_DATA_DIR", joinpath(dirname(PACKAGE_DIR), "PowerSystemsTestData"))  # TODO remove before merging! Kludge to use custom test data until https://github.com/NREL-Sienna/PowerSystemCaseBuilder.jl/issues/54 gets resolved

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
