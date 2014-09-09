global class ContDataInsert implements Database.Batchable<sObject>, Database.Stateful
{
    global string message = '<h1>nbsp;</h1>';
global Database.QueryLocator start(Database.BatchableContext bc)
    {
        return DataBase.getQueryLocator('Select FirstName,LastName,Eamil,PhoneFrom Contact ');
        
    }
    global void execute(Database.BatchableContext bc, List<sObject> ob)
    {
        message = 'The following Contacts are missing Email values <br/>';
        List<Contact> contacts = new List<Contact>();
        for(sObject s: ob)
        {
            Contact c = (Contact)s;
            message += c.FirstName + 'mahen ' + c.LastName + ' k';
           contacts.Add(c);
        }
        //insert contacts;

        update contacts;
    }
    global void finish(Database.BatchableContext bc)
    {
        Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
        mail.setToAddresses(new String[] {'beera.2009@gmail.com'});
        mail.setReplyTo('beera.2009@gmail.com');
        mail.setSenderDisplayName('Salesforce Tweaks');
        mail.setSubject('Batch Process Completed');
        mail.setHtmlBody(message);
        Messaging.sendEmail(new Messaging.SingleEmailMessage[] { mail });
    }
 }