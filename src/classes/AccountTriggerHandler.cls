public without sharing class AccountTriggerHandler extends TriggerHandler {
    private List<Account> newAccountList;
    private Map<Id, Account> newAccountMap;
    private Map<Id, Account> oldAccountMap;

    public AccountTriggerHandler() {
        this.newAccountList = (List<Account>) Trigger.new;
        this.newAccountMap = (Map<Id, Account>) Trigger.newMap;
        this.oldAccountMap = (Map<Id, Account>) Trigger.oldMap;
    }

    public override void beforeInsert() {
        AccountService.notifyOnInsert(newAccountList);
    }

    public override void beforeUpdate() {
        AccountService.notifyOnUpdate(oldAccountMap, newAccountMap);
    }
}