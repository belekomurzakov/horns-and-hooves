public without sharing class ContractTriggerHandler extends TriggerHandler {
    private Map<Id, Contract> newOppMap;
    private Map<Id, Contract> oldOpportunityMap;

    public ContractTriggerHandler() {
        this.newOppMap = (Map<Id, Contract>) Trigger.newMap;
        this.oldOpportunityMap = (Map<Id, Contract>) Trigger.oldMap;
    }
}