public class FinancialForecasting {

    static double forecast(double currentAmount, double growthRate, int yearsLeft) {

        if (yearsLeft == 0) {
            return currentAmount;
        }

        double nextValue = currentAmount * (1 + growthRate);

        return forecast(nextValue, growthRate, yearsLeft - 1);
    }

    public static void main(String[] args) {

        double presentValue = 15000;   
        double annualGrowth = 0.08;    
        int years = 6;

        double result = forecast(presentValue, annualGrowth, years);

        System.out.printf("Current Value : %.2f%n", presentValue);
        System.out.println("Growth Rate   : " + (annualGrowth * 100) + "%");
        System.out.println("Years         : " + years);
        System.out.printf("Forecasted Value : %.2f%n", result);
    }
}