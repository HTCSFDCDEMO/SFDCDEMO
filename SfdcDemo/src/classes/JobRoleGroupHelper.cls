/**
* Class Name: JobRoleGroupHelper
* Author: Suraj B. Yadav
* Date: 10-August-2012
* Requirement/Project Name: Job Role Groups *JRG
* Requirement/Description: This is a Helper class for all Job Roles Groups
* History:
*        -BSY 09082012 : Created class
*/

public class JobRoleGroupHelper {
     public static List<JobRoleGroup__c> lstJobRoleGroup;
     public static List<JobRoleGroup__c> lstJobRoleGroupFilter;
     public static String strName;
     public static boolean bolErrorMessage;
     //TODO: remove comment from Try and Catch block
     
    //For calling Search functionality
    public static List<JobRoleGroup__c> getFullData() {
        //Search the criteria and save in List object
       try{
            lstJobRoleGroup = JobRoleGroupUtils.fullDataOfJobRoleGroup();   
        }catch(Exception e){
            ApexPages.addmessage(new ApexPages.message(ApexPages.severity.INFO,'Error Occured ' + e));  
        } 
       
       return lstJobRoleGroup;
    }
    
    //For calling Search Filterfunctionality
    public static List<JobRoleGroup__c> getFilteredData(String strSearchCriteria, List<JobRoleGroup__c> lstJobRoleGroupObjects) {
        //Search the criteria and save in List object
       try{
            
            lstJobRoleGroupFilter = new  List<JobRoleGroup__c>();
            
            //Filter the data
            if(strSearchCriteria!=null){
                if(strSearchCriteria.length()>=3){  //Minimum 3 characters for Filtering
                    //Loop through all the List records
                    for(JobRoleGroup__c objJobRoleGroupTemp: lstJobRoleGroupObjects ){
                        strName = objJobRoleGroupTemp.Name;
                        strName = strName.toLowerCase(); 
                        if(strName.contains(strSearchCriteria.toLowerCase())){  //If list matches with the name, then sotre it
                            lstJobRoleGroupFilter.add(objJobRoleGroupTemp);
                        }   
                    } 
                    //If not result found, then show message
                    if(lstJobRoleGroupFilter.size()==0){
                        ApexPages.addmessage(new ApexPages.message(ApexPages.severity.INFO,'No Records Found'));
                    }
                }else{
                    //If no filter then show every group
                    lstJobRoleGroupFilter = lstJobRoleGroupObjects;
                }
            }else{
                //If no filter then show every group
                lstJobRoleGroupFilter = lstJobRoleGroupObjects;
            }

        }catch(Exception e){
            ApexPages.addmessage(new ApexPages.message(ApexPages.severity.WARNING,'Error Occured ' + e));  
        } 
       
       return lstJobRoleGroupFilter;
    }
    
    //The method will create Job Roles Groups
    public static void createJobRoleGroup(String strCreateJobRoleGroup){
        
        try{
            if(EAUtil.isNotEmpty(strCreateJobRoleGroup)){
                
                //Check for Duplicate Values
                lstJobRoleGroup = JobRoleGroupUtils.whereConditionFilter(strCreateJobRoleGroup);
                if(lstJobRoleGroup.size()>0){
                    ApexPages.addmessage(new ApexPages.message(ApexPages.severity.INFO,'Job Role Group Already Available'));
                }else{
                    //Create a new record and insert into DB
                    JobRoleGroup__c objJobRolesGroups = new JobRoleGroup__c();
                    objJobRolesGroups.Name = strCreateJobRoleGroup;
                    insert objJobRolesGroups;
                    ApexPages.addmessage(new ApexPages.message(ApexPages.severity.INFO,'Job Role Group Created Successfully'));
                }
            }else{
                ApexPages.addmessage(new ApexPages.message(ApexPages.severity.INFO,'No Job Role Group Name Entered'));
            }
        }catch(Exception e){
            ApexPages.addmessage(new ApexPages.message(ApexPages.severity.WARNING,'Error Occured ' + e));  
        }
    }
    
    //The method will Update Job Roles Groups
    public static void updateJobRoleGroup(String strUpdateJobRoleGroupName, String strSelectedUpdateJobsRolesID){
        
        try{
                //Create a new record and insert into DB
                lstJobRoleGroup = JobRoleGroupUtils.idConditionFilter(strSelectedUpdateJobsRolesID);
                if(lstJobRoleGroup.size()>0){
                    //Check for Duplicate Name
                    if(strUpdateJobRoleGroupName.equalsIgnoreCase(lstJobRoleGroup[0].name)){
                        bolErrorMessage=true; //To stop unhide the Edit Block
                        ApexPages.addmessage(new ApexPages.message(ApexPages.severity.WARNING,'Duplicate Job Role Group Name'));
                    }else{
                        List<JobRoleGroup__c> lstJobRoleGroupTemp = new List<JobRoleGroup__c>();
                        //Loop through each and every object
                        for(JobRoleGroup__c objJobRoleGroupTemp: lstJobRoleGroup){
                            objJobRoleGroupTemp.Name = strUpdateJobRoleGroupName;
                            lstJobRoleGroupTemp.add(objJobRoleGroupTemp);
                        }
                        update lstJobRoleGroupTemp; //Update Record
    
                        ApexPages.addmessage(new ApexPages.message(ApexPages.severity.INFO,'Job Role Group Updated Successfully'));
                    }
                }
        }catch(Exception e){
            ApexPages.addmessage(new ApexPages.message(ApexPages.severity.WARNING,'Error Occured ' + e));  
        }
    }
    
    //The method will Delete Job Roles Groups
    public static void activeInactiveJobRoleGroup(String strActiveInactiveJobRoleGroupID){
        
        try{
                //Create a new record and insert into DB
                lstJobRoleGroup = JobRoleGroupUtils.idConditionFilter(strActiveInactiveJobRoleGroupID);
                if(lstJobRoleGroup.size()>0){
                    List<JobRoleGroup__c> lstJobRoleGroupTemp = new List<JobRoleGroup__c>();
                    //Loop through each and every object
                    for(JobRoleGroup__c objJobRoleGroupTemp: lstJobRoleGroup){
                        //Check for Active/Inactive
                        if(objJobRoleGroupTemp.IsActive__c==true)
                            objJobRoleGroupTemp.IsActive__c = false;
                        else
                            objJobRoleGroupTemp.IsActive__c = true;
                                
                        lstJobRoleGroupTemp.add(objJobRoleGroupTemp);
                    }
                    update lstJobRoleGroupTemp; //Update Record
                                        
                    ApexPages.addmessage(new ApexPages.message(ApexPages.severity.INFO,'Job Role Group Status Changed Successfully'));
                }
        }catch(Exception e){
            ApexPages.addmessage(new ApexPages.message(ApexPages.severity.WARNING,'Error Occured ' + e));  
        }
    }
    
    //The following method will return True to False and False to True
    public static boolean enableEditMode(boolean bolValue){
        
        if(bolErrorMessage==true) bolValue=false;
        
        if(bolValue==true)
            return false;
        else if(bolValue==false)
            return true;
        
        return false; 
    }
    
    
}