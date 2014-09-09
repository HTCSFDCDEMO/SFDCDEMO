/*
* Class Name: JobRoleHelper
* Author: Haseeb.N
* Date: 10-August-2012
* Requirement/Project Name: EA
* Requirement/Description: Taking the input parameter the controller.
* History:
*        -HN 10082012 : Created class
*       -BSY 28082012 : Implemented template Functionality.
*/

public class JobRoleHelper{
    public static List<JobRole__c> lstJobRoles;
    public static List<JobRole__c> lstJobRoleFilter;
    public static String strName;
    public static boolean bolErrorMessage;
    public static List<ViewTemplate__c> lstTemplates;
    public static List<SelectOption> viewTemplateNames;
    public static List<JobRolePermission__c> lstJobRolePermission;
    public static List<JobRolePermissionMapping__c> lstJobRolePermissionMapping;
    
    //The following method will get all the List of Tempaltes
    public static List<SelectOption> getAllTemplates() {
        //Search the criteria and set into the List object
        try{
            
            lstTemplates = JobRoleUtils.getAllTemplates();
            viewTemplateNames = new List<SelectOption>();
            viewTemplateNames.add(new SelectOption('-None-','-None-'));
            for (ViewTemplate__c viewTemplateIDTemp : lstTemplates){
                viewTemplateNames.add(new SelectOption(viewTemplateIDTemp.id,viewTemplateIDTemp.Name));
            }
            
        }catch(Exception e){
            ApexPages.addmessage(new ApexPages.message(ApexPages.severity.WARNING,'Error Occured ' + e));  
        }
        return viewTemplateNames;
    }
    
    //For calling Search functionality
    public static List<JobRole__c> searchJobRoleByName(String jobRoleName) {
        //Search the criteria and set into the List object
        try{
            lstJobRoles = JobRoleUtils.searchJobRoleByName(jobRoleName);
        }catch(Exception e){
            ApexPages.addmessage(new ApexPages.message(ApexPages.severity.WARNING,'Error Occured ' + e));  
        }
        return lstJobRoles;
    }

    //To get the list of all Job Roles 
    public static List<JobRole__c> getAllJobRoles() {
        try{
            lstJobRoles = JobRoleUtils.getAllJobRoles();
        }catch(Exception e){
            ApexPages.addmessage(new ApexPages.message(ApexPages.severity.WARNING,'Error Occured ' + e));  
        }
        return lstJobRoles;
    }
    
    //For calling Search Filterfunctionality
    public static List<JobRole__c> getFilteredData(String strSearchCriteria, List<JobRole__c> lstJobRoleObjects) {
        //Search the criteria and save in List object
        try{
            lstJobRoleFilter = new  List<JobRole__c>();
            
            //Filter the data
            if(strSearchCriteria!=null){
                if(strSearchCriteria.length()>=3){  //Minimum 3 characters for Filtering
                    //Loop through all the List records
                    for(JobRole__c objJobRoleTemp: lstJobRoleObjects ){
                        strName = objJobRoleTemp.Name;
                        strName = strName.toLowerCase(); 
                        if(strName.contains(strSearchCriteria.toLowerCase())){  //If list matches with the name, then sotre it
                            lstJobRoleFilter.add(objJobRoleTemp);
                        }
                    }
                    //If not result found, then show message
                    if(lstJobRoleFilter.size()==0){
                        ApexPages.addmessage(new ApexPages.message(ApexPages.severity.INFO,'No Records Found'));
                    }
                }else{
                    //If no filter then show every group
                    lstJobRoleFilter = lstJobRoleObjects;
                }
            }else{
                //If no filter then show every group
                lstJobRoleFilter = lstJobRoleObjects;
            }
        }catch(Exception e){
            ApexPages.addmessage(new ApexPages.message(ApexPages.severity.WARNING,'Error Occured ' + e));  
        }
       return lstJobRoleFilter;
    }
    
    //The method will create Job Roles
    public static void createJobRoles(String strJobRoleName, String strViewTemplateID){
        try{
            System.debug('*************** strViewTemplateID ' + strViewTemplateID);
            if(EAUtil.isNotEmpty(strJobRoleName)||strViewTemplateID!='-None-'){
                //check for duplicate job roles.
                lstJobRoles = JobRoleUtils.getJobRoleByName(strJobRoleName); 
                if(lstJobRoles.size()>0){
                    ApexPages.addmessage(new ApexPages.message(ApexPages.severity.INFO,'Job Role Already Available'));
                }else{
                    //Create a new record and insert into DB
                    JobRole__c objJobRole = new JobRole__c();
                    objJobRole.Name = strJobRoleName;
                    objJobRole.ViewTemplate__c=strViewTemplateID;
                    objJobRole.Weightage__c=2;
                    insert objJobRole;
                    ApexPages.addmessage(new ApexPages.message(ApexPages.severity.INFO,'Job Role Created Successfully'));
                }
            }else{
                if(EAUtil.isNotEmpty(strJobRoleName))
                    ApexPages.addmessage(new ApexPages.message(ApexPages.severity.INFO,'No Job Role Name Entered'));
                else if(strViewTemplateID.equals('-None-'))
                    ApexPages.addmessage(new ApexPages.message(ApexPages.severity.INFO,'No View Template Selected'));
            }
        }catch(Exception e){
            ApexPages.addmessage(new ApexPages.message(ApexPages.severity.WARNING,'Error Occured ' + e));  
        }
    }
    //The method will create View Template
    public static void createViewTemplate(String strViewTemplateName){
        //try{
            if(EAUtil.isNotEmpty(strViewTemplateName)){
                //check for duplicate job roles.
                lstTemplates = JobRoleUtils.getAllTemplatesByName(strViewTemplateName); 
                if(lstTemplates.size()>0){
                    ApexPages.addmessage(new ApexPages.message(ApexPages.severity.INFO,'View Template Already Available'));
                }else{
                    //Create a new record and insert into DB
                    ViewTemplate__c objViewTemplate = new ViewTemplate__c();
                    objViewTemplate.Name = strViewTemplateName;
                    insert objViewTemplate;
                    ApexPages.addmessage(new ApexPages.message(ApexPages.severity.INFO,'View Template Created Successfully'));
                }
            }else{
                    ApexPages.addmessage(new ApexPages.message(ApexPages.severity.INFO,'No View Template Name Entered'));
            }
       // }catch(Exception e){
       //     ApexPages.addmessage(new ApexPages.message(ApexPages.severity.WARNING,'Error Occured ' + e));  
       // }
    }
    //The method will Update Job Roles
    public static void updateJobRoles(String strJobRoleName, String strJobRoleId){        
        try{
            if(EAUtil.isNotEmpty(strJobRoleId)){
                //Get the JobRole details by JobRoleId
                lstJobRoles = JobRoleUtils.searchJobRoleById(strJobRoleId);
                if(lstJobRoles.size()>0){
                    //check for duplicate job roles.
                    lstJobRoleFilter = JobRoleUtils.getJobRoleByName(strJobRoleName);
                    if(lstJobRoleFilter.size()>0){
                        bolErrorMessage=true; //To stop unhide the Edit Block
                        ApexPages.addmessage(new ApexPages.message(ApexPages.severity.INFO,'Duplicate Job Role Name'));
                    }else if(strJobRoleName.equalsIgnoreCase(lstJobRoles[0].name)){
                        bolErrorMessage=true; //To stop unhide the Edit Block
                        ApexPages.addmessage(new ApexPages.message(ApexPages.severity.INFO,'Duplicate Job Role Name'));
                    } else {
                        List<JobRole__c> lstJobRoleTemp = new List<JobRole__c>();
                        //Loop through each and every object
                        for(JobRole__c objJobRoleTemp: lstJobRoles){
                            objJobRoleTemp.Name = strJobRoleName;
                            lstJobRoleTemp.add(objJobRoleTemp);
                        }
                        update lstJobRoleTemp; //Update Record
                        ApexPages.addmessage(new ApexPages.message(ApexPages.severity.INFO,'Job Role Updated Successfully'));
                    }
                }
            }else{
                ApexPages.addmessage(new ApexPages.message(ApexPages.severity.INFO,'Job Role is Not Selected'));
            }
        }catch(Exception e){
            ApexPages.addmessage(new ApexPages.message(ApexPages.severity.WARNING,'Error Occured ' + e));  
        }
    }

    //The method will Delete Job Roles
    public static void activateOrDeactivateJobRole(String strJobRoleId){
        try{
            //Get the JobRole details by JobRoleId
            lstJobRoles = JobRoleUtils.searchJobRoleById(strJobRoleId);
            if(lstJobRoles.size()>0){
                List<JobRole__c> lstJobRoleTemp = new List<JobRole__c>();
                //Loop through each and every object
                for(JobRole__c objJobRoleTemp: lstJobRoles){
                    //Check for Active/Inactive
                    if(objJobRoleTemp.IsActive__c==true)
                        objJobRoleTemp.IsActive__c = false;
                    else
                        objJobRoleTemp.IsActive__c = true;
                            
                    lstJobRoleTemp.add(objJobRoleTemp);
                }
                update lstJobRoleTemp; //Update Record     
                ApexPages.addmessage(new ApexPages.message(ApexPages.severity.INFO,'Job Role Status Changed Successfully'));
            }
        }catch(Exception e){
            ApexPages.addmessage(new ApexPages.message(ApexPages.severity.WARNING,'Error Occured ' + e));  
        }
    }
    
    //The following method will return True to False and False to True
    public static boolean enableEditMode(boolean bolValue){
        if(bolValue==true)
            return false;
        else if(bolValue==false)
            return true;
        return false; 
    }
    
    //This method will return all Job Roles Permission 
    public static List<JobRolePermission__c> getAllJobRolesPermission() {
        try{
            lstJobRolePermission = JobRoleUtils.getAllJobRolesPermission();
        }catch(Exception e){
            ApexPages.addmessage(new ApexPages.message(ApexPages.severity.WARNING,'Error Occured ' + e));  
        }
        return lstJobRolePermission;
    }
    
    //This method will return Job Roles Permission Mapping  by JobRole Id
    public static List<JobRolePermissionMapping__c> getPermissionMappingByJobRoleId(String strJobRoleId) {
        try{
            lstJobRolePermissionMapping = JobRoleUtils.getPermissionMappingByJobRoleId(strJobRoleId);
        }catch(Exception e){
            ApexPages.addmessage(new ApexPages.message(ApexPages.severity.WARNING,'Error Occured ' + e));  
        }
        return lstJobRolePermissionMapping;
    }
    
    
    //Wrapper class for JobRole Permission Mapping
    public class JobRolePermissionMapping {
        public String strPermissionId       {get;set;}
        public String strPermissionName     {get;set;}
        public Boolean bolPermission    {get;set;}
    }

}