public with sharing class DataTableController {

    public DataTableController(ApexPages.StandardSetController controller) {

    }


     public DataTableController(ApexPages.StandardController controller) {

    }

    public String name{ get; set; }
    public String accounts { get; set; }
}