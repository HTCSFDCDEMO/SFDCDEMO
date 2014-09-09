global class scheduledDaily implements Schedulable {
    /**
* Builds up all of the new Objects
*
* @param sc The schedulable context
*/
 public static String CRON_EXP = '0 0 0 1 * ? *';

    /**
* Static method used to schedule the default reconciliation
*
* @return The jobId from the scheduled run
*/
    global static String scheduleIt() {
        scheduledDaily sd = new scheduledDaily();
        return System.schedule('Daily Reconciliation', CRON_EXP, sd);
    }
    global void execute(SchedulableContext sc) {
       RecordType rt = [
            select Id
            from RecordType
            where DeveloperName = 'Recipient'
        ];

        List<TestAccount__c> accountList = new List<TestAccount__c>();

       /* for (Account account:[select Id from Account where RecordTypeId = :rt.Id ])
         {
            accountList.add(new TestAccount__c(Account__c = account.Id__c));
        }*/

        if (!accountList.isEmpty()) {
            insert accountList;
        }
    }
}