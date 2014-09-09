public with sharing class LeadManagementController {
 private PageReference savePage;
    public PageReference cancel() {
        return null;
    }


    public PageReference save() {
     savePage = ApexPages.currentPage();
        return savePage;
    }


    public String getLeadScoreOptions() {
        return null;
    }


    public String getStateOptions() {
        return null;
    }

}