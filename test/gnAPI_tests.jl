
###########################
# TEST 1 get species list #
###########################

dfRslt1 = list_species(); 
dfRslt2 = list_species("mouse");

println("Get species list test 1: ", @test (dfRslt1[1:2,:] == dfSpecies) && 
                                            (dfRslt2 == filter(row-> row.Name == "mouse", dfSpecies)));


######################################
# TEST 2 get list group of a species #
######################################

dfRslt1 = filter(row->row.Id == 10, list_groups("rat"));
dfRslt2 = filter(row->row.Id == 24, list_groups("rat"));

println("Get list group for a species test 2: ", @test ((dfRslt1 == filter(row-> row.Id == 10, dfGroup)) &&
                                                        (dfRslt2 == filter(row-> row.Id == 24, dfGroup))));

###################################
# TEST 3 get list geno of a group #
###################################

dfRslt1 = list_geno("BXD");
dfRslt2 = list_geno("HSNIH-Palmer");

println("Get meta geno for a group test 3: ", @test ((dfRslt1 == dfMetaGeno1) &&
                                                        (length(dfRslt2.location) == 1)));

####################################
# TEST 4 get genotypes for a group #
####################################

dfRslt = get_geno("BXD");
dfRslt1 = filter(row->row.Locus == "rs31443144", dfRslt)[:, 1:7];
dfRslt2 = filter(row->row.Locus == "rs6269442", dfRslt)[:, 1:7];

println("Get genotypes for a group test 4: ", @test ((dfRslt1 == filter(row->row.Locus == "rs31443144", dfGeno)) &&
                                                     (dfRslt2 == filter(row->row.Locus == "rs6269442", dfGeno))));

                                                    
######################################
# TEST 5 get sample data for a group #
######################################

dfRslt = get_pheno("HSNIH-Palmer");
dfRslt1 = filter(row->row.id == "00077E9920", dfRslt)[:, [
                                                            :id,
                                                            :HSR_10308,
                                                            :HSR_10309,
                                                            :HSR_10310,
                                                            :HSR_10311
                                                            ]];
dfRslt2 = filter(row->row.id == "00077E9D84", dfRslt)[:, [
                                                            :id,
                                                            :HSR_10308,
                                                            :HSR_10309,
                                                            :HSR_10310,
                                                            :HSR_10311
                                                            ]];

println("Get sample data for a group test 5: ", @test ((dfRslt1 == filter(row->row.id == "00077E9920", dfPheno)) &&
                                                     (dfRslt2 == filter(row->row.id == "00077E9D84", dfPheno))));

  
#######################################
# TEST 6 Get information about traits #
#######################################

dfRslt1 = info_dataset("HSNIH-Palmer","10308");
dfRslt2 = info_dataset("HSNIH-Rat-Acbc-RSeq-Aug18");

println("Get information about traits test 6: ", @test ((dfRslt1 == dfInfoNonOmic) && (dfRslt2 == dfInfoOmic)));


############################################
# TEST 7 Get summary information on traits #
############################################

dfRslt1 = filter(row->row.Id == 10001, info_pheno("HXBBXH"));
dfRslt2 = info_pheno("BXD","10001");
dfRslt3 = info_pheno("HC_M2_0606_P","1436869_at");

println("Get summary information on traits test 7: ", @test ((dfRslt1 == dfInfoPheno1) && (dfRslt2 == dfInfoPheno2) && (dfRslt3 == dfInfoPheno3)));

# ################
# TEST 8 Gemma #
################

dfRslt = run_gemma("BXDPublish","10015",use_loco=true);
dfRslt1 = filter(row->row.name == "rs27186439", dfRslt);

println("Get Gemma results test 8: ", @test (dfRslt1 == dfGemma));

######################
# TEST 9 Correlation #
######################

dfRslt = run_correlation("1427571_at","HC_M2_0606_P","BXDPublish");
dfRslt1 = GeneNetworkAPI.select(filter(row->row.trait == "10157", dfRslt), [2,3,4]);

println("Get correlation test 9: ", @test (dfRslt1 == dfCorrelation));

