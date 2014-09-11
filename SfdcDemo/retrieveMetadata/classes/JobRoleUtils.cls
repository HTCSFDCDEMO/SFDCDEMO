/**
* Class Name: JobRoleUtil
* Author: Haseeb.N
* Date: 10-August-2012
* Requirement/Project Name: EA
* Requirement/Description: Util Class for Job Roles.
* History:
*        -HN 10082012 : Created class
*        -BSY 28082012 : Implemented template Functionality.
*/

public class JobRoleUtils{
    public static String strQuery;      //This is to write query
    public static String strQueryText = 'SELECT id, Name, Weightage__c, IsActive__c FROM JobRole__c';
    public static String strQueryForTemplate = 'Select id, name from ViewTemplate__c';  //May be used in Future;
    public static List<JobRole__c> lstJobRoles;
    public static List<ViewTemplate__c> lstTemplates;
    public static List<JobRolePermission__c> lstJobRolePermission;
    public static List<JobRolePermissionMapping__c> lstJobRolePermissionMapping;
    
    //This method will search the Job Roles by Job Role Name and return the value
    public static List<JobRole__c> searchJobRoleByName(String jobRoleName) {
        if(jobRoleName==null||jobRoleName==''){
            strQuery = strQueryText;
        }else{
            strQuery = strQueryText + ' WHERE Name LIKE \'%'+ jobRoleName +'%\'';
        }
        lstJobRoles = Database.query(strQuery);
        return lstJobRoles;
    }
    
    //This method will search the Job Roles by Id and return the value
    public static List<JobRole__c> searchJobRoleById(String strJobRoleId) {
        strQuery = strQueryText + ' WHERE id = \''+ strJobRoleId+'\'';
        lstJobRoles = Database.query(strQuery);
        return lstJobRoles;
    }
    
    //This method will retrun the Job Roles by Name
    public static List<JobRole__c> getJobRoleByName(String jobRoleName) {
        strQuery = strQueryText + ' WHERE Name =\''+ jobRoleName + '\'';
        lstJobRoles = Database.query(strQuery );
        return lstJobRoles;
    }
  
    //This method will return all Job Roles    
    public static List<JobRole__c> getAllJobRoles() {
        lstJobRoles = Database.query(strQueryText);
        return lstJobRoles;
    }
    
    //This method will return all Job Roles    
    public static List<ViewTemplate__c> getAllTemplates() {
        lstTemplates = Database.query(strQueryForTemplate);
        return lstTemplates;
    }
    //This method will return View TEmplate REcord by Where Condition    
    public static List<ViewTemplate__c> getAllTemplatesByName(String strViewTemplateName) {
        strQuery = strQueryForTemplate + ' WHERE Name =\''+ strViewTemplateName + '\'';
        lstTemplates = Database.query(strQuery);
        return lstTemplates;
    }
    //This method will return all Job Roles Permission   
    public static List<JobRolePermission__c> getAllJobRolesPermission() {
        lstJobRolePermission = Database.query('SELECT Id,Name FROM JobRolePermission__c');
        return lstJobRolePermission;
    }
    
    //This method will return all Job Roles PermissionMapping   
    public static List<JobRolePermissionMapping__c> getPermissionMappingByJobRoleId(String strJobRoleId) {
        lstJobRolePermissionMapping = Database.query('SELECT Id,Name FROM JobRolePermissionMapping__c WHERE JobRoleId__c =\''+ strJobRoleId +'\'');
        return lstJobRolePermissionMapping;
    }
    
}