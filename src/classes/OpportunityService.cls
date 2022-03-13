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

    /**
     * Method will trigger on update event, send private messages for OwnerId and StageName fields change.
     * Text messages are unique for both fields, and sending separately to different interested teams.
     *
     * @param oldMap map of opportunities with old values
     * @param newMap map of opportunities with new values
     */
    public static void notifyOnUpdate(Map<Id, Opportunity> oldMap, Map<Id, Opportunity> newMap) {
        Set<Id> opportunitiesOnOwnerUpdate = new Set<Id>();
        Set<Id> opportunitiesOnStageUpdate = new Set<Id>();

        String textOwnerUpdate = 'Hi,\n notifying you on update of Owner field on following opportunities: ';
        String textStageUpdate = 'Hi,\n notifying you on update of Stage field on following opportunities: ';

        for (Id id : newMap.keySet()) {
            if (!String.isBlank(newMap.get(id).Sales_Team__c)) {
                if (oldMap.get(id).OwnerId != newMap.get(id).OwnerId) {
                    opportunitiesOnOwnerUpdate.add(newMap.get(id).Sales_Team__c);
                    textOwnerUpdate += '\nOpportunity: ' + id +
                            ', ' + 'old owner: ' + oldMap.get(id).OwnerId +
                            ', ' + 'new owner: ' + newMap.get(id).OwnerId;
                }
                if (oldMap.get(id).StageName != newMap.get(id).StageName) {
                    opportunitiesOnStageUpdate.add(newMap.get(id).Sales_Team__c);
                    textStageUpdate += '\nOpportunity: ' + id +
                            ', ' + 'old stage: ' + oldMap.get(id).StageName +
                            ', ' + 'new stage: ' + newMap.get(id).StageName;
                }
            }
        }

        NotificationHelper.sendMessages(textOwnerUpdate, NotificationHelper.UPDATING_OWNER_FIELD, opportunitiesOnOwnerUpdate);
        NotificationHelper.sendMessages(textStageUpdate, NotificationHelper.UPDATING_STATUS_FIELD, opportunitiesOnStageUpdate);
    }
}