global class scheduledBatch implements Schedulable
{
   global void execute(SchedulableContext SC) 
   {
       ContDataInsert cdi = new ContDataInsert();
       Database.executebatch(cdi);  
   }
}