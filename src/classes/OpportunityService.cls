public with sharing class OpportunityService {

    /**
     * Method populate text message content for inserted new opportunities and select Sales Team Users,
     * which are interested to be notified.
     *
     * @param newList list of opportunities
     */
    public static void notifyOnInsert(List<Opportunity> newList) {
        Map<Id, Opportunity> opportunitiesWithSalesTeam = new Map<Id, Opportunity>();
        String textMessage = 'Checkout new created opportunities: ';

        for (Opportunity opportunity : newList) {
            if (opportunity.Sales_Team__c != null) {
                opportunitiesWithSalesTeam.put(opportunity.Sales_Team__c, opportunity);
                textMessage += '\nName: ' + opportunity.Name +
                        ', StageName: ' + opportunity.StageName +
                        ', CloseDate: ' + opportunity.CloseDate;
            }
        }

        NotificationHelper.sendMessages(
                textMessage,
                [SELECT Id, Id__c
                 FROM Sales_Team_User__c
                 WHERE Interested_Notification_Types__c = :NotificationHelper.INSERTING_NEW_RECORD
                 AND Sales_Team__c = :opportunitiesWithSalesTeam.keySet()]
        );
    }
}