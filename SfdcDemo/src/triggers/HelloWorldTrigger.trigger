trigger HelloWorldTrigger on Book__c (before insert) {
	/* book class object  created*/
  Book__c[] books = Trigger.new;
//books are discounted
   MyHelloWorld.applyDiscount(books);
   //Beerappa
   

}