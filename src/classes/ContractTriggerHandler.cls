public without sharing class ContractTriggerHandler extends TriggerHandler {
    private List<Contract> newContractsList;
    private Map<Id, Contract> newContractMap;
    private Map<Id, Contract> oldContractMap;

    public ContractTriggerHandler() {
        this.newContractsList = (List<Contract>) Trigger.new;
        this.newContractMap = (Map<Id, Contract>) Trigger.newMap;
        this.oldContractMap = (Map<Id, Contract>) Trigger.oldMap;
    }

    public override void beforeInsert() {
        ContractService.notifyOnInsert(newContractsList);
    }

    public override void beforeUpdate() {
        ContractService.notifyOnUpdate(oldContractMap, newContractMap);
    }
}