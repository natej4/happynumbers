using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

/*
    Asks the user for two positive integers 
    and returns the 10 happy numbers between them 
    with the greatest norms, sorted descending by the norms

    by Nate Jackson for CSC330
*/

public class happynumbers{

    public static void Main(){
        Console.Write("First Argument: ");
        int x = Convert.ToInt32(Console.ReadLine());
        Console.Write("Second Argument: ");
        int y = Convert.ToInt32(Console.ReadLine());

        if (x == y){
           Console.WriteLine("NOBODYS HAPPY");
           return;
        }
        List<int> nums = new List<int>();
        nums = filterArray(fillArray(x, y));
        
        if(nums.Count == 0){
            Console.WriteLine("NOBODYS HAPPY");
            return;
        }
        SortedDictionary<double, int> output = findNorms(nums);
        foreach (KeyValuePair<double, int> kvp in output) {
            Console.WriteLine(kvp.Value);
        }
    }

    static List<int> fillArray(int x, int y) {
        List<int> list = new List<int>();
        int[] array = {};
        int n;
        if (x > y){
            n = x;
            x = y;
            y = n;
        }

        for (int i = x; i < y; i++){
            list.Add(i);
        }
        return list;
    }

    static List<int> filterArray(List<int> nums){
        List<int> filtered = new List<int>();
        foreach(int i in nums){
            if (ishappy(i)){
                filtered.Add(i);
            }
        }
        return filtered;
    }
    
    public static bool ishappy(int n){
            List<int> cache = new List<int>();
            int sum = 0;
            while (n != 1){
                if (cache.Contains(n)){
                    return false;
                }
                cache.Add(n);
                while (n != 0){
                    int digit = n % 10;
                    sum += digit * digit;
                    n /= 10;
                }
                n = sum;
                sum = 0;
            }
           return true;            
        }

    static SortedDictionary<double, int> findNorms(List<int> nums){
        SortedDictionary<double, int> dict = new SortedDictionary<double, int>();
        List<int> cache = new List<int>();
        foreach (int i in nums){
            cache.Clear();
            double norm = 0.0;
            int j = i;
            int m = 0;
            int digit = 0;            
            while (j != 1){
                m=0;
                if (!cache.Contains(j)){
                    cache.Add(j);
                }
                while (j > 0){
                    digit = j % 10;
                    m += digit*digit;
                    j /= 10;
                }
                j = m;
            }
            foreach (int x in cache){
                int y = x;
                y = y*y;
                norm += y;
            }
            norm = Math.Sqrt(norm);
            
            dict.Add(-norm, i);

            
        }
        SortedDictionary<double, int> outputDict = new SortedDictionary<double, int>();
        for (int i = 0; i < dict.Count; i++){
            if (i < 10){
                outputDict.Add(dict.ElementAt(i).Key, dict.ElementAt(i).Value);
            }
        }
        return outputDict;
    }
    
}