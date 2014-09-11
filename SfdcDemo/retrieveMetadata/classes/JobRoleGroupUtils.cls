/**
* Class Name: JobRoleGroupUtils
* Author: Suraj B. Yadav
* Date: 10-August-2012
* Requirement/Project Name: Job Role Groups Utils *JRG
* Requirement/Description: This class will store all the Utils of Job Role Group
* History:
*        -BSY 10082012 : Created class
*/

public class JobRoleGroupUtils {
    public static String strQuery;      //This is to write query
    public static String strQueryText = 'SELECT id, Name, IsActive__c FROM JobRoleGroup__c';
    public static List<JobRoleGroup__c> lstJobRoleGroup;
    
    //This method will search the result and return the value
    public static List<JobRoleGroup__c> fullDataOfJobRoleGroup() {
        strQuery = strQueryText;
        lstJobRoleGroup = Database.query(strQuery );
        return lstJobRoleGroup;
    }  
    
    //This method will search the result and return the value
    public static List<JobRoleGroup__c> idConditionFilter(String strSelectedUpdateJobsRolesID) {
       strQuery = strQueryText + ' WHERE id =\''+ strSelectedUpdateJobsRolesID + '\'';
       lstJobRoleGroup = Database.query(strQuery );
       return lstJobRoleGroup;
    }
    
    //This method will search the result and return the value
    public static List<JobRoleGroup__c> whereConditionFilter(String strSelectedUpdateJobsRolesID) {  
       strQuery = strQueryText + ' WHERE Name =\''+ strSelectedUpdateJobsRolesID + '\'';
       lstJobRoleGroup = Database.query(strQuery );
       return lstJobRoleGroup;
    }
}