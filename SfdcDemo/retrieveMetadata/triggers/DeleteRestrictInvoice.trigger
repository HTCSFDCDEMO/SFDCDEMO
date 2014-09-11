trigger DeleteRestrictInvoice on Invoice12__c(before delete) {

// create a list of Invoices in Trigger.oldMap along with their Line Items
List<Invoice12__c> invoices = [Select i.Name, (Select Name From LineItems12__r)
                                        From Invoice12__c i
                                        Where i.Id IN :Trigger.oldMap.keySet()];

// loop through the Invoices, attaching errors to those that have Line Items
for (Invoice12__c invoice : invoices) {
       if (!invoice.LineItems12__r.isEmpty()) {
      Trigger.oldMap.get(invoice.id).addError('Cannot delete Invoice with Line Items');
      }
   }
}