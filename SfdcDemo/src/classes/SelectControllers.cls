public with sharing class SelectControllers {

    public PageReference test() {
        return null;
    }
    public String items { get; set; }
  
      String[] countries = new String[]{};
      public List<SelectOption> getItems() {
        List<SelectOption> options = new List<SelectOption>();
        options.add(new SelectOption('US','US'));
        options.add(new SelectOption('CANADA','Canada'));
        options.add(new SelectOption('MEXICO','Mexico'));

        return options;
    }
 
    public String[] getCountries() {
        return countries;
    }
 
    public void setCountries(String[] countries) {
        this.countries = countries;
    }
}