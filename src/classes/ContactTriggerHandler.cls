public without sharing class ContactTriggerHandler extends TriggerHandler {
    private List<Contact> newContactsList;

    public ContactTriggerHandler() {
        this.newContactsList = (List<Contact>) Trigger.new;
    }

    public override void beforeInsert() {
        ContactService.notifyOnInsert(newContactsList);
    }
}