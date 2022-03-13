public without sharing class AccountTriggerHandler extends TriggerHandler {
    private List<Account> newAccountList;

    public AccountTriggerHandler() {
        this.newAccountList = (List<Account>) Trigger.new;
    }

    public override void beforeInsert() {
        AccountService.notifyOnInsert(newAccountList);
    }
}