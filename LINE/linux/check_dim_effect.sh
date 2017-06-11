./pte-tune -train ../data/uid_followee_sample.txt -train_tag_file ../data/uid_tag_sample_20.txt -output ../data/user_vec_1st_100.txt -output_tag  ../data/tag_vec_1st_100.txt -binary 0 -size 100 -order 1 -negative 5 -samples 5000 -threads 40
./findSim ../data/user_vec_1st_100.txt ../data/tag_vec_1st_100.txt uid_tags_predicTags_top5.txt uid_tags_predicTags_100_0.txt 5

./pte-tune -train ../data/uid_followee_sample.txt -train_tag_file ../data/uid_tag_sample_20.txt -output ../data/user_vec_2st_100.txt -output_tag  ../data/tag_vec_2st_100.txt -binary 0 -size 100 -order 2 -negative 5 -samples 5000 -threads 40
./findSim ../data/user_vec_2st_100.txt ../data/tag_vec_2st_100.txt uid_tags_predicTags_top5.txt uid_tags_predicTags_0_100.txt 5

./concatenate -input1 ../data/tag_vec_1st_100.txt -input2 ../data/tag_vec_2st_100.txt -output tag_vec_all_100_100.txt -binary 0
./concatenate -input1 ../data/user_vec_1st_100.txt -input2 ../data/user_vec_2st_100.txt -output user_vec_all_100_100.txt -binary 0
./findSim user_vec_all_100_100.txt tag_vec_all_100_100.txt uid_tags_predicTags_top5.txt uid_tags_predicTags_100_100.txt 5

./pte-tune -train ../data/uid_followee_sample.txt -train_tag_file ../data/uid_tag_sample_20.txt -output ../data/user_vec_2st_50.txt -output_tag  ../data/tag_vec_2st_50.txt -binary 0 -size 50 -order 2 -negative 5 -samples 5000 -threads 40
./concatenate -input1 ../data/tag_vec_1st_100.txt -input2 ../data/tag_vec_2st_50.txt -output tag_vec_all_100_50.txt -binary 0
./concatenate -input1 ../data/user_vec_1st_100.txt -input2 ../data/user_vec_2st_50.txt -output user_vec_all_100_50.txt -binary 0
./findSim user_vec_all_100_50.txt tag_vec_all_100_50.txt uid_tags_predicTags_top5.txt uid_tags_predicTags_100_50.txt 5

./pte-tune -train ../data/uid_followee_sample.txt -train_tag_file ../data/uid_tag_sample_20.txt -output ../data/user_vec_2st_20.txt -output_tag  ../data/tag_vec_2st_20.txt -binary 0 -size 20 -order 2 -negative 5 -samples 5000 -threads 40
./concatenate -input1 ../data/tag_vec_1st_100.txt -input2 ../data/tag_vec_2st_20.txt -output tag_vec_all_100_20.txt -binary 0
./concatenate -input1 ../data/user_vec_1st_100.txt -input2 ../data/user_vec_2st_20.txt -output user_vec_all_100_20.txt -binary 0
./findSim user_vec_all_100_20.txt tag_vec_all_100_20.txt uid_tags_predicTags_top5.txt uid_tags_predicTags_100_20.txt 5