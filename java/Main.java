import java.util.*;
import java.math.*;
import java.util.function.BiConsumer;

/*
 * Asks the user for two positive integers 
 * and returns the 10 happy numbers between them 
 * with the greatest norms, sorted descending by the norms
 * 
 * by Nate Jackson for CSC330
 */
public class Main {
    public static void main(String[] args) {
        Scanner scanner = new Scanner(System.in);
        Main obj = new Main();
        List<Integer> nums = new ArrayList<Integer>();
        List<Double> norms = new ArrayList<Double>();
        Map<Double, Integer> map = new TreeMap<Double, Integer>();

        System.out.print("First Argument:");
        int x = scanner.nextInt();
        System.out.print("Second Argument:");
        int y = scanner.nextInt();

        //exits if the same number is entered twice
        if (x == y){
            System.out.println("NOBODYS HAPPY");
            scanner.close();
            return;
        }
        nums = obj.createList(x, y);
        nums = obj.filterList(nums);

        //exits if no happy numbers exist between the two entered numbers
        if (nums.size() == 0){
            System.out.println("NOBODYS HAPPY");
            scanner.close();
            return;
        }
        norms = obj.findNorms(nums);
        map = obj.sortbyNorms(nums, norms);
        
        //output
        List<Integer> output = new ArrayList<Integer>();
        map.forEach(new BiConsumer<Double,Integer>() {
            @Override
            public void accept(Double k, Integer v) {
                output.add(v);                
            }
        });
        int count = 0;
        for(int i:output){
            if (count < 10){
                System.out.println(i);
                count++;
            }
        }
        scanner.close();
    }

    //fills a List with all numbers between the two entered numbers
    public List<Integer> createList(int x, int y) {
        int n;
        List<Integer> nums = new ArrayList<Integer>();
        //ensuring smallest number comes first
        if (x > y){
            n=x;
            x=y;
            y=n;
        }
        for (int i=x; i<y; i++){
            nums.add(i);
        }
        return nums;
    }

    //determines if a number is happy 
    public static boolean isHappy(long number){
        long m = 0;
        int digit = 0;
        HashSet<Long> cycle = new HashSet<Long>();
        while(number != 1 && cycle.add(number)){
            m = 0;
            while(number > 0){
                digit = (int)(number % 10);
                m += digit*digit;
                number /= 10;
            }
            number = m;
        }
        return number == 1;
    }

    //removes any non-happy numbers from the list
    public List<Integer> filterList(List<Integer> nums) {
        List<Integer> happyNums = new ArrayList<Integer>();
        for (int i : nums) {
            if (isHappy(i)) happyNums.add(i);
        }
        return happyNums;
    }

    //finds the norm for each happy number in the list and places it in a seperate list
    public List<Double> findNorms(List<Integer> nums) {
        List<Double> norms = new ArrayList<Double>();
        for (int i : nums) {
            double norm = 0;
            HashSet<Integer> cycle = new HashSet<Integer>();
            int m = 0;
            int digit = 0;
            while(i != 1 && cycle.add(i)){
                m = 0;
                while(i > 0){
                    digit = (int)(i % 10);
                    m += digit*digit;
                    i /= 10;
                }
                i = m;
            }
            for (int j : cycle){
                j = j*j;
                norm += j;
            }
            norm = Math.sqrt(norm);
            //norm is added as negative to have final output in descending order
            norms.add(-norm);
        }

        return norms;
    }

    //merges lists of happy numbers and norms into a treemap
    public Map<Double,Integer> sortbyNorms(List<Integer> nums, List<Double> norms) {
        Map<Double, Integer> sort = new TreeMap<Double, Integer>();
        for (int i = 0; i < nums.size(); i++) {
            sort.put(norms.get(i), nums.get(i));
        }
        return sort;
    }
}

    