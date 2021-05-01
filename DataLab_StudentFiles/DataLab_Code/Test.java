import core.data.*;
import java.util.ArrayList;

public class Test {
    private String[] names;
    private int[] years;
    private double[] ladderScores;
    private double[] GDPs;
    private double[] socialSupports;
    private double[] lifeExps;
    private double[] freedoms;
    private double[] generosities;
    private double[] corruptions;
    private ArrayList<Country> countries;

    public static void main(String[] args) {
        DataSource ds = DataSource.connect("../world-happiness-report.csv");
        ds.load();
        //ds.printUsageString();
        Test t = new Test();
        t.readData(ds);
        t.addToArray();
        t.analyzeData();       
    }

    public void readData(DataSource ds)
    {
        // names
        names = ds.fetchStringArray("Country name");
        // years
        years = ds.fetchIntArray("year");
        // ladder scores
        ladderScores = ds.fetchDoubleArray("Life Ladder");
        // GDPs
        GDPs = ds.fetchDoubleArray("Log GDP per capita");
        // social support scores
        socialSupports = ds.fetchDoubleArray("Social support");
        // life expectancies
        lifeExps = ds.fetchDoubleArray("Healthy life expectancy at birth");
        // freedom scores
        freedoms = ds.fetchDoubleArray("Freedom to make life choices");
        // generosity scores
        generosities = ds.fetchDoubleArray("Generosity");
        // corruption scores
        corruptions = ds.fetchDoubleArray("Perceptions of corruption");
    }

    public void addToArray()
    {
        countries = new ArrayList<Country>();
        for (int i = 0; i < names.length; i++)
        {
            countries.add(i,new Country(names[i], years[i], ladderScores[i], GDPs[i], socialSupports[i], lifeExps[i], freedoms[i], generosities[i], corruptions[i]));
        }
    }

    public void analyzeData()
    {
        double max;
        Country cMax;
        
        // ladder scores
        max = Double.MIN_VALUE;
        cMax = countries.get(0);
        for (Country c : countries) {if (c.getLadderScore() > max) {max = c.getLadderScore(); cMax = c;}}
        System.out.println("\n\nThe country with the highest ladder score is " + cMax.getName() + " (" + cMax.getYear() + ").");
        
        // GDPs
        max = Double.MIN_VALUE;
        cMax = countries.get(0);
        for (Country c : countries) {if (c.getGDP() > max) {max = c.getGDP(); cMax = c;}}
        System.out.println("The country with the highest log GDP per capita is " + cMax.getName() + " (" + cMax.getYear() + ").");

        // social support scores
        max = Double.MIN_VALUE;
        cMax = countries.get(0);
        for (Country c : countries) {if (c.getSocialSupport() > max) {max = c.getSocialSupport(); cMax = c;}}
        System.out.println("The country with the best social support is " + cMax.getName() + " (" + cMax.getYear() + ").");
        
        // life expectancies
        max = Double.MIN_VALUE;
        cMax = countries.get(0);
        for (Country c : countries) {if (c.getLifeExp() > max) {max = c.getLifeExp(); cMax = c;}}
        System.out.println("The country with the highest life expectancy is " + cMax.getName() + " (" + cMax.getYear() + ").");
        
        // freedom scores
        max = Double.MIN_VALUE;
        cMax = countries.get(0);
        for (Country c : countries) {if (c.getFreedom() > max) {max = c.getFreedom(); cMax = c;}}
        System.out.println("The country with most freedom is " + cMax.getName() + " (" + cMax.getYear() + ").");
        
        // generosity scores
        max = Double.MIN_VALUE;
        cMax = countries.get(0);
        for (Country c : countries) {if (c.getGenerosity() > max) {max = c.getGenerosity(); cMax = c;}}
        System.out.println("The country with the most generosity is " + cMax.getName() + " (" + cMax.getYear() + ").");
        
        // corruption scores
        max = Double.MAX_VALUE;
        cMax = countries.get(0);
        for (Country c : countries) {if (c.getCorruption() < max) {max = c.getCorruption(); cMax = c;}}
        System.out.println("The country with least corruption is " + cMax.getName() + " (" + cMax.getYear() + ").");

        // total
        max = Double.MIN_VALUE;
        cMax = countries.get(0);
        for (Country c : countries) {if (c.getTotal() > max) {max = c.getTotal(); cMax = c;}}
        System.out.println("\nThe overall happiest country in the world since 2005 was " + cMax.getName() + " in " + cMax.getYear() + ".\n\n");
    }
}