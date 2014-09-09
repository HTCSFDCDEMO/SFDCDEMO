/*
* Class Name: JobRoleController
* Author: Haseeb.N
* Date: 10-August-2012
* Requirement/Project Name: EA - Job Role
* Requirement/Description: Taking the input parameter from UI and invoking the APIs from the helper class.
*                          This is using for testing purpose*
* History:
*        -HN 10082012 : Created class
*       -BSY 28082012 : Implemented template Functionality.
*/


public class JobRoleController {

    public String strSearchCriteria                                       {get;set;}
    public String strNewJobsRoles                                         {get;set;}
    public String strUpdateJobsRoles                                      {get;set;}
    public List<JobRole__c> lstAllJobRole                                 {get;set;}
    public List<JobRole__c> lstFilteredJobRoles                           {get;set;}
    public List<JobRolePermission__c> lstJobRolePermission                {get;set;}
    public List<JobRolePermissionMapping__c> lstJobRolePermissionMapping  {get;set;}
    public List<JobRoleHelper.JobRolePermissionMapping> lstObjJRPermission  {get;set;}
    public List<SelectOption> getViewTemplateNames                        {get;set;}
    public String strViewTemplateID                                       {get;set;}
    public String strViewTemplateName                                     {get;set;}
    public boolean bolCreateViewTemplate                                     {get;set;}
    public boolean bolShowEdit                                            {get;set;}
    public String strCurrentID                                            {get;set;}
    public String strJobRoleId                                            {get;set;}


    public JobRoleController(){
        //Get All the Group Values
        lstAllJobRole = JobRoleHelper.getAllJobRoles();
        getFilteredJobRoleList();//Call the method to get the data
        bolShowEdit=false;     //To display button  
        bolCreateViewTemplate=false;//By Default hide create of TEmpalte View 
        getViewTemplateNames=JobRoleHelper.getAllTemplates();   //This method will get all the ViewTemplate Object values     
    }  

    public PageReference enableCreateViewTemplate() {
        bolCreateViewTemplate=true;
        return null;
    }

    
    //This method will create View Template 
    public PageReference createViewTemplate() {
        JobRoleHelper.createViewTemplate(strViewTemplateName);
        bolCreateViewTemplate=false;
        return null;
    }
    //The following method will popluate data based on Search Criteria
    public PageReference getFilteredJobRoleList(){
        lstFilteredJobRoles = JobRoleHelper.getFilteredData(strSearchCriteria,lstAllJobRole);
        return null;
    }
    
    //The following method will enable Edit Mode
    public PageReference enableEditMode(){
        bolShowEdit=JobRoleHelper.enableEditMode(bolShowEdit);
        strCurrentID = ApexPages.currentPage().getParameters().get('delID');
        strUpdateJobsRoles = ApexPages.currentPage().getParameters().get('delName');
        lstJobRolePermission = JobRoleHelper.getAllJobRolesPermission();
        return null;
    }
    
    //The following method will create Job Roles
    public void createJobRoles() {
        JobRoleHelper.createJobRoles(strNewJobsRoles,strViewTemplateID);
        //Get all Job Roles
        lstAllJobRole = JobRoleHelper.getAllJobRoles();
        getFilteredJobRoleList();//Call the method to get the data
    }
    
    //The following method will create Job Roles
    public void updateJobRoles() {
        JobRoleHelper.updateJobRoles(strUpdateJobsRoles, strCurrentID); //get's the enableEditMode value from enableEditMode()
        bolShowEdit=JobRoleHelper.enableEditMode(bolShowEdit);
        //Get all Job Roles
        lstAllJobRole = JobRoleHelper.getAllJobRoles();
        getFilteredJobRoleList();//Call the method to get the data
    }

    //The following method will delete Job Role
    public void activateOrDeactivateJobRole() {
        strJobRoleId = ApexPages.currentPage().getParameters().get('delID');
        JobRoleHelper.activateOrDeactivateJobRole(strJobRoleId);
                
        //To get the updated values
        lstAllJobRole = JobRoleHelper.getAllJobRoles();  
        getFilteredJobRoleList();//Call the method to get the data

    }
    
    //To Render the JobRole Permissions
    public void getJobRolePermissionList(String strJobRoleId){
        lstJobRolePermission = JobRoleHelper.getAllJobRolesPermission();
        lstJobRolePermissionMapping = JobRoleHelper.getPermissionMappingByJobRoleId(strJobRoleId);
        
        Map<String, JobRolePermissionMapping__c> mapJRPermissionMapping = new Map<String, JobRolePermissionMapping__c>();
        //List<JobRoleHelper.JobRolePermissionMapping> lstObjJRPermission = new List<JobRoleHelper.JobRolePermissionMapping>();
        JobRoleHelper.JobRolePermissionMapping objJRPermission = new JobRoleHelper.JobRolePermissionMapping();
        
        for (JobRolePermissionMapping__c jobPermissionMapping : lstJobRolePermissionMapping){
            mapJRPermissionMapping.put(jobPermissionMapping.PermissionMasterId__c,jobPermissionMapping);
        }
        
        for (JobRolePermission__c jobPermission : lstJobRolePermission){
            objJRPermission.strPermissionId = jobPermission.id;
            if(EAUtil.isNotEmpty(mapJRPermissionMapping.get(objJRPermission.strPermissionId)))
                objJRPermission.bolPermission = true;
            else
                objJRPermission.bolPermission = false;
            lstObjJRPermission.add(objJRPermission);
        }
        
        
    }

}