public class sample
{

    public PageReference cancel() {
        return null;
    }


    public PageReference save() {
        return null;
    }

    public String selectedValue { get; set; }
Public sample(){
 selectedValue = '--None--';
 //selectedValue = 'NOKIA';
}
// select option


    public PageReference test() {
        return null;
    }


    public String[] getPhones() {
        return phones;
    }
    public void setPhones(String[] phones) {
        this.phones= phones;
    }
    
String[] phones= new String[]{
 };
public List<SelectOption> getItems() {
        List<SelectOption> options = new List<SelectOption>();
        options.add(new SelectOption('INTEX', 'INTEX'));
        options.add(new SelectOption('NOKIA','NOKIA'));
        options.add(new SelectOption('LG','LG'));
        options.add(new SelectOption('MOTORALA','Motorala'));
        options.add(new SelectOption('SAMSUNG','SAMSUNG'));
        options.add(new SelectOption('LAVA','LAVA'));
        options.add(new SelectOption('IPHONE','IPHONE'));
        
        return options;
    }

}