#include <stdio.h>
#include <string.h>
#include <math.h>
#include <malloc.h>

typedef double real;  

const long long max_size = 2000;          // max length of strings
const long long NN = 40;                   // number of closest words that will be shown
const long long max_w = 100;              // max length of vocabulary entries

int main(int argc, char **argv) {
  FILE *f;
  FILE *f_tag;
  char st1[max_size];   //用于记录客户端输入的值
  char *bestw[NN];
  char file_name[max_size], st[100][max_size], tag_file_name[max_size];
  real dist, len, bestd[NN], vec[max_size];
  long long words, size, a, b, c, d, cn, bi[100], words_tag, size_tag, from_word_num, from_word_dim, to_word_num, to_word_dim;
  real *M;
  real *N;
  real *from_vec;
  real *to_vec;
  char *vocab;
  char *vocab_tag;
  char *from_vocab;
  char *to_vacab;
  char ch;
  int method;
  if (argc < 3) {
    printf("Usage: ./distance <FILE-1> <FILE-2>\nwhere FILE-1 contains user projections in the BINARY FORMAT\n"
      "and FILE-2 contains tag projections in the BINARY FORMAT\n");
    return 0;
  }
  strcpy(file_name, argv[1]);
  f = fopen(file_name, "rb");
  if (f == NULL) {
    printf("user file not found\n");
    return -1;
  }
  fscanf(f, "%lld", &words);
  fscanf(f, "%lld", &size);
  vocab = (char *)malloc((long long)words * max_w * sizeof(char));
  for (a = 0; a < NN; a++) bestw[a] = (char *)malloc(max_size * sizeof(char));
  M = (real *)malloc((long long)words * (long long)size * sizeof(real));
  if (M == NULL) {
    printf("Cannot allocate memory: %lld MB    %lld  %lld\n", (long long)words * size * sizeof(real) / 1048576, words, size);
    return -1;
  }
  for (b = 0; b < words; b++) {
    a = 0;
    while (1) {
      vocab[b * max_w + a] = fgetc(f);
      if (feof(f) || (vocab[b * max_w + a] == ' ')) break;
      if ((a < max_w) && (vocab[b * max_w + a] != '\n')) a++;
    }
    vocab[b * max_w + a] = 0;
  
    // if (!strcmp(&vocab[b * max_w],"66858853"))
    // {
    //   printf("uid: %s\n",&vocab[b * max_w]);
    // }

    for (a = 0; a < size; a++) {
      // fread(&M[a + b * size], sizeof(float), 1, f);
      fscanf(f,"%lf%c",&M[a + b * size],&ch);
    }
    len = 0;
    for (a = 0; a < size; a++) len += M[a + b * size] * M[a + b * size];
    len = sqrt(len);
    for (a = 0; a < size; a++) M[a + b * size] /= len;           //归一化
    if (b % 10000 == 0)
    {
      printf("Reading users: %.3lf%%%c", b / (double)(words + 1) * 100, 13);
      fflush(stdout);
    }
  }
  printf("Have allocated memory: %lld MB for user vacabulary  %lld  %lld\n", (long long)words * size * sizeof(real) / 1048576, words, size);
  fclose(f);

  strcpy(tag_file_name,argv[2]);
  f_tag = fopen(tag_file_name, "rb");
  if (f_tag == NULL) {
    printf("tag file not found\n");
    return -1;
  }
  fscanf(f_tag,"%lld",&words_tag);
  fscanf(f_tag,"%lld",&size_tag);
  vocab_tag = (char *)malloc((long long)words_tag * max_w * sizeof(char));
  N = (real *)malloc((long long)words_tag * (long long)size_tag * sizeof(real));
  if (N == NULL) {
    printf("Cannot allocate memory: %lld MB    %lld  %lld\n", (long long)words_tag * size_tag * sizeof(real) / 1048576, words_tag, size_tag);
    return -1;
  }

  for ( b = 0; b < words_tag; ++b)
  {
    a = 0;
    while(1){
      vocab_tag[b * max_w + a] = fgetc(f_tag);
      if (feof(f_tag) || (vocab_tag[b * max_w +a] == ' ')) break;
      if ((a < max_w) && (vocab_tag[b * max_w + a] != '\n')) a++;
    }
    vocab_tag[b * max_w + a] =0;

    for (a = 0; a < size_tag; a++) {  
      // fread(&M[a + b * size], sizeof(float), 1, f);
      fscanf(f_tag,"%lf%c",&N[a + b * size_tag],&ch);
    }
    len = 0;
    for (a = 0; a < size_tag; a++) len += N[a + b * size_tag] * N[a + b * size_tag];
    len = sqrt(len);
    for (a = 0; a < size; a++) N[a + b * size_tag] /= len;           //归一化

    if (b % 10000 == 0)
    {
      printf("Reading tags: %.3lf%%%c", b / (double)(words_tag + 1) * 100, 13);
      fflush(stdout);
    }
  }

  printf("Have allocated memory: %lld MB for tag vacabulary  %lld  %lld\n", (long long)words_tag * size_tag * sizeof(real) / 1048576, words_tag, size_tag);
  fclose(f_tag);
  
  


  
  while (1) {

    printf("If you want to find User Profile, press 0,\n"
           "If you want to find Target Users, press 1,\n"
           "Please choose:\n");

    while(1){
      scanf("%d%c",&method,&ch);
      if (method !=0 && method !=1)
        printf("Please type in the right number.\n");
      else
        break;
    }
    if (method == 0)  //找标签
    {
      from_vec = M;
      from_vocab = vocab;
      from_word_num = words;
      from_word_dim = size;
      to_vec = N;
      to_vacab = vocab_tag;
      to_word_num = words_tag;
      to_word_dim = size_tag;
    }else{
      from_vec = N;
      from_vocab = vocab_tag;
      from_word_num = words_tag;
      from_word_dim = size_tag;
      to_vec = M;
      to_vacab = vocab;
      to_word_num = words;
      to_word_dim = size;
    }

    for (a = 0; a < NN; a++) bestd[a] = 0;
    for (a = 0; a < NN; a++) bestw[a][0] = 0;
    printf("Enter Weibo User ID or Tag(EXIT to break): ");
    a = 0;
    while (1) {
      st1[a] = fgetc(stdin);
      if ((st1[a] == '\n') || (a >= max_size - 1)) {
        st1[a] = 0;
        break;
      }
      a++;
    }
    if (!strcmp(st1, "EXIT")) break;
    cn = 0;
    b = 0;
    c = 0;
    while (1) {
      st[cn][b] = st1[c];
      b++;
      c++;
      st[cn][b] = 0;
      if (st1[c] == 0) break;
      if (st1[c] == ' ') {
        cn++;
        b = 0;
        c++;
      }
    }
    cn++;
   
     for (a = 0; a < cn; a++) {
      // printf("User Id: %s\n",st[a]);
      for (b = 0; b < from_word_num; b++) if (!strcmp(&from_vocab[b * max_w], st[a])) break;
      if (b == from_word_num) b = -1;
      bi[a] = b;  //bi记录查询词在词汇表中的位置
      printf("\nUser or Tag: %s  Position in user vocabulary: %lld\n", st[a], bi[a]);
      if (b == -1) {
        printf("Out of user or Tag dictionary!\n");
        break;
      }
    }


    if (b == -1) continue;
    printf("\n                                              Tag       Cosine distance\n------------------------------------------------------------------------\n");
    for (a = 0; a < from_word_dim; a++) vec[a] = 0;     //存储目标词向量
    for (b = 0; b < cn; b++) {
      if (bi[b] == -1) continue;
      for (a = 0; a < from_word_dim; a++) vec[a] += from_vec[a + bi[b] * from_word_dim];
    }
    len = 0;
    for (a = 0; a < from_word_dim; a++) len += vec[a] * vec[a];
    len = sqrt(len);                           //目标词向量的长度
    for (a = 0; a < from_word_dim; a++) vec[a] /= len;  //归一化
    for (a = 0; a < NN; a++) bestd[a] = -1;
    for (a = 0; a < NN; a++) bestw[a][0] = 0;
    for (c = 0; c < to_word_num; c++) {
      a = 0;
      for (b = 0; b < cn; b++) if (bi[b] == c) a = 1;
      if (a == 1) continue;
      dist = 0;
      for (a = 0; a < to_word_dim; a++) dist += vec[a] * to_vec[a + c * to_word_dim];
      for (a = 0; a < NN; a++) {
        if (dist > bestd[a]) {
          for (d = NN - 1; d > a; d--) {
            bestd[d] = bestd[d - 1];
            strcpy(bestw[d], bestw[d - 1]);
          }
          bestd[a] = dist;
          strcpy(bestw[a], &to_vacab[c * max_w]);
          break;
        }
      }
    }
    for (a = 0; a < NN; a++) printf("%50s\t\t%lf\n", bestw[a], bestd[a]);
  }
  return 0;
}
