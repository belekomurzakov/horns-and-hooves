public without sharing class ContactTriggerHandler extends TriggerHandler {
    private Map<Id, Contact> newOppMap;
    private Map<Id, Contact> oldOpportunityMap;

    public ContactTriggerHandler() {
        this.newOppMap = (Map<Id, Contact>) Trigger.newMap;
        this.oldOpportunityMap = (Map<Id, Contact>) Trigger.oldMap;
    }
}