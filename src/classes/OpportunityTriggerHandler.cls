public class OpportunityTriggerHandler extends TriggerHandler {
    private List<Opportunity> newOpportunitiesList;

    public OpportunityTriggerHandler() {
        this.newOpportunitiesList = (List<Opportunity>) Trigger.new;
    }

    public override void beforeInsert() {
        OpportunityService.notifyOnInsert(newOpportunitiesList);
    }
}