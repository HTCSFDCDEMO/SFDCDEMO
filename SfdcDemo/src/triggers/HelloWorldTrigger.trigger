trigger HelloWorldTrigger on Book__c (before insert) {
	/* book class object */
  Book__c[] books = Trigger.new;

   MyHelloWorld.applyDiscount(books);
   
   

}