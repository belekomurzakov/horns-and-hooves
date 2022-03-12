public class OpportunityTriggerHandler extends TriggerHandler {
    private Map<Id, Opportunity> newOppMap;
    private Map<Id, Opportunity> oldOpportunityMap;

    public OpportunityTriggerHandler() {
        this.newOppMap = (Map<Id, Opportunity>) Trigger.newMap;
        this.oldOpportunityMap = (Map<Id, Opportunity>) Trigger.oldMap;
    }
}