public with sharing class ContactService {

    /**
     * Method populate text message content for inserted new Contacts and select Sales Team Users,
     * which are interested to be notified.
     *
     * @param newList list of Contacts
     */
    public static void notifyOnInsert(List<Contact> newList) {
        Map<Id, Contact> contactsWithSalesTeam = new Map<Id, Contact>();

        String text = 'Checkout new created contacts: ';
        for (Contact contact : newList) {
            if (contact.Sales_Team__c != null) {
                contactsWithSalesTeam.put(contact.Sales_Team__c, contact);
                text += '\nName: ' + contact.FirstName + ' ' + contact.LastName +
                        ', Department: ' + contact.Department +
                        ', Email: ' + contact.Email;
            }
        }

        NotificationHelper.sendMessages(text, NotificationHelper.INSERTING_NEW_RECORD, contactsWithSalesTeam.keySet());
    }

    /**
     * Method will trigger on update event, send private messages for OwnerId and Status__c fields change.
     * Text messages are unique for both fields, and sending separately to different interested teams.
     *
     * @param oldMap map of contacts with old values
     * @param newMap map of contacts with new values
     */
    public static void notifyOnUpdate(Map<Id, Contact> oldMap, Map<Id, Contact> newMap) {
        Set<Id> contactsOnOwnerUpdate = new Set<Id>();
        Set<Id> contactsOnStatusUpdate = new Set<Id>();

        String textOwnerUpdate = 'Hi,\n notifying you on update of Owner field on following contacts: ';
        String textStatusUpdate = 'Hi,\n notifying you on update of Status field on following contacts: ';

        for (Id id : newMap.keySet()) {
            if (!String.isBlank(newMap.get(id).Sales_Team__c)) {
                if (oldMap.get(id).OwnerId != newMap.get(id).OwnerId) {
                    contactsOnOwnerUpdate.add(newMap.get(id).Sales_Team__c);
                    textOwnerUpdate += '\nContact: ' + id +
                            ', ' + 'old owner: ' + oldMap.get(id).OwnerId +
                            ', ' + 'new owner: ' + newMap.get(id).OwnerId;
                }
                if (oldMap.get(id).Status__c != newMap.get(id).Status__c) {
                    contactsOnStatusUpdate.add(newMap.get(id).Sales_Team__c);
                    textStatusUpdate += '\nContact: ' + id +
                            ', ' + 'old status: ' + oldMap.get(id).Status__c +
                            ', ' + 'new status: ' + newMap.get(id).Status__c;
                }
            }
        }

        NotificationHelper.sendMessages(textOwnerUpdate, NotificationHelper.UPDATING_OWNER_FIELD, contactsOnOwnerUpdate);
        NotificationHelper.sendMessages(textStatusUpdate, NotificationHelper.UPDATING_STATUS_FIELD, contactsOnStatusUpdate);
    }    
}