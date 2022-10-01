# This file contains the functions to get data from gene network APIs

######################################
# Functions running jobs on the server
######################################

"""
    run_gemma(dataset::String,trait::String; use_loco::Bool=false, maf::Float64=0.01,
        gn_url::String=gn_url())

Runs GEMMA with the specified `trait` in the specified `dataset`.
Optional arguments include:

- use_loco (default=false): if LOCO (leave one chromosome out) should be used
- maf (default=0.01): the minimum minor allele frequency of the markers to be scanned
"""
function run_gemma(dataset::String, trait::String; use_loco::Bool=false, maf::Float64=0.01,
                   gn_url::String=gn_url())
    loco = use_loco == true ? "true" : "false"
    url = gn_url * "mapping?trait_id=" * trait * "&db=" * dataset * "&method=gemma" *
        "&use_loco=" * loco * "&maf=" * string(maf)
    return get_api(url) |> JSON.parse |> (x->x[1]) |> j2m
end

"""
    function run_rqtl(dataset::String, trait::String; method::String="hk",
                  model::String="normal", n_perm::Int64=0,
                  control_marker::String="",
                  gn_url::String=gn_url())
Runs R/qtl's `scanone` function with the specified `trait` in the specified `dataset`.

Some optional arguments have analogs in options in the parent
`scanone` function.  See the [help for that
function](https://rqtl.org/manual/qtl-manual.pdf).

Optional arguments inlcude:

- method (default="hk"): possible values are
  - hk: Haley-Knott method
  - em: EM algorithm
  - ehk: Extended EM algorithm
  - imp: multiple imputation
  - mr: marker regression dropping individuals with missing genotypes
  - mr-imp: marker regression filling in missing data with a single imputation
  - mr-argmax: marker regression filling in by the Viterbi algorithm
- model (default="normal"): model for trait given genotypes; possible values are
  - normal: equivalent to linear regression with complete data
  - binary: equivalent to logistic regression with complete data
  - 2part: two-part model for trait given genotype
  - np: non-parametric analysis
- n_perm (default=0) number of permutations to perform
- control_marker: name of marker to control for as an additive covariate
"""
function run_rqtl(dataset::String, trait::String; method::String="hk",
                  model::String="normal", n_perm::Int64=0,
                  control_marker::String="",
                  interval_mapping::Bool=false, gn_url::String=gn_url())

    methods = ["hk", "ehk", "em", "imp", "mr", "mr-imp", "mr-argmax"]
    models=["normal", "binary", "2part", "np"]
    if !(method in methods)
        error("Currently does not support $method in R/qtl. Please select from hk, ehk, em, imp, mr, mr-imp, mr-argmax.")
    end
    if !(model in models)
        error("No $model model in R/qtl. Please choose from normal, binary, 2part, np.")
    end

    im = interval_mapping == true ? "true" : "false"
    # run_rqtl("BXDPublish", "10015", method="em", interval_mapping=TRUE)
    url = gn_url * "mapping?trait_id=" * trait * "&db=" * dataset * "&method=rqtl" *
        "&rqtl_method=" * method * "&rqtl_model=" * model * "&num_perm=" * string(n_perm) *
        "&interval_mapping=" * string(interval_mapping)
    println(url)
    return json2df(get_api(url))
end

"""
    run_correlation(trait::String, dataset::String, group::String; tp:;String="sample",
                    method::String="pearson", n_result::Int64=500,
                    gn_url::String=gn_url())

This function correlates a `trait` in a `dataset` against all traits
in a target database (`group`).

This query currently takes the following parameters:

- trait (required): trait ID for which the correlation is wanted
- dataset (required): dataset in which the trait occurs (use the short abbreviation)
- group (required): group in which which the comparisons will be performed
- tp: sample (default) | tissue
- method: pearson (default) | spearman
- n_result: maximum number of results to return (default = 500)
"""
function run_correlation(trait::String, dataset::String, group::String; tp::String="sample",
                         method::String="pearson", n_result::Int64=500,
                         gn_url::String=gn_url())
    types = ["sample", "tissue"]
    methods = ["pearson", "spearman"]

    if !(tp in types)
        error("No $t type. Choose from sample and tissue")
    end
    if !(method in methods)
        error("Currently does not support $method in correlation. Choose from pearson and spearman.")
    end

    url = gn_url * "correlation" * "?trait_id=" * trait * "&db=" * dataset * "&target_db=" *
        group * "&type=" * "&method=" * method * "&return=" * string(n_result)
    return json2df(get_api(url))
end
