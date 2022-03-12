trigger SalesTeamUserTrigger on Sales_Team_User__c (before insert, before update) {
    new SalesTeamUserTriggerHandler().run();
}