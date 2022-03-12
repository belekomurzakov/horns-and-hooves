public without sharing class AccountTriggerHandler extends TriggerHandler {
    private Map<Id, Account> newOppMap;
    private Map<Id, Account> oldOpportunityMap;

    public AccountTriggerHandler() {
        this.newOppMap = (Map<Id, Account>) Trigger.newMap;
        this.oldOpportunityMap = (Map<Id, Account>) Trigger.oldMap;
    }
}