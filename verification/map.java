/*
 * Copyright 1999-2015 Alibaba.com All right reserved. This software is the
 * confidential and proprietary information of Alibaba.com ("Confidential
 * Information"). You shall not disclose such Confidential Information and shall
 * use it only in accordance with the terms of the license agreement you entered
 * into with Alibaba.com.
 */

import java.io.BufferedReader;
import java.io.FileNotFoundException;
import java.io.FileReader;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

/**
 * 类map的实现描述：TODO 类实现描述
 *
 * @author leidan.ll 2017/3/16 下午8:22
 */
public class map {

    public static void main(String[] args) {

        List<String> fact = new ArrayList<>(10);
        List<String> pred = new ArrayList<>(10);
        String factStr = "";
        String predStr = "";
        int matchNum = 0;
        int userNum = 0;
        float precision = 0L;
        float totalPrecision = 0L;
        try {
            StringBuffer sb = new StringBuffer("");
            FileReader reader = new FileReader("/Users/extends_die/code/weibo_user_profile/verification/mean_average_precision/src/combine.txt");
            BufferedReader br = new BufferedReader(reader);
            String str = null;
            while ((str = br.readLine()) != null) {
                userNum += 1;
                factStr = str.split("\\t")[1].trim();
                predStr = str.split("\\t")[2].trim();

                String[] factArray = factStr.split(" ");
                String[] predArray = predStr.split(" ");
                matchNum = 0;
                precision = 0L;


                for (int i = 0; i < predArray.length; i++) { //音乐 体育 法国 健身 英国 美国 哲学

                    for (int j = 0; j < factArray.length; j++) {//音乐 体育 健身 哲学
                        if (factArray[j].contains(predArray[i])) {
                            matchNum += 1;
                            precision += matchNum / (i + 1.0);
                            break;
                        }
                    }
                }
                totalPrecision += precision / factArray.length;
            }
            float map = totalPrecision / userNum;
            System.out.println(map);

        } catch (FileNotFoundException e) {
            e.printStackTrace();
        } catch (IOException e) {
            e.printStackTrace();
        }

    }
}