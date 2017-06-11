#./pte-joint -train ../data/uid_followee_sample.txt -train_tag_file ../data/uid_tag_sample_50.txt -output ../data/user_vec_1st_pte_joint.txt -output_tag  ../data/tag_vec_1st_pte_joint.txt -binary 0 -size 100 -order 1 -negative 5 -samples 5000 -threads 40
#./findSim ../data/user_vec_1st_pte_joint.txt ../data/tag_vec_1st_pte_joint.txt uid_tags_predicTags_top50.txt uid_tags_predicTags_pte_joint_res50.txt 50

#./pte-undirect-tune -train ../data/uid_followee_sample.txt -train_tag_file ../data/uid_tag_sample_50.txt -output ../data/user_vec_1st_pte_tune_undirect.txt -output_tag  ../data/tag_vec_1st_pte_tune_undirect.txt -binary 0 -size 100 -order 1 -negative 5 -samples 5000 -threads 40
#./findSim ../data/user_vec_1st_pte_tune_undirect.txt ../data/tag_vec_1st_pte_tune_undirect.txt uid_tags_predicTags_top50.txt uid_tags_predicTags_pte_tune_undirect_res50.txt 50

#./pte-undirect-joint -train ../data/uid_followee_sample.txt -train_tag_file ../data/uid_tag_sample_50.txt -output ../data/user_vec_1st_pte_joint_undirect.txt -output_tag  ../data/tag_vec_1st_pte_joint_undirect.txt -binary 0 -size 100 -order 1 -negative 5 -samples 5000 -threads 40
#./findSim ../data/user_vec_1st_pte_joint_undirect.txt ../data/tag_vec_1st_pte_joint_undirect.txt uid_tags_predicTags_top50.txt uid_tags_predicTags_pte_joint_undirect_res50.txt 50

./pte-tune -train ../data/uid_followee_sample.txt -train_tag_file ../data/uid_tag_sample_50.txt -output ../data/user_vec_1st_pte_tune.txt -output_tag  ../data/tag_vec_1st_pte_tune.txt -binary 0 -size 100 -order 1 -negative 5 -samples 5000 -threads 40
./findSim ../data/user_vec_1st_pte_tune.txt ../data/tag_vec_1st_pte_tune.txt uid_tags_predicTags_top50.txt uid_tags_predicTags_pte_tune_res50.txt 50
