./pte-tune -train ../data/uid_followee_sample.txt -train_tag_file ../data/uid_tag_sample.txt -output ../data/user_vec_1st_threshold_0.txt -output_tag  ../data/tag_vec_1st_threshold_0.txt -binary 0 -size 100 -order 1 -negative 5 -samples 5000 -threads 40
./findSim ../data/user_vec_1st_threshold_0.txt ../data/tag_vec_1st_threshold_0.txt uid_tags_predicTags_top5.txt uid_tags_predicTags_threshold_0.txt 5

./pte-tune -train ../data/uid_followee_sample.txt -train_tag_file ../data/uid_tag_sample_10.txt -output ../data/user_vec_1st_threshold_10.txt -output_tag  ../data/tag_vec_1st_threshold_10.txt -binary 0 -size 100 -order 1 -negative 5 -samples 5000 -threads 40
./findSim ../data/user_vec_1st_threshold_10.txt ../data/tag_vec_1st_threshold_10.txt uid_tags_predicTags_top5.txt uid_tags_predicTags_threshold_10.txt 5

./pte-tune -train ../data/uid_followee_sample.txt -train_tag_file ../data/uid_tag_sample_20.txt -output ../data/user_vec_1st_threshold_20.txt -output_tag  ../data/tag_vec_1st_threshold_20.txt -binary 0 -size 100 -order 1 -negative 5 -samples 5000 -threads 40
./findSim ../data/user_vec_1st_threshold_20.txt ../data/tag_vec_1st_threshold_20.txt uid_tags_predicTags_top5.txt uid_tags_predicTags_threshold_20.txt 5

./pte-tune -train ../data/uid_followee_sample.txt -train_tag_file ../data/uid_tag_sample_50.txt -output ../data/user_vec_1st_threshold_50.txt -output_tag  ../data/tag_vec_1st_threshold_50.txt -binary 0 -size 100 -order 1 -negative 5 -samples 5000 -threads 40
./findSim ../data/user_vec_1st_threshold_50.txt ../data/tag_vec_1st_threshold_50.txt uid_tags_predicTags_top5.txt uid_tags_predicTags_threshold_50.txt 5

./pte-tune -train ../data/uid_followee_sample.txt -train_tag_file ../data/uid_tag_sample_100.txt -output ../data/user_vec_1st_threshold_100.txt -output_tag  ../data/tag_vec_1st_threshold_100.txt -binary 0 -size 100 -order 1 -negative 5 -samples 5000 -threads 40
./findSim ../data/user_vec_1st_threshold_100.txt ../data/tag_vec_1st_threshold_100.txt uid_tags_predicTags_top5.txt uid_tags_predicTags_threshold_100.txt 5