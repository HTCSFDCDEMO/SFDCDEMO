/**
* Class Name: JobRoleGroupController  
* Author: Suraj B. Yadav
* Date: 09-August-2012
* Requirement/Project Name: Job Role Groups
* Requirement/Description: This class will search for the criteria Job Roles
* History:
*        -BSY 09082012 : Created class
*/

public class JobRoleGroupController {
    public String strSearchCriteria                         {get;set;}
    public String strNewJobsRoles                           {get;set;}
    public String strUpdateJobsRoles                        {get;set;}
    public String strDeleteJobsRoles                        {get;set;}
    public List<JobRoleGroup__c> lstJobRoleGroup            {get;set;} 
    public List<JobRoleGroup__c> lstAllJobRoleGroup         {get;set;}  
    public List<JobRoleGroup__c> lstAllJobRoleGroupFilter   {get;set;}   
    public List<selectOption> getGrps                       {get;set;} 
    public String strSelectedUpdateJobsRoles                {get;set;}
    public boolean bolShowEdit                              {get;set;}
    public String strCurrentID                              {get;set;}
    
   public JobRoleGroupController(){
                
        //Get All the Group Values
         lstAllJobRoleGroup = JobRoleGroupHelper.getFullData();
         searchJobRoleGroupFilterData();//Call the method to get the data
         bolShowEdit=false;     //To display button
   }  
   
        //The following method will popluate data based on Search Criteria
       public PageReference searchJobRoleGroupFilterData(){
            lstAllJobRoleGroupFilter = JobRoleGroupHelper.getFilteredData(strSearchCriteria,lstAllJobRoleGroup);
            
            return null;
        }

        //The following method will enable Edit Mode
        public PageReference enableEditMode(){
                bolShowEdit=JobRoleGroupHelper.enableEditMode(bolShowEdit);
                strCurrentID = ApexPages.currentPage().getParameters().get('delID');
                strUpdateJobsRoles = ApexPages.currentPage().getParameters().get('delName');
                return null;
        }
        
        //The following method will create Job Roles Groups
        public void createJobRoleGroup() {
                JobRoleGroupHelper.createJobRoleGroup(strNewJobsRoles);
                
                //Get All the Group Values
                 lstAllJobRoleGroup = JobRoleGroupHelper.getFullData();
                 searchJobRoleGroupFilterData();//Call the method to get the data
        }
        
        //The following method will create Job Roles Groups
        public void UpdateJobRoleGroup() {
                JobRoleGroupHelper.updateJobRoleGroup(strUpdateJobsRoles, strCurrentID); //get's the enableEditMode value from enableEditMode()
                bolShowEdit=JobRoleGroupHelper.enableEditMode(bolShowEdit);
                
                //Get All the Group Values
                 lstAllJobRoleGroup = JobRoleGroupHelper.getFullData();
                 searchJobRoleGroupFilterData();//Call the method to get the data
        }
        
        //The following method will delete Job Roles Groups
        public void ActiveInactiveJobRoleGroup() {
                strDeleteJobsRoles = ApexPages.currentPage().getParameters().get('delID');
                JobRoleGroupHelper.activeInactiveJobRoleGroup(strDeleteJobsRoles);
                
                //To get the updated values 
                lstAllJobRoleGroup = JobRoleGroupHelper.getFullData();    
                searchJobRoleGroupFilterData();//Call the method to get the data
        }
}