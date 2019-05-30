include("../src/api-process.jl")

using DelimitedFiles
using DataFrames
using BenchmarkTools

#returns single json
example_url = "http://gn2-zach.genenetwork.org/api/v_pre1/trait/BXD/10001" 

#returns multiple json
group_url = "http://gn2-zach.genenetwork.org/api/v_pre1/mouse/groups"
group_all_url = "http://gn2-zach.genenetwork.org/api/v_pre1/groups"

geno_url = "http://gn2-zach.genenetwork.org/api/v_pre1/genotypes/BXD"

dataset_url = "http://gn2-zach.genenetwork.org/api/v_pre1/datasets/mouse/bxd"
dataset_all_url = "http://gn2-zach.genenetwork.org/api/v_pre1/datasets/bxd"

sample_data_url = "http://gn2-zach.genenetwork.org/api/v_pre1/sample_data/HSNIH-PalmerPublish.csv"

pheno_url = "http://gn2-zach.genenetwork.org/api/v_pre1/dataset/bxd/10001"


example_response = parse_json(get_api(example_url))
group_response = parse_json(get_api(group_url))

group_all_response = parse_json(get_api(group_all_url))

geno_data = process_csv_file(get_api(geno_url), delim='\t', comments=true)

display(geno_data[1:5,1:5])


