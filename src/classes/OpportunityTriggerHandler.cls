public class OpportunityTriggerHandler extends TriggerHandler {
    private List<Opportunity> newOpportunitiesList;
    private Map<Id, Opportunity> newOpportunityMap;
    private Map<Id, Opportunity> oldOpportunityMap;

    public OpportunityTriggerHandler() {
        this.newOpportunitiesList = (List<Opportunity>) Trigger.new;
        this.newOpportunityMap = (Map<Id, Opportunity>) Trigger.newMap;
        this.oldOpportunityMap = (Map<Id, Opportunity>) Trigger.oldMap;
    }

    public override void beforeInsert() {
        OpportunityService.notifyOnInsert(newOpportunitiesList);
    }
    
    public override void beforeUpdate() {
        OpportunityService.notifyOnUpdate(oldOpportunityMap, newOpportunityMap);
    }
}