public class RunTest 
{
   public String  str{set;get;}

  public PageReference sayHello(){  
 
         return null;
       }  

   @IsTest(SeeAllData=true) public static void  testRunTest ()
   {
   RunTest rt=new RunTest ();
   rt.str='Hello';

        System.assertEquals(rt.sayHello(),null);        
   }
    
    

}