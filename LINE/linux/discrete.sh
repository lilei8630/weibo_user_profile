./pte-tune -train ../data/uid_followee_sample_empty.txt -train_tag_file ../data/uid_tag_sample_20.txt -output ../data/empty.txt -output_tag  ../data/tag_vec_1st_dis_sup.txt -binary 0 -size 100 -order 1 -negative 5 -samples 5000 -threads 40
./pte-tune -train ../data/uid_followee_sample.txt -train_tag_file ../data/uid_tag_sample_empty.txt -output ../data/user_vec_1st_dis_sup.txt -output_tag  ../data/empty.txt -binary 0 -size 100 -order 1 -negative 5 -samples 5000 -threads 40

./pte-tune -train ../data/uid_followee_sample_empty.txt -train_tag_file ../data/uid_tag_sample_20.txt -output ../data/empty.txt -output_tag  ../data/tag_vec_2st_dis_sup.txt -binary 0 -size 50 -order 2 -negative 5 -samples 5000 -threads 40
./pte-tune -train ../data/uid_followee_sample.txt -train_tag_file ../data/uid_tag_sample_empty.txt -output ../data/user_vec_2st_dis_sup.txt -output_tag  ../data/empty.txt -binary 0 -size 50 -order 2 -negative 5 -samples 5000 -threads 40

./concatenate -input1 ../data/tag_vec_1st_dis_sup.txt -input2 ../data/tag_vec_2st_dis_sup.txt -output tag_vec_all_dis_sup.txt -binary 0
./concatenate -input1 ../data/user_vec_1st_dis_sup.txt -input2 ../data/user_vec_2st_dis_sup.txt -output user_vec_all_dis_sup.txt -binary 0



./findSim ../data/user_vec_all_dis_sup.txt ../data/tag_vec_all_dis_sup.txt uid_tags_predicTags_top5.txt uid_tags_predicTags_dis_sup.txt 5
