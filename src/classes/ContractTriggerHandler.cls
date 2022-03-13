public without sharing class ContractTriggerHandler extends TriggerHandler {
    private List<Contract> newContractsList;

    public ContractTriggerHandler() {
        this.newContractsList = (List<Contract>) Trigger.new;
    }

    public override void beforeInsert() {
        ContractService.notifyOnInsert(newContractsList);
    }
}