/*** Controller ***/
public with sharing class exampleCon1 {
    String username ;

    public String getUsername() {
        return username ;
    }
            
    public PageReference sayHello() {
        username = UserInfo.getName();
        return null;
    }
            
    public void setState(String n) {
        state = n;
    }
            
    public String getState() {
        return state;
    }
            
    public PageReference methodOne() {
        return null;
    }
            
    private String state = 'no';
}