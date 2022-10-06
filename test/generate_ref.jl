
#####################################
# Generate dataframe to be compared #
#####################################

# TEST 1 - refs
dfSpecies = GeneNetworkAPI.DataFrame(
            FullName = ["Mus musculus", "Rattus norvegicus"],
            Id = [1, 2],
            Name = ["mouse", "rat"],
            TaxonomyId = [10090, 10116]
);

# TEST 2 - refs
dfGroup = GeneNetworkAPI.DataFrame(
    DisplayName = ["Hybrid Rat Diversity Panel (Includes HXB/BXH)", "UIOWA SRxSHRSP F2"],
    FullName = ["Hybrid Rat Diversity Panel (Includes HXB/BXH)", "UIOWA SRxSHRSP F2"],
    GeneticType = ["None", "intercross"],
    Id = [10 ,24],
    MappingMethodId = ["1", "1"],
    Name = ["HXBBXH", "SRxSHRSPF2"],
    SpeciesId = [2, 2], 
    public = [2, 2]
)

# TEST 3 - refs
dfMetaGeno1 = GeneNetworkAPI.DataFrame(
    f1s = ["B6D2F1", "D2B6F1", ""],
    mat = ["C57BL/6J", "", ""],
    pat = ["DBA/2J", "", ""],
    location = ["BXD.8.geno", "BXD.geno*", "BXD.4.geno"]
)

# dfMetaGeno2 = GeneNetworkAPI.DataFrame(
#     location = ["BXD.8.geno", "BXD.geno*", "BXD.4.geno"]
# )

# TEST 4 - refs
dfGeno = GeneNetworkAPI.DataFrame(
    Chr = ["1", "1"],
    Locus = ["rs31443144", "rs6269442"],
    cM = [1.5, 1.5],
    Mb = [3.010274, 3.492195],
    BXD1 = ["B", "B"],
    BXD2 = ["B", "B"],
    BXD5 = ["D", "D"] 
)

# TEST 5 - refs
dfPheno = GeneNetworkAPI.DataFrame(
    id = ["00077E9920", "00077E9D84"],
    HSR_10308 = [223.0, 179.0],
    HSR_10309 = [226.0, 128.0],
    HSR_10310 = [123.0, 100.0],
    HSR_10311 = [70.0, 41.0] 
)

# TEST 6 - refs
dfInfoNonOmic = GeneNetworkAPI.DataFrame( 
    dataset_type = ["phenotype"],
    description = ["Central nervous system, behavior: Reaction time, premature initiations indicated by number of times that the rat pulled its snout out of the center hole before the imperative stimulus occurred and then put its snout back into the center hole without going to the left water feeder in the first 3-minute time epoch for males and females [n]"],
    id = [10308],
    name = ["reaction_time_pint1_5"]
)

dfInfoOmic = GeneNetworkAPI.DataFrame( 
    confidential = [0],
    data_scale = ["log2"],
    dataset_type = ["mRNA expression"],
    full_name = ["HSNIH-Palmer Nucleus Accumbens Core RNA-Seq (Aug18) rlog"],
    id = [860],
    name = ["HSNIH-Rat-Acbc-RSeq-0818"],
    public = [1],
    short_name = ["HSNIH-Palmer Nucleus Accumbens Core RNA-Seq (Aug18) rlog"],
    tissue = ["Nucleus Accumbens mRNA"],
    tissue_id = [17]
)

# TEST 7 - refs
dfInfoPheno1 = GeneNetworkAPI.DataFrame( 
    Additive = [0.0499967532467532],
    Id = [10001],
    LRS = [16.2831307029479],
    Locus = ["rs106114574"],
    PhenotypeId = [1449],
    PublicationId = [319],
    Sequence = [1]
)

dfInfoPheno2 = GeneNetworkAPI.DataFrame( 
    additive = [2.39444435069444],
    id = [4],
    locus = ["rs48756159"],
    lrs = [13.4974911471087]
)

dfInfoPheno3 = GeneNetworkAPI.DataFrame( 
    additive = [-0.214087568058076],
    alias  = ["HHG1; HLP3; HPE3; SMMCI; Dsh; Hhg1"],
    chr = ["5"],
    description = ["sonic hedgehog (hedgehog)"],
    id = [99602],
    locus = ["rs8253327"],
    lrs = [12.7711275309832],
    mb = [28.457155],
    mean = [9.279090909090911],
    name = ["1436869_at"],
    p_value = [0.306],
    se = [nothing],
    symbol = ["Shh"],
)

# TEST 8 - refs

dfGemma = GeneNetworkAPI.DataFrame( 
    Mb = [25.100133],
    additive = [-2.2764345],
    chr = [2],
    lod_score = [15.131865142718427],
    name = ["rs27186439"],
    p_value = [7.381334e-16]
)

# TEST 9 - refs

dfCorrelation = GeneNetworkAPI.DataFrame( 
    # Symbol("#_strains") = [25.100133],
    p_value = [0.006807187408935392],
    sample_r = [0.8928571428571429],
    trait = ["10157"]
)