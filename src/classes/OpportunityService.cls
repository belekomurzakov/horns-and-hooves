public with sharing class OpportunityService {

    /**
     * Method populate text message content for inserted new opportunities and select Sales Team Users,
     * which are interested to be notified.
     *
     * @param newList list of opportunities
     */
    public static void notifyOnInsert(List<Opportunity> newList) {
        Map<Id, Opportunity> opportunitiesWithSalesTeam = new Map<Id, Opportunity>();

        String text = 'Checkout new created opportunities: ';
        for (Opportunity opportunity : newList) {
            if (opportunity.Sales_Team__c != null) {
                opportunitiesWithSalesTeam.put(opportunity.Sales_Team__c, opportunity);
                text += '\nName: ' + opportunity.Name +
                        ', StageName: ' + opportunity.StageName +
                        ', CloseDate: ' + opportunity.CloseDate;
            }
        }

        NotificationHelper.sendMessages(text, NotificationHelper.INSERTING_NEW_RECORD, opportunitiesWithSalesTeam.keySet());
    }
}