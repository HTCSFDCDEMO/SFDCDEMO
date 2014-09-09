public with sharing class MyCustomizedLists {

 // Resources we need to hold on to across requests
    private ApexPages.StandardSetController controller;
    private PageReference savePage;
    // This is the state for the list "app"
    private Set<String> unSelectedNames = new Set<String>();
    private Set<String> selectedNames = new Set<String>();
    private Set<String> inaccessibleNames = new Set<String>();
    
    
    private MySelectedAccount__c myAccs;

    public MyCustomizedLists(ApexPages.StandardSetController controller) {
     
      this.controller = controller;
        loadFieldsWithVisibility();
    }
// Initial load of the fields lists
    private void loadFieldsWithVisibility() {
        Map<String, Schema.SobjectField> fields = Schema.SobjectType.Account.fields.getMap();
        for (String s : fields.keySet()) {
        if (s != 'Name') { // name is always displayed
        unSelectedNames.add(s);
       }
        if (!fields.get(s).getDescribe().isAccessible()) {
        inaccessibleNames.add(s);
           }
        }
        List<MySelectedAccount__c> previousSelectedAccounts= [select name__c from MySelectedAccount__c];
        for (MySelectedAccount__c acc : previousSelectedAccounts ) {
                selectedNames.add(acc.Name__c);
       }
       
     }
     // The fields to show in the list
    // This is what we generate the dynamic references from
    public List<String> getDisplayFields() {
        List<String> displayFields = new List<String>(selectedNames);
        displayFields.sort();
        return displayFields;
    }
    // Nav: go to customize screen
    public PageReference customize() {
        savePage = ApexPages.currentPage();
        return Page.MyCustomisedList;
    } 
    
    public PageReference save() {
        savePage = ApexPages.currentPage();
        
        List<MySelectedAccount__c> lists= [select Name__c from MySelectedAccount__c];
        delete lists;
        
        System.debug('*************save Accounts>>>>>>>>>>>>>>>> : '+ selectedNames+ '::::::::'+selectedNames.size());
        for(String s: selectedNames){
        System.debug('****************************in side the for loop ');
            myAccs= new MySelectedAccount__c();
            myAccs.Name__c=s;
            insert myAccs;
            } 
            
                     
        return Page.MyCustomisedList;
    } 

    // Nav: return to list view
    public PageReference show() {
        // This forces a re-query with the new fields list
        controller.reset();
        controller.addFields(getDisplayFields());
        return savePage;
    }
    // Create the select options for the two select lists on the page
        public List<SelectOption> getSelectedOptions() {
        return selectOptionsFromSet(selectedNames);
    }
    public List<SelectOption> getUnSelectedOptions() {
      return selectOptionsFromSet(unSelectedNames);
    }
    private List<SelectOption> selectOptionsFromSet(Set<String> opts) {
        List<String> optionsList = new List<String>(opts);
        optionsList.sort();
        List<SelectOption> options = new List<SelectOption>();
        for (String s : optionsList) {
        options.add(new
        SelectOption(s, decorateName(s), inaccessibleNames.contains(s)));
     }
     return options;
    }
    private String decorateName(String s) {
      return inaccessibleNames.contains(s) ? '*' + s : s;
    }
    // These properties receive the customization form postback data
    // Each time the [<<] or [>>] button is clicked, these get the contents
    // of the respective selection lists from the form
   public transient List<String> selectedData { get; set; }
    public transient List<String> unselectedData { get; set; }
    // Handle the actual button clicks. Page gets updated via a
    // rerender on the form
    public void doAdd() {
     moveFields(selectedData , selectedNames, unSelectedNames);
    }
    public void doRemove() {
     moveFields(unselectedData , unSelectedNames, selectedNames);
    }
    private void moveFields(List<String> items,
    Set<String> moveTo, Set<String> removeFrom) {
    for (String s: items) {
    if( ! inaccessibleNames.contains(s)) {
    moveTo.add(s);
    removeFrom.remove(s);
          }
        }
       }

}