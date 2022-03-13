public with sharing class NotificationHelper {
    private static final Integer RECIPIENT_MAX = 9;

    //I didn't put it to enum, because Apex unlike Java doesn't support parameters/methods.
    public final static String INSERTING_NEW_RECORD = 'Inserting new record';
    public final static String UPDATING_OWNER_FIELD = 'Updating Owner field';
    public final static String UPDATING_STATUS_FIELD = 'Updating Status field';

    @TestVisible
    private final static List<String> notificationTypes = new List<String>{
            NotificationHelper.INSERTING_NEW_RECORD,
            NotificationHelper.UPDATING_STATUS_FIELD,
            NotificationHelper.UPDATING_OWNER_FIELD
    };

    /**
     * ConnectApi.ChatterMessages.sendMessage() support sending message up to 9 recipients, so following method
     * sends message in several iterations.
     *
     * @param textMessage
     * @param notificationTypes
     * @param Set<Id> salesTeams
     */
    public static void sendMessages(String textMessage, String notificationTypes, Set<Id> salesTeams) {
        Set<Id> salesTeamUserIds = new Set<Id>();
        String recipients = '';
        Integer i = 0;

        for (Sales_Team_User__c salesTeamUser : selectSalesTeamUsers(notificationTypes, salesTeams)) {
            if (i <= RECIPIENT_MAX) {
                salesTeamUserIds.add(salesTeamUser.Id__c);
                i++;
            } else {
                recipients = salesTeamUserIds.toString().replace('{', '').replace('}', '');

                try {
                    ConnectApi.ChatterMessages.sendMessage(textMessage, recipients);
                } catch (Exception e) {
                    System.debug(e.getMessage());
                }

                salesTeamUserIds.clear();
                recipients = '';
                i = 0;
            }
        }

        if (salesTeamUserIds.size() > 0) {
            recipients = salesTeamUserIds.toString().replace('{', '').replace('}', '');
            try {
                ConnectApi.ChatterMessages.sendMessage(textMessage, recipients);
            } catch (Exception e) {
                System.debug(e.getMessage());
            }
        }
    }

    /**
     * @param notificationTypes
     * @param salesTeams
     *
     * @return list of Sales Team Users
     */
    private static List<Sales_Team_User__c> selectSalesTeamUsers(String notificationTypes, Set<Id> salesTeams) {
        return [
                SELECT Id, Id__c
                FROM Sales_Team_User__c
                WHERE Interested_Notification_Types__c = :notificationTypes
                AND Sales_Team__c = :salesTeams
        ];
    }
}