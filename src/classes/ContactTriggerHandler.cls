public without sharing class ContactTriggerHandler extends TriggerHandler {
    private List<Contact> newContactsList;
    private Map<Id, Contact> newContactMap;
    private Map<Id, Contact> oldContactMap;

    public ContactTriggerHandler() {
        this.newContactsList = (List<Contact>) Trigger.new;
        this.newContactMap = (Map<Id, Contact>) Trigger.newMap;
        this.oldContactMap = (Map<Id, Contact>) Trigger.oldMap;
    }

    public override void beforeInsert() {
        ContactService.notifyOnInsert(newContactsList);
    }

    public override void beforeUpdate() {
        ContactService.notifyOnUpdate(oldContactMap, newContactMap);
    }
}