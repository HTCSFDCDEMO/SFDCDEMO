public Class EAUtil
{
    public Static String escSQuote(String strNeedsToBeEscapedForQuote)
    {
        if(strNeedsToBeEscapedForQuote != null)
            return String.escapeSingleQuotes(strNeedsToBeEscapedForQuote);
        else
            return null;   
    }
    
    
    
     public static boolean isEmpty(Object obj){
        boolean returnValue = True;
        if(obj instanceOf String){
            String str = (String)obj;
            return (str == null || str.length()== 0 || str.trim().length()==0);
        }
        if(obj instanceOf List<Object>){
            List<Object> lst = (List<Object>) obj;
            return (lst == null || lst.isEmpty());
        }
        if(obj instanceOf Map<String,String>){
            Map<String,String> m = (Map<String,String>) obj;
            return (m == null || m.isEmpty());
        }
        if(obj instanceOf Pagereference){
            Pagereference pr = (Pagereference) obj;
            return (pr == null);
        }
        
        return returnValue;
    }
    
    public static boolean isNotEmpty(Object obj){
        return !isEmpty(obj);
    }
    
    //2011-10-19T00:00:00
    public static string getDateTimeFormat(DateTime dTime){
        string result =  dTime.format('yyyy-MM-dd HH:mm:ss');
        return result.replace(' ','T'); 
    }
   ////////////////////////////////////////////////////////////////////
    //Test Methods
    
    static testMethod void testIsEmpty() {
        Map<String,String> m = new Map<String,String>{'CSIL-RequestorId'=>'CS-AccountManagement'};
        System.debug('Map is ' +m);
        System.assertEquals(false,EAUtil.isEmpty(m));
        //System.assert(false, );
        
        //positive test
         String str = null;
         System.assertEquals(true,isEmpty(str));
         
         List<String> objList = new List<String>();
         System.assertEquals(true,EAUtil.isEmpty(objList));
    }
   static testMethod void testGetDateTimeFormat() {
        DateTime testDate = datetime.newInstance(2011, 12, 19, 10, 00, 10);
        String formattedDate = getDateTimeFormat(testDate);
        System.assertEquals('2011-12-19T10:00:10',formattedDate );
   }
   static testMethod void testEscSQuote() {
    //positive test
        String StringWQuote = 'Electronic\'Arts';
        String formatStringWQuote = escSQuote(StringWQuote);
        
    //negative test
        String emptyString =  null;
        emptyString = escSQuote(emptyString);
        System.assertEquals(null, emptyString);
   }
 }