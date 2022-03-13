public with sharing class ContactService {

    /**
     * Method populate text message content for inserted new Contacts and select Sales Team Users,
     * which are interested to be notified.
     *
     * @param newList list of Contacts
     */
    public static void notifyOnInsert(List<Contact> newList) {
        Map<Id, Contact> contactsWithSalesTeam = new Map<Id, Contact>();

        String textMessage = 'Checkout new created contacts: ';
        for (Contact Contact : newList) {
            if (Contact.Sales_Team__c != null) {
                contactsWithSalesTeam.put(Contact.Sales_Team__c, Contact);
                textMessage += '\nName: ' + Contact.Name +
                        ', Department: ' + Contact.Department	 +
                        ', Email: ' + Contact.Email;
            }
        }

        NotificationHelper.sendMessages(
                textMessage,
                NotificationHelper.selectSalesTeamUsers(
                        NotificationHelper.INSERTING_NEW_RECORD,
                        contactsWithSalesTeam.keySet()
                )
        );
    }    
}